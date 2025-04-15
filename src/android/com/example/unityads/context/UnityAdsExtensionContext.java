package com.example.unityads.context;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.example.unityads.functions.InitFunction;
import com.example.unityads.functions.IsReadyFunction;
import com.example.unityads.functions.ShowFunction;
import com.example.unityads.functions.GetVersionFunction;
import com.example.unityads.functions.SetDebugModeFunction;
import com.example.unityads.functions.LoadFunction;

/**
 * Unity Ads扩展上下文类
 * 管理所有可从ActionScript调用的函数
 */
public class UnityAdsExtensionContext extends FREContext {

    /**
     * 映射函数名称到FREFunction实现
     * @return 函数映射表
     */
    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
        
        // 添加所有功能函数到映射表
        functionMap.put("init", new InitFunction());
        functionMap.put("isReady", new IsReadyFunction());
        functionMap.put("show", new ShowFunction());
        functionMap.put("load", new LoadFunction());
        functionMap.put("getVersion", new GetVersionFunction());
        functionMap.put("setDebugMode", new SetDebugModeFunction());
        
        return functionMap;
    }

    /**
     * 当上下文被销毁时调用
     */
    @Override
    public void dispose() {
        // 清理资源，如果需要的话
    }
}