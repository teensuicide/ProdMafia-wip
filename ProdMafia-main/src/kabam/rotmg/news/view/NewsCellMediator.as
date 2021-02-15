package kabam.rotmg.news.view {
   import flash.net.URLRequest;
   import kabam.rotmg.news.controller.OpenSkinSignal;
   import kabam.rotmg.news.model.NewsCellLinkType;
   import kabam.rotmg.news.model.NewsCellVO;
   import kabam.rotmg.packages.control.OpenPackageSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class NewsCellMediator extends Mediator {
       
      
      [Inject]
      public var view:NewsCell;
      
      [Inject]
      public var openPackageSignal:OpenPackageSignal;
      
      [Inject]
      public var openSkinSignal:OpenSkinSignal;
      
      public function NewsCellMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.clickSignal.add(this.onNewsClicked);
      }
      
      override public function destroy() : void {
         this.view.clickSignal.remove(this.onNewsClicked);
      }
      
      private function onNewsClicked(param1:NewsCellVO) : void {
         var _loc2_:* = null;
         var _loc3_:* = param1.linkType;
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case NewsCellLinkType.OPENS_LINK:
               _loc2_ = new URLRequest(param1.linkDetail);
               return;
            case NewsCellLinkType.OPENS_PACKAGE:
               this.openPackageSignal.dispatch(param1.linkDetail);
               return;
            case NewsCellLinkType.OPENS_SKIN:
               this.openSkinSignal.dispatch(param1.linkDetail);
               return;
            default:
               return;
         }
      }
   }
}
