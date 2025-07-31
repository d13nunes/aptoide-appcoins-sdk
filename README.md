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
* [`consumePurchase(...)`](#consumepurchase)
* [Interfaces](#interfaces)

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
getProducts() => Promise<{ products: Array<{ sku: string; title: string; description: string; price: number; currency: string; label: string; }>; }>
```

**Returns:** <code>Promise&lt;{ products: { sku: string; title: string; description: string; price: number; currency: string; label: string; }[]; }&gt;</code>

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
getPurchases() => Promise<{ purchases: Array<{ purchaseId: string; sku: string; state: string; }>; }>
```

**Returns:** <code>Promise&lt;{ purchases: { purchaseId: string; sku: string; state: string; }[]; }&gt;</code>

--------------------


### consumePurchase(...)

```typescript
consumePurchase(options: { purchaseId: string; }) => Promise<void>
```

| Param         | Type                                 |
| ------------- | ------------------------------------ |
| **`options`** | <code>{ purchaseId: string; }</code> |

--------------------


### Interfaces


#### Array

| Prop         | Type                | Description                                                                                            |
| ------------ | ------------------- | ------------------------------------------------------------------------------------------------------ |
| **`length`** | <code>number</code> | Gets or sets the length of the array. This is a number one higher than the highest index in the array. |

| Method             | Signature                                                                                                                     | Description                                                                                                                                                                                                                                 |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **toString**       | () =&gt; string                                                                                                               | Returns a string representation of an array.                                                                                                                                                                                                |
| **toLocaleString** | () =&gt; string                                                                                                               | Returns a string representation of an array. The elements are converted to string using their toLocalString methods.                                                                                                                        |
| **pop**            | () =&gt; T \| undefined                                                                                                       | Removes the last element from an array and returns it. If the array is empty, undefined is returned and the array is not modified.                                                                                                          |
| **push**           | (...items: T[]) =&gt; number                                                                                                  | Appends new elements to the end of an array, and returns the new length of the array.                                                                                                                                                       |
| **concat**         | (...items: <a href="#concatarray">ConcatArray</a>&lt;T&gt;[]) =&gt; T[]                                                       | Combines two or more arrays. This method returns a new array without modifying any existing arrays.                                                                                                                                         |
| **concat**         | (...items: (T \| <a href="#concatarray">ConcatArray</a>&lt;T&gt;)[]) =&gt; T[]                                                | Combines two or more arrays. This method returns a new array without modifying any existing arrays.                                                                                                                                         |
| **join**           | (separator?: string \| undefined) =&gt; string                                                                                | Adds all the elements of an array into a string, separated by the specified separator string.                                                                                                                                               |
| **reverse**        | () =&gt; T[]                                                                                                                  | Reverses the elements in an array in place. This method mutates the array and returns a reference to the same array.                                                                                                                        |
| **shift**          | () =&gt; T \| undefined                                                                                                       | Removes the first element from an array and returns it. If the array is empty, undefined is returned and the array is not modified.                                                                                                         |
| **slice**          | (start?: number \| undefined, end?: number \| undefined) =&gt; T[]                                                            | Returns a copy of a section of an array. For both start and end, a negative index can be used to indicate an offset from the end of the array. For example, -2 refers to the second to last element of the array.                           |
| **sort**           | (compareFn?: ((a: T, b: T) =&gt; number) \| undefined) =&gt; this                                                             | Sorts an array in place. This method mutates the array and returns a reference to the same array.                                                                                                                                           |
| **splice**         | (start: number, deleteCount?: number \| undefined) =&gt; T[]                                                                  | Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.                                                                                                                      |
| **splice**         | (start: number, deleteCount: number, ...items: T[]) =&gt; T[]                                                                 | Removes elements from an array and, if necessary, inserts new elements in their place, returning the deleted elements.                                                                                                                      |
| **unshift**        | (...items: T[]) =&gt; number                                                                                                  | Inserts new elements at the start of an array, and returns the new length of the array.                                                                                                                                                     |
| **indexOf**        | (searchElement: T, fromIndex?: number \| undefined) =&gt; number                                                              | Returns the index of the first occurrence of a value in an array, or -1 if it is not present.                                                                                                                                               |
| **lastIndexOf**    | (searchElement: T, fromIndex?: number \| undefined) =&gt; number                                                              | Returns the index of the last occurrence of a specified value in an array, or -1 if it is not present.                                                                                                                                      |
| **every**          | &lt;S extends T&gt;(predicate: (value: T, index: number, array: T[]) =&gt; value is S, thisArg?: any) =&gt; this is S[]       | Determines whether all the members of an array satisfy the specified test.                                                                                                                                                                  |
| **every**          | (predicate: (value: T, index: number, array: T[]) =&gt; unknown, thisArg?: any) =&gt; boolean                                 | Determines whether all the members of an array satisfy the specified test.                                                                                                                                                                  |
| **some**           | (predicate: (value: T, index: number, array: T[]) =&gt; unknown, thisArg?: any) =&gt; boolean                                 | Determines whether the specified callback function returns true for any element of an array.                                                                                                                                                |
| **forEach**        | (callbackfn: (value: T, index: number, array: T[]) =&gt; void, thisArg?: any) =&gt; void                                      | Performs the specified action for each element in an array.                                                                                                                                                                                 |
| **map**            | &lt;U&gt;(callbackfn: (value: T, index: number, array: T[]) =&gt; U, thisArg?: any) =&gt; U[]                                 | Calls a defined callback function on each element of an array, and returns an array that contains the results.                                                                                                                              |
| **filter**         | &lt;S extends T&gt;(predicate: (value: T, index: number, array: T[]) =&gt; value is S, thisArg?: any) =&gt; S[]               | Returns the elements of an array that meet the condition specified in a callback function.                                                                                                                                                  |
| **filter**         | (predicate: (value: T, index: number, array: T[]) =&gt; unknown, thisArg?: any) =&gt; T[]                                     | Returns the elements of an array that meet the condition specified in a callback function.                                                                                                                                                  |
| **reduce**         | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T) =&gt; T                           | Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.                      |
| **reduce**         | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T, initialValue: T) =&gt; T          |                                                                                                                                                                                                                                             |
| **reduce**         | &lt;U&gt;(callbackfn: (previousValue: U, currentValue: T, currentIndex: number, array: T[]) =&gt; U, initialValue: U) =&gt; U | Calls the specified callback function for all the elements in an array. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function.                      |
| **reduceRight**    | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T) =&gt; T                           | Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function. |
| **reduceRight**    | (callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) =&gt; T, initialValue: T) =&gt; T          |                                                                                                                                                                                                                                             |
| **reduceRight**    | &lt;U&gt;(callbackfn: (previousValue: U, currentValue: T, currentIndex: number, array: T[]) =&gt; U, initialValue: U) =&gt; U | Calls the specified callback function for all the elements in an array, in descending order. The return value of the callback function is the accumulated result, and is provided as an argument in the next call to the callback function. |


#### ConcatArray

| Prop         | Type                |
| ------------ | ------------------- |
| **`length`** | <code>number</code> |

| Method    | Signature                                                          |
| --------- | ------------------------------------------------------------------ |
| **join**  | (separator?: string \| undefined) =&gt; string                     |
| **slice** | (start?: number \| undefined, end?: number \| undefined) =&gt; T[] |

</docgen-api>
