 
package kabam.lib.math.easing {
   public class Quad {
       
      
      public function Quad() {
         super();
      }
      
      public static function easeIn(param1:Number) : Number {
         return param1 * param1;
      }
      
      public static function easeOut(param1:Number) : Number {
         return -param1 * (param1 - 2);
      }
      
      public static function easeInOut(param1:Number) : Number {
         param1 = param1 * 2;
         if(param1 * 2 < 1) {
            return 0.5 * param1 * param1;
         }
         param1--;
         return -0.5 * (param1 * (param1 - 2) - 1);
      }
   }
}
