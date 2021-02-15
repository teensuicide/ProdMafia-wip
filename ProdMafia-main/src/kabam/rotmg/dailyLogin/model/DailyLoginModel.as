package kabam.rotmg.dailyLogin.model {
   import io.decagames.rotmg.utils.date.TimeSpan;
   
   public class DailyLoginModel {
      
      public static const DAY_IN_MILLISECONDS:Number = 86400000;
       
      
      public var shouldDisplayCalendarAtStartup:Boolean;
      
      public var currentDisplayedCaledar:String;
      
      private var serverTimestamp:Number;
      
      private var serverMeasureTime:Number;
      
      private var daysConfig:Object;
      
      private var userDayConfig:Object;
      
      private var currentDayConfig:Object;
      
      private var maxDayConfig:Object;
      
      private var _currentDay:int = -1;
      
      private var sortAsc:Function;
      
      private var _currentDate:Date;
      
      private var _nextDay:Date;
      
      private var _initialized:Boolean;
      
      public function DailyLoginModel() {
         daysConfig = {};
         userDayConfig = {};
         currentDayConfig = {};
         maxDayConfig = {};
         sortAsc = function(param1:CalendarDayModel, param2:CalendarDayModel):Number {
            if(param1.dayNumber < param2.dayNumber) {
               return -1;
            }
            if(param1.dayNumber > param2.dayNumber) {
               return 1;
            }
            return 0;
         };
         super();
         this.clear();
      }
      
      public function get initialized() : Boolean {
         return this._initialized;
      }
      
      public function get daysLeftToCalendarEnd() : int {
         var _loc2_:Date = this.getServerTime();
         var _loc1_:int = _loc2_.getDate();
         var _loc3_:int = this.getDayCount(_loc2_.fullYear,_loc2_.month + 1);
         return _loc3_ - _loc1_;
      }
      
      public function get overallMaxDays() : int {
         var _loc1_:int = 0;
         var _loc3_:* = 0;
         var _loc2_:* = this.maxDayConfig;
         var _loc6_:int = 0;
         var _loc5_:* = this.maxDayConfig;
         for each(_loc1_ in this.maxDayConfig) {
            if(_loc1_ > _loc3_) {
               _loc3_ = _loc1_;
            }
         }
         return _loc3_;
      }
      
      public function setServerTime(param1:Number) : void {
         this.serverTimestamp = param1;
         this.serverMeasureTime = new Date().getTime();
      }
      
      public function hasCalendar(param1:String) : Boolean {
         return this.daysConfig[param1].length > 0;
      }
      
      public function getServerUTCTime() : Date {
         var _loc1_:Date = new Date();
         _loc1_.setUTCMilliseconds(this.serverTimestamp);
         return _loc1_;
      }
      
      public function getServerTime() : Date {
         var _loc1_:Date = new Date();
         _loc1_.setTime(this.serverTimestamp + (_loc1_.getTime() - this.serverMeasureTime));
         return _loc1_;
      }
      
      public function getTimestampDay() : int {
         return Math.floor(this.getServerTime().getTime() / 86400000);
      }
      
      public function addDay(param1:CalendarDayModel, param2:String) : void {
         this._initialized = true;
         this.daysConfig[param2].push(param1);
      }
      
      public function setUserDay(param1:int, param2:String) : void {
         this.userDayConfig[param2] = param1;
      }
      
      public function calculateCalendar(param1:String) : void {
         var _loc6_:* = null;
         var _loc2_:Vector.<CalendarDayModel> = this.sortCalendar(this.daysConfig[param1]);
         var _loc4_:int = _loc2_.length;
         this.daysConfig[param1] = _loc2_;
         this.maxDayConfig[param1] = _loc2_[_loc4_ - 1].dayNumber;
         var _loc5_:Vector.<CalendarDayModel> = new Vector.<CalendarDayModel>();
         var _loc3_:int = 1;
         while(_loc3_ <= this.maxDayConfig[param1]) {
            _loc6_ = this.getDayByNumber(param1,_loc3_);
            if(_loc3_ == this.userDayConfig[param1]) {
               _loc6_.isCurrent = true;
            }
            _loc5_.push(_loc6_);
            _loc3_++;
         }
         this.daysConfig[param1] = _loc5_;
      }
      
      public function getDaysConfig(param1:String) : Vector.<CalendarDayModel> {
         return this.daysConfig[param1];
      }
      
      public function getMaxDays(param1:String) : int {
         return this.maxDayConfig[param1];
      }
      
      public function markAsClaimed(param1:int, param2:String) : void {
         this.daysConfig[param2][param1 - 1].isClaimed = true;
      }
      
      public function clear() : void {
         this.daysConfig["consecutive"] = new Vector.<CalendarDayModel>();
         this.daysConfig["nonconsecutive"] = new Vector.<CalendarDayModel>();
         this.daysConfig["unlock"] = new Vector.<CalendarDayModel>();
         this.shouldDisplayCalendarAtStartup = false;
      }
      
      public function getCurrentDay(param1:String) : int {
         return this.currentDayConfig[param1];
      }
      
      public function setCurrentDay(param1:String, param2:int) : void {
         this.currentDayConfig[param1] = param2;
      }
      
      public function getFormatedQuestRefreshTime() : String {
         this._currentDate = this.getServerTime();
         this._nextDay = new Date();
         this._nextDay.setTime(this._currentDate.valueOf() + 86400000);
         this._nextDay.setUTCHours(0);
         this._nextDay.setUTCMinutes(0);
         this._nextDay.setUTCSeconds(0);
         this._nextDay.setUTCMilliseconds(0);
         var _loc1_:TimeSpan = new TimeSpan(this._nextDay.valueOf() - this._currentDate.valueOf());
         return (_loc1_.hours > 9?_loc1_.hours.toString():"0" + _loc1_.hours.toString()) + "h " + (_loc1_.minutes > 9?_loc1_.minutes.toString():"0" + _loc1_.minutes.toString()) + "m";
      }
      
      private function getDayCount(param1:int, param2:int) : int {
         var _loc3_:Date = new Date(param1,param2,0);
         return _loc3_.getDate();
      }
      
      private function getDayByNumber(param1:String, param2:int) : CalendarDayModel {
         var _loc3_:* = null;
         var _loc4_:* = this.daysConfig[param1];
         var _loc7_:int = 0;
         var _loc6_:* = this.daysConfig[param1];
         for each(_loc3_ in this.daysConfig[param1]) {
            if(_loc3_.dayNumber == param2) {
               return _loc3_;
            }
         }
         return new CalendarDayModel(param2,-1,0,0,false,param1);
      }
      
      private function sortCalendar(param1:Vector.<CalendarDayModel>) : Vector.<CalendarDayModel> {
         return param1.sort(this.sortAsc);
      }
   }
}
