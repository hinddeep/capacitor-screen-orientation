import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ScreenOrientation)
public class ScreenOrientation: CAPPlugin, UIApplicationDelegate {

    override public func load() {
NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
     @objc func rotated()
    {
        var orientation:String
        orientation = fetchScreenOrientation()
        notifyListeners("orientation_changed", data: [
            "orientation": orientation
        ], retainUntilConsumed: true)
    }

    @objc func getScreenOrientation(_ call: CAPPluginCall) {
      var orientation:String
      orientation = fetchScreenOrientation()
        call.success([
            "orientation": orientation
        ])
    }

    func fetchScreenOrientation() -> String
    {
        var orientation:String
        switch UIDevice.current.orientation {
               case UIDeviceOrientation.landscapeLeft:
                   orientation = "LANDSCAPE_PRIMARY"
                   break
               case UIDeviceOrientation.landscapeRight:
                   orientation = "LANDSCAPE_SECONDARY"
                   break
               case UIDeviceOrientation.portrait:
                   orientation = "PORTRAIT_PRIMARY"
                   break
               case UIDeviceOrientation.portraitUpsideDown:
                   orientation = "PORTRAIT_SECONDARY"
                   break
               default:
                   orientation = "UNSPECIFIED"
               }
        return orientation
    }
    
    @objc public func lockScreenOrientation(_ call: CAPPluginCall) {
       DispatchQueue.main.async {
        let value = self.translateOrientation(call)
        let lock = ["orientation":value]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CAPOrientationLocked"), object: self, userInfo: lock )
            UIDevice.current.setValue(value, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
    
     @objc public func unlockScreenOrientation(_ call: CAPPluginCall) {
        let lock = ["orientation":0]
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CAPOrientationLocked"), object: self, userInfo: lock )
    }
    
    @objc public func rotateTo(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let value = self.translateOrientation(call)
            UIDevice.current.setValue(value, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }

    func translateOrientation(_ call: CAPPluginCall) -> Int 
    {
        let orientation = call.getString("orientation") ?? ""
        var value: Int
        value = 0
        switch orientation {
                case "PORTRAIT":
                    value = UIInterfaceOrientation.portrait.rawValue
                    break
                case "PORTRAIT_PRIMARY":
                    value = UIInterfaceOrientation.portrait.rawValue
                    break
                case "PORTRAIT_SECONDARY":
                    value = UIInterfaceOrientation.portraitUpsideDown.rawValue
                    break
                case "LANDSCAPE":
                    value = 5
                    break
                case "LANDSCAPE_PRIMARY":
                    value = UIInterfaceOrientation.landscapeLeft.rawValue
                    break
                case "LANDSCAPE_SECONDARY":
                    value = UIInterfaceOrientation.landscapeRight.rawValue
                    break
                case "CURRENT":
                    value = UIDevice.current.orientation.rawValue
                    break
                default:
                    print("UNSPECIFIED")
                }
        return value
    }
}
