package kabam.rotmg.game.view {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.packages.model.PackageInfo;
   import kabam.rotmg.packages.services.PackageModel;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ShopDisplayMediator extends Mediator {
       
      
      [Inject]
      public var view:ShopDisplay;
      
      [Inject]
      public var packageBoxModel:PackageModel;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      private var toolTip:TextToolTip = null;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public function ShopDisplayMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc3_:* = null;
         if(this.view.shopButton && this.view.isOnNexus) {
            this.view.shopButton.addEventListener("click",this.view.onShopClick);
            this.toolTip = new TextToolTip(3552822,10197915,null,"Click to open!",95);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.shopButton);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
         }
         var _loc2_:Vector.<PackageInfo> = this.packageBoxModel.getTargetingBoxesForGrid().concat(this.packageBoxModel.getBoxesForGrid());
         var _loc1_:Date = new Date();
         _loc1_.setTime(Parameters.data["packages_indicator"]);
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc3_ in _loc2_) {
            if(_loc3_ != null && (!_loc3_.endTime || _loc3_.getSecondsToEnd() > 0)) {
               if(_loc3_.isNew() && (_loc3_.startTime.getTime() > _loc1_.getTime() || !Parameters.data["packages_indicator"])) {
                  this.view.newIndicator(true);
               }
            }
         }
      }
   }
}
