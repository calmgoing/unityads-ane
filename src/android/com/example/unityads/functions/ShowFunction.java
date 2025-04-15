package com.example.unityads.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

import com.unity3d.ads.IUnityAdsShowListener;
import com.unity3d.ads.UnityAds;

/**
 * 显示Unity Ads广告的函数
 */
public class ShowFunction implements FREFunction, IUnityAdsShowListener {
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
            
            Log.d(TAG, "Showing Unity Ads for placement: " + placementId);
            
            // 显示广告
            if (placementId.isEmpty()) {
                // 在新版Unity Ads SDK中，必须指定placementId
                Log.w(TAG, "Unity Ads requires a placement ID in newer SDK versions");
                ctx.dispatchStatusEventAsync("UNITY_ADS_ERROR", "Placement ID is required");
            } else {
                UnityAds.show(ctx.getActivity(), placementId, this);
            }
            
            return null;
            
        } catch (FRETypeMismatchException e) {
            Log.e(TAG, "Type mismatch in ShowFunction: " + e.getMessage());
            dispatchStatusEvent("UNITY_ADS_ERROR", "Type mismatch: " + e.getMessage());
        } catch (FREInvalidObjectException e) {
            Log.e(TAG, "Invalid object in ShowFunction: " + e.getMessage());
            dispatchStatusEvent("UNITY_ADS_ERROR", "Invalid object: " + e.getMessage());
        } catch (FREWrongThreadException e) {
            Log.e(TAG, "Wrong thread in ShowFunction: " + e.getMessage());
            dispatchStatusEvent("UNITY_ADS_ERROR", "Wrong thread: " + e.getMessage());
        } catch (Exception e) {
            Log.e(TAG, "Exception in ShowFunction: " + e.getMessage());
            dispatchStatusEvent("UNITY_ADS_ERROR", "Exception: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * 广告开始显示回调
     * @param placementId 广告位ID
     */
    @Override
    public void onUnityAdsShowStart(String placementId) {
        Log.d(TAG, "Unity Ads show start for placement: " + placementId);
        dispatchStatusEvent("UNITY_ADS_SHOW_START", placementId);
    }
    
    /**
     * 广告点击回调
     * @param placementId 广告位ID
     */
    @Override
    public void onUnityAdsShowClick(String placementId) {
        Log.d(TAG, "Unity Ads show click for placement: " + placementId);
        dispatchStatusEvent("UNITY_ADS_SHOW_CLICK", placementId);
    }
    
    /**
     * 广告显示完成回调
     * @param placementId 广告位ID
     * @param finishState 完成状态
     */
    @Override
    public void onUnityAdsShowComplete(String placementId, UnityAds.UnityAdsShowCompletionState finishState) {
        Log.d(TAG, "Unity Ads show complete for placement: " + placementId + ", state: " + finishState.name());
        dispatchStatusEvent("UNITY_ADS_SHOW_COMPLETE", placementId + "," + finishState.name());
    }
    
    /**
     * 广告显示失败回调
     * @param placementId 广告位ID
     * @param error 错误信息
     * @param message 错误消息
     */
    @Override
    public void onUnityAdsShowFailure(String placementId, UnityAds.UnityAdsShowError error, String message) {
        Log.e(TAG, "Unity Ads show failure for placement: " + placementId + ", error: " + error.name() + " - " + message);
        dispatchStatusEvent("UNITY_ADS_SHOW_FAILURE", placementId + "," + error.name() + "," + message);
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