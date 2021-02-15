package kabam.rotmg.text.view {
   import com.company.ui.BaseSimpleText;
   import com.company.util.PointUtil;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class BitmapTextFactory {
      
      private static const glowFilter:GlowFilter = new GlowFilter(0,1,3,3,2,1);
      
      public static var padding:int = 0;
      
      private static var textField:BaseSimpleText;
       
      
      public function BitmapTextFactory() {
         super();
      }
      
      public static function make(param1:String, param2:int, param3:uint, param4:Boolean, param5:Matrix, param6:Boolean) : BitmapData {
         configureTextField(param2,param3,param4,param1);
         return makeBitmapData(param6,param5);
      }
      
      private static function configureTextField(param1:int, param2:uint, param3:Boolean, param4:String) : void {
         if(!textField) {
            textField = new BaseSimpleText(param1,param2);
         } else {
            textField.setSize(param1);
            textField.setColor(param2);
         }
         textField.setBold(param3);
         textField.setText(param4);
         textField.autoSize = "left";
         textField.updateMetrics();
      }
      
      private static function makeBitmapData(param1:Boolean, param2:Matrix) : BitmapData {
         var _loc4_:int = textField.width + padding + param2.tx;
         var _loc5_:int = textField.height + padding + 1;
         var _loc3_:BitmapData = new BitmapData(_loc4_,_loc5_,true,0);
         _loc3_.draw(textField,param2);
         param1 && _loc3_.applyFilter(_loc3_,_loc3_.rect,PointUtil.ORIGIN,glowFilter);
         return _loc3_;
      }
   }
}
