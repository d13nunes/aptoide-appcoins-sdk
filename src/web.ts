import { WebPlugin } from '@capacitor/core';

import type { AppCoinsSdkPlugin } from './definitions';

export class AppCoinsSdkWeb extends WebPlugin implements AppCoinsSdkPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
