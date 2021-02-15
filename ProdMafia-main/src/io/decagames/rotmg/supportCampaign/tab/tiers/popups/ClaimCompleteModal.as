package io.decagames.rotmg.supportCampaign.tab.tiers.popups {
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.modal.TextModal;
   import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
   
   public class ClaimCompleteModal extends TextModal {
       
      
      public function ClaimCompleteModal() {
         var _loc1_:Vector.<BaseButton> = new Vector.<BaseButton>();
         _loc1_.push(new ClosePopupButton("OK"));
         super(300,"Claim complete","You will find your items in the Gift Chest.",_loc1_);
      }
   }
}
