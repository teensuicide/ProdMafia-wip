package com.company.assembleegameclient.ui.board {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.Scrollbar;
   import com.company.ui.BaseSimpleText;
   import com.company.util.GraphicsUtil;
   import com.company.util.HTMLUtil;
   import flash.display.Graphics;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   class ViewBoard extends Sprite {
      
      public static const TEXT_WIDTH:int = 400;
      
      public static const TEXT_HEIGHT:int = 400;
      
      private static const URL_REGEX:RegExp = /((https?|ftp):((\/\/)|(\\\\))+[\w\d:#@%\/;$()~_?\+-=\\\.&]*)/g;
       
      
      public var w_:int;
      
      public var h_:int;
      
      private var text_:String;
      
      private var boardText_:BaseSimpleText;
      
      private var mainSprite_:Sprite;
      
      private var scrollBar_:Scrollbar;
      
      private var editButton_:DeprecatedTextButton;
      
      private var closeButton_:DeprecatedTextButton;
      
      private var backgroundFill_:GraphicsSolidFill;
      
      private var outlineFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      function ViewBoard(param1:String, param2:Boolean) {
         backgroundFill_ = new GraphicsSolidFill(3355443,1);
         outlineFill_ = new GraphicsSolidFill(16777215,1);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,outlineFill_);
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.text_ = param1;
         this.mainSprite_ = new Sprite();
         var _loc4_:Shape = new Shape();
         var _loc5_:Graphics = _loc4_.graphics;
         _loc5_.beginFill(0);
         _loc5_.drawRect(0,0,400,400);
         _loc5_.endFill();
         this.mainSprite_.addChild(_loc4_);
         this.mainSprite_.mask = _loc4_;
         addChild(this.mainSprite_);
         var _loc3_:String = HTMLUtil.escape(param1);
         _loc3_ = _loc3_.replace(URL_REGEX,"<font color=\"#7777EE\"><a href=\"$1\" target=\"_blank\">$1</a></font>");
         this.boardText_ = new BaseSimpleText(16,11776947,false,400,0);
         this.boardText_.border = false;
         this.boardText_.mouseEnabled = true;
         this.boardText_.multiline = true;
         this.boardText_.wordWrap = true;
         this.boardText_.embedFonts = true;
         this.boardText_.htmlText = _loc3_;
         this.boardText_.useTextDimensions();
         this.mainSprite_.addChild(this.boardText_);
         var _loc6_:* = this.boardText_.height > 400;
         if(_loc6_) {
            this.scrollBar_ = new Scrollbar(16,396);
            this.scrollBar_.x = 406;
            this.scrollBar_.y = 0;
            this.scrollBar_.setIndicatorSize(400,this.boardText_.height);
            this.scrollBar_.addEventListener("change",this.onScrollBarChange,false,0,true);
            addChild(this.scrollBar_);
         }
         this.w_ = 400 + (!!_loc6_?26:0);
         this.editButton_ = new DeprecatedTextButton(14,"ViewGuildBoard.edit",120);
         this.editButton_.x = 4;
         this.editButton_.y = 404;
         this.editButton_.addEventListener("click",this.onEdit,false,0,true);
         addChild(this.editButton_);
         this.editButton_.visible = param2;
         this.closeButton_ = new DeprecatedTextButton(14,"ViewGuildBoard.close",120);
         this.closeButton_.x = this.w_ - 124;
         this.closeButton_.y = 404;
         this.closeButton_.addEventListener("click",this.onClose,false,0,true);
         this.closeButton_.textChanged.addOnce(this.layoutBackground);
         addChild(this.closeButton_);
      }
      
      private function layoutBackground() : void {
         this.h_ = 400 + this.closeButton_.height + 8;
         x = 400 - this.w_ / 2;
         y = 300 - this.h_ / 2;
         graphics.clear();
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,this.w_ + 12,this.h_ + 12,4,[1,1,1,1],this.path_);
         graphics.drawGraphicsData(this.graphicsData_);
      }
      
      private function onScrollBarChange(param1:Event) : void {
         this.boardText_.y = -this.scrollBar_.pos() * (this.boardText_.height - 400);
      }
      
      private function onEdit(param1:Event) : void {
         dispatchEvent(new Event("change"));
      }
      
      private function onClose(param1:Event) : void {
         dispatchEvent(new Event("complete"));
      }
   }
}
