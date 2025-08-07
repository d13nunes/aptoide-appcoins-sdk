import type { PluginListenerHandle } from '@capacitor/core';

export interface AppCoinsSdkPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  isAvailable(): Promise<{ isAvailable: boolean }>;
  getProducts(): Promise<{ products: AptoideProduct[] }>;
  purchase(options: { sku: string }): Promise<{ purchaseId: string; sku: string; state: string }>;
  getPurchases(): Promise<{ purchases: AptoidePurchase[] }>;
  addListener(eventName: 'transaction', listenerFunc: (event: TransactionEvent) => void): Promise<PluginListenerHandle>;
  // consumePurchase(options: { purchaseId: string }): Promise<void>;
}
export interface TransactionEvent {
    type: 'success' | 'error';
    sku?: string;
    message?: string;
}
// Aptoide types for mapping
export type AptoideProduct = {
	sku: string;
	title: string;
	description: string;
	price: string;
	currency: string;
};

export type AptoidePurchase = {
	purchaseId: string;
	sku: string;
	state: string;
};