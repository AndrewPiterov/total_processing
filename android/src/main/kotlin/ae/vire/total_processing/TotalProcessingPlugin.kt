@file:Suppress("NAME_SHADOWING")

package ae.vire.total_processing

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.os.Parcelable
import android.util.Log
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity
import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResult
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings
import com.oppwa.mobile.connect.exception.PaymentError
import com.oppwa.mobile.connect.exception.PaymentException
import com.oppwa.mobile.connect.payment.card.CardPaymentParams
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import com.oppwa.mobile.connect.provider.*


/** TotalProcessingPlugin */
class TotalProcessingPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity

  private val providerMode= Connect.ProviderMode.LIVE

  private var paymentProvider: OppPaymentProvider? = null


  private val checkoutRequestCode = 123

  private var handleCheckoutResultEvent: EventChannel? = null
  private var handleCheckoutResultSink : EventChannel.EventSink? = null
  private val handleCheckoutResultHandler = object : EventChannel.StreamHandler {
    override fun onListen(arg: Any?, eventSink: EventChannel.EventSink?) {
      handleCheckoutResultSink = eventSink
    }
    override fun onCancel(o: Any?) {}
  }

  private var customUIResultEvent: EventChannel? = null
  private var customUIResultSink : EventChannel.EventSink? = null
  private val customUIResultHandler = object : EventChannel.StreamHandler {
    override fun onListen(arg: Any?, eventSink: EventChannel.EventSink?) {
      customUIResultSink = eventSink
    }
    override fun onCancel(o: Any?) {}
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "total_processing")
    channel.setMethodCallHandler(this)
    handleCheckoutResultEvent = EventChannel(flutterPluginBinding.binaryMessenger, "handleCheckoutResult")
    handleCheckoutResultEvent!!.setStreamHandler(handleCheckoutResultHandler)

    customUIResultEvent = EventChannel(flutterPluginBinding.binaryMessenger, "customUIResult")
    customUIResultEvent!!.setStreamHandler(customUIResultHandler)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "startCheckout" -> {
        val checkoutID: String = call.argument<String>("checkoutId")!!
        val paymentBrands: List<String> = call.argument<List<String>>("paymentBrands")!!
          startCheckout(checkoutID, paymentBrands)
      }
      "customUIPay" -> {
        val checkoutID: String = call.argument<String>("checkoutId")!!
        val cardHolder: String = call.argument<String>("cardHolder")!!
        val cardNumber: String = call.argument<String>("cardNumber")!!
        if (!CardPaymentParams.isNumberValid(cardNumber,true)) {
          val item: MutableMap<String, Any?> = HashMap()
          item["isErrored"] = true
          val paymentError: MutableMap<String, Any?> = HashMap()
          paymentError["errorCode"] = "cardNumber"
          paymentError["errorInfo"] = "Invalid card number"
          paymentError["errorMessage"] = "Invalid card number"
          item["paymentError"] = paymentError
          handleCheckoutResultSink?.success(item)
          return
        }
        val expiryMonth: String = call.argument<String>("expiryMonth")!!
        val expiryYear: String = call.argument<String>("expiryYear")!!
        val cvc: String = call.argument<String>("cvc")!!
        val cardBrand: String = call.argument<String>("cardBrand")!!
        val shopperResultUrl: String = call.argument<String>("shopperResultUrl")!!
        pay(checkoutID,cardHolder,cardNumber,expiryMonth,expiryYear,cvc,cardBrand, shopperResultUrl)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @SuppressLint("SuspiciousIndentation")
  private fun startCheckout(checkoutID: String, paymentBrands: List<String>) {
    // since mSDK version 6.0.0 the shopper result URL is not required
    val checkoutSettings = CheckoutSettings(checkoutID, paymentBrands.toSet(), providerMode)
    val var3: Intent = Intent(
      activity,
      CheckoutActivity::class.java
    ).putExtra("com.oppwa.mobile.connect.checkout.dialog.EXTRA_CHECKOUT_SETTINGS", checkoutSettings)
      if (checkoutSettings.componentName != null) {
        var3.putExtra(
          "com.oppwa.mobile.connect.checkout.dialog.EXTRA_CHECKOUT_RECEIVER",
          checkoutSettings.componentName
        )
      }
      if (checkoutSettings.paymentButtonBrand != null) {
        var3.putExtra(
          "com.oppwa.mobile.connect.checkout.dialog.EXTRA_CHECKOUT_PAYMENT_BUTTON_METHOD",
          checkoutSettings.paymentButtonBrand
        )
      }
    Log.i("startActivity", "startActivity")
    activity.startActivityForResult(var3,checkoutRequestCode)
  }


  private fun handleCheckoutResult(result: CheckoutActivityResult) {
//    if (result.isErrored) {
//      Log.i("handleCheckoutResult", "errorInfo :${result.paymentError?.errorInfo}")
//      Log.i("handleCheckoutResult", "errorMessage :${result.paymentError?.errorMessage}")
//    }
//
//    if (result.isCanceled) {
//      Log.i("handleCheckoutResult", "isCanceled")
//    }
//
//    Log.i("handleCheckoutResult", "${result.transaction}")
//
//    val resourcePath = result.resourcePath
//
//    if (resourcePath != null) {
//      Log.i("resourcePath", "$resourcePath")
//    }
    val item: MutableMap<String, Any?> = HashMap()
    item["isErrored"] = result.isErrored
    val paymentError: MutableMap<String, Any?> = HashMap()
    paymentError["errorCode"] = result.paymentError?.errorCode.toString()
    paymentError["errorInfo"] = result.paymentError?.errorInfo
    paymentError["errorMessage"] = result.paymentError?.errorMessage
    item["paymentError"] = paymentError
    item["isCanceled"] = result.isCanceled
    item["resourcePath"] = result.resourcePath.toString()
    val transaction: MutableMap<String, Any?> = HashMap()
    transaction["transactionType"] = result.transaction?.transactionType.toString()
    val paymentParams: MutableMap<String, Any?> = HashMap()
    paymentParams["checkoutId"] = result.transaction?.paymentParams?.checkoutId
    paymentParams["paymentBrand"] = result.transaction?.paymentParams?.paymentBrand
    paymentParams["shopperResultUrl"] = result.transaction?.paymentParams?.shopperResultUrl
    transaction["paymentParams"] = paymentParams
    transaction["brandSpecificInfo"] = result.transaction?.brandSpecificInfo.toString()
    transaction["redirectUrl"] = result.transaction?.redirectUrl.toString()
    transaction["threeDS2Info"] = result.transaction?.threeDS2Info.toString()
    transaction["threeDS2MethodRedirectUrl"] = result.transaction?.threeDS2MethodRedirectUrl.toString()
    transaction["yooKassaInfo"] = result.transaction?.yooKassaInfo.toString()
    item["transaction"] = transaction
    handleCheckoutResultSink?.success(item)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
    paymentProvider = OppPaymentProvider(activity, providerMode)
    paymentProvider!!.setThreeDSWorkflowListener { activity }

  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {

  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == checkoutRequestCode) {
      // Ensure the result is for the checkout request
      if (data != null) {
        val checkoutResult = parseCheckoutResult(resultCode,data)
        handleCheckoutResult(checkoutResult)
        return true
      }
    }
    return false
  }

  private fun parseCheckoutResult(resultCode: Int,intent: Intent): CheckoutActivityResult {
    val builder = CheckoutActivityResult.Builder()

    val isCanceled = resultCode == 101

    return builder.setTransaction(intent.getParcelableExtra<Parcelable>("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_TRANSACTION") as Transaction?)
      .setPaymentError(intent.getParcelableExtra<Parcelable>("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_ERROR") as PaymentError?)
      .setResourcePath(intent.getStringExtra("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_RESOURCE_PATH"))
      .setCanceled(isCanceled)
      .build()
  }


//  private fun requestCheckoutInfo(checkoutId: String) {
//    try {
//      paymentProvider!!.requestCheckoutInfo(checkoutId, object : ITransactionListener {
//        override fun transactionCompleted(p0: Transaction) {
//          // Handle transaction completion if needed
//        }
//
//        override fun transactionFailed(p0: Transaction, p1: PaymentError) {
//          // Handle transaction failure if needed
//        }
//      })
//    } catch (e: PaymentException) {
//      e.message?.let {
//        val item: MutableMap<String, Any?> = HashMap()
//        item["isErrored"] = true
//        val paymentError: MutableMap<String, Any?> = HashMap()
//        paymentError["errorCode"] = e.error.errorCode.toString()
//        paymentError["errorInfo"] = e.error.errorInfo
//        paymentError["errorMessage"] = e.error.errorMessage
//        item["paymentError"] = paymentError
//        customUIResultSink?.success(item)
//      }
//    }
//  }


  private fun pay(checkoutId: String, cardHolder: String,cardNumber: String,cardExpiryMonth: String,cardExpiryYear: String,cardCVV: String,cardBrand: String,shopperResultUrl: String) {
    try {
      val paymentParams = CardPaymentParams(
        checkoutId,
        cardBrand,
        cardNumber,
        cardHolder,
        cardExpiryMonth,
        "20$cardExpiryYear",
        cardCVV
      )

      paymentParams.shopperResultUrl = shopperResultUrl
      val transaction = Transaction(paymentParams)

      paymentProvider!!.submitTransaction(transaction, object : ITransactionListener {
        override fun transactionCompleted(p0: Transaction) {
          val item: MutableMap<String, Any?> = HashMap()
          item["isErrored"] = false
          val transaction: MutableMap<String, Any?> = HashMap()
          transaction["transactionType"] = p0.transactionType.toString()
          val paymentParams: MutableMap<String, Any?> = HashMap()
          paymentParams["checkoutId"] = p0.paymentParams.checkoutId
          paymentParams["paymentBrand"] = p0.paymentParams.paymentBrand
          paymentParams["shopperResultUrl"] = p0.paymentParams.shopperResultUrl
          transaction["paymentParams"] = paymentParams
          transaction["brandSpecificInfo"] = p0.brandSpecificInfo.toString()
          transaction["redirectUrl"] = p0.redirectUrl.toString()
          transaction["threeDS2Info"] = p0.threeDS2Info.toString()
          transaction["threeDS2MethodRedirectUrl"] = p0.threeDS2MethodRedirectUrl.toString()
          transaction["yooKassaInfo"] = p0.yooKassaInfo.toString()
          item["transaction"] = transaction
          activity.runOnUiThread {
            customUIResultSink?.success(item)
          }
        }

        override fun transactionFailed(p0: Transaction, p1: PaymentError) {
          val item: MutableMap<String, Any?> = HashMap()
          item["isErrored"] = true
          val paymentError: MutableMap<String, Any?> = HashMap()
          paymentError["errorCode"] = p1.errorCode.toString()
          paymentError["errorInfo"] = p1.errorInfo
          paymentError["errorMessage"] = p1.errorMessage
          item["paymentError"] = paymentError
          val transaction: MutableMap<String, Any?> = HashMap()
          transaction["transactionType"] = p0.transactionType.toString()
          val paymentParams: MutableMap<String, Any?> = HashMap()
          paymentParams["checkoutId"] = p0.paymentParams.checkoutId
          paymentParams["paymentBrand"] = p0.paymentParams.paymentBrand
          paymentParams["shopperResultUrl"] = p0.paymentParams.shopperResultUrl
          transaction["paymentParams"] = paymentParams
          transaction["brandSpecificInfo"] = p0.brandSpecificInfo.toString()
          transaction["redirectUrl"] = p0.redirectUrl.toString()
          transaction["threeDS2Info"] = p0.threeDS2Info.toString()
          transaction["threeDS2MethodRedirectUrl"] = p0.threeDS2MethodRedirectUrl.toString()
          transaction["yooKassaInfo"] = p0.yooKassaInfo.toString()
          item["transaction"] = transaction
          activity.runOnUiThread {
            customUIResultSink?.success(item)
          }
        }
      })

      paymentProvider!!.setThreeDSWorkflowListener { activity }

    } catch (e: PaymentException) {
      val item: MutableMap<String, Any?> = HashMap()
      item["isErrored"] = true
      val paymentError: MutableMap<String, Any?> = HashMap()
      paymentError["errorCode"] = e.error.errorCode.toString()
      paymentError["errorInfo"] = e.error.errorInfo
      paymentError["errorMessage"] = e.error.errorMessage
      item["paymentError"] = paymentError
      activity.runOnUiThread {
        customUIResultSink?.success(item)
      }
    }
  }

//  val threeDSConfig = OppThreeDSConfig.Builder()

//  private val threeDSWorkflowListener: ThreeDSWorkflowListener = object : ThreeDSWorkflowListener {
//    override fun onThreeDSChallengeRequired(): Activity {
//      // provide your Activity
//      return activity
//    }
//
//    override fun onThreeDSConfigRequired(): OppThreeDSConfig {
//      // provide your OppThreeDSConfig
//      return threeDSConfig
//    }
//  }

}
