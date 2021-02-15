package io.decagames.rotmg.pets.windows.yard.fuse {
   import io.decagames.rotmg.pets.components.petItem.PetItem;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.tabs.UITab;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class FuseTab extends UITab {
      
      public static const MAXED_COLOR:uint = 6735914;
      
      public static const BAD_COLOR:uint = 14948352;
      
      public static const DEFAULT_COLOR:uint = 15032832;
      
      public static const LOW:String = "FusionStrength.Low";
      
      public static const BAD:String = "FusionStrength.Bad";
      
      public static const GOOD:String = "FusionStrength.Good";
      
      public static const GREAT:String = "FusionStrength.Great";
      
      public static const FANTASTIC:String = "FusionStrength.Fantastic";
      
      public static const MAXED:String = "FusionStrength.Maxed";
      
      public static const NONE:String = "FusionStrength.None";
       
      
      private var petsGrid:UIGrid;
      
      private var gridWidth:int = 220;
      
      private var fusionStrengthLabel:UILabel;
      
      private var fuseButtonsMargin:int = 20;
      
      private var _fuseGoldButton:ShopBuyButton;
      
      private var _fuseFameButton:ShopBuyButton;
      
      public function FuseTab(param1:int) {
         var _loc2_:int = 0;
         super("Fuse");
         this.petsGrid = new UIGrid(220,5,5,85,5);
         this.petsGrid.x = Math.round((param1 - this.gridWidth - 17) / 2);
         this.petsGrid.y = 15;
         addChild(this.petsGrid);
         this.fusionStrengthLabel = new UILabel();
         DefaultLabelFormat.fusionStrengthLabel(this.fusionStrengthLabel,0,0);
         this.fusionStrengthLabel.width = param1;
         this.fusionStrengthLabel.wordWrap = true;
         this.fusionStrengthLabel.y = 102;
         addChild(this.fusionStrengthLabel);
         this._fuseGoldButton = new ShopBuyButton(0,0);
         this._fuseFameButton = new ShopBuyButton(0,1);
         var _loc3_:int = 100;
         this._fuseFameButton.width = _loc3_;
         this._fuseGoldButton.width = _loc3_;
         _loc3_ = 125;
         this._fuseFameButton.y = _loc3_;
         this._fuseGoldButton.y = _loc3_;
         _loc2_ = (param1 - (this._fuseGoldButton.width + this._fuseFameButton.width + this.fuseButtonsMargin)) / 2;
         this._fuseGoldButton.x = _loc2_;
         this._fuseFameButton.x = this._fuseGoldButton.x + this._fuseGoldButton.width + _loc2_;
         addChild(this._fuseGoldButton);
         addChild(this._fuseFameButton);
      }
      
      private static function getKeyFor(param1:Number) : String {
         if(isMaxed(param1)) {
            return "FusionStrength.Maxed";
         }
         if(param1 > 0.8) {
            return "FusionStrength.Fantastic";
         }
         if(param1 > 0.6) {
            return "FusionStrength.Great";
         }
         if(param1 > 0.4) {
            return "FusionStrength.Good";
         }
         if(param1 > 0.2) {
            return "FusionStrength.Low";
         }
         return "FusionStrength.Bad";
      }
      
      private static function isMaxed(param1:Number) : Boolean {
         return Math.abs(param1 - 1) < 0.001;
      }
      
      private static function isBad(param1:Number) : Boolean {
         return param1 < 0.2;
      }
      
      public function get fuseGoldButton() : ShopBuyButton {
         return this._fuseGoldButton;
      }
      
      public function get fuseFameButton() : ShopBuyButton {
         return this._fuseFameButton;
      }
      
      public function setStrengthPercentage(param1:Number, param2:Boolean = false) : void {
         var _loc3_:* = null;
         if(param2) {
            this.fusionStrengthLabel.text = "This pet is at its highest Rarity";
         } else if(param1 == -1) {
            this.fusionStrengthLabel.text = "Select a Pet to Fuse";
         } else {
            _loc3_ = LineBuilder.getLocalizedStringFromKey(getKeyFor(param1));
            this.fusionStrengthLabel.text = _loc3_ + " Fusion";
            DefaultLabelFormat.fusionStrengthLabel(this.fusionStrengthLabel,this.colorText(param1),_loc3_.length);
         }
      }
      
      public function clearGrid() : void {
         this.petsGrid.clearGrid();
      }
      
      public function addPet(param1:PetItem) : void {
         var _loc2_:UIGridElement = new UIGridElement();
         _loc2_.addChild(param1);
         this.petsGrid.addGridElement(_loc2_);
      }
      
      private function colorText(param1:Number) : uint {
         if(isMaxed(param1)) {
            return 6735914;
         }
         if(isBad(param1)) {
            return 14948352;
         }
         return 15032832;
      }
   }
}
