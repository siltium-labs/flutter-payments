/* 
import Flutter
import UIKit

public class FlutterPaymentsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_payments", binaryMessenger: registrar.messenger())
    let instance = FlutterPaymentsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
*/

import Flutter
import UIKit
//import MercadoPagoSDK

public class SwiftFlutterPaymentsPlugin: NSObject, FlutterPlugin, PXLifeCycleProtocol {

  var pendingResult: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_payments_method_channel", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPaymentsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getPlatformVersion") {
        result("iOS " + UIDevice.current.systemVersion)
    } else if (call.method == "startCheckoutWithMercadoPago") {
        /* let args = call.arguments as! Dictionary<String, String>
        let publicKey = args["publicKey"] ?? ""
        let preferenceId = args["preferenceId"] ?? ""

        pendingResult = result

        startCheckoutWithMercadoPago(publicKey: publicKey, preferenceId: preferenceId) */
    } else {
        //handleNavigationBar(isMercadoPagoActive: false)
        result(FlutterMethodNotImplemented)
    }
  }

  /* private func startCheckoutWithMercadoPago(publicKey: String, preferenceId: String) {
      let checkout = MercadoPago.init(builder: MercadoPagoBuilder.init(publicKey: publicKey, preferenceId: preferenceId))

      handleNavigationBar(isMercadoPagoActive: true)
      checkout.start(navigationController: controller(), lifeCycleProtocol: self)
  }

  public func cancelCheckout() -> (() -> Void)? {
      return {
          var resultData : [String : String] = [:]
          resultData["result"] = "canceled"
          self.pendingResult!(resultData)

          self.handleNavigationBar(isMercadoPagoActive: false)
      }
  }

  public func finishCheckout() -> ((PXResult?) -> Void)? {
      return ({(_ result: PXResult?) in
          var resultData : [String : Any?] = [:]

          if let payment = (result as? PXPayment) {
              resultData["result"] = "done"
              resultData["status"] = payment.status
              resultData["statusDetail"] = payment.statusDetail
              resultData["id"] = payment.id
              resultData["paymentMethodId"] = payment.paymentMethodId
              resultData["paymentTypeId"] = payment.paymentTypeId
              resultData["issuerId"] = payment.issuerId
              resultData["installments"] = payment.installments
              resultData["captured"] = payment.captured
              resultData["liveMode"] = payment.liveMode
              resultData["transactionAmount"] = String(describing: "\(payment.transactionAmount)")
              resultData["transactionDetails"] = payment.transactionDetails
              self.pendingResult!(resultData)
          } else {
              resultData["result"] = "done"
              resultData["status"] = result?.getStatus()
              resultData["statusDetail"] = result?.getStatusDetail()
              resultData["id"] = Int(result?.getPaymentId() ?? "")
              self.pendingResult!(resultData)
          }

          self.handleNavigationBar(isMercadoPagoActive: false)
      })
  }

  private func handleNavigationBar(isMercadoPagoActive: Bool) {
      if (isMercadoPagoActive) {
          controller().navigationBar.isHidden = false
      } else {
          controller().popToRootViewController(animated: true)
          controller().navigationBar.isHidden = true
      }
  }

  private func controller() -> UINavigationController {
      let rootViewController = UIApplication.shared.keyWindow?.rootViewController
      return rootViewController as! UINavigationController
  } */

}
