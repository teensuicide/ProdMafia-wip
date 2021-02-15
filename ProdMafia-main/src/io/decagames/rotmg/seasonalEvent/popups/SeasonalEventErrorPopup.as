package io.decagames.rotmg.seasonalEvent.popups {
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class SeasonalEventErrorPopup extends ModalPopup {
       
      
      private const WIDTH:int = 330;
      
      private const HEIGHT:int = 100;
      
      private var _errorText:UILabel;
      
      private var _okButton:SliceScalingButton;
      
      private var _message:String;
      
      public function SeasonalEventErrorPopup(param1:String) {
         super(330,100,"Seasonal Event!",DefaultLabelFormat.defaultSmallPopupTitle);
         this._message = param1;
         this.init();
      }
      
      public function get okButton() : SliceScalingButton {
         return this._okButton;
      }
      
      public function get message() : String {
         return this._message;
      }
      
      private function init() : void {
         this.createLabel();
         this.createButton();
      }
      
      private function createButton() : void {
         var _loc1_:* = null;
         _loc1_ = new TextureParser().getSliceScalingBitmap("UI","main_button_decoration",186);
         addChild(_loc1_);
         _loc1_.x = Math.round((330 - _loc1_.width) / 2);
         _loc1_.y = this._errorText.y + this._errorText.height + 4;
         this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this._okButton.setLabel("OK",DefaultLabelFormat.questButtonCompleteLabel);
         this._okButton.width = 130;
         this._okButton.x = Math.round(100);
         this._okButton.y = this._errorText.y + this._errorText.height + 10;
         addChild(this._okButton);
      }
      
      private function createLabel() : void {
         this._errorText = new UILabel();
         DefaultLabelFormat.createLabelFormat(this._errorText,14,16777215,"center");
         this._errorText.width = 330;
         this._errorText.multiline = true;
         this._errorText.wordWrap = true;
         this._errorText.text = this._message;
         this._errorText.y = 10;
         addChild(this._errorText);
      }
   }
}
