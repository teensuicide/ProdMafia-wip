package kabam.rotmg.stage3D.Object3D {
   import flash.geom.Matrix3D;
   import flash.utils.ByteArray;
   
   public class Util {
       
      
      public function Util() {
         super();
      }
      
      public static function perspectiveProjection(param1:Number = 90, param2:Number = 1, param3:Number = 1, param4:Number = 2048) : Matrix3D {
         var _loc7_:Number = param3 * Math.tan(param1 * 0.00872664625997165);
         var _loc14_:Number = -_loc7_;
         var _loc11_:Number = _loc14_ * param2;
         var _loc5_:Number = _loc7_ * param2;
         var _loc8_:Number = 2 * param3 / (_loc5_ - _loc11_);
         var _loc6_:Number = 2 * param3 / (_loc7_ - _loc14_);
         var _loc12_:Number = (_loc5_ + _loc11_) / (_loc5_ - _loc11_);
         var _loc10_:Number = (_loc7_ + _loc14_) / (_loc7_ - _loc14_);
         var _loc9_:Number = -(param4 + param3) / (param4 - param3);
         var _loc13_:Number = -2 * (param4 * param3) / (param4 - param3);
         return new Matrix3D(Vector.<Number>([_loc8_,0,0,0,0,_loc6_,0,0,_loc12_,_loc10_,_loc9_,-1,0,0,_loc13_,0]));
      }
      
      public static function readString(param1:ByteArray, param2:int) : String {
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param2) {
            _loc3_ = uint(param1.readUnsignedByte());
            if(_loc3_ === 0) {
               param1.position = param1.position + Math.max(0,param2 - (_loc4_ + 1));
               break;
            }
            _loc5_ = _loc5_ + String.fromCharCode(_loc3_);
            _loc4_++;
         }
         return _loc5_;
      }
      
      public static function upperPowerOfTwo(param1:uint) : uint {
         param1--;
         param1 = param1 | param1 >> 1;
         param1 = param1 | param1 >> 2;
         param1 = param1 | param1 >> 4;
         param1 = param1 | param1 >> 8;
         param1 = param1 | param1 >> 16;
         return param1 + 1;
      }
   }
}
