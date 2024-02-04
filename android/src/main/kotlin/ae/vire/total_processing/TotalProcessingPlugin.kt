package ae.vire.total_processing

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TotalProcessingPlugin */
class TotalProcessingPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
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
    handleCheckoutResultEvent = EventChannel(flutterPluginBinding.binaryMessenger, "scannerResult")
    handleCheckoutResultEvent!!.setStreamHandler(handleCheckoutResultHandler)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "checkoutSettings" ->{
        val paymentBrands: String? = call.argument<String>("paymentBrands")
        val shopperResultURL: String? = call.argument<String>("shopperResultURL")
        if (shopperResultURL != null) {
          checkoutSettings(shopperResultURL)
        }
      }
      "startCheckout" -> {
        val checkoutID: String? = call.argument<String>("checkoutID")
        if (checkoutID != null) {
          startCheckout(checkoutID)
        };
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun startCheckout(checkoutID: String) {

  }

  private fun checkoutSettings(shopperResultURL: String) {

  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {

  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

  }

  override fun onDetachedFromActivity() {

  }

}
