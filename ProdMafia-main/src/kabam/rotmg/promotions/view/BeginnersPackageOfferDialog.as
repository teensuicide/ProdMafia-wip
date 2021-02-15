package kabam.rotmg.promotions.view {
   import flash.display.Sprite;
   import kabam.rotmg.promotions.view.components.TransparentButton;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class BeginnersPackageOfferDialog extends Sprite {
      
      public static var hifiBeginnerOfferEmbed:Class = BeginnersPackageOfferDialog_hifiBeginnerOfferEmbed;
       
      
      public var close:Signal;
      
      public var buy:Signal;
      
      public function BeginnersPackageOfferDialog() {
         super();
         this.makeBackground();
         this.makeCloseButton();
         this.makeBuyButton();
      }
      
      public function centerOnScreen() : void {
         x = (stage.stageWidth - width) * 0.5;
         y = (stage.stageHeight - height) * 0.5;
      }
      
      private function makeBackground() : void {
         addChild(new hifiBeginnerOfferEmbed());
      }
      
      private function makeBuyButton() : void {
         var _loc1_:Sprite = this.makeTransparentTargetButton(270,400,150,40);
         this.buy = new NativeMappedSignal(_loc1_,"click");
      }
      
      private function makeCloseButton() : void {
         var _loc1_:Sprite = this.makeTransparentTargetButton(550,30,30,30);
         this.close = new NativeMappedSignal(_loc1_,"click");
      }
      
      private function makeTransparentTargetButton(param1:int, param2:int, param3:int, param4:int) : Sprite {
         var _loc5_:TransparentButton = new TransparentButton(param1,param2,param3,param4);
         addChild(_loc5_);
         return _loc5_;
      }
   }
}
