package com.example.unityads.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

import com.unity3d.ads.UnityAds;

/**
 * 获取Unity Ads SDK版本的函数
 */
public class GetVersionFunction implements FREFunction {
    private static final String TAG = "UnityAdsANE";
    
    /**
     * 调用函数
     * @param ctx FREContext
     * @param args 参数数组
     * @return FREObject 返回值，表示Unity Ads SDK版本
     */
    @Override
    public FREObject call(FREContext ctx, FREObject[] args) {
        try {
            Log.d(TAG, "Getting Unity Ads SDK version");
            
            // 获取Unity Ads SDK版本
            String version = UnityAds.getVersion();
            
            Log.d(TAG, "Unity Ads SDK version: " + version);
            
            // 返回版本信息到ActionScript
            return FREObject.newObject(version);
            
        } catch (FREWrongThreadException e) {
            Log.e(TAG, "Wrong thread in GetVersionFunction: " + e.getMessage());
            ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Wrong thread: " + e.getMessage());
        } catch (Exception e) {
            Log.e(TAG, "Exception in GetVersionFunction: " + e.getMessage());
            ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Exception: " + e.getMessage());
        }
        
        // 发生错误时返回空字符串
        try {
            return FREObject.newObject("");
        } catch (FREWrongThreadException e) {
            Log.e(TAG, "Error creating return value: " + e.getMessage());
            return null;
        }
    }
}