package com.siltium.multipay_plugin

import android.app.Activity
import android.app.Activity.RESULT_CANCELED
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.CardToken
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import com.mercadopago.android.px.model.PaymentMethod
import com.mercadopago.android.px.services.MercadoPagoServices
import com.mercadopago.android.px.model.Token
import com.mercadopago.android.px.services.Callback
import com.mercadopago.android.px.model.exceptions.ApiException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar

/** MultipayPlugin */
class MultipayPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, ActivityResultListener {
  // The MethodChannel that will the communication between Flutter and native Android
  //
  // This local reference serves to register the plugin with the Flutter Engine and unregister it
  // when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var pendingResult: Result? = null
  var methodResult: MethodChannel.Result? = null
  private val REQUEST_CODE = 13313

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "multipay_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "mpCheckout") {
      if (pendingResult == null) {
        val args = call.arguments as HashMap<*, *>
        val publicKey = args["publicKey"] as String
        val preferenceId = args["preferenceId"] as String

        startMPCheckout(publicKey, preferenceId, result)
      }
    } else if (call.method == "mpGetCardID") {
      val args = call.arguments as HashMap<*, *>
      val publicKey = args["publicKey"] as String
      val cardNumber = args["cardNumber"] as String
      val expirationMonth = args["expirationMonth"] as Int
      val expirationYear = args["expirationYear"] as Int
      val securityCode = args["securityCode"] as String
      val cardHolderName = args["cardHolderName"] as String
      val identificationType = args["identificationType"] as String
      val identificationNumber = args["identificationNumber"] as String

      getTokenCard(publicKey, cardNumber, expirationMonth, expirationYear, securityCode, cardHolderName, identificationType, identificationNumber, result)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  
  private fun startMPCheckout(publicKey: String, preferenceId: String, result: Result) {
    if (activity != null) {
      pendingResult = result
      MercadoPagoCheckout.Builder(publicKey, preferenceId).build().startPayment(activity!!, REQUEST_CODE)
    } else {
      result.error("0", "Not ready", null)
    }
  }

  private fun getTokenCard(publicKey: String, cardNumber: String, expirationMonth: Int, expirationYear: Int, securityCode: String, cardHolderName: String, identificationType: String, identificationNumber: String, result: Result){
    val tkn = CardToken(cardNumber, expirationMonth, expirationYear, securityCode, cardHolderName, identificationType, identificationNumber)
    //val mpServ = MercadoPagoServices(activity!!, publicKey)
    
    /* mpServ.createToken(tkn, object: Callback<Token>(){
      override fun success(token: Token){
        result.success(token)
      }

      override fun failure(error: ApiException){
        result.error("error")
      }
    }) */
  }

  override fun onDetachedFromActivity() {
    Log.d("multipay_plugin", "onDetachedFromActivity")
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("multipay_plugin", "onAttachedToActivity")
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    Log.d("multipay_plugin", "onActivityResult")

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