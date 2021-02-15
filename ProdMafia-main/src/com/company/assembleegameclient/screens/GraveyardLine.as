package com.company.assembleegameclient.screens {
   import com.company.ui.BaseSimpleText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import org.osflash.signals.Signal;
   
   public class GraveyardLine extends Sprite {
      
      public static const WIDTH:int = 415;
      
      public static const HEIGHT:int = 52;
      
      public static const COLOR:uint = 11776947;
      
      public static const OVER_COLOR:uint = 16762880;
       
      
      public var viewCharacterFame:Signal;
      
      public var icon_:Bitmap;
      
      public var titleText_:BaseSimpleText;
      
      public var taglineText_:BaseSimpleText;
      
      public var dtText_:BaseSimpleText;
      
      public var link:String;
      
      public var accountId:String;
      
      public function GraveyardLine(param1:BitmapData, param2:String, param3:String, param4:String, param5:int, param6:String) {
         viewCharacterFame = new Signal(int);
         super();
         this.link = param4;
         this.accountId = param6;
         buttonMode = true;
         useHandCursor = true;
         tabEnabled = false;
         this.icon_ = new Bitmap();
         this.icon_.bitmapData = param1;
         this.icon_.x = 12;
         this.icon_.y = 26 - param1.height / 2 - 3;
         addChild(this.icon_);
         this.titleText_ = new BaseSimpleText(18,11776947,false,0,0);
         param2 = param2.replace("????","Samurai");
         this.titleText_.text = param2;
         this.titleText_.updateMetrics();
         this.titleText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.titleText_.x = 73;
         addChild(this.titleText_);
         this.taglineText_ = new BaseSimpleText(14,11776947,false,0,0);
         this.taglineText_.text = param3;
         this.taglineText_.updateMetrics();
         this.taglineText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.taglineText_.x = 73;
         this.taglineText_.y = 24;
         addChild(this.taglineText_);
         this.dtText_ = new BaseSimpleText(16,11776947,false,0,0);
         this.dtText_.text = this.getTimeDiff(param5);
         this.dtText_.updateMetrics();
         this.dtText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.dtText_.x = 415 - this.dtText_.width;
         addChild(this.dtText_);
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
         addEventListener("mouseDown",this.onMouseDown);
      }
      
      private function getTimeDiff(param1:int) : String {
         var _loc2_:Number = new Date().getTime() / 1000;
         var _loc3_:int = _loc2_ - param1;
         if(_loc3_ <= 0) {
            return "now";
         }
         if(_loc3_ < 60) {
            return _loc3_ + " secs";
         }
         if(_loc3_ < 3600) {
            return int(_loc3_ / 60) + " mins";
         }
         if(_loc3_ < 86400) {
            return int(_loc3_ / 3600) + " hours";
         }
         return int(_loc3_ / 86400) + " days";
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         this.titleText_.setColor(16762880);
         this.taglineText_.setColor(16762880);
         this.dtText_.setColor(16762880);
      }
      
      protected function onRollOut(param1:MouseEvent) : void {
         this.titleText_.setColor(11776947);
         this.taglineText_.setColor(11776947);
         this.dtText_.setColor(11776947);
      }
      
      protected function onMouseDown(param1:MouseEvent) : void {
         var _loc2_:Array = this.link.split(":",2);
         var _loc3_:* = _loc2_[0];
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case "fame":
               this.viewCharacterFame.dispatch(int(_loc2_[1]));
               return;
            case "http":
            case "https":
            default:
               return;
         }
      }
   }
}
