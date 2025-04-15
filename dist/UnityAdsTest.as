package
{
    import com.example.unityads.UnityAds;
    import com.example.unityads.events.UnityAdsEvent;
    import com.hzq.mobile.HzqAne;
    
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.utils.setTimeout;
    
    /**
     * Unity Ads ANE Test Application
     * Used to test Unity Ads initialization, loading and display functions
     */
    public class UnityAdsTest extends Sprite
    {
        // Game ID, please replace with your Unity Ads Game ID
        private const GAME_ID:String = "5823992";
        
        // Placement IDs, please replace with your placement IDs
        private const REWARDED_PLACEMENT_ID:String = "Rewarded_Android";
        private const INTERSTITIAL_PLACEMENT_ID:String = "Interstitial_Android";
        
        // Track ad loading status
        private var isRewardedLoaded:Boolean = false;
        private var isInterstitialLoaded:Boolean = false;
        
        // UI components
        private var btnInit:SimpleButton;
        private var btnShowRewarded:SimpleButton;
        private var btnShowInterstitial:SimpleButton;
        private var txtStatus:TextField;
        private var hzqAne:HzqAne;
        
        /**
         * Constructor
         */
        public function UnityAdsTest()
        {
            if (stage)
            {
                init();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, init);
            }
        }
        
        /**
         * Initialize application
         */
        private function init(e:Event = null):void
        {
            if (hasEventListener(Event.ADDED_TO_STAGE))
            {
                removeEventListener(Event.ADDED_TO_STAGE, init);
            }
            
            // Set stage properties
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            // Initialize HzqAne
            hzqAne = HzqAne.getIns();
            hzqAne.createLogUI(20, 10, stage);
            
            // Create UI
            createUI();
            
            // Add Unity Ads event listeners
            addUnityAdsEventListeners();
        }
        
        /**
         * Create user interface
         */
        private function createUI():void
        {
            // Create status text field
            txtStatus = new TextField();
            txtStatus.defaultTextFormat = new TextFormat("Arial", 16, 0x000000);
            txtStatus.width = stage.stageWidth - 40;
            txtStatus.height = 100;
            txtStatus.x = 20;
            txtStatus.y = 20;
            txtStatus.multiline = true;
            txtStatus.wordWrap = true;
            txtStatus.border = true;
            txtStatus.background = true;
            txtStatus.backgroundColor = 0xEEEEEE;
            txtStatus.autoSize = TextFieldAutoSize.NONE;
            txtStatus.text = "Unity Ads test application started. Please click 'Initialize Unity Ads' button to begin testing.";
            addChild(txtStatus);
            
            // Create initialization button
            var initBtn:Sprite = createButton("Initialize Unity Ads", 0x4CAF50);
            initBtn.x = 20;
            initBtn.y = 140;
            initBtn.addEventListener(MouseEvent.CLICK, onInitClick);
            addChild(initBtn);
            
            // Create show rewarded ad button
            var rewardedBtn:Sprite = createButton("Show Rewarded Ad", 0x2196F3);
            rewardedBtn.x = 20;
            rewardedBtn.y = 200;
            rewardedBtn.addEventListener(MouseEvent.CLICK, onShowRewardedClick);
            addChild(rewardedBtn);
            
            // Create show interstitial ad button
            var interstitialBtn:Sprite = createButton("Show Interstitial Ad", 0xFF9800);
            interstitialBtn.x = 20;
            interstitialBtn.y = 260;
            interstitialBtn.addEventListener(MouseEvent.CLICK, onShowInterstitialClick);
            addChild(interstitialBtn);
            
            // Create load ads button
            var loadAdsBtn:Sprite = createButton("Load All Ads", 0xE91E63);
            loadAdsBtn.x = 20;
            loadAdsBtn.y = 320;
            loadAdsBtn.addEventListener(MouseEvent.CLICK, onLoadAdsClick);
            addChild(loadAdsBtn);
        }
        
        /**
         * Create button
         */
        private function createButton(label:String, color:uint):Sprite
        {
            var btn:Sprite = new Sprite();
            btn.graphics.beginFill(color);
            btn.graphics.drawRoundRect(0, 0, 200, 40, 10, 10);
            btn.graphics.endFill();
            
            var btnText:TextField = new TextField();
            btnText.defaultTextFormat = new TextFormat("Arial", 16, 0xFFFFFF, true);
            btnText.width = 200;
            btnText.height = 40;
            btnText.text = label;
            btnText.selectable = false;
            btnText.mouseEnabled = false;
            btnText.autoSize = TextFieldAutoSize.NONE;
            btnText.x = (200 - btnText.textWidth) / 2;
            btnText.y = (40 - btnText.textHeight) / 2;
            
            btn.addChild(btnText);
            btn.buttonMode = true;
            btn.mouseChildren = false;
            
            return btn;
        }
        
        /**
         * Add Unity Ads event listeners
         */
        private function addUnityAdsEventListeners():void
        {
            hzqAne.log("Adding Unity Ads event listeners...");
            UnityAds.instance.addEventListener(UnityAdsEvent.INIT_COMPLETE, onUnityAdsInitComplete);
            UnityAds.instance.addEventListener(UnityAdsEvent.INIT_FAILED, onUnityAdsInitFailed);
            UnityAds.instance.addEventListener(UnityAdsEvent.LOAD_COMPLETE, onUnityAdsLoadComplete);
            UnityAds.instance.addEventListener(UnityAdsEvent.LOAD_FAILED, onUnityAdsLoadFailed);
            UnityAds.instance.addEventListener(UnityAdsEvent.READY, onUnityAdsReady);
            UnityAds.instance.addEventListener(UnityAdsEvent.SHOW_START, onUnityAdsShowStart);
            UnityAds.instance.addEventListener(UnityAdsEvent.SHOW_CLICK, onUnityAdsShowClick);
            UnityAds.instance.addEventListener(UnityAdsEvent.SHOW_COMPLETE, onUnityAdsShowComplete);
            UnityAds.instance.addEventListener(UnityAdsEvent.SHOW_FAILURE, onUnityAdsShowFailure);
            UnityAds.instance.addEventListener(UnityAdsEvent.ERROR, onUnityAdsError);
            hzqAne.log("Unity Ads event listeners added");
        }
        
        /**
         * Initialize button click handler
         */
        private function onInitClick(e:MouseEvent):void
        {
            updateStatus("Initializing Unity Ads...");
            hzqAne.log("Initializing Unity Ads... Game ID: " + GAME_ID);
            
            try {
                // Initialize Unity Ads, set test mode to true
                hzqAne.log("Calling UnityAds.instance.init method");
                UnityAds.instance.init(GAME_ID, true);
                hzqAne.log("UnityAds.instance.init method called, waiting for callback...");
            } catch (error:Error) {
                hzqAne.log("Error initializing Unity Ads: " + error.message);
                updateStatus("Error initializing Unity Ads: " + error.message);
            }
        }
        
        /**
         * Load all ads - both interstitial and rewarded
         */
        private function loadAllAds():void {
            loadRewardedAd();
            loadInterstitialAd();
        }
        
        /**
         * Load rewarded ad
         */
        private function loadRewardedAd():void {
            if (!isRewardedLoaded) {
                hzqAne.log("Loading rewarded ad...");
                try {
                    UnityAds.instance.load(REWARDED_PLACEMENT_ID);
                } catch (error:Error) {
                    hzqAne.log("Error loading rewarded ad: " + error.message);
                }
            }
        }
        
        /**
         * Load interstitial ad
         */
        private function loadInterstitialAd():void {
            if (!isInterstitialLoaded) {
                hzqAne.log("Loading interstitial ad...");
                try {
                    UnityAds.instance.load(INTERSTITIAL_PLACEMENT_ID);
                } catch (error:Error) {
                    hzqAne.log("Error loading interstitial ad: " + error.message);
                }
            }
        }
        
        /**
         * Load ads button click handler
         */
        private function onLoadAdsClick(e:MouseEvent):void
        {
            updateStatus("Loading all ads...");
            loadAllAds();
        }
        
        /**
         * Show rewarded ad button click handler
         */
        private function onShowRewardedClick(e:MouseEvent):void
        {
            if (isRewardedLoaded)
            {
                updateStatus("Showing rewarded ad...");
                hzqAne.log("Showing rewarded ad...");
                isRewardedLoaded = false; // Reset the flag
                UnityAds.instance.show(REWARDED_PLACEMENT_ID);
                // Start loading the next ad right away
                loadRewardedAd();
            }
            else
            {
                updateStatus("Rewarded ad is not ready. Loading now...");
                hzqAne.log("Rewarded ad is not ready. Loading now...");
                loadRewardedAd();
            }
        }
        
        /**
         * Show interstitial ad button click handler
         */
        private function onShowInterstitialClick(e:MouseEvent):void
        {
            if (isInterstitialLoaded)
            {
                updateStatus("Showing interstitial ad...");
                hzqAne.log("Showing interstitial ad...");
                isInterstitialLoaded = false; // Reset the flag
                UnityAds.instance.show(INTERSTITIAL_PLACEMENT_ID);
                // Start loading the next ad right away
                loadInterstitialAd();
            }
            else
            {
                updateStatus("Interstitial ad is not ready. Loading now...");
                hzqAne.log("Interstitial ad is not ready. Loading now...");
                loadInterstitialAd();
            }
        }
        
        /**
         * Unity Ads initialization complete event handler
         */
        private function onUnityAdsInitComplete(e:UnityAdsEvent):void
        {
            hzqAne.log("Unity Ads initialization complete event received!");
            updateStatus("Unity Ads initialized successfully! Loading all ads...");
            
            // Load all ads automatically after initialization
            loadAllAds();
        }
        
        /**
         * Unity Ads initialization failed event handler
         */
        private function onUnityAdsInitFailed(e:UnityAdsEvent):void
        {
            hzqAne.log("Unity Ads initialization failed event received!");
            updateStatus("Unity Ads initialization failed: " + e.errorMessage);
            hzqAne.log("Unity Ads initialization failed: Error code=" + e.errorCode + ", Error message=" + e.errorMessage);
        }
        
        /**
         * Unity Ads load complete event handler
         */
        private function onUnityAdsLoadComplete(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads load complete: " + e.placementId);
            hzqAne.log("Unity Ads load complete: " + e.placementId);
            
            // Update loading status flags
            if (e.placementId == REWARDED_PLACEMENT_ID) {
                isRewardedLoaded = true;
                hzqAne.log("Rewarded ad is now ready to show");
            } else if (e.placementId == INTERSTITIAL_PLACEMENT_ID) {
                isInterstitialLoaded = true;
                hzqAne.log("Interstitial ad is now ready to show");
            }
        }
        
        /**
         * Unity Ads load failed event handler
         */
        private function onUnityAdsLoadFailed(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads load failed: " + e.placementId + ", Error: " + e.errorMessage);
            hzqAne.log("Unity Ads load failed: " + e.placementId + ", Error code=" + e.errorCode + ", Error message=" + e.errorMessage);
            
            // Reset loading status flags
            if (e.placementId == REWARDED_PLACEMENT_ID) {
                isRewardedLoaded = false;
                // Retry loading after a short delay
                setTimeout(loadRewardedAd, 5000); // Retry after 5 seconds
            } else if (e.placementId == INTERSTITIAL_PLACEMENT_ID) {
                isInterstitialLoaded = false;
                // Retry loading after a short delay
                setTimeout(loadInterstitialAd, 5000); // Retry after 5 seconds
            }
        }
        
        /**
         * Unity Ads ready event handler
         */
        private function onUnityAdsReady(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads ready: " + e.placementId);
            hzqAne.log("Unity Ads ready: " + e.placementId);
            
            // Update loading status flags
            if (e.placementId == REWARDED_PLACEMENT_ID) {
                isRewardedLoaded = true;
            } else if (e.placementId == INTERSTITIAL_PLACEMENT_ID) {
                isInterstitialLoaded = true;
            }
        }
        
        /**
         * Unity Ads show start event handler
         */
        private function onUnityAdsShowStart(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads show started: " + e.placementId);
            hzqAne.log("Unity Ads show started: " + e.placementId);
        }
        
        /**
         * Unity Ads show click event handler
         */
        private function onUnityAdsShowClick(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads clicked: " + e.placementId);
            hzqAne.log("Unity Ads clicked: " + e.placementId);
        }
        
        /**
         * Unity Ads show complete event handler
         */
        private function onUnityAdsShowComplete(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads show completed: " + e.placementId + ", State: " + e.errorCode);
            hzqAne.log("Unity Ads show completed: " + e.placementId + ", State: " + e.errorCode);
            
            // If rewarded ad completed, give reward
            if (e.placementId == REWARDED_PLACEMENT_ID && e.errorCode == "COMPLETED")
            {
                updateStatus("Congratulations! You've earned a reward.");
                hzqAne.log("Congratulations! You've earned a reward.");
            }
            
            // Ensure we're loading the next ad if not already loading
            if (e.placementId == REWARDED_PLACEMENT_ID && !isRewardedLoaded) {
                loadRewardedAd();
            } else if (e.placementId == INTERSTITIAL_PLACEMENT_ID && !isInterstitialLoaded) {
                loadInterstitialAd();
            }
        }
        
        /**
         * Unity Ads show failure event handler
         */
        private function onUnityAdsShowFailure(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads show failed: " + e.placementId + ", Error: " + e.errorMessage);
            hzqAne.log("Unity Ads show failed: " + e.placementId + ", Error: " + e.errorMessage);
            
            // If showing fails, we should load a new ad
            if (e.placementId == REWARDED_PLACEMENT_ID) {
                isRewardedLoaded = false;
                loadRewardedAd();
            } else if (e.placementId == INTERSTITIAL_PLACEMENT_ID) {
                isInterstitialLoaded = false;
                loadInterstitialAd();
            }
        }
        
        /**
         * Unity Ads error event handler
         */
        private function onUnityAdsError(e:UnityAdsEvent):void
        {
            updateStatus("Unity Ads error: " + e.errorMessage);
            hzqAne.log("Unity Ads error: " + e.errorMessage);
        }
        
        /**
         * Update status text
         */
        private function updateStatus(message:String):void
        {
            txtStatus.text = message;
        }
    }
}