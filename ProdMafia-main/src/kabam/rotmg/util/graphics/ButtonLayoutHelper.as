package kabam.rotmg.util.graphics {
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class ButtonLayoutHelper {
       
      
      public function ButtonLayoutHelper() {
         super();
      }
      
      public function layout(param1:int, ... rest) : void {
         var _loc3_:int = rest.length;
         var _loc4_:* = int(_loc3_) - 1;
         switch(_loc4_) {
            case 0:
               this.centerButton(param1,rest[0]);
               return;
            case 1:
               this.twoButtons(param1,rest[0],rest[1]);
               return;
            default:
               return;
         }
      }
      
      private function centerButton(param1:int, param2:DisplayObject) : void {
         var _loc3_:Rectangle = param2.getRect(param2);
         param2.x = (param1 - _loc3_.width) * 0.5 - _loc3_.left;
      }
      
      private function twoButtons(param1:int, param2:DisplayObject, param3:DisplayObject) : void {
         var _loc4_:* = null;
         var _loc5_:Rectangle = param2.getRect(param2);
         _loc4_ = param3.getRect(param3);
         param2.x = (param1 - 2 * param2.width) * 0.25 - _loc5_.left;
         param3.x = (3 * param1 - 2 * param3.width) * 0.25 - _loc4_.left;
      }
   }
}
