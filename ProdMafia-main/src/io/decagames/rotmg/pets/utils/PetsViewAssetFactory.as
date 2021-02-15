package io.decagames.rotmg.pets.utils {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.ui.LineBreakDesign;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   
   public class PetsViewAssetFactory {
       
      
      public function PetsViewAssetFactory() {
         super();
      }
      
      public static function returnPetSlotShape(param1:uint, param2:uint, param3:int, param4:Boolean, param5:Boolean, param6:int = 2) : Shape {
         var _loc7_:Shape = new Shape();
         param4 && _loc7_.graphics.beginFill(4605510,1);
         param5 && _loc7_.graphics.lineStyle(param6,param2);
         _loc7_.graphics.drawRoundRect(0,param3,param1,param1,16,16);
         _loc7_.x = (100 - param1) * 0.5;
         return _loc7_;
      }
      
      public static function returnCloseButton(param1:int) : DialogCloseButton {
         var _loc2_:* = null;
         _loc2_ = new DialogCloseButton();
         _loc2_.y = 4;
         _loc2_.x = param1 - _loc2_.width - 5;
         return _loc2_;
      }
      
      public static function returnTooltipLineBreak() : LineBreakDesign {
         var _loc1_:LineBreakDesign = new LineBreakDesign(173,0);
         _loc1_.x = 5;
         _loc1_.y = 92;
         return _loc1_;
      }
      
      public static function returnBitmap(param1:uint, param2:uint = 80) : Bitmap {
         return new Bitmap(ObjectLibrary.getRedrawnTextureFromType(param1,param2,true));
      }
      
      public static function returnCaretakerBitmap(param1:uint) : Bitmap {
         return new Bitmap(ObjectLibrary.getRedrawnTextureFromType(param1,80,true,true,10));
      }
      
      public static function returnTextfield(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : TextFieldDisplayConcrete {
         var _loc5_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _loc5_.setSize(param2).setColor(param1).setBold(param3);
         _loc5_.setVerticalAlign("bottom");
         _loc5_.filters = !param4?[]:[new DropShadowFilter(0,0,0)];
         return _loc5_;
      }
   }
}
