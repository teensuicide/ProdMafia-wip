package io.decagames.rotmg.utils.colors {
   public class RGB {
       
      
      public function RGB() {
         super();
      }
      
      public static function fromRGB(param1:int, param2:int, param3:int) : uint {
         return param1 << 16 | param2 << 8 | param3;
      }
      
      public static function toRGB(param1:uint) : Array {
         return [getRed(param1),getGreen(param1),getBlue(param1)];
      }
      
      public static function getRed(param1:int) : int {
         return param1 >> 16 & 255;
      }
      
      public static function getGreen(param1:int) : int {
         return param1 >> 8 & 255;
      }
      
      public static function getBlue(param1:int) : int {
         return param1 & 255;
      }
   }
}
