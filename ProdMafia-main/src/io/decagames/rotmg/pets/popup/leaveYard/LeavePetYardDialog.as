package io.decagames.rotmg.pets.popup.leaveYard {
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.popups.modal.TextModal;
   import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class LeavePetYardDialog extends TextModal {
       
      
      private var _leaveButton:SliceScalingButton;
      
      public function LeavePetYardDialog() {
         var _loc1_:* = undefined;
         _leaveButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         _loc1_ = new Vector.<BaseButton>();
         this._leaveButton.width = 100;
         this._leaveButton.setLabel(LineBuilder.getLocalizedStringFromKey("PetsDialog.leave"),DefaultLabelFormat.defaultButtonLabel);
         _loc1_.push(new ClosePopupButton(LineBuilder.getLocalizedStringFromKey("PetsDialog.remain")));
         _loc1_.push(this.leaveButton);
         super(300,LineBuilder.getLocalizedStringFromKey("LeavePetYardDialog.title"),LineBuilder.getLocalizedStringFromKey("LeavePetYardDialog.text"),_loc1_);
      }
      
      public function get leaveButton() : SliceScalingButton {
         return this._leaveButton;
      }
   }
}
