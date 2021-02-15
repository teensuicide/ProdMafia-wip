package kabam.rotmg.text.model {
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FontInfo {
      
      private static const renderingFontSize:Number = 200;
      
      private static const GUTTER:Number = 2;
       
      
      protected var name:String;
      
      private var textColor:uint = 0;
      
      private var xHeightRatio:Number;
      
      private var verticalSpaceRatio:Number;
      
      public function FontInfo() {
         super();
      }
      
      public function setName(param1:String) : void {
         this.name = param1;
         this.computeRatiosByRendering();
      }
      
      public function getName() : String {
         return this.name;
      }
      
      public function getXHeight(param1:Number) : Number {
         return this.xHeightRatio * param1;
      }
      
      public function getVerticalSpace(param1:Number) : Number {
         return this.verticalSpaceRatio * param1;
      }
      
      private function computeRatiosByRendering() : void {
         var _loc3_:TextField = this.makeTextField();
         var _loc1_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc1_.draw(_loc3_);
         var _loc2_:Rectangle = _loc1_.getColorBoundsRect(16777215,this.textColor,true);
         this.xHeightRatio = this.deNormalize(_loc2_.height);
         this.verticalSpaceRatio = this.deNormalize(_loc3_.height - _loc2_.bottom - 2);
      }
      
      private function makeTextField() : TextField {
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = "left";
         _loc1_.text = "x";
         _loc1_.textColor = this.textColor;
         _loc1_.setTextFormat(new TextFormat(this.name,200));
         return _loc1_;
      }
      
      private function deNormalize(param1:Number) : Number {
         return param1 / 200;
      }
   }
}
