# Ionic Capacitor Screen Orientation

For detailed tutorial on how to use this plugin visit:
https://medium.com/@hinddeep.purohit007/handling-screen-orientation-changes-in-capacitor-apps-19fe339578a6 

Platforms Supported: Android, iOS

The Capacitor plugin I’ve developed can be used to detect the current of orientation of the screen, lock the screen in a particular orientation (disable auto-rotate) or unlock screen rotation (enable auto-rotate) and to listen for orientation changes.

# Installation <br/>

<i> npm install capacitor-screen-orientation </i>

# Android Configuration: <br/>

Open MainActivity.java and add the following code inside this.init() <br/>
<i> add(ScreenOrientation.class); </i> <br/>
Adding the above mentioned line will add the following import statement: <br/>
<i> import com.bkon.capacitor.screenorientation.ScreenOrientation; </i> <br/>
If you encounter errors, please add both the lines manually to MainActivity.java <br/><br/>

If you want to listen for the orientation change event on Android: <br/>

1. Open “AndroidManifest.xml” for your app <br/>
2. Find the Activity tag <br/>
3. Go to android:configChanges=”...” <br/>
4. Remove ‘orientation |’ from configChanges <br/> <br/>

Supported Orientations: <br/>

1. LANDSCAPE: left of right is decided by the device’s sensor <br/>
2. LANDSCAPE_PRIMARY: explicitly specified by developer <br/>
3. LANDSCAPE_SECONDARY: explicitly specified by developer <br/>
4. PORTRAIT: up or upside down is decided by the device’s sensor <br/>
5. PORTRAIT_PRIMARY: explicitly specified by the user <br/>
6. PORTRAIT_SECONDARY: explicitly specified by the user <br/>
7. CURRENT: current orientation of the device <br/>

<b>SPECIAL NOTE: Ionic has implicitly disabled PORTRAIT_SECONDARY. </b><br/>

# iOS Configuration: <br/>

If you want to lock the screen to the specified orientation on iOS: <br/>

1. Open AppDelegate.swift for your app <br/>
2. Add the following code: <br/>

var orientationLock = UIInterfaceOrientationMask.all <br/><br/>

func application(\_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { <br/>
return self.orientationLock <br/>
} <br/>

Supported Orientations: <br/>

1. all: all orientations <br/>
2. allButUpsideDown: all orientations other than upside down <br/>
3. landscape: left of right is decided by the device’s sensor <br/>
4. landscapeLeft: explicitly specified by the user <br/>
5. landscapeRight: explicitly specified by the user <br/>
6. portrait: up or upside down is decided by the device’s sensor <br/>
7. portraitUpsideDown: explicitly specified by the user <br/>

<b> SPECIAL NOTE: Ionic has implicitly disabled portraitUpsideDown. </b> <br/>

# Import the Plugin in your Web app <br/>

Open app.component.ts file and import the plugin as follows: <br/>
<i> import { Plugins } from "@capacitor/core";</i> <br/>
<i> const { ScreenOrientation } = Plugins;</i> <br/>

# Handle screen orientation:

1. Create a function to get the current screen orientation: <br/>
   async getOrientation() { <br/>
   let obj = await ScreenOrientation.getScreenOrientation(); <br/>
   this.screen_orientation = obj.orientation; <br/>
   } <br/>

2. Create a function to lock the screen in a particular orientation:
   async lockOrientation() { <br/>
   await ScreenOrientation.lockScreenOrientation({ <br/>
   orientation: this.screen_orientation_lock, <br/>
   }); <br/>
   } <br/>

Supported values for screen_orientation_lock variable: <br/>

1. LANDSCAPE_PRIMARY (Android and iOS) <br/>
2. PORTRAIT_PRIMARY (Android and iOS) <br/>
3. LANDSCAPE_SECONDARY (Android and iOS) <br/>
4. PORTRAIT_SECONDARY (Android and iOS) <br/>
5. LANDSCAPE (Android only) <br/>
6. PORTRAIT (Android only) <br/>
7. CURRENT (Android only) <br/>

3) Create a function to unlock screen rotation: <br/>
   async UnlockOrientation() { <br/>
   await ScreenOrientation.unlockScreenOrientation({}); <br/>
   } <br/>

4) Create a function that handles subscription to the orientation change event: <br/>
   subscribeToOrientationChanges() { <br/>
   ScreenOrientation.addListener("orientation_changed", (data) => { <br/>
   this.screen_orientation_event = data.orientation; <br/>
   }); <br/>
   } <br/>
