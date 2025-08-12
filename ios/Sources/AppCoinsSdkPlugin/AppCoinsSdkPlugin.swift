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
      
        // CAPPluginMethod(name: "consumePurchase", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = AppCoinsSdk()

    private var products: [Product] = []
  
    override public func load() {
        super.load()
        Task { await observePurchases() }
    }
  
    private func observePurchases() async {
      for await intent in Purchase.updates {
        let result = await intent.confirm()
        await handle(result: result)
      }
    }
    
  // HINT: You can use the same handle method for both regular and intent IAP
    private func handle(result: PurchaseResult) async {
      do {
        switch result {
        case .success(let verificationResult):
          switch verificationResult {
          case .verified(let purchase):
            self.notifyListeners("transaction", data: [
              "purchaseId": purchase.orderUid,
              "sku": purchase.sku,
              "state": purchase.state,
              "type": "success"
            ])
            try await purchase.finish()
            return
          case .unverified(let purchase, let verificationError):
            // deal with unverified transactions
            break
          }
          
        case .pending: // transaction is not finished
          break
        case .userCancelled: // user cancelled the transaction
          break
        case .failed(let error): // deal with any possible errors
          break
        }
        self.notifyListeners("transaction", data: [
          "message": "Aptoide transaction failed",
          "type": "error"
        ])
     
      } catch {
        print("Error handling purchase intent: \(error.localizedDescription)" )
      }
    }

  @objc func isAvailable(_ call: CAPPluginCall)  {
        print("🔌 AppCoinsSdkPlugin isAvailable method called")
        
    Task {
      let isAvailable = await AppcSDK.isAvailable()
      print("🔌 AppcSDK.isAvailable() returned: \(isAvailable)")
      call.resolve([
        "isAvailable": isAvailable
      ])
    }
    }

    @objc func getProducts(_ call: CAPPluginCall) {
        print("AppCoinsSdkPlugin getProducts")
      Task {
      if await AppcSDK.isAvailable() {
          do {
            self.products = try await Product.products()
            let productsArray = self.products.map { product -> [String: Any] in
              return [
                "sku": product.sku,
                "title": product.title,
                "description": product.description,
                "price": product.priceValue,
                "currency": product.priceSymbol,
                "label": product.priceLabel
              ]
            }
            call.resolve(["products": productsArray])
          } catch {
            call.reject("Failed to get products: \(error.localizedDescription)")
          }
        } else {
          call.reject("App Coins SDK is not available")
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
                if self.products.isEmpty {
                  self.products = try await Product.products()
                }
                let product = products.first(where: { $0.sku == sku })
                if product == nil {
                    call.reject("Product not found")
                    return
                }
                let result = await product?.purchase()
                print("Result: \(result)")
                switch result {
                case .success(let verificationResult):
                switch verificationResult {
                    case .verified(let purchase):
                    print("Verified")
                        // consume the item and give it to the user
                        print("Consuming purchase")
                        try await purchase.finish()
                        call.resolve([
                            "purchaseId": purchase.orderUid,
                            "sku": purchase.sku,
                            "state": purchase.state
                        ])
                    case .unverified(let purchase, let verificationError):
                        // deal with unverified transactions
                        print("Unverified")
                        call.reject("Failed to purchase: \(verificationError.localizedDescription)")
                }
                case .pending: // transaction is not finished
                    print("Transaction is not finished")
                case .userCancelled: // user cancelled the transaction
                    print("User cancelled the transaction")
                    call.reject("User cancelled the transaction")
                case .failed(let error): // deal with any possible errors
                    print("Failed to purchase: \(error.localizedDescription)")
                    call.reject("Failed to purchase: \(error.localizedDescription)")
                case .none:
                  call.reject("Failed to purchase none")
                }
            } catch {
                call.reject("Failed to purchase: \(error.localizedDescription)")
            }
        }
    }

    @objc func getPurchases(_ call: CAPPluginCall) {
        Task {
            do {
              let purchases = try await Purchase.all()
                let purchasesArray = purchases.map { purchase -> [String: Any] in
                    return [
                        "purchaseId": purchase.orderUid,
                        "sku": purchase.sku,
                        "state": purchase.state
                    ]
                }
                call.resolve(["purchases": purchasesArray])
            } catch {
                call.reject("Failed to get purchases: \(error.localizedDescription)")
            }
        }
    }
}
