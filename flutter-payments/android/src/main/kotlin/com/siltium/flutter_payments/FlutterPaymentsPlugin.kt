package com.siltium.flutter_payments

import android.app.Activity
import android.app.Activity.RESULT_CANCELED
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterPaymentsPlugin */
class FlutterPaymentsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var pendingResult: Result? = null

  private val REQUEST_CODE = 13313

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mercado_pago")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "startCheckout") {
      if (pendingResult == null) {
        val args = call.arguments as HashMap<*, *>
        val publicKey = args["publicKey"] as String
        val preferenceId = args["preferenceId"] as String

        Log.d("FlutterPaymentsPlugin", "Starting checkout for $preferenceId")
        startCheckout(publicKey, preferenceId, result)
      } else {
        result.error("1", "Another operation in progress", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun startCheckout(publicKey: String, preferenceId: String, result: Result) {
    if (activity != null) {
      pendingResult = result
      MercadoPagoCheckout.Builder(publicKey, preferenceId).build().startPayment(activity!!, REQUEST_CODE)
    } else {
      result.error("0", "Not ready", null)
    }
  }

  override fun onDetachedFromActivity() {
    Log.d("FlutterPaymentsPlugin", "onDetachedFromActivity")
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("FlutterPaymentsPlugin", "onAttachedToActivity")
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    Log.d("FlutterPaymentsPlugin", "onActivityResult")

    if (requestCode == REQUEST_CODE) {
      if (resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE) {
        val payment = data?.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment

        val payer = mapOf(
          "no-op" to ""
        )

        val transactionDetails = mapOf(
          "no-op" to ""
        )

        //Done!
        // TODO Return all fields in the payment and map them to Dart objects
        pendingResult?.success(mapOf(
          "result" to "done",
          "id" to payment.id,
          "status" to payment.paymentStatus,
          "statusDetail" to payment.paymentStatusDetail,
          "paymentMethodId" to payment.paymentMethodId,
          "paymentTypeId" to payment.paymentTypeId,
          "issuerId" to payment.issuerId,
          "installments" to payment.installments,
          "captured" to payment.captured,
          "liveMode" to payment.liveMode,
          "operationType" to payment.operationType,
          "payer" to payer,
          "transactionAmount" to payment.transactionAmount.toString(),
          "transactionDetails" to transactionDetails
        ))
      } else if (resultCode == RESULT_CANCELED) {
        if (data?.extras != null && data.extras?.containsKey(MercadoPagoCheckout.EXTRA_ERROR) == true) {
          val mercadoPagoError = data.getSerializableExtra(MercadoPagoCheckout.EXTRA_ERROR) as MercadoPagoError

          pendingResult?.success(mapOf(
            "result" to "error",
            "errorMessage" to mercadoPagoError.message
          ))
        } else {
          pendingResult?.success(mapOf(
            "result" to "canceled"
          ))
        }
      }
      pendingResult = null
    }
    return true
  }
}
