import { WebPlugin } from '@capacitor/core';
import { ScreenOrientationPlugin } from './definitions';
export declare class ScreenOrientationWeb extends WebPlugin implements ScreenOrientationPlugin {
    constructor();
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
declare const ScreenOrientation: ScreenOrientationWeb;
export { ScreenOrientation };
