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
import com.oppwa.mobile.connect.provider.Connect
import com.oppwa.mobile.connect.provider.Transaction
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** TotalProcessingPlugin */
class TotalProcessingPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity

  private val CHECKOUT_REQUEST_CODE = 123

  private var handleCheckoutResultEvent: EventChannel? = null
  private var handleCheckoutResultSink : EventChannel.EventSink? = null
  private val handleCheckoutResultHandler = object : EventChannel.StreamHandler {
    override fun onListen(arg: Any?, eventSink: EventChannel.EventSink?) {
      handleCheckoutResultSink = eventSink
    }
    override fun onCancel(o: Any?) {}
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "total_processing")
    channel.setMethodCallHandler(this)
    handleCheckoutResultEvent = EventChannel(flutterPluginBinding.binaryMessenger, "handleCheckoutResult")
    handleCheckoutResultEvent!!.setStreamHandler(handleCheckoutResultHandler)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "startCheckout" -> {
        val checkoutID: String = call.argument<String>("checkoutId")!!
        val paymentBrands: List<String> = call.argument<List<String>>("paymentBrands")!!
          startCheckout(checkoutID, paymentBrands)
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
    val checkoutSettings = CheckoutSettings(checkoutID, paymentBrands.toSet(), Connect.ProviderMode.TEST)
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
    activity.startActivityForResult(var3,CHECKOUT_REQUEST_CODE)
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
    if (requestCode == CHECKOUT_REQUEST_CODE) {
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

}
