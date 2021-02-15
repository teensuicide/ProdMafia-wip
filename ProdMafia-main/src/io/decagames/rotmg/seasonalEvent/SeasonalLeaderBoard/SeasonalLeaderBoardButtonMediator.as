package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class SeasonalLeaderBoardButtonMediator extends Mediator {
       
      
      [Inject]
      public var view:SeasonalLeaderBoardButton;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var toolTip:TextToolTip = null;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public function SeasonalLeaderBoardButtonMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.button.addEventListener("click",this.onButtonClick);
         this.toolTip = new TextToolTip(3552822,10197915,null,"Click to open!",95);
         this.hoverTooltipDelegate = new HoverTooltipDelegate();
         this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
         this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
         this.hoverTooltipDelegate.setDisplayObject(this.view.button);
         this.hoverTooltipDelegate.tooltip = this.toolTip;
      }
      
      override public function destroy() : void {
         super.destroy();
         this.view.button.removeEventListener("click",this.onButtonClick);
         this.hoverTooltipDelegate.removeDisplayObject();
         this.hoverTooltipDelegate = null;
      }
      
      private function onButtonClick(param1:MouseEvent) : void {
         if(this.seasonalEventModel.isChallenger == 1) {
            this.showPopupSignal.dispatch(new SeasonalLeaderBoard());
         } else {
            this.showPopupSignal.dispatch(new SeasonalLegacyLeaderBoard());
         }
      }
   }
}
