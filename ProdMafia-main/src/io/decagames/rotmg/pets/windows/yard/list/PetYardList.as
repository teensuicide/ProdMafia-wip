package io.decagames.rotmg.pets.windows.yard.list {
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.components.petItem.PetItem;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.scroll.UIScrollbar;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.colors.Tint;
   
   public class PetYardList extends Sprite {
      
      public static const YARD_HEIGHT:int = 425;
      
      public static var YARD_WIDTH:int = 275;
       
      
      private var yardContainer:Sprite;
      
      private var contentInset:SliceScalingBitmap;
      
      private var contentTitle:SliceScalingBitmap;
      
      private var title:UILabel;
      
      private var contentGrid:UIGrid;
      
      private var contentElement:UIGridElement;
      
      private var petGrid:UIGrid;
      
      private var _upgradeButton:SliceScalingButton;
      
      public function PetYardList() {
         super();
         this.contentGrid = new UIGrid(YARD_WIDTH - 55,1,15);
         this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",YARD_WIDTH);
         addChild(this.contentInset);
         this.contentInset.height = 425;
         this.contentInset.x = 0;
         this.contentInset.y = 0;
         this.contentTitle = TextureParser.instance.getSliceScalingBitmap("UI","content_title_decoration",YARD_WIDTH);
         addChild(this.contentTitle);
         this.contentTitle.x = 0;
         this.contentTitle.y = 0;
         this.title = new UILabel();
         this.title.text = "Pet Yard";
         DefaultLabelFormat.petNameLabel(this.title,16777215);
         this.title.width = YARD_WIDTH;
         this.title.wordWrap = true;
         this.title.y = 3;
         this.title.x = 0;
         addChild(this.title);
         this.createScrollview();
         this.createPetsGrid();
      }
      
      public function get upgradeButton() : BaseButton {
         return this._upgradeButton;
      }
      
      public function showPetYardRarity(param1:String, param2:Boolean) : void {
         var _loc4_:* = null;
         var _loc3_:* = null;
         _loc4_ = TextureParser.instance.getSliceScalingBitmap("UI","content_divider_smalltitle_white",180);
         Tint.add(_loc4_,3355443,1);
         addChild(_loc4_);
         _loc4_.x = Math.round((YARD_WIDTH - _loc4_.width) / 2);
         _loc4_.y = 23;
         _loc3_ = new UILabel();
         DefaultLabelFormat.petYardRarity(_loc3_);
         _loc3_.text = param1;
         _loc3_.width = _loc4_.width;
         _loc3_.wordWrap = true;
         _loc3_.y = _loc4_.y + 2;
         _loc3_.x = _loc4_.x;
         addChild(_loc3_);
         if(param2) {
            this._upgradeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","upgrade_button"));
            this._upgradeButton.x = _loc4_.x + _loc4_.width - this._upgradeButton.width + 8;
            this._upgradeButton.y = _loc4_.y - this._upgradeButton.height / 2 + 8;
            addChild(this._upgradeButton);
         }
      }
      
      public function addPet(param1:PetItem) : void {
         var _loc2_:UIGridElement = new UIGridElement();
         _loc2_.addChild(param1);
         this.petGrid.addGridElement(_loc2_);
      }
      
      public function clearPetsList() : void {
         this.petGrid.clearGrid();
      }
      
      private function createScrollview() : void {
         var _loc2_:Sprite = new Sprite();
         this.yardContainer = new Sprite();
         this.yardContainer.x = this.contentInset.x;
         this.yardContainer.y = 2;
         this.yardContainer.addChild(this.contentGrid);
         _loc2_.addChild(this.yardContainer);
         var _loc1_:UIScrollbar = new UIScrollbar(365);
         _loc1_.mouseRollSpeedFactor = 1;
         _loc1_.scrollObject = this;
         _loc1_.content = this.yardContainer;
         _loc2_.addChild(_loc1_);
         _loc1_.x = this.contentInset.x + this.contentInset.width - 25;
         _loc1_.y = 7;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.drawRect(0,0,YARD_WIDTH,380);
         _loc3_.x = this.yardContainer.x;
         _loc3_.y = this.yardContainer.y;
         this.yardContainer.mask = _loc3_;
         _loc2_.addChild(_loc3_);
         addChild(_loc2_);
         _loc2_.y = 45;
      }
      
      private function createPetsGrid() : void {
         this.contentElement = new UIGridElement();
         this.petGrid = new UIGrid(YARD_WIDTH - 55,5,5);
         this.petGrid.x = 18;
         this.petGrid.y = 8;
         this.contentElement.addChild(this.petGrid);
         this.contentGrid.addGridElement(this.contentElement);
      }
   }
}
