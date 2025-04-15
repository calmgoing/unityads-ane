package com.example.unityads.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

import com.unity3d.ads.UnityAds;

/**
 * 设置Unity Ads调试模式的函数
 */
public class SetDebugModeFunction implements FREFunction {
    private static final String TAG = "UnityAdsANE";
    
    /**
     * 调用函数
     * @param ctx FREContext
     * @param args 参数数组
     * @return FREObject 返回值
     */
    @Override
    public FREObject call(FREContext ctx, FREObject[] args) {
        try {
            // 获取调试模式参数
            boolean debugMode = false;
            if (args.length > 0 && args[0] != null) {
                debugMode = args[0].getAsBool();
            }
            
            Log.d(TAG, "Setting Unity Ads debug mode: " + debugMode);
            
            // 设置调试模式
            UnityAds.setDebugMode(debugMode);
            
            return null;
            
        } catch (FRETypeMismatchException e) {
            Log.e(TAG, "Type mismatch in SetDebugModeFunction: " + e.getMessage());
            ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Type mismatch: " + e.getMessage());
        } catch (FREInvalidObjectException e) {
            Log.e(TAG, "Invalid object in SetDebugModeFunction: " + e.getMessage());
            ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Invalid object: " + e.getMessage());
        } catch (FREWrongThreadException e) {
            Log.e(TAG, "Wrong thread in SetDebugModeFunction: " + e.getMessage());
            ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Wrong thread: " + e.getMessage());
        } catch (Exception e) {
            Log.e(TAG, "Exception in SetDebugModeFunction: " + e.getMessage());
            ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Exception: " + e.getMessage());
        }
        
        return null;
    }
}