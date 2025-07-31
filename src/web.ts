import { WebPlugin } from '@capacitor/core';

import type { AppCoinsSdkPlugin } from './definitions';

export class AppCoinsSdkWeb extends WebPlugin implements AppCoinsSdkPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async isAvailable(): Promise<{ isAvailable: boolean }> {
    console.log('isAvailable called on web');
    return { isAvailable: false };
  }

  async getProducts(): Promise<{ products: Array<{ sku: string; title: string; description: string; price: number; currency: string; label: string }> }> {
    console.log('getProducts called on web');
    return { products: [] };
  }

  async purchase(options: { sku: string }): Promise<{ purchaseId: string; sku: string; state: string }> {
    console.log('purchase called on web', options);
    throw new Error('Purchase not supported on web');
  }

  async getPurchases(): Promise<{ purchases: Array<{ purchaseId: string; sku: string; state: string }> }> {
    console.log('getPurchases called on web');
    return { purchases: [] };
  }

  async consumePurchase(options: { purchaseId: string }): Promise<void> {
    console.log('consumePurchase called on web', options);
    throw new Error('Consume purchase not supported on web');
  }
}
