import Foundation
import Capacitor
import AppCoinsSDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AppCoinsSdkPlugin)
public class AppCoinsSdkPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AppCoinsSdkPlugin"
    public let jsName = "AppCoinsSdk"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "isAvailable", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getProducts", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "purchase", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getPurchases", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "consumePurchase", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = AppCoinsSdk()


    override public func load() {
        super.load()
        print("AppCoinsSdkPlugin loaded")
    }


    @objc func isAvailable(_ call: CAPPluginCall) {
        print("AppCoinsSdkPlugin isAvailable")
        call.resolve([
            "isAvailable": AppcSDK.isAvailable()
        ])
    }

    @objc func getProducts(_ call: CAPPluginCall) {
        print("AppCoinsSdkPlugin getProducts")
        Task {
            do {
                let products = try await AppcSDK.shared.getProducts()
                let productsArray = products.map { product -> [String: Any] in
                    return [
                        "sku": product.sku,
                        "title": product.title,
                        "description": product.description,
                        "price": product.price,
                        "currency": product.currency
                    ]
                }
                call.resolve(["products": productsArray])
            } catch {
                call.reject("Failed to get products: \(error.localizedDescription)")
            }
        }
    }

    @objc func purchase(_ call: CAPPluginCall) {
        print("AppCoinsSdkPlugin purchase")
        guard let sku = call.getString("sku") else {
            call.reject("SKU is required")
            return
        }

        Task {
            do {
                let purchase = try await AppcSDK.shared.purchase(sku: sku)
                call.resolve([
                    "purchaseId": purchase.purchaseId,
                    "sku": purchase.sku,
                    "state": purchase.state.rawValue
                ])
            } catch {
                call.reject("Failed to purchase: \(error.localizedDescription)")
            }
        }
    }

    @objc func getPurchases(_ call: CAPPluginCall) {
        Task {
            do {
                let purchases = try await AppcSDK.shared.getPurchases()
                let purchasesArray = purchases.map { purchase -> [String: Any] in
                    return [
                        "purchaseId": purchase.purchaseId,
                        "sku": purchase.sku,
                        "state": purchase.state.rawValue
                    ]
                }
                call.resolve(["purchases": purchasesArray])
            } catch {
                call.reject("Failed to get purchases: \(error.localizedDescription)")
            }
        }
    }

    @objc func consumePurchase(_ call: CAPPluginCall) {
        print("AppCoinsSdkPlugin consumePurchase")
        guard let purchaseId = call.getString("purchaseId") else {
            call.reject("purchaseId is required")
            return
        }

        Task {
            do {
                try await AppcSDK.shared.consume(purchaseId: purchaseId)
                call.resolve()
            } catch {
                call.reject("Failed to consume purchase: \(error.localizedDescription)")
            }
        }
    }
}
