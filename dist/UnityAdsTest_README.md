# Unity Ads ANE 测试应用

这是一个用于测试Unity Ads ANE的ActionScript 3.0测试应用。本应用演示了如何在AIR应用中集成和使用Unity Ads广告服务。

## 使用说明

### 1. 配置游戏ID

在使用测试应用前，请先在`UnityAdsTest.as`文件中配置您的Unity Ads游戏ID和广告位ID：

```actionscript
// 游戏ID，请替换为您的Unity Ads游戏ID
private const GAME_ID:String = "YOUR_GAME_ID";

// 广告位ID，请替换为您的广告位ID
private const REWARDED_PLACEMENT_ID:String = "rewardedVideo";
private const INTERSTITIAL_PLACEMENT_ID:String = "interstitial";
```

### 2. 编译应用

使用Adobe AIR SDK编译应用：

```bash
# 编译SWF文件
amxmlc -swf-version=33 -debug=false -optimize=true -o UnityAdsTest.swf UnityAdsTest.as

# 打包AIR应用（Android）
adt -package -target apk-debug -storetype pkcs12 -keystore your_certificate.p12 -storepass your_password UnityAdsTest.apk application.xml UnityAdsTest.swf -extdir libs
```

注意：确保将`UnityAdsANE.ane`文件放在`libs`目录中。

### 3. 运行应用

安装编译好的APK文件到Android设备上，或者使用ADL直接运行：

```bash
adl -profile mobileDevice application.xml
```

## 功能说明

测试应用提供了以下功能：

1. **初始化Unity Ads**：点击"初始化Unity Ads"按钮初始化SDK
2. **显示激励广告**：点击"显示激励广告"按钮展示激励视频广告
3. **显示插屏广告**：点击"显示插屏广告"按钮展示插屏广告

应用会在界面上显示广告状态和事件信息，同时也会通过HzqAne的日志功能输出详细信息。

## 事件处理

测试应用演示了如何处理Unity Ads的各种事件：

- 初始化完成/失败
- 广告准备就绪
- 广告开始显示
- 广告被点击
- 广告显示完成
- 广告显示失败
- 其他错误

## 注意事项

1. 测试时建议使用Unity Ads的测试模式（已在代码中设置为true）
2. 确保在真实设备上测试，模拟器可能无法正常显示广告
3. 确保设备有网络连接
4. 首次初始化可能需要一些时间才能加载广告