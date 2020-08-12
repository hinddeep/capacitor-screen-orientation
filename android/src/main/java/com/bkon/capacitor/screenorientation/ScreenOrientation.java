package com.bkon.capacitor.screenorientation;

import android.content.pm.ActivityInfo;
import android.view.Surface;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

@NativePlugin
public class ScreenOrientation extends Plugin {

    @PluginMethod
    public void getScreenOrientation(PluginCall call) {
        JSObject ret;
        ret = new JSObject();
        String orientation = fetchScreenOrientation();
        ret.put("orientation", orientation);
        call.success(ret);
    }

    private String fetchScreenOrientation() {
        int rotation = getBridge().getActivity().getWindowManager().getDefaultDisplay().getRotation();
        switch (rotation) {
            case Surface.ROTATION_0:
                return "PORTRAIT_PRIMARY";
            case Surface.ROTATION_90:
                return "LANDSCAPE_PRIMARY";
            case Surface.ROTATION_180:
                return "PORTRAIT_SECONDARY";
            case Surface.ROTATION_270:
                return "LANDSCAPE_SECONDARY";
        }
        return "UNSPECIFIED";
    }

    @PluginMethod
    public void lockScreenOrientation(PluginCall call) {
        String orientation = call.getString("orientation");
        switch (orientation) {
            case "LANDSCAPE_PRIMARY":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                break;
            case "PORTRAIT_PRIMARY":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
                break;
            case "LANDSCAPE_SECONDARY":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE);
                break;
            case "PORTRAIT_SECONDARY":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT);
                break;
            case "LANDSCAPE":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE);
                break;
            case "PORTRAIT":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT);
                break;
            case "CURRENT":
                getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LOCKED);
                break;
        }

    }

    @PluginMethod
    public void unlockScreenOrientation(PluginCall call) {
        getBridge().getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED);
    }

    @Override
    protected void handleOnStart() {
        JSObject ret;
        ret = new JSObject();
        String orientation = fetchScreenOrientation();
        ret.put("orientation", orientation);
        notifyListeners("orientation_changed", ret, true);
    }

}