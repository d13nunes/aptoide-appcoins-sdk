# aptoide-appcoinssdk

Unofficial Capacitor plugin for appcoins-sdk

## Install

```bash
npm install aptoide-appcoinssdk
npx cap sync
```

# Setup
## iOS 

### Add AppCoins SDK Swift Package
Nothing need here the capacitor plugin already manages this

The following setup instructions could be outdate please check the Aptoide official documentation for iOS setup https://github.com/Catappult/appcoins-sdk-ios 

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

## API

<docgen-index>

* [`echo(...)`](#echo)

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

</docgen-api>
