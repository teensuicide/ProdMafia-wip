package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.screens.charrects.CharacterRectList;
   import flash.display.Shape;
   import flash.display.Sprite;
   import kabam.rotmg.core.model.PlayerModel;
   
   public class CharacterList extends Sprite {
      
      public static const WIDTH:int = 760;
      
      public static const HEIGHT:int = 415;
      
      public static const TYPE_CHAR_SELECT:int = 1;
      
      public static const TYPE_GRAVE_SELECT:int = 2;
      
      public static const TYPE_VAULT_SELECT:int = 3;
       
      
      public var charRectList_:Sprite;
      
      public function CharacterList(param1:PlayerModel, param2:int) {
         var _loc4_:* = null;
         var _loc3_:* = null;
         super();
         var _loc5_:* = param2 - 1;
         switch(_loc5_) {
            case 0:
               this.charRectList_ = new CharacterRectList();
               break;
            case 1:
               this.charRectList_ = new Graveyard(param1);
         }
         addChild(this.charRectList_);
         if(height > 400) {
            _loc4_ = new Shape();
            _loc3_ = _loc4_.graphics;
            _loc3_.beginFill(0);
            _loc3_.drawRect(0,0,760,415);
            _loc3_.endFill();
            addChild(_loc4_);
            mask = _loc4_;
         }
      }
      
      public function setPos(param1:Number) : void {
         this.charRectList_.y = param1;
      }
   }
}
