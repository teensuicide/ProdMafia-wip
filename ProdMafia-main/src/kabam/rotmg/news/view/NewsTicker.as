package kabam.rotmg.news.view {
   import com.company.assembleegameclient.game.events.DisplayAreaChangedSignal;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.model.FontModel;
   
   public class NewsTicker extends Sprite {
      
      private static var pendingScrollText:String = "";
       
      
      private const WIDTH:int = 280;
      
      private const HEIGHT:int = 25;
      
      private const MAX_REPEATS:int = 2;
      
      private const SCROLL_PREPEND:String = "                                                                               ";
      
      private const SCROLL_APPEND:String = "                                                                                ";
      
      public var scrollText:TextField;
      
      private var timer:Timer;
      
      private var currentRepeat:uint = 0;
      
      private var scrollOffset:int = 0;
      
      public function NewsTicker() {
         super();
         this.scrollText = this.createScrollText();
         this.timer = new Timer(0.17,0);
         this.drawBackground();
         this.align();
         this.visible = false;
         if(NewsTicker.pendingScrollText != "") {
            this.activateNewScrollText(NewsTicker.pendingScrollText);
            NewsTicker.pendingScrollText = "";
         }
      }
      
      public static function setPendingScrollText(param1:String) : void {
         NewsTicker.pendingScrollText = param1;
      }
      
      public function activateNewScrollText(param1:String) : void {
         if(this.visible == false) {
            this.visible = true;
            StaticInjectorContext.getInjector().getInstance(DisplayAreaChangedSignal).dispatch();
            this.scrollText.text = "                                                                               " + param1 + "                                                                                ";
            this.timer.addEventListener("timer",this.scrollAnimation);
            this.currentRepeat = 1;
            this.timer.start();
         }
      }
      
      private function align() : void {
         this.scrollText.x = 5;
         this.scrollText.y = 2;
      }
      
      private function drawBackground() : void {
         graphics.beginFill(0,0.4);
         graphics.drawRoundRect(0,0,280,25,12,12);
         graphics.endFill();
      }
      
      private function createScrollText() : TextField {
         var _loc2_:* = null;
         _loc2_ = new TextField();
         var _loc1_:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
         _loc1_.apply(_loc2_,16,16777215,false);
         _loc2_.selectable = false;
         _loc2_.doubleClickEnabled = false;
         _loc2_.mouseEnabled = false;
         _loc2_.mouseWheelEnabled = false;
         _loc2_.text = "";
         _loc2_.wordWrap = false;
         _loc2_.multiline = false;
         _loc2_.selectable = false;
         _loc2_.width = 270;
         _loc2_.height = 25;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function scrollAnimation(param1:TimerEvent) : void {
         this.timer.stop();
         if(this.scrollText.scrollH < this.scrollText.maxScrollH) {
            this.scrollOffset++;
            this.scrollText.scrollH = this.scrollOffset;
            this.timer.start();
         } else if(this.currentRepeat >= 1 && this.currentRepeat < 2) {
            this.currentRepeat++;
            this.scrollOffset = 0;
            this.scrollText.scrollH = 0;
            this.timer.start();
         } else {
            this.currentRepeat = 0;
            this.scrollOffset = 0;
            this.scrollText.scrollH = 0;
            this.timer.removeEventListener("timer",this.scrollAnimation);
            this.visible = false;
            StaticInjectorContext.getInjector().getInstance(DisplayAreaChangedSignal).dispatch();
         }
      }
   }
}
