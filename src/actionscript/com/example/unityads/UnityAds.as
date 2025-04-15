package com.example.unityads {
    import flash.events.EventDispatcher;
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;
    import com.example.unityads.events.UnityAdsEvent;
    
    /**
     * Unity Ads ANE的ActionScript接口类
     * 提供与Unity Ads SDK交互的方法
     */
    public class UnityAds extends EventDispatcher {
        // 单例实例
        private static var _instance:UnityAds;
        
        // 扩展上下文
        private var _context:ExtensionContext;
        
        // 扩展ID
        private static const EXTENSION_ID:String = "com.example.unityads";
        
        /**
         * 构造函数
         */
        public function UnityAds() {
            if (_instance) {
                throw new Error("UnityAds is a singleton and cannot be instantiated directly. Use UnityAds.instance instead.");
            }
            
            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
            
            if (!_context) {
                throw new Error("Unity Ads native extension could not be created. Make sure the ANE is properly added to your project.");
            }
            
            _context.addEventListener(StatusEvent.STATUS, onStatus);
        }
        
        /**
         * 获取单例实例
         */
        public static function get instance():UnityAds {
            if (!_instance) {
                _instance = new UnityAds();
            }
            return _instance;
        }
        
        /**
         * 初始化Unity Ads
         * @param gameId 游戏ID
         * @param testMode 是否启用测试模式
         */
        public function init(gameId:String, testMode:Boolean = false):void {
            _context.call("init", gameId, testMode);
        }
        /**
 * 加载广告
 * @param placementId 广告位ID
 */
public function load(placementId:String = null):void {
    _context.call("load", placementId);
}
        /**
         * 检查广告是否准备好
         * @param placementId 广告位ID
         * @return 广告是否准备好
         */
        public function isReady(placementId:String = null):Boolean {
            return _context.call("isReady", placementId) as Boolean;
        }
        
        /**
         * 显示广告
         * @param placementId 广告位ID
         */
        public function show(placementId:String = null):void {
            _context.call("show", placementId);
        }
        
        /**
         * 获取Unity Ads SDK版本
         * @return SDK版本
         */
        public function getVersion():String {
            return _context.call("getVersion") as String;
        }
        
        /**
         * 设置调试模式
         * @param debugMode 是否启用调试模式
         */
        public function setDebugMode(debugMode:Boolean):void {
            _context.call("setDebugMode", debugMode);
        }
        
        /**
         * 处理来自原生扩展的状态事件
         * @param event 状态事件
         */
        private function onStatus(event:StatusEvent):void {
            var code:String = event.code;
            var level:String = event.level;
            
            trace("[UnityAds] 收到状态事件: " + code + ", level: " + level);
            
            switch (code) {
                case "UNITY_ADS_INIT_COMPLETE":
                    trace("[UnityAds] 收到初始化完成事件，准备分发UnityAdsEvent.INIT_COMPLETE");
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.INIT_COMPLETE));
                    trace("[UnityAds] 已分发UnityAdsEvent.INIT_COMPLETE事件");
                    break;
                    
                case "UNITY_ADS_INIT_FAILED":
                    var initErrorParts:Array = level.split(":");
                    var initErrorCode:String = initErrorParts[0];
                    var initErrorMessage:String = initErrorParts.length > 1 ? initErrorParts[1].trim() : "";
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.INIT_FAILED, initErrorCode, initErrorMessage));
                    break;
                    
                case "UNITY_ADS_SHOW_START":
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.SHOW_START, level));
                    break;
                    
                case "UNITY_ADS_SHOW_CLICK":
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.SHOW_CLICK, level));
                    break;
                    
                case "UNITY_ADS_SHOW_COMPLETE":
                    var completeParts:Array = level.split(",");
                    var placementId:String = completeParts[0];
                    var finishState:String = completeParts.length > 1 ? completeParts[1] : "";
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.SHOW_COMPLETE, placementId, finishState));
                    break;
                    
                case "UNITY_ADS_SHOW_FAILURE":
                    var failureParts:Array = level.split(",");
                    var failurePlacementId:String = failureParts[0];
                    var failureErrorCode:String = failureParts.length > 1 ? failureParts[1] : "";
                    var failureErrorMessage:String = failureParts.length > 2 ? failureParts[2] : "";
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.SHOW_FAILURE, failurePlacementId, failureErrorCode, failureErrorMessage));
                    break;
                    
                case "UNITY_ADS_ERROR":
                    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.ERROR, "", level));
                    break;
                    case "UNITY_ADS_LOAD_COMPLETE":
    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.LOAD_COMPLETE, level));
    break;
    
case "UNITY_ADS_LOAD_FAILED":
    var loadFailureParts:Array = level.split(",");
    var loadFailurePlacementId:String = loadFailureParts[0];
    var loadFailureErrorCode:String = loadFailureParts.length > 1 ? loadFailureParts[1] : "";
    var loadFailureErrorMessage:String = loadFailureParts.length > 2 ? loadFailureParts[2] : "";
    dispatchEvent(new UnityAdsEvent(UnityAdsEvent.LOAD_FAILED, loadFailurePlacementId, loadFailureErrorCode, loadFailureErrorMessage));
    break;
            }
        }
        
        /**
         * 释放资源
         */
        public function dispose():void {
            if (_context) {
                _context.removeEventListener(StatusEvent.STATUS, onStatus);
                _context.dispose();
                _context = null;
            }
            _instance = null;
        }
    }
}