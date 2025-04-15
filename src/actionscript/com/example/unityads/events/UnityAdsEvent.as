package com.example.unityads.events {
    import flash.events.Event;
    
    /**
     * Unity Ads事件类
     * 用于处理Unity Ads的各种事件
     */
    public class UnityAdsEvent extends Event {
        // 事件类型常量
        public static const INIT_COMPLETE:String = "unityAdsInitComplete";
        public static const INIT_FAILED:String = "unityAdsInitFailed";
        public static const READY:String = "unityAdsReady";
        public static const SHOW_START:String = "unityAdsShowStart";
        public static const SHOW_CLICK:String = "unityAdsShowClick";
        public static const SHOW_COMPLETE:String = "unityAdsShowComplete";
        public static const SHOW_FAILURE:String = "unityAdsShowFailure";
        public static const ERROR:String = "unityAdsError";
        public static const LOAD_COMPLETE:String = "unityAdsLoadComplete";
        public static const LOAD_FAILED:String = "unityAdsLoadFailed";
        
        // 事件数据
        private var _placementId:String;
        private var _errorCode:String;
        private var _errorMessage:String;
        
        /**
         * 构造函数
         * @param type 事件类型
         * @param placementId 广告位ID
         * @param errorCode 错误代码
         * @param errorMessage 错误消息
         * @param bubbles 是否冒泡
         * @param cancelable 是否可取消
         */
        public function UnityAdsEvent(type:String, placementId:String = "", errorCode:String = "", errorMessage:String = "", bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            _placementId = placementId;
            _errorCode = errorCode;
            _errorMessage = errorMessage;
        }
        
        /**
         * 获取广告位ID
         */
        public function get placementId():String {
            return _placementId;
        }
        
        /**
         * 获取错误代码
         */
        public function get errorCode():String {
            return _errorCode;
        }
        
        /**
         * 获取错误消息
         */
        public function get errorMessage():String {
            return _errorMessage;
        }
        
        /**
         * 克隆事件
         * @return 克隆的事件实例
         */
        override public function clone():Event {
            return new UnityAdsEvent(type, _placementId, _errorCode, _errorMessage, bubbles, cancelable);
        }
        
        /**
         * 获取事件的字符串表示
         * @return 事件的字符串表示
         */
        override public function toString():String {
            return formatToString("UnityAdsEvent", "type", "placementId", "errorCode", "errorMessage", "bubbles", "cancelable");
        }
    }
}