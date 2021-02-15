package io.decagames.rotmg.pets.components.petSkinsCollection {
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot;
   import io.decagames.rotmg.pets.data.vo.SkinVO;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.scroll.UIScrollbar;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.colors.Tint;
   
   public class PetSkinsCollection extends Sprite {
      
      public static const COLLECTION_HEIGHT:int = 425;
      
      public static var COLLECTION_WIDTH:int = 360;
       
      
      private var collectionContainer:Sprite;
      
      private var contentInset:SliceScalingBitmap;
      
      private var contentTitle:SliceScalingBitmap;
      
      private var title:UILabel;
      
      private var contentGrid:UIGrid;
      
      private var contentElement:UIGridElement;
      
      private var petGrid:UIGrid;
      
      public function PetSkinsCollection(param1:int, param2:int) {
         var _loc4_:* = null;
         var _loc3_:* = null;
         super();
         this.contentGrid = new UIGrid(COLLECTION_WIDTH - 40,1,15);
         this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",COLLECTION_WIDTH);
         addChild(this.contentInset);
         this.contentInset.height = 425;
         this.contentInset.x = 0;
         this.contentInset.y = 0;
         this.contentTitle = TextureParser.instance.getSliceScalingBitmap("UI","content_title_decoration",COLLECTION_WIDTH);
         addChild(this.contentTitle);
         this.contentTitle.x = 0;
         this.contentTitle.y = 0;
         this.title = new UILabel();
         this.title.text = "Collection";
         DefaultLabelFormat.petNameLabel(this.title,16777215);
         this.title.width = COLLECTION_WIDTH;
         this.title.wordWrap = true;
         this.title.y = 4;
         this.title.x = 0;
         addChild(this.title);
         _loc4_ = TextureParser.instance.getSliceScalingBitmap("UI","content_divider_smalltitle_white",94);
         Tint.add(_loc4_,3355443,1);
         addChild(_loc4_);
         _loc4_.x = Math.round((COLLECTION_WIDTH - _loc4_.width) / 2);
         _loc4_.y = 23;
         _loc3_ = new UILabel();
         DefaultLabelFormat.wardrobeCollectionLabel(_loc3_);
         _loc3_.text = param1 + "/" + param2;
         _loc3_.width = _loc4_.width;
         _loc3_.wordWrap = true;
         _loc3_.y = _loc4_.y + 1;
         _loc3_.x = _loc4_.x;
         addChild(_loc3_);
         this.createScrollview();
      }
      
      public function addPetSkins(param1:String, param2:Vector.<SkinVO>) : void {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(param2 == null) {
            return;
         }
         this.petGrid = new UIGrid(COLLECTION_WIDTH - 40,7,5);
         param2 = param2.sort(this.sortByRarity);
         var _loc6_:* = param2;
         var _loc10_:int = 0;
         var _loc9_:* = param2;
         for each(_loc3_ in param2) {
            this.petGrid.addGridElement(new PetSkinSlot(_loc3_,true));
            _loc5_++;
            if(_loc3_.isOwned) {
               _loc7_++;
            }
         }
         this.petGrid.x = 10;
         this.petGrid.y = 25;
         var _loc8_:PetFamilyContainer = new PetFamilyContainer(param1,_loc7_,_loc5_);
         _loc8_.addChild(this.petGrid);
         this.contentGrid.addGridElement(_loc8_);
      }
      
      private function createScrollview() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _loc2_ = new Sprite();
         this.collectionContainer = new Sprite();
         this.collectionContainer.x = this.contentInset.x;
         this.collectionContainer.y = 2;
         this.collectionContainer.addChild(this.contentGrid);
         _loc2_.addChild(this.collectionContainer);
         _loc1_ = new UIScrollbar(368);
         _loc1_.mouseRollSpeedFactor = 1;
         _loc1_.scrollObject = this;
         _loc1_.content = this.collectionContainer;
         _loc2_.addChild(_loc1_);
         _loc1_.x = this.contentInset.x + this.contentInset.width - 25;
         _loc1_.y = 7;
         _loc3_ = new Sprite();
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.drawRect(0,0,COLLECTION_WIDTH,380);
         _loc3_.x = this.collectionContainer.x;
         _loc3_.y = this.collectionContainer.y;
         this.collectionContainer.mask = _loc3_;
         _loc2_.addChild(_loc3_);
         addChild(_loc2_);
         _loc2_.y = 42;
      }
      
      private function sortByName(param1:SkinVO, param2:SkinVO) : int {
         if(param1.name > param2.name) {
            return 1;
         }
         return -1;
      }
      
      private function sortByRarity(param1:SkinVO, param2:SkinVO) : int {
         if(param1.rarity.ordinal == param2.rarity.ordinal) {
            return this.sortByName(param1,param2);
         }
         if(param1.rarity.ordinal > param2.rarity.ordinal) {
            return 1;
         }
         return -1;
      }
   }
}
