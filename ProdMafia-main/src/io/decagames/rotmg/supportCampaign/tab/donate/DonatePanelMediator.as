package io.decagames.rotmg.supportCampaign.tab.donate {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.events.Event;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import io.decagames.rotmg.supportCampaign.signals.MaxRankReachedSignal;
   import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
   import io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopup;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class DonatePanelMediator extends Mediator {
       
      
      [Inject]
      public var view:DonatePanel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var model:SupporterCampaignModel;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var maxRankReachedSignal:MaxRankReachedSignal;
      
      [Inject]
      public var updateCampaignProgress:UpdateCampaignProgress;
      
      private var infoToolTip:TextToolTip;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public function DonatePanelMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.maxRankReachedSignal.add(this.onMaxRankReached);
         this.updateCampaignProgress.add(this.onCampaignUpdate);
         if(!this.model.isEnded) {
            this.view.upArrow.clickSignal.add(this.upClickHandler);
            this.view.downArrow.clickSignal.add(this.downClickHandler);
            this.view.amountTextfield.addEventListener("change",this.onAmountChange);
         }
         if(this.model.hasMaxRank()) {
            this.setDonateButtonState(true);
            this.onMaxRankReached();
         } else if(this.view.donateButton) {
            this.view.donateButton.clickSignal.add(this.donateClickHandler);
         }
         if(this.model.donatePointsRatio == 0) {
            this.infoToolTip = new TextToolTip(3552822,15585539,"Donation not possible","You cannot spend Gold to progress in this Campaign",220);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view);
            this.hoverTooltipDelegate.tooltip = this.infoToolTip;
         }
      }
      
      override public function destroy() : void {
         if(!this.model.isEnded) {
            this.view.upArrow.clickSignal.remove(this.upClickHandler);
            this.view.downArrow.clickSignal.remove(this.downClickHandler);
            this.view.donateButton.clickSignal.remove(this.donateClickHandler);
            this.view.amountTextfield.removeEventListener("change",this.onAmountChange);
         }
         if(this.model.donatePointsRatio == 0) {
            this.hoverTooltipDelegate = null;
            this.infoToolTip = null;
         }
         this.maxRankReachedSignal.remove(this.onMaxRankReached);
         this.updateCampaignProgress.remove(this.onCampaignUpdate);
      }
      
      public function onCampaignUpdate() : void {
         this.onAmountChange();
      }
      
      private function onMaxRankReached() : void {
         this.setDonateButtonState(true);
         this.view.setCompleteText(this.model.campaignTitle + " Complete!");
      }
      
      private function setDonateButtonState(param1:Boolean) : void {
         if(this.view.donateButton) {
            this.view.donateButton.disabled = param1;
         }
      }
      
      private function upClickHandler(param1:BaseButton) : void {
         if(this.model.ranks[this.model.ranks.length - 1] - this.model.points > 0) {
            this.view.addDonateAmount(this.getDonationPoints(100));
         }
      }
      
      private function downClickHandler(param1:BaseButton) : void {
         this.view.addDonateAmount(this.getDonationPoints(-100));
      }
      
      private function donateClickHandler(param1:BaseButton) : void {
         this.showPopupSignal.dispatch(new DonateConfirmationPopup(this.view.gold,this.view.gold * this.model.donatePointsRatio));
      }
      
      private function getDonationPoints(param1:int) : int {
         var _loc2_:* = 0;
         var _loc4_:int = parseInt(this.view.amountTextfield.text);
         var _loc3_:int = (this.model.ranks[this.model.ranks.length - 1] - this.model.points) / this.model.donatePointsRatio;
         if(_loc4_ + param1 > _loc3_) {
            _loc2_ = int(_loc3_ - _loc4_);
            this.view.upArrow.disabled = true;
         } else {
            this.view.upArrow.disabled = false;
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function onAmountChange(param1:Event = null) : void {
         var _loc2_:int = (this.model.ranks[this.model.ranks.length - 1] - this.model.points) / this.model.donatePointsRatio;
         if(int(this.view.amountTextfield.text) > _loc2_) {
            this.view.amountTextfield.text = _loc2_.toString();
         }
         this.view.updateDonateAmount();
      }
   }
}
