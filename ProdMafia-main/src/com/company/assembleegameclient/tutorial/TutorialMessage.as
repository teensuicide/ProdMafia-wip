package com.company.assembleegameclient.tutorial {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class TutorialMessage extends Sprite {
      
      public static const BORDER:int = 8;
       
      
      private var tutorial_:Tutorial;
      
      private var rect_:Rectangle;
      
      private var messageText_:TextFieldDisplayConcrete;
      
      private var nextButton_:DeprecatedTextButton = null;
      
      private var startTime_:int;
      
      private var fill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      public function TutorialMessage(param1:Tutorial, param2:String, param3:Boolean, param4:Rectangle) {
         fill_ = new GraphicsSolidFill(3552822,1);
         lineStyle_ = new GraphicsStroke(1,false,"normal","none","round",3,new GraphicsSolidFill(16777215));
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[lineStyle_,fill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.tutorial_ = param1;
         this.rect_ = param4.clone();
         x = this.rect_.x;
         y = this.rect_.y;
         this.rect_.x = 0;
         this.rect_.y = 0;
         this.messageText_ = new TextFieldDisplayConcrete().setSize(15).setColor(16777215).setTextWidth(this.rect_.width - 32);
         this.messageText_.setStringBuilder(new LineBuilder().setParams(param2));
         this.messageText_.x = 16;
         this.messageText_.y = 16;
         if(param3) {
            this.nextButton_ = new DeprecatedTextButton(18,"Next");
            this.nextButton_.addEventListener("click",this.onNextButton);
            this.nextButton_.x = this.rect_.width - this.nextButton_.width - 20;
            this.nextButton_.y = this.rect_.height - this.nextButton_.height - 10;
         }
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function drawRect() : void {
         var _loc2_:Number = Math.min(1,0.1 + 0.9 * (TimeUtil.getTrueTime() - this.startTime_) / 200);
         if(_loc2_ == 1) {
            addChild(this.messageText_);
            if(this.nextButton_ != null) {
               addChild(this.nextButton_);
            }
            removeEventListener("enterFrame",this.onEnterFrame);
         }
         var _loc1_:Rectangle = this.rect_.clone();
         _loc1_.inflate(-(1 - _loc2_) * this.rect_.width / 2,-(1 - _loc2_) * this.rect_.height / 2);
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height,4,[1,1,1,1],this.path_);
         graphics.clear();
         graphics.drawGraphicsData(this.graphicsData_);
      }
      
      private function onAddedToStage(param1:Event) : void {
         this.startTime_ = TimeUtil.getTrueTime();
         addEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void {
         this.drawRect();
      }
      
      private function onNextButton(param1:MouseEvent) : void {
         this.tutorial_.doneAction("Next");
      }
   }
}
