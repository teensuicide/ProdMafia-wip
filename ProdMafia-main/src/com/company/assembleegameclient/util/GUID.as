package com.company.assembleegameclient.util {
   public class GUID {
      
      private static var counter:Number = 0;
       
      
      public function GUID() {
         super();
      }
      
      public static function create() : String {
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime();
         return "A" + Math.random() * 4294967295 + "B" + _loc2_;
      }
      
      public static function str_b64(param1:String) : String {
         return binb2b64(str2binb_2(param1));
      }
      
      private static function calculate(param1:String) : String {
         return hex_sha1(param1);
      }
      
      private static function hex_sha1(param1:String) : String {
         return binb2hex(core_sha1(str2binb(param1),param1.length * 8));
      }
      
      private static function core_sha1(param1:Array, param2:Number) : Array {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc15_:* = NaN;
         var _loc14_:Number = NaN;
         param1[param2 >> 5] = param1[param2 >> 5] | 128 << 24 - param2 % 32;
         param1[(param2 + 64 >> 9 << 4) + 15] = param2;
         var _loc16_:Array = new Array(80);
         var _loc3_:* = 1732584193;
         var _loc11_:* = -271733879;
         var _loc4_:* = -1732584194;
         var _loc13_:* = 271733878;
         var _loc5_:* = -1009589776;
         var _loc9_:* = 0;
         while(_loc9_ < param1.length) {
            _loc6_ = _loc3_;
            _loc7_ = _loc11_;
            _loc12_ = _loc4_;
            _loc8_ = _loc13_;
            _loc10_ = _loc5_;
            _loc15_ = 0;
            while(_loc15_ < 80) {
               if(_loc15_ < 16) {
                  _loc16_[_loc15_] = param1[_loc9_ + _loc15_];
               } else {
                  _loc16_[_loc15_] = rol(_loc16_[_loc15_ - 3] ^ _loc16_[_loc15_ - 8] ^ _loc16_[_loc15_ - 14] ^ _loc16_[_loc15_ - 16],1);
               }
               _loc14_ = safe_add(safe_add(rol(_loc3_,5),sha1_ft(_loc15_,_loc11_,_loc4_,_loc13_)),safe_add(safe_add(_loc5_,_loc16_[_loc15_]),sha1_kt(_loc15_)));
               _loc5_ = _loc13_;
               _loc13_ = _loc4_;
               _loc4_ = rol(_loc11_,30);
               _loc11_ = _loc3_;
               _loc3_ = _loc14_;
               _loc15_++;
            }
            _loc3_ = safe_add(_loc3_,_loc6_);
            _loc11_ = safe_add(_loc11_,_loc7_);
            _loc4_ = safe_add(_loc4_,_loc12_);
            _loc13_ = safe_add(_loc13_,_loc8_);
            _loc5_ = safe_add(_loc5_,_loc10_);
            _loc9_ = _loc9_ + 16;
         }
         return [_loc3_,_loc11_,_loc4_,_loc13_,_loc5_];
      }
      
      private static function sha1_ft(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         if(param1 < 20) {
            return param2 & param3 | ~param2 & param4;
         }
         if(param1 < 40) {
            return param2 ^ param3 ^ param4;
         }
         if(param1 < 60) {
            return param2 & param3 | param2 & param4 | param3 & param4;
         }
         return param2 ^ param3 ^ param4;
      }
      
      private static function sha1_kt(param1:Number) : Number {
         return param1 < 20?1518500249:Number(param1 < 40?1859775393:Number(param1 < 60?-1894007588:-899497514));
      }
      
      private static function safe_add(param1:Number, param2:Number) : Number {
         var _loc4_:Number = (param1 & 65535) + (param2 & 65535);
         var _loc3_:Number = (param1 >> 16) + (param2 >> 16) + (_loc4_ >> 16);
         return _loc3_ << 16 | _loc4_ & 65535;
      }
      
      private static function rol(param1:Number, param2:Number) : Number {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      private static function str2binb_2(param1:String) : Array {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc3_:* = undefined;
         var _loc2_:* = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length * 8) {
            _loc5_ = _loc4_ >> 5;
            _loc3_ = _loc2_[_loc5_] | (param1.charCodeAt(_loc4_ / 8) & 255) << 24 - _loc4_ % 32;
            _loc2_[_loc5_] = _loc3_;
            _loc4_ = _loc4_ + 8;
         }
         return _loc2_;
      }
      
      private static function str2binb(param1:String) : Array {
         var _loc2_:* = [];
         var _loc3_:* = 0;
         while(_loc3_ < param1.length * 8) {
            _loc2_[_loc3_ >> 5] = _loc2_[_loc3_ >> 5] | (param1.charCodeAt(_loc3_ / 8) & 128) << 24 - _loc3_ % 32;
            _loc3_ = _loc3_ + 8;
         }
         return _loc2_;
      }
      
      private static function binb2hex(param1:Array) : String {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length * 4) {
            _loc2_ = _loc2_ + ("0123456789abcdef".charAt(param1[_loc3_ >> 2] >> (3 - _loc3_ % 4) * 8 + 4 & 15) + "0123456789abcdef".charAt(param1[_loc3_ >> 2] >> (3 - _loc3_ % 4) * 8 & 15));
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function binb2b64(param1:Array) : String {
         var _loc5_:int = 0;
         var _loc4_:* = 0;
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < param1.length * 4) {
            _loc4_ = (param1[_loc5_ >> 2] >> 8 * (3 - _loc5_ % 4) & 255) << 16 | (param1[_loc5_ + 1 >> 2] >> 8 * (3 - (_loc5_ + 1) % 4) & 255) << 8 | param1[_loc5_ + 2 >> 2] >> 8 * (3 - (_loc5_ + 2) % 4) & 255;
            _loc3_ = 0;
            while(_loc3_ < 4) {
               if(_loc5_ * 8 + _loc3_ * 6 > param1.length * 32) {
                  _loc2_ = _loc2_ + "=";
               } else {
                  _loc2_ = _loc2_ + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(_loc4_ >> 6 * (3 - _loc3_) & 63);
               }
               _loc3_++;
            }
            _loc5_ = _loc5_ + 3;
         }
         return _loc2_;
      }
   }
}
