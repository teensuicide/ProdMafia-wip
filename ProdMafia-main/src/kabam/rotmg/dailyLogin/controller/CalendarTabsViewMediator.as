package kabam.rotmg.dailyLogin.controller {
   import flash.events.MouseEvent;
   import kabam.rotmg.dailyLogin.config.CalendarSettings;
   import kabam.rotmg.dailyLogin.model.DailyLoginModel;
   import kabam.rotmg.dailyLogin.view.CalendarTabButton;
   import kabam.rotmg.dailyLogin.view.CalendarTabsView;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CalendarTabsViewMediator extends Mediator {
       
      
      [Inject]
      public var view:CalendarTabsView;
      
      [Inject]
      public var model:DailyLoginModel;
      
      private var tabs:Vector.<CalendarTabButton>;
      
      public function CalendarTabsViewMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc1_:* = null;
         this.tabs = new Vector.<CalendarTabButton>();
         this.view.init(CalendarSettings.getTabsRectangle(this.model.overallMaxDays));
         var _loc3_:String = "";
         if(this.model.hasCalendar("nonconsecutive")) {
            _loc3_ = "nonconsecutive";
            this.tabs.push(this.view.addCalendar("Login Calendar","nonconsecutive","Unlock rewards the more days you login. Logins do not need to be in consecutive days. You must claim all rewards before the end of the event."));
         }
         if(this.model.hasCalendar("consecutive")) {
            if(_loc3_ == "") {
               _loc3_ = "consecutive";
            }
            this.tabs.push(this.view.addCalendar("Login Streak","consecutive","Login on consecutive days to keep your streak alive. The more consecutive days you login, the more rewards you can unlock. If you miss a day, you start over. All rewards must be claimed by the end of the event."));
         }
         var _loc2_:* = this.tabs;
         var _loc6_:int = 0;
         var _loc5_:* = this.tabs;
         for each(_loc1_ in this.tabs) {
            _loc1_.addEventListener("click",this.onTabChange);
         }
         this.view.drawTabs();
         if(_loc3_ != "") {
            this.model.currentDisplayedCaledar = _loc3_;
            this.view.selectTab(_loc3_);
         }
      }
      
      override public function destroy() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.tabs;
         var _loc5_:int = 0;
         var _loc4_:* = this.tabs;
         for each(_loc3_ in this.tabs) {
            _loc3_.removeEventListener("click",this.onTabChange);
         }
         this.tabs = new Vector.<CalendarTabButton>();
         super.destroy();
      }
      
      private function onTabChange(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         var _loc2_:CalendarTabButton = param1.currentTarget as CalendarTabButton;
         if(_loc2_ != null) {
            this.model.currentDisplayedCaledar = _loc2_.calendarType;
            this.view.selectTab(_loc2_.calendarType);
         }
      }
   }
}
