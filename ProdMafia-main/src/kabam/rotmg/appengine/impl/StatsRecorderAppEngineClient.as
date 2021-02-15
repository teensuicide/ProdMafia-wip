package kabam.rotmg.appengine.impl {
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.events.EventDispatcher;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import org.osflash.signals.OnceSignal;
   
   public class StatsRecorderAppEngineClient extends EventDispatcher implements AppEngineClient {
       
      
      [Inject]
      public var stats:AppEngineRequestStats;
      
      [Inject]
      public var wrapped:SimpleAppEngineClient;
      
      private var timeAtRequest:int;
      
      private var target:String;
      
      public function StatsRecorderAppEngineClient() {
         super();
      }
      
      public function get complete() : OnceSignal {
         return this.wrapped.complete;
      }
      
      public function setDataFormat(param1:String) : void {
         this.wrapped.setDataFormat(param1);
      }
      
      public function setSendEncrypted(param1:Boolean) : void {
         this.wrapped.setSendEncrypted(param1);
      }
      
      public function setMaxRetries(param1:int) : void {
         this.wrapped.setMaxRetries(param1);
      }
      
      public function sendRequest(param1:String, param2:Object, param3:Boolean = false) : void {
         this.timeAtRequest = TimeUtil.getTrueTime();
         this.target = param1;
         this.wrapped.complete.addOnce(this.onComplete);
         this.wrapped.sendRequest(param1,param2,param3);
      }
      
      public function requestInProgress() : Boolean {
         return false;
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         this.stats.recordStats(this.target,param1,TimeUtil.getTrueTime() - this.timeAtRequest);
      }
   }
}
