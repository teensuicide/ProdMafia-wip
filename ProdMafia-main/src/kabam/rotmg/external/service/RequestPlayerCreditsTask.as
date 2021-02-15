package kabam.rotmg.external.service {
   import com.company.util.MoreObjectUtil;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.model.GameModel;
   
   public class RequestPlayerCreditsTask extends BaseTask {
      
      private static const REQUEST:String = "account/getCredits";
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      private var retryTimes:Array;
      
      private var timer:Timer;
      
      private var retryCount:int = 0;
      
      public function RequestPlayerCreditsTask() {
         retryTimes = [2,5,15];
         timer = new Timer(1000);
         super();
      }
      
      override protected function startTask() : void {
         this.timer.addEventListener("timer",this.handleTimer);
         this.timer.start();
      }
      
      private function makeRequest() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("account/getCredits",this.makeRequestObject());
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         if(param1) {
            _loc3_ = XML(param2).toString();
            if(_loc3_ != "" && _loc3_.search("Error") != -1) {
               this.setCredits(parseInt(_loc3_));
            }
         } else if(this.retryCount < this.retryTimes.length) {
            this.timer.addEventListener("timer",this.handleTimer);
            this.timer.start();
            _loc4_ = true;
         }
      }
      
      private function setCredits(param1:int) : void {
         if(param1 >= 0) {
            if(this.gameModel != null && this.gameModel.player != null && param1 != this.gameModel.player.credits_) {
               this.gameModel.player.setCredits(param1);
            } else if(this.playerModel != null && this.playerModel.getCredits() != param1) {
               this.playerModel.setCredits(param1);
            }
         }
      }
      
      private function makeRequestObject() : Object {
         var _loc1_:* = {};
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         return _loc1_;
      }
      
      private function handleTimer(param1:TimerEvent) : void {
         var _loc2_:* = this.retryTimes;
         var _loc3_:* = this.retryCount;
         var _loc4_:* = _loc2_[_loc3_] - 1;
         _loc2_[_loc3_] = _loc4_;
         if(this.retryTimes[this.retryCount] <= 0) {
            this.timer.removeEventListener("timer",this.handleTimer);
            this.makeRequest();
            this.retryCount++;
            this.timer.stop();
         }
      }
   }
}
