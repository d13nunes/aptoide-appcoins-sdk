import { registerPlugin } from '@capacitor/core';

import type { AppCoinsSdkPlugin } from './definitions';

const AppCoinsSdk = registerPlugin<AppCoinsSdkPlugin>('AppCoinsSdk', {
  web: () => import('./web').then((m) => new m.AppCoinsSdkWeb()),
});

export * from './definitions';
export { AppCoinsSdk };
