package kabam.rotmg.packages.view {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import kabam.display.Loader.LoaderProxy;
   import kabam.display.Loader.LoaderProxyConcrete;
   import kabam.lib.resizing.view.Resizable;
   import kabam.rotmg.packages.model.PackageInfo;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   
   public class PackageOfferDialog extends Sprite implements Resizable {
       
      
      const paddingTop:Number = 6;
      
      const paddingRight:Number = 6;
      
      const paddingBottom:Number = 16;
      
      const fontSize:int = 27;
      
      private const busyIndicator:DisplayObject = makeBusyIndicator();
      
      private const buyNow:Sprite = makeBuyNow();
      
      private const title:TextFieldDisplayConcrete = makeTitle();
      
      private const closeButton:DialogCloseButton = makeCloseButton();
      
      public var ready:Signal;
      
      public var buy:Signal;
      
      public var close:Signal;
      
      var loader:LoaderProxy;
      
      var goldDisplay:GoldDisplay;
      
      var image:DisplayObject;
      
      private var packageInfo:PackageInfo;
      
      private var spaceAvailable:Rectangle;
      
      public function PackageOfferDialog() {
         ready = new Signal();
         buy = new Signal();
         close = new Signal();
         loader = new LoaderProxyConcrete();
         goldDisplay = new GoldDisplay();
         spaceAvailable = new Rectangle();
         super();
      }
      
      public function setPackage(param1:PackageInfo) : PackageOfferDialog {
         removeChild(this.busyIndicator);
         this.packageInfo = param1;
         return this;
      }
      
      public function getPackage() : PackageInfo {
         return this.packageInfo;
      }
      
      public function destroy() : void {
         this.loader.unload();
      }
      
      public function resize(param1:Rectangle) : void {
         this.spaceAvailable = param1;
         this.center();
      }
      
      private function makeBusyIndicator() : DisplayObject {
         var _loc1_:DisplayObject = new BusyIndicator();
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeCloseButton() : DialogCloseButton {
         return new DialogCloseButton();
      }
      
      private function makeBuyNow() : DeprecatedTextButton {
         return new DeprecatedTextButton(16,"PackageOfferDialog.buyNow");
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(27).setColor(11776947);
         _loc1_.y = 11;
         _loc1_.setAutoSize("center");
         return _loc1_;
      }
      
      private function setImageURL(param1:String) : void {
         this.loader && this.loader.unload();
         this.loader.contentLoaderInfo.addEventListener("ioError",this.onIOError);
         this.loader.contentLoaderInfo.addEventListener("complete",this.onComplete);
         this.loader.load(new URLRequest(param1));
      }
      
      private function populateDialog(param1:DisplayObject) : void {
         this.setImage(param1);
         addChild(this.title);
         this.handleCloseButton();
         this.handleBuyNow();
         this.handleGold();
      }
      
      private function removeListeners() : void {
         this.loader.contentLoaderInfo.removeEventListener("ioError",this.onIOError);
         this.loader.contentLoaderInfo.removeEventListener("complete",this.onComplete);
      }
      
      private function handleGold() : void {
         this.goldDisplay.init();
         addChild(this.goldDisplay);
         this.goldDisplay.x = this.buyNow.x - 16;
         this.goldDisplay.y = this.buyNow.y + this.buyNow.height / 2;
      }
      
      private function handleBuyNow() : void {
         addChild(this.buyNow);
         this.buyNow.x = this.image.width / 2 - this.buyNow.width / 2;
         this.buyNow.y = this.image.height - this.buyNow.height - 16 - 4;
         this.buyNow.addEventListener("mouseUp",this.onBuyNow);
      }
      
      private function handleCloseButton() : void {
         addChild(this.closeButton);
         this.closeButton.x = this.image.width - this.closeButton.width * 2 - 6;
         this.closeButton.y = 11;
         this.closeButton.addEventListener("mouseUp",this.onMouseUp);
      }
      
      private function setImage(param1:DisplayObject) : void {
         this.image && removeChild(this.image);
         this.image = param1;
         this.image && addChild(this.image);
         this.center();
      }
      
      private function center() : void {
         x = (this.spaceAvailable.width - width) / 2;
         y = (this.spaceAvailable.height - height) / 2;
      }
      
      private function setTitle(param1:String) : void {
         this.title.setStringBuilder(new StaticStringBuilder(param1));
         this.title.x = this.image.width / 2;
      }
      
      private function setGold(param1:int) : void {
         this.goldDisplay.setGold(param1);
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         this.closeButton.disabled = true;
         this.closeButton.removeEventListener("mouseUp",this.onMouseUp);
         this.close.dispatch();
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         this.removeListeners();
         this.populateDialog(new PackageBackground());
         this.ready.dispatch();
      }
      
      private function onComplete(param1:Event) : void {
         this.removeListeners();
         this.populateDialog(this.loader);
         this.ready.dispatch();
      }
      
      private function onBuyNow(param1:Event) : void {
         this.buyNow.removeEventListener("mouseUp",this.onBuyNow);
         this.buy.dispatch();
      }
   }
}
