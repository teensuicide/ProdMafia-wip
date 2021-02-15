package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import flash.display.BitmapData;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.language.model.StringMap;
   import kabam.rotmg.text.model.FontModel;
   
   public class Sign extends GameObject {
       
      
      private var stringMap:StringMap;
      
      private var fontModel:FontModel;
      
      public function Sign(param1:XML) {
         super(param1);
         texture = null;
         this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
         this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
      }
      
      override protected function getTexture(param1:Camera, param2:int) : BitmapData {
         if(texture != null) {
            return texture;
         }
         var _loc4_:TextField = new TextField();
         _loc4_.multiline = true;
         _loc4_.wordWrap = false;
         _loc4_.autoSize = "left";
         _loc4_.textColor = 16777215;
         _loc4_.embedFonts = true;
         var _loc5_:TextFormat = new TextFormat();
         _loc5_.align = "center";
         _loc5_.font = this.fontModel.getFont().getName();
         _loc5_.size = 24;
         _loc5_.color = 16777215;
         _loc5_.bold = true;
         _loc4_.defaultTextFormat = _loc5_;
         var _loc3_:String = this.stringMap.getValue(this.stripCurlyBrackets(name_));
         if(_loc3_ == null) {
            _loc3_ = name_ != null?name_:"null";
         }
         _loc4_.text = _loc3_.split("|").join("\n");
         var _loc6_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         _loc6_.draw(_loc4_);
         texture = TextureRedrawer.redraw(_loc6_,size_,false,0);
         return texture;
      }
      
      private function stripCurlyBrackets(param1:String) : String {
         var _loc2_:Boolean = param1 != null && param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}";
         return !!_loc2_?param1.substr(1,param1.length - 2):param1;
      }
   }
}
