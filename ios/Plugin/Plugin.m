#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(ScreenOrientation, "ScreenOrientation",
           CAP_PLUGIN_METHOD(getScreenOrientation, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(lockScreenOrientation, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(unlockScreenOrientation, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(rotateTo, CAPPluginReturnPromise);
)
