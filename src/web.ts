import { WebPlugin } from '@capacitor/core';
import type { PluginListenerHandle } from '@capacitor/core';

import type { AppCoinsSdkPlugin, AptoideProduct, AptoidePurchase, TransactionEvent } from './definitions';

export class AppCoinsSdkWeb extends WebPlugin implements AppCoinsSdkPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async isAvailable(): Promise<{ isAvailable: boolean }> {
    console.log('isAvailable called on web');
    return { isAvailable: false };
  }

  async getProducts(): Promise<{ products: AptoideProduct[] }> {
    console.log('getProducts called on web');
    return { products: [] };
  }

  async purchase(options: { sku: string }): Promise<{ purchaseId: string; sku: string; state: string }> {
    console.log('purchase called on web', options);
    throw new Error('Purchase not supported on web');
  }

  async getPurchases(): Promise<{ purchases: AptoidePurchase[] }> {
    console.log('getPurchases called on web');
    throw new Error('Purchase not supported on web');
  }

  async addListener(eventName: 'transaction', listenerFunc: (event: TransactionEvent) => void): Promise<PluginListenerHandle> {
    console.log('listen called on web', eventName, listenerFunc);
    throw new Error('Purchase not supported on web');
  }
}
