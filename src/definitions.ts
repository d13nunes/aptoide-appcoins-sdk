export interface AppCoinsSdkPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
