package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.map.Camera;
   import com.company.util.Trig;
   import flash.utils.Dictionary;
   
   public class AnimatedChar {
      
      public static const RIGHT:int = 0;
      
      public static const LEFT:int = 1;
      
      public static const DOWN:int = 3;
      
      public static const UP:int = 2;
      
      public static const NUM_DIR:int = 4;
      
      public static const STAND:int = 0;
      
      public static const WALK:int = 1;
      
      public static const ATTACK:int = 2;
      
      public static const NUM_ACTION:int = 3;
      
      private static const SEC_TO_DIRS:Vector.<Vector.<int>> = new <Vector.<int>>[new <int>[1,2,3],new <int>[2,1,3],new <int>[2,0,3],new <int>[0,2,3],new <int>[0,3],new <int>[3,0],new <int>[3,1],new <int>[1,3]];
      
      private static const PIOVER4:Number = 0.7853981633974483;
       
      
      private var width_:int;
      
      private var height_:int;
      
      private var dict_:Dictionary;
      
      public function AnimatedChar(param1:int, param2:int) {
         this.dict_ = new Dictionary();
         super();
         this.width_ = param1;
         this.height_ = param2;
      }
      
      public function setImageVec(param1:int, param2:int, param3:Vector.<MaskedImage>) : void {
         var _loc4_:int = 0;
         if(!(param1 in this.dict_)) {
            this.dict_[param1] = new Dictionary();
         }
         if(param2 == 1) {
            this.dict_[param1][0] = new <MaskedImage>[param3[0]];
         }
         this.dict_[param1][param2] = param3;
         if(param1 == 0) {
            if(!(1 in this.dict_)) {
               this.dict_[1] = new Dictionary();
            }
            if(!(param2 in this.dict_[1])) {
               this.dict_[1][param2] = new Vector.<MaskedImage>(0);
            }
            if(param2 == 1) {
               this.dict_[1][0] = new <MaskedImage>[param3[0].mirror()];
            }
            _loc4_ = 0;
            while(_loc4_ < param3.length) {
               this.dict_[1][param2].push(param3[_loc4_].mirror());
               _loc4_++;
            }
         }
      }
      
      public function imageVec(param1:int, param2:int) : Vector.<MaskedImage> {
         return this.dict_[param1][param2];
      }
      
      public function imageFromDir(param1:int, param2:int, param3:Number) : MaskedImage {
         var _loc4_:Vector.<MaskedImage> = this.dict_[param1][param2];
         param3 = Math.max(0,Math.min(0.99999,param3));
         var _loc5_:int = param3 * _loc4_.length;
         return _loc4_[_loc5_];
      }
      
      public function imageFromAngle(param1:Number, param2:int, param3:Number) : MaskedImage {
         var _loc4_:int = (int(param1 / 0.785398163397448 + 4)) % 8;
         var _loc7_:Vector.<int> = SEC_TO_DIRS[_loc4_];
         var _loc6_:Dictionary = this.dict_[_loc7_[0]];
         if(!_loc6_) {
            _loc6_ = this.dict_[_loc7_[1]];
            if(!_loc6_) {
               _loc6_ = this.dict_[_loc7_[2]];
            }
         }
         var _loc5_:Vector.<MaskedImage> = _loc6_[param2];
         param3 = Math.max(0,Math.min(0.99999,param3));
         var _loc8_:int = param3 * _loc5_.length;
         return _loc5_[_loc8_];
      }
      
      public function imageFromFacing(param1:Number, param2:Camera, param3:int, param4:Number) : MaskedImage {
         var _loc10_:Number = Trig.boundToPI(param1 - param2.angleRad_);
         var _loc5_:int = (int(_loc10_ / 0.785398163397448 + 4)) % 8;
         var _loc8_:Vector.<int> = SEC_TO_DIRS[_loc5_];
         var _loc7_:Dictionary = this.dict_[_loc8_[0]];
         if(_loc7_ == null) {
            _loc7_ = this.dict_[_loc8_[1]];
            if(_loc7_ == null) {
               _loc7_ = this.dict_[_loc8_[2]];
            }
         }
         var _loc6_:Vector.<MaskedImage> = _loc7_[param3];
         param4 = Math.max(0,Math.min(0.99999,param4));
         var _loc9_:int = param4 * _loc6_.length;
         return _loc6_[_loc9_];
      }
      
      public function getHeight() : int {
         return this.height_;
      }
   }
}
