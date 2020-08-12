import { WebPlugin } from '@capacitor/core';
import { ScreenOrientationPlugin } from './definitions';

export class ScreenOrientationWeb extends WebPlugin implements ScreenOrientationPlugin {
  constructor() {
    super({
      name: 'ScreenOrientation',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const ScreenOrientation = new ScreenOrientationWeb();

export { ScreenOrientation };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(ScreenOrientation);
