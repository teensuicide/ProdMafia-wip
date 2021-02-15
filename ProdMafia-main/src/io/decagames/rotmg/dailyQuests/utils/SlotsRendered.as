package io.decagames.rotmg.dailyQuests.utils {
   import flash.display.Sprite;
   import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
   
   public class SlotsRendered {
       
      
      public function SlotsRendered() {
         super();
      }
      
      public static function renderSlots(param1:Vector.<int>, param2:Vector.<int>, param3:String, param4:Sprite, param5:int, param6:int, param7:int, param8:Vector.<DailyQuestItemSlot>, param9:Boolean = false) : void {
         var _loc14_:int = 0;
         var _loc10_:int = 0;
         var _loc18_:int = 0;
         var _loc15_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Boolean = false;
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc16_:Sprite = new Sprite();
         var _loc12_:Sprite = new Sprite();
         _loc11_ = _loc16_;
         param4.addChild(_loc16_);
         param4.addChild(_loc12_);
         _loc12_.y = 40 + param6;
         var _loc19_:* = param1;
         var _loc25_:int = 0;
         var _loc24_:* = param1;
         for each(_loc14_ in param1) {
            if(!_loc21_) {
               _loc23_++;
            } else {
               _loc20_++;
            }
            _loc15_ = param2.indexOf(_loc14_);
            if(_loc15_ >= 0) {
               param2.splice(_loc15_,1);
            }
            _loc13_ = new DailyQuestItemSlot(_loc14_,param3,param3 == "reward"?false:_loc15_ >= 0,param9);
            _loc13_.x = _loc22_ * (40 + param6);
            _loc11_.addChild(_loc13_);
            param8.push(_loc13_);
            _loc22_++;
            if(_loc22_ >= 4) {
               _loc11_ = _loc12_;
               _loc22_ = 0;
               _loc21_ = true;
            }
         }
         _loc10_ = _loc23_ * 40 + (_loc23_ - 1) * param6;
         _loc18_ = _loc20_ * 40 + (_loc20_ - 1) * param6;
         param4.y = param5;
         if(!_loc21_) {
            param4.y = param4.y + Math.round(20 + param6 / 2);
         }
         _loc16_.x = Math.round((param7 - _loc10_) / 2);
         _loc12_.x = Math.round((param7 - _loc18_) / 2);
      }
   }
}
