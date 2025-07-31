export interface AppCoinsSdkPlugin {
  isAvailable(): Promise<{ isAvailable: boolean }>;
  getProducts(): Promise<{ products: Product[] }>;
  purchase(options: { sku: string }): Promise<Purchase>;
  getPurchases(): Promise<{ purchases: Purchase[] }>;
  consumePurchase(options: { purchaseId: string }): Promise<void>;
}

export interface Product {
  sku: string;
  title: string;
  description: string;
  price: string;
  currency: string;
}

export interface Purchase {
  purchaseId: string;
  sku: string;
  state: string;
}
