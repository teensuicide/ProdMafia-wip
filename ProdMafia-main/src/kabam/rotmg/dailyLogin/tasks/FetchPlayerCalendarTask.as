package kabam.rotmg.dailyLogin.tasks {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.MoreObjectUtil;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.build.api.BuildData;
   import kabam.rotmg.build.api.BuildEnvironment;
   import kabam.rotmg.core.signals.SetLoadingMessageSignal;
   import kabam.rotmg.dailyLogin.model.CalendarDayModel;
   import kabam.rotmg.dailyLogin.model.DailyLoginModel;
   import robotlegs.bender.framework.api.ILogger;
   
   public class FetchPlayerCalendarTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var setLoadingMessage:SetLoadingMessageSignal;
      
      [Inject]
      public var dailyLoginModel:DailyLoginModel;
      
      [Inject]
      public var buildData:BuildData;
      
      private var requestData:Object;
      
      public function FetchPlayerCalendarTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.logger.info("FetchPlayerCalendarTask start");
         this.requestData = this.makeRequestData();
         this.sendRequest();
      }
      
      public function makeRequestData() : Object {
         var _loc1_:* = {};
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         _loc1_.game_net_user_id = this.account.gameNetworkUserId();
         _loc1_.game_net = this.account.gameNetwork();
         _loc1_.play_platform = this.account.playPlatform();
         return _loc1_;
      }
      
      private function sendRequest() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/dailyLogin/fetchCalendar",this.requestData);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onCalendarUpdate(param2);
         } else {
            this.onTextError(param2);
         }
      }
      
      private function onCalendarUpdate(param1:String) : void {
         var _loc3_:* = null;
         var _loc2_:* = param1;
         try {
            _loc3_ = new XML(_loc2_);
         }
         catch(e:Error) {
            completeTask(true);
            return;
         }
         this.dailyLoginModel.clear();
         var _loc4_:Number = parseFloat(_loc3_.attribute("serverTime")) * 1000;
         this.dailyLoginModel.setServerTime(_loc4_);
         if(!Parameters.data.calendarShowOnDay || Parameters.data.calendarShowOnDay < this.dailyLoginModel.getTimestampDay()) {
            this.dailyLoginModel.shouldDisplayCalendarAtStartup = true;
         }
         if(this.buildData.getEnvironment() == BuildEnvironment.LOCALHOST) {
         }
         if(_loc3_.hasOwnProperty("NonConsecutive") && _loc3_.NonConsecutive..Login.length() > 0) {
            this.parseCalendar(_loc3_.NonConsecutive,"nonconsecutive",_loc3_.attribute("nonconCurDay"));
         }
         if(_loc3_.hasOwnProperty("Consecutive") && _loc3_.Consecutive..Login.length() > 0) {
            this.parseCalendar(_loc3_.Consecutive,"consecutive",_loc3_.attribute("conCurDay"));
         }
         completeTask(true);
      }
      
      private function parseCalendar(param1:XMLList, param2:String, param3:String) : void {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = param1..Login;
         var _loc9_:int = 0;
         var _loc8_:* = param1..Login;
         for each(_loc7_ in param1..Login) {
            _loc6_ = this.getDayFromXML(_loc7_,param2);
            if(_loc7_.hasOwnProperty("key")) {
               _loc6_.claimKey = _loc7_.key;
            }
            this.dailyLoginModel.addDay(_loc6_,param2);
         }
         if(param3) {
            this.dailyLoginModel.setCurrentDay(param2,int(param3));
         }
         this.dailyLoginModel.setUserDay(param1.attribute("days"),param2);
         this.dailyLoginModel.calculateCalendar(param2);
      }
      
      private function getDayFromXML(param1:XML, param2:String) : CalendarDayModel {
         return new CalendarDayModel(param1.Days,param1.ItemId,param1.Gold,param1.ItemId.attribute("quantity"),param1.hasOwnProperty("Claimed"),param2);
      }
      
      private function onTextError(param1:String) : void {
         completeTask(true);
      }
   }
}
