import { WebPlugin } from '@capacitor/core';

import type { AppCoinsSdkPlugin, Product, Purchase } from './definitions';

export class AppCoinsSdkWeb extends WebPlugin implements AppCoinsSdkPlugin {
  async isAvailable(): Promise<{ isAvailable: boolean }> {
    throw this.unimplemented('Not implemented on web.');
  }

  async getProducts(): Promise<{ products: Product[] }> {
    throw this.unimplemented('Not implemented on web.');
  }

  async purchase(options: { sku: string }): Promise<Purchase> {
    console.log(options);
    throw this.unimplemented('Not implemented on web.');
  }

  async getPurchases(): Promise<{ purchases: Purchase[] }> {
    throw this.unimplemented('Not implemented on web.');
  }

  async consumePurchase(options: { purchaseId: string }): Promise<void> {
    console.log(options);
    throw this.unimplemented('Not implemented on web.');
  }
}
