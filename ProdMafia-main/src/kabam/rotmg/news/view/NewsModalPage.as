package kabam.rotmg.news.view {
   import com.company.assembleegameclient.ui.Scrollbar;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.model.FontModel;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   
   public class NewsModalPage extends Sprite {
      
      public static const TEXT_MARGIN:int = 22;
      
      public static const TEXT_MARGIN_HTML:int = 26;
      
      public static const TEXT_TOP_MARGIN_HTML:int = 40;
      
      private static const SCROLLBAR_WIDTH:int = 10;
      
      public static const WIDTH:int = 136;
      
      public static const HEIGHT:int = 310;
       
      
      protected var scrollBar_:Scrollbar;
      
      private var innerModalWidth:int;
      
      private var htmlText:TextField;
      
      public function NewsModalPage(param1:String, param2:String) {
         var _loc5_:* = null;
         var _loc3_:* = null;
         super();
         this.doubleClickEnabled = false;
         this.mouseEnabled = false;
         this.innerModalWidth = 386;
         this.htmlText = new TextField();
         var _loc4_:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
         _loc4_.apply(this.htmlText,16,15792127,false,false);
         this.htmlText.width = this.innerModalWidth;
         this.htmlText.multiline = true;
         this.htmlText.wordWrap = true;
         this.htmlText.htmlText = param2;
         this.htmlText.filters = [new DropShadowFilter(0,0,0)];
         this.htmlText.height = this.htmlText.textHeight + 8;
         _loc5_ = new Sprite();
         _loc5_.addChild(this.htmlText);
         _loc5_.y = 40;
         _loc5_.x = 26;
         _loc3_ = new Sprite();
         _loc3_.graphics.beginFill(16711680);
         _loc3_.graphics.drawRect(0,0,this.innerModalWidth,310);
         _loc3_.x = 26;
         _loc3_.y = 40;
         addChild(_loc3_);
         _loc5_.mask = _loc3_;
         disableMouseOnText(this.htmlText);
         addChild(_loc5_);
         var _loc6_:TextFieldDisplayConcrete = NewsModal.getText(param1,22,6,true);
         addChild(_loc6_);
         if(this.htmlText.height >= 310) {
            this.scrollBar_ = new Scrollbar(10,310,0.1,_loc5_);
            this.scrollBar_.x = 420;
            this.scrollBar_.y = 40;
            this.scrollBar_.setIndicatorSize(310,_loc5_.height);
            addChild(this.scrollBar_);
         }
         this.addEventListener("addedToStage",this.onAddedHandler);
      }
      
      private static function disableMouseOnText(param1:TextField) : void {
         param1.mouseWheelEnabled = false;
      }
      
      protected function onScrollBarChange(param1:Event) : void {
         this.htmlText.y = -this.scrollBar_.pos() * (this.htmlText.height - 310);
      }
      
      private function onAddedHandler(param1:Event) : void {
         this.addEventListener("removedFromStage",this.onRemovedFromStage);
         if(this.scrollBar_) {
            this.scrollBar_.addEventListener("change",this.onScrollBarChange);
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         this.removeEventListener("removedFromStage",this.onRemovedFromStage);
         this.removeEventListener("addedToStage",this.onAddedHandler);
         if(this.scrollBar_) {
            this.scrollBar_.removeEventListener("change",this.onScrollBarChange);
         }
      }
   }
}
