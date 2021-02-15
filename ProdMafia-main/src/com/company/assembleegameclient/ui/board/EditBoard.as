package com.company.assembleegameclient.ui.board {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.Scrollbar;
   import com.company.ui.BaseSimpleText;
   import com.company.util.GraphicsUtil;
   import flash.display.Graphics;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   class EditBoard extends Sprite {
      
      public static const TEXT_WIDTH:int = 400;
      
      public static const TEXT_HEIGHT:int = 400;
       
      
      public var w_:int;
      
      public var h_:int;
      
      private var text_:String;
      
      private var boardText_:BaseSimpleText;
      
      private var mainSprite_:Sprite;
      
      private var scrollBar_:Scrollbar;
      
      private var cancelButton_:DeprecatedTextButton;
      
      private var saveButton_:DeprecatedTextButton;
      
      private var backgroundFill_:GraphicsSolidFill;
      
      private var outlineFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      function EditBoard(param1:String) {
         backgroundFill_ = new GraphicsSolidFill(3355443,1);
         outlineFill_ = new GraphicsSolidFill(16777215,1);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,outlineFill_);
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.text_ = param1;
         this.mainSprite_ = new Sprite();
         var _loc2_:Shape = new Shape();
         var _loc3_:Graphics = _loc2_.graphics;
         _loc3_.beginFill(0);
         _loc3_.drawRect(0,0,400,400);
         _loc3_.endFill();
         this.mainSprite_.addChild(_loc2_);
         this.mainSprite_.mask = _loc2_;
         addChild(this.mainSprite_);
         this.boardText_ = new BaseSimpleText(16,11776947,true,400,400);
         this.boardText_.border = false;
         this.boardText_.mouseEnabled = true;
         this.boardText_.multiline = true;
         this.boardText_.wordWrap = true;
         this.boardText_.embedFonts = true;
         this.boardText_.text = param1;
         this.boardText_.useTextDimensions();
         this.boardText_.addEventListener("change",this.onTextChange,false,0,true);
         this.boardText_.addEventListener("scroll",this.onTextChange,false,0,true);
         this.mainSprite_.addChild(this.boardText_);
         this.scrollBar_ = new Scrollbar(16,396);
         this.scrollBar_.x = 406;
         this.scrollBar_.y = 0;
         this.scrollBar_.setIndicatorSize(400,this.boardText_.height);
         this.scrollBar_.addEventListener("change",this.onScrollBarChange,false,0,true);
         addChild(this.scrollBar_);
         this.w_ = 426;
         this.cancelButton_ = new DeprecatedTextButton(14,"Frame.cancel",120);
         this.cancelButton_.x = 4;
         this.cancelButton_.y = 404;
         this.cancelButton_.addEventListener("click",this.onCancel,false,0,true);
         addChild(this.cancelButton_);
         this.saveButton_ = new DeprecatedTextButton(14,"EditGuildBoard.save",120);
         this.saveButton_.x = this.w_ - 124;
         this.saveButton_.y = 404;
         this.saveButton_.addEventListener("click",this.onSave,false,0,true);
         this.saveButton_.textChanged.add(this.layoutBackground);
         addChild(this.saveButton_);
      }
      
      public function getText() : String {
         return this.boardText_.text;
      }
      
      private function layoutBackground() : void {
         this.h_ = 400 + this.saveButton_.height + 8;
         x = 400 - this.w_ / 2;
         y = 300 - this.h_ / 2;
         graphics.clear();
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,this.w_ + 12,this.h_ + 12,4,[1,1,1,1],this.path_);
         graphics.drawGraphicsData(this.graphicsData_);
         this.scrollBar_.setIndicatorSize(400,this.boardText_.textHeight,false);
      }
      
      private function onScrollBarChange(param1:Event) : void {
         this.boardText_.scrollV = 1 + this.scrollBar_.pos() * this.boardText_.maxScrollV;
      }
      
      private function onCancel(param1:Event) : void {
         dispatchEvent(new Event("cancel"));
      }
      
      private function onSave(param1:Event) : void {
         dispatchEvent(new Event("complete"));
      }
      
      private function onTextChange(param1:Event) : void {
         if(this.scrollBar_ == null) {
            return;
         }
         this.scrollBar_.setIndicatorSize(400,this.boardText_.textHeight,false);
         if(this.boardText_.maxScrollV == 1) {
            this.scrollBar_.setPos(0);
         } else {
            this.scrollBar_.setPos((this.boardText_.scrollV - 1) / (this.boardText_.maxScrollV - 1));
         }
      }
   }
}
