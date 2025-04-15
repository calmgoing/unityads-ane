package com.example.unityads;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.example.unityads.context.UnityAdsExtensionContext;

/**
 * Unity Ads ANE的主扩展类
 * 实现FREExtension接口，作为ANE的入口点
 */
public class UnityAdsExtension implements FREExtension {
    
    /**
     * 创建扩展上下文
     * @return FREContext 扩展上下文实例
     */
    @Override
    public FREContext createContext(String contextType) {
        return new UnityAdsExtensionContext();
    }
    
    /**
     * 初始化扩展
     * 在ANE首次加载时调用
     */
    @Override
    public void initialize() {
        // 初始化代码，如果需要的话
    }
    
    /**
     * 释放扩展资源
     * 在ANE卸载时调用
     */
    @Override
    public void dispose() {
        // 清理资源，如果需要的话
    }
}