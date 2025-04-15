package com.example.unityads.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

import com.unity3d.ads.IUnityAdsLoadListener;
import com.unity3d.ads.UnityAds;

/**
 * 加载Unity Ads广告的函数
 */
public class LoadFunction implements FREFunction, IUnityAdsLoadListener {
    private static final String TAG = "UnityAdsANE";
    private FREContext context;
    
    /**
     * 调用函数
     * @param ctx FREContext
     * @param args 参数数组
     * @return FREObject 返回值
     */
    @Override
    public FREObject call(FREContext ctx, FREObject[] args) {
        this.context = ctx;
        
        try {
            // 获取广告位ID参数
            String placementId = "";
            if (args.length > 0 && args[0] != null) {
                placementId = args[0].getAsString();
            }
            
            Log.d(TAG, "Loading Unity Ads for placement: " + placementId);
            
            // 加载广告
            if (placementId.isEmpty()) {
                Log.w(TAG, "Unity Ads requires a placement ID");
                ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Placement ID is required");
            } else {
                UnityAds.load(placementId, this);
            }
            
            return null;
            
        } catch (Exception e) {
            Log.e(TAG, "Exception in LoadFunction: " + e.getMessage());
            dispatchStatusEvent("UNITY_ADS_ERROR", "Exception: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * 广告加载成功回调
     * @param placementId 广告位ID
     */
    @Override
    public void onUnityAdsAdLoaded(String placementId) {
        Log.d(TAG, "Unity Ads loaded successfully for placement: " + placementId);
        dispatchStatusEvent("UNITY_ADS_LOAD_COMPLETE", placementId);
    }
    
    /**
     * 广告加载失败回调
     * @param placementId 广告位ID
     * @param error 错误信息
     * @param message 错误消息
     */
    @Override
    public void onUnityAdsFailedToLoad(String placementId, UnityAds.UnityAdsLoadError error, String message) {
        Log.e(TAG, "Unity Ads failed to load for placement: " + placementId + ", error: " + error.name() + " - " + message);
        dispatchStatusEvent("UNITY_ADS_LOAD_FAILED", placementId + "," + error.name() + "," + message);
    }
    
    /**
     * 发送状态事件到ActionScript
     * @param code 事件代码
     * @param level 事件级别/消息
     */
    private void dispatchStatusEvent(String code, String level) {
        if (context != null) {
            context.dispatchStatusEventAsync(code, level);
        }
    }
}