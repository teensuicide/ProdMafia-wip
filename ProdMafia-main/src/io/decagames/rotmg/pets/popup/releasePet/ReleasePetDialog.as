package io.decagames.rotmg.pets.popup.releasePet {
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.popups.modal.TextModal;
   import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class ReleasePetDialog extends TextModal {
       
      
      private var _releaseButton:SliceScalingButton;
      
      private var _petId:int;
      
      public function ReleasePetDialog(param1:int) {
         this._petId = param1;
         var _loc2_:Vector.<BaseButton> = new Vector.<BaseButton>();
         this._releaseButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this._releaseButton.width = 100;
         this._releaseButton.setLabel(LineBuilder.getLocalizedStringFromKey("PetPanel.release"),DefaultLabelFormat.defaultButtonLabel);
         _loc2_.push(this.releaseButton);
         _loc2_.push(new ClosePopupButton(LineBuilder.getLocalizedStringFromKey("Frame.cancel")));
         super(300,"Release Pet","Are you sure you want to release this Pet? Once released, you will not be able to get you pet back.",_loc2_);
      }
      
      public function get releaseButton() : SliceScalingButton {
         return this._releaseButton;
      }
      
      public function get petId() : int {
         return this._petId;
      }
   }
}
