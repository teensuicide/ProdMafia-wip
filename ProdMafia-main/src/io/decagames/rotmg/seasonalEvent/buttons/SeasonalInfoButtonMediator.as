package io.decagames.rotmg.seasonalEvent.buttons {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventInfoPopup;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class SeasonalInfoButtonMediator extends Mediator {
       
      
      [Inject]
      public var view:SeasonalInfoButton;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      private var toolTip:TextToolTip = null;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public function SeasonalInfoButtonMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.infoButton.addEventListener("click",this.onInfoClicked);
         this.toolTip = new TextToolTip(3552822,10197915,null,"Click to open Seasonal Event Info!",95);
         this.hoverTooltipDelegate = new HoverTooltipDelegate();
         this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
         this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
         this.hoverTooltipDelegate.setDisplayObject(this.view.infoButton);
         this.hoverTooltipDelegate.tooltip = this.toolTip;
      }
      
      override public function destroy() : void {
         super.destroy();
         this.view.infoButton.removeEventListener("click",this.onInfoClicked);
         this.hoverTooltipDelegate.removeDisplayObject();
         this.hoverTooltipDelegate = null;
      }
      
      private function onInfoClicked(param1:MouseEvent) : void {
         this.showPopupSignal.dispatch(new SeasonalEventInfoPopup(this.seasonalEventModel.rulesAndDescription));
      }
   }
}
