package kabam.rotmg.dailyLogin.controller {
   import flash.events.MouseEvent;
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.core.model.MapModel;
   import kabam.rotmg.dailyLogin.message.ClaimDailyRewardMessage;
   import kabam.rotmg.dailyLogin.model.DailyLoginModel;
   import kabam.rotmg.dailyLogin.view.CalendarDayBox;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CalendarDayBoxMediator extends Mediator {
       
      
      [Inject]
      public var view:CalendarDayBox;
      
      [Inject]
      public var socketServer:SocketServer;
      
      [Inject]
      public var messages:MessageProvider;
      
      [Inject]
      public var mapModel:MapModel;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var model:DailyLoginModel;
      
      public function CalendarDayBoxMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.addEventListener("click",this.onClickHandler);
      }
      
      override public function destroy() : void {
         this.view.removeEventListener("click",this.onClickHandler);
         super.destroy();
      }
      
      private function onClickHandler(param1:MouseEvent) : void {
         var _loc2_:* = null;
         this.view.removeEventListener("click",this.onClickHandler);
         if(this.hudModel.gameSprite.map.name_ == "Daily Quest Room" && this.view.day.claimKey != "" && !this.view.day.isClaimed) {
            _loc2_ = this.messages.require(3) as ClaimDailyRewardMessage;
            _loc2_.claimKey = this.view.day.claimKey;
            _loc2_.type_ = this.view.getDay().calendarType;
            this.socketServer.sendMessage(_loc2_);
            this.view.markAsClaimed();
            this.model.markAsClaimed(this.view.getDay().dayNumber,this.view.getDay().calendarType);
         }
      }
   }
}
