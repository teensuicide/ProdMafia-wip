package com.company.assembleegameclient.ui.menu {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.GraphicsUtil;
   import com.company.util.RectangleUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.ui.view.UnFocusAble;
   
   public class Menu extends Sprite implements UnFocusAble {
       
      
      protected var yOffset:int;
      
      private var backgroundFill_:GraphicsSolidFill;
      
      private var outlineFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      private var background_:uint;
      
      private var outline_:uint;
      
      public function Menu(param1:uint, param2:uint) {
         backgroundFill_ = new GraphicsSolidFill(0,1);
         outlineFill_ = new GraphicsSolidFill(0,1);
         lineStyle_ = new GraphicsStroke(1,false,"normal","none","round",3,outlineFill_);
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.background_ = param1;
         this.outline_ = param2;
         this.yOffset = 40;
         filters = [new DropShadowFilter(0,0,0,1,16,16)];
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      }
      
      public function scaleParent(param1:Boolean) : void {
         var _loc2_:* = null;
         if(this.parent is GameSprite) {
            _loc2_ = this;
         } else {
            _loc2_ = this.parent;
         }
         var _loc4_:Number = 800 / stage.stageWidth;
         var _loc3_:Number = 600 / stage.stageHeight;
         if(param1 == true) {
            _loc2_.scaleX = _loc4_ / _loc3_;
            _loc2_.scaleY = 1;
         } else {
            _loc2_.scaleX = _loc4_;
            _loc2_.scaleY = _loc3_;
         }
      }
      
      public function positionFixed() : void {
         var _loc4_:Boolean = Parameters.data.uiscale;
         var _loc1_:Number = (stage.stageWidth - 800) * 0.5 + stage.mouseX;
         var _loc3_:Number = (stage.stageHeight - 600) * 0.5 + stage.mouseY;
         var _loc2_:Number = 600 / stage.stageHeight;
         this.scaleParent(_loc4_);
         if(_loc4_) {
            _loc1_ = _loc1_ * _loc2_;
            _loc3_ = _loc3_ * _loc2_;
         }
         if(stage == null) {
            return;
         }
         if(stage.mouseX + 0.5 * stage.stageWidth - 400 < stage.stageWidth * 0.5) {
            x = _loc1_ + 12;
         } else {
            x = _loc1_ - width - 1;
         }
         if(x < 12) {
            x = 12;
         }
         if(stage.mouseY + 0.5 * stage.stageHeight - 300 < stage.stageHeight * 0.333333333333333) {
            y = _loc3_ + 12;
         } else {
            y = _loc3_ - height - 1;
         }
         if(y < 12) {
            y = 12;
         }
      }
      
      public function remove() : void {
         if(parent != null) {
            parent.removeChild(this);
         }
      }
      
      protected function addOption(param1:MenuOption) : void {
         param1.x = 8;
         param1.y = this.yOffset;
         addChild(param1);
         this.yOffset = this.yOffset + 28;
      }
      
      protected function draw() : void {
         this.backgroundFill_.color = this.background_;
         this.outlineFill_.color = this.outline_;
         graphics.clear();
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,Math.max(154,width + 12),height + 12,4,[1,1,1,1],this.path_);
         graphics.drawGraphicsData(this.graphicsData_);
      }
      
      private function position() : void {
         if(stage == null) {
            return;
         }
         this.positionFixed();
      }
      
      protected function onAddedToStage(param1:Event) : void {
         this.draw();
         this.position();
         addEventListener("enterFrame",this.onEnterFrame,false,0,true);
         addEventListener("rollOut",this.onRollOut,false,0,true);
      }
      
      protected function onRemovedFromStage(param1:Event) : void {
         this.parent.scaleX = 1;
         this.parent.scaleY = 1;
         removeEventListener("enterFrame",this.onEnterFrame);
         removeEventListener("rollOut",this.onRollOut);
      }
      
      protected function onEnterFrame(param1:Event) : void {
         if(stage == null) {
            return;
         }
         this.scaleParent(Parameters.data.uiscale);
         if(RectangleUtil.pointDistSquared(getRect(stage),stage.mouseX,stage.mouseY) > 1600) {
            this.remove();
         }
      }
      
      protected function onRollOut(param1:Event) : void {
         this.remove();
      }
   }
}
