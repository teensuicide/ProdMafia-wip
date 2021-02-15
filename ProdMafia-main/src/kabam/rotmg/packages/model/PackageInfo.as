package kabam.rotmg.packages.model {
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
   import org.osflash.signals.Signal;
   
   public class PackageInfo extends GenericBoxInfo {
      
      public static const PURCHASE_TYPE_MIXED:String = "PURCHASE_TYPE_MIXED";
      
      public static const PURCHASE_TYPE_SLOTS_ONLY:String = "PURCHASE_TYPE_SLOTS_ONLY";
      
      public static const PURCHASE_TYPE_CONTENTS_ONLY:String = "PURCHASE_TYPE_CONTENTS_ONLY";
       
      
      public var imageLoadedSignal:Signal;
      
      public var popupImageLoadedSignal:Signal;
      
      protected var _image:String;
      
      protected var _popupImage:String = "";
      
      private var _showOnLogin:Boolean;
      
      private var _charSlot:int;
      
      private var _vaultSlot:int;
      
      private var _gold:int;
      
      private var _loader:Loader;
      
      private var _popupLoader:Loader;
      
      public function PackageInfo() {
         imageLoadedSignal = new Signal();
         popupImageLoadedSignal = new Signal();
         super();
      }
      
      public function get image() : String {
         return this._image;
      }
      
      public function set image(param1:String) : void {
         this._image = param1;
         this._loader = new Loader();
         this.loadImage(this._image,this._loader,this.onComplete);
      }
      
      public function get popupImage() : String {
         return this._popupImage;
      }
      
      public function set popupImage(param1:String) : void {
         this._popupImage = param1;
         this._popupLoader = new Loader();
         this.loadImage(this._popupImage,this._popupLoader,this.onCompletePopup);
      }
      
      public function get showOnLogin() : Boolean {
         return this._showOnLogin;
      }
      
      public function set showOnLogin(param1:Boolean) : void {
         this._showOnLogin = param1;
      }
      
      public function get charSlot() : int {
         return this._charSlot;
      }
      
      public function set charSlot(param1:int) : void {
         this._charSlot = param1;
      }
      
      public function get vaultSlot() : int {
         return this._vaultSlot;
      }
      
      public function set vaultSlot(param1:int) : void {
         this._vaultSlot = param1;
      }
      
      public function get gold() : int {
         return this._gold;
      }
      
      public function set gold(param1:int) : void {
         this._gold = param1;
      }
      
      public function get loader() : Loader {
         return this._loader;
      }
      
      public function get popupLoader() : Loader {
         return this._popupLoader;
      }
      
      public function get purchaseType() : String {
         if(contents != "") {
            if(this._charSlot > 0 || this._vaultSlot > 0) {
               return "PURCHASE_TYPE_MIXED";
            }
            return "PURCHASE_TYPE_CONTENTS_ONLY";
         }
         return "PURCHASE_TYPE_SLOTS_ONLY";
      }
      
      public function dispose() : void {
      }
      
      private function loadImage(param1:String, param2:Loader, param3:Function) : void {
         param2.contentLoaderInfo.addEventListener("complete",param3);
         param2.contentLoaderInfo.addEventListener("ioError",this.onIOError);
         param2.contentLoaderInfo.addEventListener("securityError",this.onSecurityEventError);
         try {
            param2.load(new URLRequest(param1));
            return;
         }
         catch(error:SecurityError) {
            return;
         }
      }
      
      private function unbindLoaderEvents(param1:Loader, param2:Function) : void {
         if(param1 && param1.contentLoaderInfo) {
            param1.contentLoaderInfo.removeEventListener("complete",param2);
            param1.contentLoaderInfo.removeEventListener("ioError",this.onIOError);
            param1.contentLoaderInfo.removeEventListener("securityError",this.onSecurityEventError);
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
      }
      
      private function onSecurityEventError(param1:SecurityErrorEvent) : void {
      }
      
      private function onComplete(param1:Event) : void {
         this.imageLoadedSignal.dispatch();
         this.unbindLoaderEvents(this._loader,this.onComplete);
      }
      
      private function onCompletePopup(param1:Event) : void {
         this.popupImageLoadedSignal.dispatch();
         this.unbindLoaderEvents(this._popupLoader,this.onCompletePopup);
      }
   }
}
