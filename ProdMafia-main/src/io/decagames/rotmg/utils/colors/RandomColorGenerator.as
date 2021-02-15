package io.decagames.rotmg.utils.colors {
   import flash.utils.Dictionary;
   
   public class RandomColorGenerator {
       
      
      private var colorDictionary:Dictionary;
      
      private var seed:int = -1;
      
      public function RandomColorGenerator(param1:int = -1) {
         super();
         this.seed = param1;
         this.colorDictionary = new Dictionary();
         this.loadColorBounds();
      }
      
      public function randomColor(param1:String = "") : Array {
         var _loc2_:int = this.pickHue();
         var _loc5_:int = this.pickSaturation(_loc2_,param1);
         var _loc4_:int = this.pickBrightness(_loc2_,_loc5_,param1);
         var _loc3_:Array = this.HSVtoRGB([_loc2_,_loc5_,_loc4_]);
         return _loc3_;
      }
      
      private function HSVtoRGB(param1:Array) : Array {
         var _loc8_:* = Number(param1[0]);
         if(_loc8_ === 0) {
            _loc8_ = 1;
         }
         if(_loc8_ === 360) {
            _loc8_ = 359;
         }
         _loc8_ = Number(_loc8_ / 360);
         var _loc5_:Number = param1[1] / 100;
         var _loc13_:Number = param1[2] / 100;
         var _loc10_:Number = Math.floor(_loc8_ * 6);
         var _loc4_:Number = _loc8_ * 6 - _loc10_;
         var _loc6_:Number = _loc13_ * (1 - _loc5_);
         var _loc3_:Number = _loc13_ * (1 - _loc4_ * _loc5_);
         var _loc9_:Number = _loc13_ * (1 - (1 - _loc4_) * _loc5_);
         var _loc2_:* = 256;
         var _loc12_:* = 256;
         var _loc7_:* = 256;
         var _loc11_:* = _loc10_;
         var _loc14_:* = _loc11_;
         switch(_loc14_) {
            case 0:
               _loc2_ = _loc13_;
               _loc12_ = _loc9_;
               _loc7_ = _loc6_;
               break;
            case 1:
               _loc2_ = _loc3_;
               _loc12_ = _loc13_;
               _loc7_ = _loc6_;
               break;
            case 2:
               _loc2_ = _loc6_;
               _loc12_ = _loc13_;
               _loc7_ = _loc9_;
               break;
            case 3:
               _loc2_ = _loc6_;
               _loc12_ = _loc3_;
               _loc7_ = _loc13_;
               break;
            case 4:
               _loc2_ = _loc9_;
               _loc12_ = _loc6_;
               _loc7_ = _loc13_;
               break;
            case 5:
               _loc2_ = _loc13_;
               _loc12_ = _loc6_;
               _loc7_ = _loc3_;
         }
         return [Math.floor(_loc2_ * 255),Math.floor(_loc12_ * 255),Math.floor(_loc7_ * 255)];
      }
      
      private function pickSaturation(param1:int, param2:String) : int {
         var _loc6_:Array = this.getSaturationRange(param1);
         var _loc5_:int = _loc6_[0];
         var _loc3_:int = _loc6_[1];
         var _loc4_:* = param2;
         var _loc7_:* = _loc4_;
         switch(_loc7_) {
            case "bright":
               _loc5_ = 55;
               break;
            case "dark":
               _loc5_ = _loc3_ - 10;
               break;
            case "light":
               _loc3_ = 55;
         }
         return this.randomWithin([_loc5_,_loc3_]);
      }
      
      private function getColorInfo(param1:int) : Object {
         var _loc2_:* = undefined;
         var _loc3_:* = null;
         if(param1 >= 334 && param1 <= 360) {
            param1 = param1 - 360;
         }
         var _loc4_:* = this.colorDictionary;
         var _loc7_:int = 0;
         var _loc6_:* = this.colorDictionary;
         for(_loc2_ in this.colorDictionary) {
            _loc3_ = this.colorDictionary[_loc2_];
            if(_loc3_.hueRange && param1 >= _loc3_.hueRange[0] && param1 <= _loc3_.hueRange[1]) {
               return this.colorDictionary[_loc2_];
            }
         }
         return null;
      }
      
      private function getSaturationRange(param1:int) : Array {
         return this.getColorInfo(param1).saturationRange;
      }
      
      private function pickBrightness(param1:int, param2:int, param3:String) : int {
         var _loc6_:int = this.getMinimumBrightness(param1,param2);
         var _loc5_:int = 100;
         var _loc4_:* = param3;
         var _loc7_:* = _loc4_;
         switch(_loc7_) {
            case "dark":
               _loc5_ = _loc6_ + 20;
               break;
            case "light":
               _loc6_ = (_loc5_ + _loc6_) / 2;
               break;
            case "random":
               _loc6_ = 0;
               _loc5_ = 100;
         }
         return this.randomWithin([_loc6_,_loc5_]);
      }
      
      private function getMinimumBrightness(param1:int, param2:int) : int {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc9_:int = 0;
         var _loc8_:Array = this.getColorInfo(param1).lowerBounds;
         while(_loc9_ < _loc8_.length - 1) {
            _loc3_ = _loc8_[_loc9_][0];
            _loc7_ = _loc8_[_loc9_][1];
            _loc10_ = _loc8_[_loc9_ + 1][0];
            _loc6_ = _loc8_[_loc9_ + 1][1];
            if(param2 >= _loc3_ && param2 <= _loc10_) {
               _loc4_ = (_loc6_ - _loc7_) / (_loc10_ - _loc3_);
               _loc5_ = _loc7_ - _loc4_ * _loc3_;
               return _loc4_ * param2 + _loc5_;
            }
            _loc9_++;
         }
         return 0;
      }
      
      private function randomWithin(param1:Array) : int {
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.seed == -1) {
            return Math.floor(param1[0] + Math.random() * (param1[1] + 1 - param1[0]));
         }
         _loc2_ = param1[1] || 1;
         _loc4_ = param1[0] || 0;
         this.seed = (this.seed * 9301 + 49297) % 233280;
         _loc3_ = this.seed / 233280;
         return Math.floor(_loc4_ + _loc3_ * (_loc2_ - _loc4_));
      }
      
      private function pickHue(param1:int = -1) : int {
         var _loc2_:Array = this.getHueRange(param1);
         var _loc3_:int = this.randomWithin(_loc2_);
         if(_loc3_ < 0) {
            _loc3_ = 360 + _loc3_;
         }
         return _loc3_;
      }
      
      private function getHueRange(param1:int) : Array {
         if(param1 < 360 && param1 > 0) {
            return [param1,param1];
         }
         return [0,360];
      }
      
      private function defineColor(param1:String, param2:Array, param3:Array) : void {
         var _loc6_:int = param3[0][0];
         var _loc5_:int = param3[param3.length - 1][0];
         var _loc4_:int = param3[param3.length - 1][1];
         var _loc7_:int = param3[0][1];
         this.colorDictionary[param1] = {
            "hueRange":param2,
            "lowerBounds":param3,
            "saturationRange":[_loc6_,_loc5_],
            "brightnessRange":[_loc4_,_loc7_]
         };
      }
      
      private function loadColorBounds() : void {
         this.defineColor("monochrome",null,[[0,0],[100,0]]);
         this.defineColor("red",[-26,18],[[20,100],[30,92],[40,89],[50,85],[60,78],[70,70],[80,60],[90,55],[100,50]]);
         this.defineColor("orange",[19,46],[[20,100],[30,93],[40,88],[50,86],[60,85],[70,70],[100,70]]);
         this.defineColor("yellow",[47,62],[[25,100],[40,94],[50,89],[60,86],[70,84],[80,82],[90,80],[100,75]]);
         this.defineColor("green",[63,178],[[30,100],[40,90],[50,85],[60,81],[70,74],[80,64],[90,50],[100,40]]);
         this.defineColor("blue",[179,257],[[20,100],[30,86],[40,80],[50,74],[60,60],[70,52],[80,44],[90,39],[100,35]]);
         this.defineColor("purple",[258,282],[[20,100],[30,87],[40,79],[50,70],[60,65],[70,59],[80,52],[90,45],[100,42]]);
         this.defineColor("pink",[283,334],[[20,100],[30,90],[40,86],[60,84],[80,80],[90,75],[100,73]]);
      }
   }
}
