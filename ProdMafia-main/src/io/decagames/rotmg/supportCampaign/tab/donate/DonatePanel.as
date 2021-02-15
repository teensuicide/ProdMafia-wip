package io.decagames.rotmg.supportCampaign.tab.donate {
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.colors.GreyScale;
   import kabam.rotmg.assets.services.IconFactory;
   
   public class DonatePanel extends Sprite {
       
      
      private var _mainContent:Sprite;
      
      private var _donationContent:Sprite;
      
      private var _completedContent:Sprite;
      
      private var pointAmountTextfield:UILabel;
      
      private var completeTextfield:UILabel;
      
      private var supportIcon:SliceScalingBitmap;
      
      private var leftPanel:SliceScalingBitmap;
      
      private var rightPanel:SliceScalingBitmap;
      
      private var _ratio:int;
      
      private var _isEnded:Boolean;
      
      private var _coinBitmap:Bitmap;
      
      private var _downArrow:SliceScalingButton;
      
      private var _upArrow:SliceScalingButton;
      
      private var _donateButton:SliceScalingButton;
      
      private var _amountTextfield:UILabel;
      
      public function DonatePanel(param1:int, param2:Boolean) {
         super();
         this._ratio = param1;
         this._isEnded = param2;
         this.init();
      }
      
      public function get downArrow() : SliceScalingButton {
         return this._downArrow;
      }
      
      public function get upArrow() : SliceScalingButton {
         return this._upArrow;
      }
      
      public function get donateButton() : SliceScalingButton {
         return this._donateButton;
      }
      
      public function get amountTextfield() : UILabel {
         return this._amountTextfield;
      }
      
      public function get gold() : int {
         return int(this._amountTextfield.text);
      }
      
      public function setCompleteText(param1:String) : void {
         if(!this.completeTextfield) {
            this.createCompleteTextField();
         }
         this._donationContent.visible = false;
         this.completeTextfield.text = param1;
         this.completeTextfield.x = Math.round((this._mainContent.width - this.completeTextfield.width) / 2);
         this.completeTextfield.y = 8;
         this._completedContent.visible = true;
      }
      
      public function updateDonateAmount() : void {
         this.updatePoints(int(this._amountTextfield.text) * this._ratio);
      }
      
      public function addDonateAmount(param1:int) : void {
         var _loc2_:int = int(this._amountTextfield.text) + param1;
         if(_loc2_.toString().length > 5 || _loc2_ <= 0) {
            return;
         }
         this._amountTextfield.text = _loc2_.toString();
         this.updatePoints(_loc2_ * this._ratio);
      }
      
      private function init() : void {
         this.createContainers();
         if(!this._isEnded) {
            this.createPanels();
            this.createArrows();
            this.createCoinBitmap();
            this.createAmountTextField();
            this.createPointsAmountTextField();
            this.createSupportIcon();
            this.createDonateButton();
            this.updatePoints(100 * this._ratio);
            if(this._ratio == 0) {
               this.disableElements();
            }
         } else {
            this.createCompleteTextField();
         }
      }
      
      private function disableElements() : void {
         this._upArrow.disabled = true;
         this._downArrow.disabled = true;
         this._amountTextfield.text = "0";
         this._amountTextfield.type = "dynamic";
         GreyScale.setGreyScale(this._coinBitmap.bitmapData);
         GreyScale.setGreyScale(this.supportIcon.bitmapData);
         this._donateButton.disabled = true;
      }
      
      private function createContainers() : void {
         this._mainContent = new Sprite();
         addChild(this._mainContent);
         this._donationContent = new Sprite();
         this._mainContent.addChild(this._donationContent);
         this._completedContent = new Sprite();
         this._mainContent.addChild(this._completedContent);
      }
      
      private function createPanels() : void {
         this.leftPanel = TextureParser.instance.getSliceScalingBitmap("UI","black_field_background",130);
         this.leftPanel.height = 30;
         this.leftPanel.y = 6;
         this._donationContent.addChild(this.leftPanel);
         this.rightPanel = TextureParser.instance.getSliceScalingBitmap("UI","black_field_background",130);
         this.rightPanel.height = 30;
         this.rightPanel.x = 214;
         this.rightPanel.y = 6;
         this._donationContent.addChild(this.rightPanel);
      }
      
      private function createArrows() : void {
         var _loc1_:* = null;
         _loc1_ = TextureParser.instance.getSliceScalingBitmap("UI","spinner_up_arrow");
         this._upArrow = new SliceScalingButton(_loc1_.clone());
         this._upArrow.x = this.leftPanel.width - 40;
         this._upArrow.y = this.leftPanel.y + 2;
         this._donationContent.addChild(this._upArrow);
         this._downArrow = new SliceScalingButton(_loc1_.clone());
         this._downArrow.rotation = 180;
         this._downArrow.x = this._upArrow.x + this._downArrow.width;
         this._downArrow.y = this.leftPanel.y + 28;
         this._donationContent.addChild(this._downArrow);
      }
      
      private function createCoinBitmap() : void {
         this._coinBitmap = new Bitmap(IconFactory.makeCoin());
         this._coinBitmap.y = this.leftPanel.y + 6;
         this._coinBitmap.x = this.leftPanel.width - 64;
         this._donationContent.addChild(this._coinBitmap);
      }
      
      private function createAmountTextField() : void {
         this._amountTextfield = new UILabel();
         this._amountTextfield.type = "input";
         this._amountTextfield.restrict = "0-9";
         this._amountTextfield.maxChars = 5;
         this._amountTextfield.selectable = true;
         DefaultLabelFormat.donateAmountLabel(this._amountTextfield);
         this._amountTextfield.wordWrap = true;
         this._amountTextfield.width = 52;
         this._amountTextfield.text = "100";
         this._amountTextfield.x = 10;
         this._amountTextfield.y = this.leftPanel.y + 6;
         this._donationContent.addChild(this._amountTextfield);
      }
      
      private function createPointsAmountTextField() : void {
         this.pointAmountTextfield = new UILabel();
         DefaultLabelFormat.createLabelFormat(this.pointAmountTextfield,18,15585539,"center",true);
         this.pointAmountTextfield.x = this.rightPanel.width / 2 - this.pointAmountTextfield.width / 2 + 9;
         this.pointAmountTextfield.y = this._amountTextfield.y;
         this._donationContent.addChild(this.pointAmountTextfield);
      }
      
      private function createSupportIcon() : void {
         this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI","campaign_Points");
         this.supportIcon.x = this.pointAmountTextfield.x + this.pointAmountTextfield.width;
         this.supportIcon.y = this.pointAmountTextfield.y + 1;
         this._donationContent.addChild(this.supportIcon);
      }
      
      private function createDonateButton() : void {
         var _loc1_:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","buy_button_background",119);
         _loc1_.x = 112;
         this._donationContent.addChild(_loc1_);
         this._donateButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this._donateButton.setLabel("Boost",DefaultLabelFormat.defaultButtonLabel);
         this._donateButton.width = _loc1_.width - 14;
         this._donateButton.x = _loc1_.x + 7;
         this._donateButton.y = _loc1_.y + 4;
         this._donateButton.disabled = this._isEnded;
         this._donationContent.addChild(this._donateButton);
      }
      
      private function createCompleteTextField() : void {
         this.completeTextfield = new UILabel();
         DefaultLabelFormat.createLabelFormat(this.completeTextfield,18,65280,"center",true);
         this._completedContent.addChild(this.completeTextfield);
      }
      
      private function updatePoints(param1:int) : void {
         this.pointAmountTextfield.text = param1.toString();
         var _loc2_:int = this.pointAmountTextfield.width + this.supportIcon.width + 4;
         this.pointAmountTextfield.x = this.rightPanel.x + Math.round((this.rightPanel.width - this.pointAmountTextfield.width) / 2) - 8;
         this.supportIcon.x = this.pointAmountTextfield.x + this.pointAmountTextfield.width;
      }
   }
}
