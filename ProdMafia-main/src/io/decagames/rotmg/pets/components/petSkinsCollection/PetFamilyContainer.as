package io.decagames.rotmg.pets.components.petSkinsCollection {
   import io.decagames.rotmg.pets.data.family.PetFamilyColors;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.colors.Tint;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class PetFamilyContainer extends UIGridElement {
       
      
      public function PetFamilyContainer(param1:String, param2:int, param3:int) {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         super();
         var _loc6_:uint = PetFamilyColors.KEYS_TO_COLORS[param1];
         _loc5_ = TextureParser.instance.getSliceScalingBitmap("UI","content_divider_white",320);
         Tint.add(_loc5_,_loc6_,1);
         addChild(_loc5_);
         _loc5_.x = 10;
         _loc5_.y = 3;
         _loc4_ = new UILabel();
         DefaultLabelFormat.petFamilyLabel(_loc4_,16777215);
         _loc4_.text = LineBuilder.getLocalizedStringFromKey(param1);
         _loc4_.y = 0;
         _loc4_.x = 160 - _loc4_.width / 2 + 10;
         _loc7_ = TextureParser.instance.getSliceScalingBitmap("UI","content_divider_smalltitle_white",_loc4_.width + 20);
         Tint.add(_loc7_,_loc6_,1);
         addChild(_loc7_);
         _loc7_.x = 160 - _loc7_.width / 2 + 10;
         _loc7_.y = 0;
         addChild(_loc4_);
      }
   }
}
