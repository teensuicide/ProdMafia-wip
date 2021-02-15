package kabam.rotmg.dailyLogin.view {
   import flash.display.Sprite;
   import kabam.rotmg.dailyLogin.model.CalendarDayModel;
   
   public class CalendarView extends Sprite {
       
      
      public function CalendarView() {
         super();
      }
      
      public function init(param1:Vector.<CalendarDayModel>, param2:int, param3:int) : void {
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = param1;
         var _loc13_:int = 0;
         var _loc12_:* = param1;
         for each(_loc11_ in param1) {
            _loc9_ = new CalendarDayBox(_loc11_,param2,_loc10_ + 1 == param3);
            addChild(_loc9_);
            _loc9_.x = _loc7_ * 70;
            if(_loc7_ > 0) {
               _loc9_.x = _loc9_.x + _loc7_ * 10;
            }
            _loc9_.y = _loc8_ * 70;
            if(_loc8_ > 0) {
               _loc9_.y = _loc9_.y + _loc8_ * 10;
            }
            _loc7_++;
            _loc10_++;
            if(_loc10_ % 7 == 0) {
               _loc7_ = 0;
               _loc8_++;
            }
         }
         _loc6_ = 550;
         this.x = (this.parent.width - _loc6_) / 2;
         this.y = 40;
      }
   }
}
