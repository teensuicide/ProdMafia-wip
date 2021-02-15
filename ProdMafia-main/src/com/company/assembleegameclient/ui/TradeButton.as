package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class TradeButton extends BackgroundFilledText {
      
      private static const WAIT_TIME:int = 2999;
      
      private static const COUNTDOWN_STATE:int = 0;
      
      private static const NORMAL_STATE:int = 1;
      
      private static const WAITING_STATE:int = 2;
      
      private static const DISABLED_STATE:int = 3;
       
      
      public var statusBar_:Sprite;
      
      public var barMask_:Shape;
      
      public var myText:StaticTextDisplay;
      
      public var h_:int;
      
      private var state_:int;
      
      private var lastResetTime_:int;
      
      private var barGraphicsData_:Vector.<IGraphicsData>;
      
      private var outlineGraphicsData_:Vector.<IGraphicsData>;
      
      public function TradeButton(param1:int, param2:int = 0) {
         super(param2);
         this.makeGraphics();
         this.lastResetTime_ = TimeUtil.getTrueTime();
         this.myText = new StaticTextDisplay();
         this.myText.setAutoSize("center").setVerticalAlign("middle");
         this.myText.setSize(param1).setColor(3552822).setBold(true);
         this.myText.setStringBuilder(new LineBuilder().setParams("PlayerMenu.Trade"));
         w_ = param2 != 0?param2:this.myText.width + 12;
         this.h_ = this.myText.height + 8;
         this.myText.x = w_ * 0.5;
         this.myText.y = this.h_ * 0.5;
         GraphicsUtil.clearPath(path_);
         GraphicsUtil.drawCutEdgeRect(0,0,w_,this.myText.height + 8,4,[1,1,1,1],path_);
         this.statusBar_ = this.newStatusBar();
         addChild(this.statusBar_);
         addChild(this.myText);
         this.draw();
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
         addEventListener("mouseOver",this.onMouseOver,false,0,true);
         addEventListener("rollOut",this.onRollOut,false,0,true);
         addEventListener("click",this.onClick,false,0,true);
      }
      
      public function reset() : void {
         this.lastResetTime_ = TimeUtil.getTrueTime();
         this.state_ = 0;
         this.setEnabled(false);
         this.setText("PlayerMenu.Trade");
      }
      
      public function disable() : void {
         this.state_ = 3;
         this.setEnabled(false);
         this.setText("PlayerMenu.Trade");
      }
      
      private function makeGraphics() : void {
         var _loc2_:GraphicsSolidFill = new GraphicsSolidFill(12566463,1);
         this.barGraphicsData_ = new <IGraphicsData>[_loc2_,path_,GraphicsUtil.END_FILL];
         var _loc1_:GraphicsSolidFill = new GraphicsSolidFill(16777215,1);
         var _loc3_:GraphicsStroke = new GraphicsStroke(2,false,"normal","none","round",3,_loc1_);
         this.outlineGraphicsData_ = new <IGraphicsData>[_loc3_,path_,GraphicsUtil.END_STROKE];
      }
      
      private function setText(param1:String) : void {
         this.myText.setStringBuilder(new LineBuilder().setParams(param1));
      }
      
      private function setEnabled(param1:Boolean) : void {
         if(Parameters.data.TradeDelay) {
            param1 = true;
         }
         if(param1 == mouseEnabled) {
            return;
         }
         mouseEnabled = param1;
         mouseChildren = param1;
         graphicsData_[0] = !!param1?enabledFill_:disabledFill_;
         this.draw();
      }
      
      private function newStatusBar() : Sprite {
         var _loc4_:Sprite = new Sprite();
         var _loc1_:Sprite = new Sprite();
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.clear();
         _loc3_.graphics.drawGraphicsData(this.barGraphicsData_);
         _loc1_.addChild(_loc3_);
         this.barMask_ = new Shape();
         _loc1_.addChild(this.barMask_);
         _loc1_.mask = this.barMask_;
         _loc4_.addChild(_loc1_);
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.clear();
         _loc2_.graphics.drawGraphicsData(this.outlineGraphicsData_);
         _loc4_.addChild(_loc2_);
         return _loc4_;
      }
      
      private function drawCountDown(param1:Number) : void {
         this.barMask_.graphics.clear();
         this.barMask_.graphics.beginFill(12566463);
         this.barMask_.graphics.drawRect(0,0,w_ * param1,this.h_);
         this.barMask_.graphics.endFill();
      }
      
      private function draw() : void {
         var _loc2_:int = 0;
         var _loc1_:Number = NaN;
         _loc2_ = TimeUtil.getTrueTime();
         if(this.state_ == 0) {
            if(_loc2_ - this.lastResetTime_ >= 2999) {
               this.state_ = 1;
               this.setEnabled(true);
            }
         }
         switch(int(this.state_)) {
            case 0:
               this.statusBar_.visible = true;
               _loc1_ = (_loc2_ - this.lastResetTime_) / 2999;
               this.drawCountDown(_loc1_);
               break;
            case 1:
            case 2:
            case 3:
               this.statusBar_.visible = false;
         }
         graphics.clear();
         graphics.drawGraphicsData(graphicsData_);
      }
      
      private function onAddedToStage(param1:Event) : void {
         addEventListener("enterFrame",this.onEnterFrame,false,0,true);
         this.reset();
         this.draw();
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("enterFrame",this.onEnterFrame);
         removeEventListener("addedToStage",this.onAddedToStage);
         removeEventListener("removedFromStage",this.onRemovedFromStage);
         removeEventListener("mouseOver",this.onMouseOver);
         removeEventListener("rollOut",this.onRollOut);
         removeEventListener("click",this.onClick);
      }
      
      private function onEnterFrame(param1:Event) : void {
         this.draw();
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         enabledFill_.color = 16768133;
         this.draw();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         enabledFill_.color = 16777215;
         this.draw();
      }
      
      private function onClick(param1:MouseEvent) : void {
         this.state_ = 2;
         this.setEnabled(false);
         this.setText("PlayerMenu.Waiting");
      }
   }
}
