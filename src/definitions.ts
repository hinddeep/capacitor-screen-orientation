declare module '@capacitor/core' {
  interface PluginRegistry {
    ScreenOrientation: ScreenOrientationPlugin;
  }
}

export interface ScreenOrientationPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
