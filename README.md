# Unity Ads ANE

这是一个适用于Adobe AIR的Unity Ads原生扩展(ANE)，它允许你在Adobe AIR应用或游戏中集成Unity广告功能。

## 特点

- 支持Unity Ads 4.14.1
- 支持常见的广告类型（插页式广告、激励视频等）
- 适用于Android平台
- 支持AIR 51.1+

## 安装

1. 下载最新的 `UnityAdsANE.ane` 文件（在 `dist` 目录中）
2. 将ANE添加到你的AIR项目中
3. 修改你的应用描述符XML文件，添加以下内容：

```xml
<extensions>
    <extensionID>com.example.unityads</extensionID>
</extensions>

<!-- 针对Android的权限 -->
<android>
    <manifestAdditions><![CDATA[
        <manifest android:installLocation="auto">
            <uses-permission android:name="android.permission.INTERNET"/>
            <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
            
            <application>
                <!-- Unity Ads配置 -->
                <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="YOUR_ADMOB_APP_ID"/>
            </application>
        </manifest>
    ]]></manifestAdditions>
</android>
```

## 用法

### 初始化SDK

```actionscript
// 导入类
import com.example.unityads.UnityAds;

// 初始化SDK
UnityAds.init("YOUR_UNITY_GAME_ID", false); // 第二个参数为调试模式标志
```

### 加载广告

```actionscript
// 加载插页式广告
UnityAds.loadInterstitial("interstitial_placement_id");

// 加载激励视频广告
UnityAds.loadRewardedVideo("rewarded_video_placement_id");
```

### 显示广告

```actionscript
// 显示插页式广告
UnityAds.showInterstitial("interstitial_placement_id");

// 显示激励视频广告
UnityAds.showRewardedVideo("rewarded_video_placement_id");
```

### 事件监听

```actionscript
// 添加事件监听器
UnityAds.addEventListener(UnityAdsEvent.READY, onAdReady);
UnityAds.addEventListener(UnityAdsEvent.START, onAdStart);
UnityAds.addEventListener(UnityAdsEvent.COMPLETE, onAdComplete);
UnityAds.addEventListener(UnityAdsEvent.SKIPPED, onAdSkipped);
UnityAds.addEventListener(UnityAdsEvent.ERROR, onAdError);

// 事件处理函数
private function onAdReady(event:UnityAdsEvent):void {
    trace("广告准备就绪: " + event.placementId);
}

private function onAdStart(event:UnityAdsEvent):void {
    trace("广告开始播放: " + event.placementId);
}

private function onAdComplete(event:UnityAdsEvent):void {
    trace("广告播放完成: " + event.placementId);
    // 在这里处理奖励逻辑
}

private function onAdSkipped(event:UnityAdsEvent):void {
    trace("广告被跳过: " + event.placementId);
}

private function onAdError(event:UnityAdsEvent):void {
    trace("广告错误: " + event.placementId + ", 错误: " + event.message);
}
```

## 构建项目

如果你想自己构建ANE，请按照以下步骤操作：

1. 克隆此仓库
2. 确保您已安装Adobe AIR SDK、Android SDK和JDK
3. 使用Gradle 8.4下载最新的Unity Ads和相关依赖
4. 运行`ant -f build/build.xml`构建ANE文件

## 依赖项

- Adobe AIR SDK 51.1+
- Unity Ads 4.14.1
- Android SDK API Level 34
- Gradle 8.4 (用于构建)

## 注意事项

- 本ANE仅支持Android平台
- 确保在发布应用前正确配置了Unity广告平台上的游戏ID和广告位ID

## 许可

MIT 许可证 