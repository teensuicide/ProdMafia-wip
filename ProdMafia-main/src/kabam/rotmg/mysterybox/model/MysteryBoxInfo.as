package kabam.rotmg.mysterybox.model {
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
   import kabam.display.Loader.LoaderProxy;
   import kabam.display.Loader.LoaderProxyConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class MysteryBoxInfo extends GenericBoxInfo {
       
      
      public var _rollsWithContents:Vector.<Vector.<int>>;
      
      public var _rollsWithContentsUnique:Vector.<int>;
      
      public var _iconImageUrl:String;
      
      private var _iconImage:DisplayObject;
      
      public var _infoImageUrl:String;
      
      private var _infoImage:DisplayObject;
      
      private var _loader:LoaderProxy;
      
      private var _infoImageLoader:LoaderProxy;
      
      private var _rollsContents:Vector.<Vector.<int>>;
      
      private var _rolls:int;
      
      private var _jackpots:String = "";
      
      private var _displayedItems:String = "";
      
      public function MysteryBoxInfo() {
         _rollsWithContents = new Vector.<Vector.<int>>();
         _rollsWithContentsUnique = new Vector.<int>();
         _loader = new LoaderProxyConcrete();
         _infoImageLoader = new LoaderProxyConcrete();
         _rollsContents = new Vector.<Vector.<int>>();
         super();
      }
      
      public function get iconImageUrl() : * {
         return this._iconImageUrl;
      }
      
      public function set iconImageUrl(param1:String) : void {
         this._iconImageUrl = param1;
         this.loadIconImageFromUrl(this._iconImageUrl);
      }
      
      public function get iconImage() : DisplayObject {
         return this._iconImage;
      }
      
      public function get infoImageUrl() : * {
         return this._infoImageUrl;
      }
      
      public function set infoImageUrl(param1:String) : void {
         this._infoImageUrl = param1;
         this.loadInfomageFromUrl(this._infoImageUrl);
      }
      
      public function get infoImage() : DisplayObject {
         return this._infoImage;
      }
      
      public function set infoImage(param1:DisplayObject) : void {
         this._infoImage = param1;
      }
      
      public function get loader() : LoaderProxy {
         return this._loader;
      }
      
      public function set loader(param1:LoaderProxy) : void {
         this._loader = param1;
      }
      
      public function get infoImageLoader() : LoaderProxy {
         return this._infoImageLoader;
      }
      
      public function set infoImageLoader(param1:LoaderProxy) : void {
         this._infoImageLoader = param1;
      }
      
      public function get rollsContents() : Vector.<Vector.<int>> {
         return this._rollsContents;
      }
      
      public function get rolls() : int {
         return this._rolls;
      }
      
      public function set rolls(param1:int) : void {
         this._rolls = param1;
      }
      
      public function get jackpots() : String {
         return this._jackpots;
      }
      
      public function set jackpots(param1:String) : void {
         this._jackpots = param1;
      }
      
      public function get displayedItems() : String {
         return this._displayedItems;
      }
      
      public function set displayedItems(param1:String) : void {
         this._displayedItems = param1;
      }
      
      public function get currencyName() : String {
         var _loc1_:* = _priceCurrency;
         var _loc2_:* = _loc1_;
         switch(_loc2_) {
            case "0":
               return LineBuilder.getLocalizedStringFromKey("Currency.gold").toLowerCase();
            case "1":
               return LineBuilder.getLocalizedStringFromKey("Currency.fame").toLowerCase();
            default:
               return "";
         }
      }
      
      public function parseContents() : void {
         var _loc7_:int = 0;
         var _loc6_:* = undefined;
         var _loc9_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc11_:* = null;
         var _loc10_:* = null;
         var _loc8_:Array = _contents.split(";");
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:* = _loc8_;
         var _loc15_:int = 0;
         var _loc14_:* = _loc8_;
         for each(_loc3_ in _loc8_) {
            _loc9_ = new Vector.<int>();
            _loc11_ = _loc3_.split(",");
            _loc7_ = 0;
            _loc6_ = _loc11_;
            var _loc13_:int = 0;
            var _loc12_:* = _loc11_;
            for each(_loc10_ in _loc11_) {
               if(_loc1_[int(_loc10_)] == null) {
                  _loc1_[_loc10_] = true;
                  this._rollsWithContentsUnique.push(_loc10_);
               }
               _loc9_.push(_loc10_);
            }
            this._rollsWithContents.push(_loc9_);
            this._rollsContents[_loc4_] = _loc9_;
            _loc4_++;
         }
      }
      
      private function loadIconImageFromUrl(param1:String) : void {
         this._loader && this._loader.unload();
         this._loader.contentLoaderInfo.addEventListener("complete",this.onComplete);
         this._loader.contentLoaderInfo.addEventListener("ioError",this.onError);
         this._loader.contentLoaderInfo.addEventListener("diskError",this.onError);
         this._loader.contentLoaderInfo.addEventListener("networkError",this.onError);
         this._loader.load(new URLRequest(param1));
      }
      
      private function loadInfomageFromUrl(param1:String) : void {
         this.loadImageFromUrl(param1,this._infoImageLoader);
      }
      
      private function loadImageFromUrl(param1:String, param2:LoaderProxy) : void {
         param2 && param2.unload();
         param2.contentLoaderInfo.addEventListener("complete",this.onInfoComplete);
         param2.contentLoaderInfo.addEventListener("ioError",this.onInfoError);
         param2.contentLoaderInfo.addEventListener("diskError",this.onInfoError);
         param2.contentLoaderInfo.addEventListener("networkError",this.onInfoError);
         param2.load(new URLRequest(param1));
      }
      
      private function onError(param1:IOErrorEvent) : void {
      }
      
      private function onComplete(param1:Event) : void {
         this._loader.contentLoaderInfo.removeEventListener("complete",this.onComplete);
         this._loader.contentLoaderInfo.removeEventListener("ioError",this.onError);
         this._loader.contentLoaderInfo.removeEventListener("diskError",this.onError);
         this._loader.contentLoaderInfo.removeEventListener("networkError",this.onError);
         this._iconImage = DisplayObject(this._loader);
      }
      
      private function onInfoError(param1:IOErrorEvent) : void {
      }
      
      private function onInfoComplete(param1:Event) : void {
         this._infoImageLoader.contentLoaderInfo.removeEventListener("complete",this.onInfoComplete);
         this._infoImageLoader.contentLoaderInfo.removeEventListener("ioError",this.onInfoError);
         this._infoImageLoader.contentLoaderInfo.removeEventListener("diskError",this.onInfoError);
         this._infoImageLoader.contentLoaderInfo.removeEventListener("networkError",this.onInfoError);
         this._infoImage = DisplayObject(this._infoImageLoader);
      }
   }
}
