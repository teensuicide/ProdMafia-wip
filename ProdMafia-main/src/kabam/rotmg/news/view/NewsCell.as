package kabam.rotmg.news.view {
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.net.URLRequest;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.news.model.NewsCellVO;
   import kabam.rotmg.text.view.TextDisplay;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   import org.swiftsuspenders.Injector;
   
   public class NewsCell extends Sprite {
      
      private static const BOX_HEIGHT:uint = 30;
      
      private static const LARGE:String = "LARGE";
      
      private static const SMALL:String = "SMALL";
      
      static var DefaultGraphicLarge:Class = NewsCell_DefaultGraphicLarge;
      
      static var DefaultGraphicSmall:Class = NewsCell_DefaultGraphicSmall;
       
      
      public var clickSignal:Signal;
      
      private var imageContainer:Sprite;
      
      private var maskShape:Shape;
      
      private var boxShape:Shape;
      
      private var textField:TextFieldDisplayConcrete;
      
      private var size:String;
      
      private var w:Number;
      
      private var h:Number;
      
      private var _vo:NewsCellVO;
      
      private var _loader:Loader;
      
      private var textSize:uint = 18;
      
      private var injector:Injector;
      
      public function NewsCell(param1:Number, param2:Number) {
         clickSignal = new Signal(NewsCellVO);
         super();
         this.injector = StaticInjectorContext.getInjector();
         this.setSize(param1,param2);
         this.initImageContainer();
         this.initMask();
         this.initBox();
      }
      
      public function init(param1:NewsCellVO) : void {
         this._vo = param1;
         this.updateTextField();
         addEventListener("mouseDown",this.onMouseDown);
         buttonMode = true;
      }
      
      public function load() : void {
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener("complete",this.onComplete);
         this._loader.contentLoaderInfo.addEventListener("ioError",this.onIOError);
         this._loader.load(new URLRequest(this._vo.imageURL));
      }
      
      private function setSize(param1:Number, param2:Number) : void {
         this.w = param1;
         this.h = param2;
         if(param1 == 306 && param2 == 194) {
            this.size = "LARGE";
         } else if(param1 == 151 && param2 == 189) {
            this.size = "SMALL";
         }
      }
      
      private function addDisplayAssets() : void {
         var _loc1_:* = new Shape();
         this.maskShape = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Shape();
         this.boxShape = _loc1_;
         addChild(_loc1_);
      }
      
      private function initImageContainer() : void {
         this.imageContainer = new Sprite();
         addChild(this.imageContainer);
      }
      
      private function initMask() : void {
         this.maskShape = new Shape();
         this.maskShape.graphics.beginFill(16711935);
         this.maskShape.graphics.drawRect(0,0,this.w,this.h);
         this.imageContainer.mask = this.maskShape;
         addChild(this.maskShape);
      }
      
      private function initBox() : void {
         this.boxShape = new Shape();
         this.boxShape.graphics.beginFill(0,0.8);
         this.boxShape.graphics.drawRect(0,this.h - 30,this.w,30);
         addChild(this.boxShape);
      }
      
      private function updateTextField() : void {
         this.textField = this.injector.getInstance(TextDisplay).setSize(this.textSize).setColor(16777215);
         addChild(this.textField);
         this.textField.setBold(true).setAutoSize("center").setVerticalAlign("middle");
         this.textField.setStringBuilder(new StaticStringBuilder(this._vo.headline));
         this.resizeTextField();
         this.textField.x = this.w / 2;
         this.textField.y = this.h - 12.5;
         this.textField.filters = [new DropShadowFilter(0,0,0)];
      }
      
      private function resizeTextField() : void {
         if(this.textField.width > this.w - 10) {
            this.textSize = this.textSize - 2;
            this.textField.setSize(this.textSize).setColor(16777215);
            this.resizeTextField();
         }
      }
      
      private function onComplete(param1:Event) : void {
         this.imageContainer.addChild(this._loader);
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         var _loc2_:* = this.size;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "LARGE":
               this.imageContainer.addChild(new DefaultGraphicLarge());
               return;
            case "SMALL":
               this.imageContainer.addChild(new DefaultGraphicSmall());
               return;
            default:
               return;
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         this.clickSignal.dispatch(this._vo);
      }
   }
}
