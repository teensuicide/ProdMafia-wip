package kabam.rotmg.core.service {
   import flash.system.Capabilities;
   import io.decagames.rotmg.service.tracking.GoogleAnalyticsTracker;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GoogleAnalytics {
       
      
      [Inject]
      public var logger:ILogger;
      
      private var tracker:GoogleAnalyticsTracker;
      
      public function GoogleAnalytics() {
         super();
      }
      
      public function init(param1:String, param2:String) : void {
         this.logger.debug("GA setup: " + param1 + ", type:" + Capabilities.playerType);
         this.tracker = new GoogleAnalyticsTracker(param1,this.logger,param2);
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = "", param4:Number = NaN) : void {
         this.tracker.trackEvent(param1,param2,param3,param4);
         this.logger.debug("Track event - category: " + param1 + ", action:" + param2 + ", label: " + param3 + ", value:" + param4);
      }
      
      public function trackPageView(param1:String) : void {
      }
   }
}
