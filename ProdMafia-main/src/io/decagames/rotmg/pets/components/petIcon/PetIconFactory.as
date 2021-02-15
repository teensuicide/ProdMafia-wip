package io.decagames.rotmg.pets.components.petIcon {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   
   public class PetIconFactory {
       
      
      public var outlineSize:Number = 1.4;
      
      public function PetIconFactory() {
         super();
      }
      
      public function create(param1:PetVO, param2:int) : PetIcon {
         var _loc5_:BitmapData = this.getPetSkinTexture(param1,param2);
         var _loc4_:Bitmap = new Bitmap(_loc5_);
         var _loc3_:PetIcon = new PetIcon(param1);
         _loc3_.setBitmap(_loc4_);
         return _loc3_;
      }
      
      public function getPetSkinTexture(param1:IPetVO, param2:int, param3:uint = 0) : BitmapData {
         var _loc5_:Number = NaN;
         if(!param1.getSkinMaskedImage()) {
            return null;
         }
         return new BitmapData(param2,param2);
      }
   }
}
