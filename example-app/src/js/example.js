import { AppCoinsSdk } from 'capacitor-appcoins-sdk';

async function loadProducts() {
  try {
    const { products } = await AppCoinsSdk.getProducts();
    const productsDiv = document.getElementById('products');
    productsDiv.innerHTML = '';
    products.forEach(product => {
      const container = document.createElement('div');
      container.textContent = `${product.title} - ${product.price} ${product.currency}`;
      const btn = document.createElement('button');
      btn.textContent = `Buy`;
      btn.onclick = () => buyProduct(product.sku);
      container.appendChild(btn);
      productsDiv.appendChild(container);
    });
  } catch (e) {
    document.getElementById('products').textContent = 'Failed to load products.';
  }
}

async function buyProduct(sku) {
  try {
    const purchase = await AppCoinsSdk.purchase({ sku });
    alert('Purchase successful: ' + JSON.stringify(purchase));
    loadPurchases();
  } catch (e) {
    alert('Purchase failed: ' + (e.message || e));
  }
}

async function consumePurchase(purchaseId) {
  try {
    await AppCoinsSdk.consumePurchase({ purchaseId });
    alert('Purchase consumed successfully!');
    loadPurchases();
  } catch (e) {
    alert('Failed to consume purchase: ' + (e.message || e));
  }
}

async function loadPurchases() {
  try {
    const { purchases } = await AppCoinsSdk.getPurchases();
    const purchasesDiv = document.getElementById('purchases');
    purchasesDiv.innerHTML = '';
    purchases.forEach(p => {
      const div = document.createElement('div');
      div.textContent = `SKU: ${p.sku}, ID: ${p.purchaseId}, State: ${p.state}`;
      const btn = document.createElement('button');
      btn.textContent = 'Consume';
      btn.onclick = () => consumePurchase(p.purchaseId);
      div.appendChild(btn);
      purchasesDiv.appendChild(div);
    });
  } catch (e) {
    document.getElementById('purchases').textContent = 'Failed to load purchases.';
  }
}

window.onload = () => {
  loadProducts();
  loadPurchases();
};

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    AppCoinsSdk.echo({ value: inputValue })
}
