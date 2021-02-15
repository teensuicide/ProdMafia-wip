 
package kabam.lib.math.easing {
   public class Expo {
       
      
      public function Expo() {
         super();
      }
      
      public static function easeIn(param1:Number) : Number {
         return param1 == 0?0:Number(Math.pow(2,10 * (param1 - 1)) - 0.001);
      }
      
      public static function easeOut(param1:Number) : Number {
         return param1 == 1?1:Number(-Math.pow(2,-10 * param1) + 1);
      }
      
      public static function easeInOut(param1:Number) : Number {
         if(param1 == 0 || param1 == 1) {
            return param1;
         }
         param1 = param1 * 2;
         if(param1 * 2 < 1) {
            return 0.5 * Math.pow(2,10 * (param1 - 1));
         }
         return 0.5 * (-Math.pow(2,-10 * (param1 - 1)) + 2);
      }
   }
}
