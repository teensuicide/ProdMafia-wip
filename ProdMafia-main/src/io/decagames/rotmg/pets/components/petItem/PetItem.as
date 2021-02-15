package io.decagames.rotmg.pets.components.petItem {
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.components.petIcon.PetIcon;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.utils.ItemBackgroundFactory;
   import kabam.rotmg.pets.view.dialogs.Disableable;
   
   public class PetItem extends Sprite implements Disableable {
      
      public static const TOP_LEFT:String = "topLeft";
      
      public static const TOP_RIGHT:String = "topRight";
      
      public static const BOTTOM_RIGHT:String = "bottomRight";
      
      public static const BOTTOM_LEFT:String = "bottomLeft";
      
      public static const REGULAR:String = "regular";
      
      private static const CUT_STATES:Array = ["topLeft","topRight","bottomRight","bottomLeft"];
       
      
      private var petIcon:PetIcon;
      
      private var background:String;
      
      private var size:int;
      
      private var backgroundGraphic:PetItemBackground;
      
      private var defaultBackgroundColor:uint;
      
      private var defaultSelectedColor:uint = 15306295;
      
      public function PetItem(param1:uint = 5526612) {
         super();
         this.defaultBackgroundColor = param1;
      }
      
      public function set selected(param1:Boolean) : void {
         this.setBackground(this.background,!param1?this.defaultBackgroundColor:uint(this.defaultSelectedColor),1);
      }
      
      public function setPetIcon(param1:PetIcon) : void {
         this.petIcon = param1;
         this.petIcon.x = -8;
         this.petIcon.y = -8;
         addChild(param1);
      }
      
      public function disable() : void {
         this.petIcon.disable();
      }
      
      public function isEnabled() : Boolean {
         return this.petIcon.isEnabled();
      }
      
      public function setSize(param1:int) : void {
         this.size = param1;
      }
      
      public function setBackground(param1:String, param2:uint, param3:Number) : void {
         this.background = param1;
         if(this.backgroundGraphic) {
            removeChild(this.backgroundGraphic);
         }
         this.backgroundGraphic = PetItemBackground(ItemBackgroundFactory.create(this.size,this.getCuts(),param2,param3));
         addChildAt(this.backgroundGraphic,0);
      }
      
      public function getBackground() : String {
         return this.background;
      }
      
      public function getPetVO() : PetVO {
         return this.petIcon.getPetVO();
      }
      
      private function getCuts() : Array {
         var _loc1_:* = [0,0,0,0];
         if(this.background != "regular") {
            _loc1_[CUT_STATES.indexOf(this.background)] = 1;
         }
         return _loc1_;
      }
   }
}
