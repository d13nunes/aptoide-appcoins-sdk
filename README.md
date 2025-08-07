# aptoide-appcoinssdk

Unofficial Capacitor plugin for appcoins-sdk



## Install

```bash
npm install aptoide-appcoinssdk
npx cap sync
```

# Setup
## iOS 
The following setup instructions could be outdate please check the Aptoide official documentation for iOS setup https://github.com/Catappult/appcoins-sdk-ios 
This plugins was build to work with SPM, not sure if it will work with podspecs. Check official documentation on how to migrate https://capacitorjs.com/docs/ios/spm#using-spm-in-an-existing-capacitor-project

### Add AppCoins SDK Swift Package
In XCode add the Swift Package from the repo https://github.com/Catappult/appcoins-sdk-ios.git.
This is needed in order to call App Coins Sdk methods in Application Delegate

### Add AppCoins SDK Keychain Access Entitlement
In order to enable the AppCoins SDK to save the user’s AppCoins Wallet information in the keychain, the application will need to concede the SDK Keychain Access entitlements. To do so, follow these steps:

1. Select your project in the project navigator (left sidebar);
2. Select your target under "TARGETS";
3. Go to the "Signing & Capabilities" tab;
4. Click the "+" button to add a new capability;
5. Search for "Keychain Sharing" and select it;
6. Enable the "Keychain Sharing" capability by double-clicking it;
7. This will automatically write your app’s identifier in the "Keychain Groups" text box, you should replace it with **com.aptoide.appcoins-wallet**;
8. Xcode will automatically generate an entitlements file (e.g., YourAppName.entitlements) and add it to your project;

### Add AppCoins SDK URL Type
To manage redirect deep links for specific payment method integrations, your application must include a URL Type in the info.plist file. To do this, follow these steps:

1. In the project navigator (left sidebar), select your project.
2. Under "TARGETS", select your target.
3. Navigate to the "Info" tab.
4. Scroll down to the "URL Types" section.
5. Click the "+" button to add a new URL Type.
6. Set the URL Scheme to **$(PRODUCT_BUNDLE_IDENTIFIER).iap** and the role to "Editor".

### Handle the Redirect

**AppDelegate.swift**
Deep link handling in AppDelegate.swift.

# Testing 
Check Aptoide documentation https://github.com/Catappult/appcoins-sdk-ios?tab=readme-ov-file#testing
Sandbox environment https://docs.catappult.io/docs/ios-sandbox-environment

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  // Your application initialization
  initialize()

  if let url = launchOptions?[.url] as? URL {
    if AppcSDK.handle(redirectURL: url) { return true }
  }
  return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
  if AppcSDK.handle(redirectURL: url) { return true }
  
  // Your application initialization
  initialize()
  return true
}
```

Why This Logic?

Initialize First in `didFinishLaunchingWithOptions`

Ensure UI and dependencies are ready before processing deep links.
Handling deep links too early could cause issues if services aren’t initialized.
Prioritize Deep Links in open url

When a deep link is received while the app is running, handle it immediately.
If `AppcSDK.handle(redirectURL:)` processes the link, return early.

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`isAvailable()`](#isavailable)
* [`getProducts()`](#getproducts)
* [`purchase(...)`](#purchase)
* [`getPurchases()`](#getpurchases)
* [`addListener('transaction', ...)`](#addlistenertransaction-)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### isAvailable()

```typescript
isAvailable() => Promise<{ isAvailable: boolean; }>
```

**Returns:** <code>Promise&lt;{ isAvailable: boolean; }&gt;</code>

--------------------


### getProducts()

```typescript
getProducts() => Promise<{ products: AptoideProduct[]; }>
```

**Returns:** <code>Promise&lt;{ products: AptoideProduct[]; }&gt;</code>

--------------------


### purchase(...)

```typescript
purchase(options: { sku: string; }) => Promise<{ purchaseId: string; sku: string; state: string; }>
```

| Param         | Type                          |
| ------------- | ----------------------------- |
| **`options`** | <code>{ sku: string; }</code> |

**Returns:** <code>Promise&lt;{ purchaseId: string; sku: string; state: string; }&gt;</code>

--------------------


### getPurchases()

```typescript
getPurchases() => Promise<{ purchases: AptoidePurchase[]; }>
```

**Returns:** <code>Promise&lt;{ purchases: AptoidePurchase[]; }&gt;</code>

--------------------


### addListener('transaction', ...)

```typescript
addListener(eventName: 'transaction', listenerFunc: (event: TransactionEvent) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                              |
| ------------------ | --------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'transaction'</code>                                                        |
| **`listenerFunc`** | <code>(event: <a href="#transactionevent">TransactionEvent</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### Interfaces


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### TransactionEvent

| Prop          | Type                              |
| ------------- | --------------------------------- |
| **`type`**    | <code>'error' \| 'success'</code> |
| **`sku`**     | <code>string</code>               |
| **`message`** | <code>string</code>               |


### Type Aliases


#### AptoideProduct

<code>{ 	sku: string; 	title: string; 	description: string; 	price: string; 	currency: string; }</code>


#### AptoidePurchase

<code>{ 	purchaseId: string; 	sku: string; 	state: string; }</code>

</docgen-api>
