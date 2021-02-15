package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
   import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class InteractiveItemTile extends ItemTile {
      
      private static const DOUBLE_CLICK_PAUSE:uint = 250;
      
      private static const DRAG_DIST:int = 3;
       
      
      private var doubleClickTimer:Timer;
      
      private var dragStart:Point;
      
      private var pendingSecondClick:Boolean;
      
      private var isDragging:Boolean;
      
      public function InteractiveItemTile(param1:int, param2:ItemGrid, param3:Boolean, param4:Boolean = false) {
         super(param1,param2,param4);
         mouseChildren = false;
         this.doubleClickTimer = new Timer(250,1);
         this.doubleClickTimer.addEventListener("timerComplete",this.onDoubleClickTimerComplete);
         this.setInteractive(param3);
      }
      
      override public function setItem(param1:int) : Boolean {
         var _loc2_:Boolean = super.setItem(param1);
         if(_loc2_) {
            this.stopDragging();
         }
         return _loc2_;
      }
      
      public function setInteractive(param1:Boolean) : void {
         if(param1) {
            addEventListener("mouseDown",this.onMouseDown);
            addEventListener("mouseUp",this.onMouseUp);
            addEventListener("mouseOut",this.onMouseOut);
            addEventListener("removedFromStage",this.onRemovedFromStage);
         } else {
            removeEventListener("mouseDown",this.onMouseDown);
            removeEventListener("mouseUp",this.onMouseUp);
            removeEventListener("mouseOut",this.onMouseOut);
         }
      }
      
      public function getDropTarget() : DisplayObject {
         return itemSprite.dropTarget;
      }
      
      protected function beginDragCallback() : void {
      }
      
      protected function endDragCallback() : void {
      }
      
      private function setPendingDoubleClick(param1:Boolean) : void {
         this.pendingSecondClick = param1;
         if(this.pendingSecondClick) {
            this.doubleClickTimer.reset();
            this.doubleClickTimer.start();
         } else {
            this.doubleClickTimer.stop();
         }
      }
      
      private function stopDragging() : void {
         if(this.isDragging) {
            itemSprite.stopDrag();
            if(stage.contains(itemSprite)) {
               stage.removeChild(itemSprite);
            }
            this.isDragging = false;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.setPendingDoubleClick(false);
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         if(this.isDragging) {
            return;
         }
         if(param1.shiftKey) {
            this.setPendingDoubleClick(false);
            dispatchEvent(new ItemTileEvent("ITEM_SHIFT_CLICK",this));
         } else if(param1.ctrlKey) {
            this.setPendingDoubleClick(false);
            dispatchEvent(new ItemTileEvent("ITEM_CTRL_CLICK",this));
         } else if(!this.pendingSecondClick) {
            this.setPendingDoubleClick(true);
         } else {
            this.setPendingDoubleClick(false);
            dispatchEvent(new ItemTileEvent("ITEM_DOUBLE_CLICK",this));
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         if(getItemId() == -1) {
            return;
         }
         this.beginDragCheck(param1);
      }
      
      private function beginDragCheck(param1:MouseEvent) : void {
         this.dragStart = new Point(param1.stageX,param1.stageY);
         addEventListener("mouseMove",this.onMouseMoveCheckDrag);
         addEventListener("mouseOut",this.cancelDragCheck);
         addEventListener("mouseUp",this.cancelDragCheck);
      }
      
      private function cancelDragCheck(param1:MouseEvent) : void {
         removeEventListener("mouseMove",this.onMouseMoveCheckDrag);
         removeEventListener("mouseOut",this.cancelDragCheck);
         removeEventListener("mouseUp",this.cancelDragCheck);
      }
      
      private function onMouseMoveCheckDrag(param1:MouseEvent) : void {
         var _loc2_:Number = param1.stageX - this.dragStart.x;
         var _loc4_:Number = param1.stageY - this.dragStart.y;
         var _loc3_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc4_ * _loc4_);
         if(_loc3_ > 3) {
            this.cancelDragCheck(null);
            this.setPendingDoubleClick(false);
            this.beginDrag(param1);
         }
      }
      
      private function onDoubleClickTimerComplete(param1:TimerEvent) : void {
         this.setPendingDoubleClick(false);
         dispatchEvent(new ItemTileEvent("ITEM_CLICK",this));
      }
      
      private function beginDrag(param1:MouseEvent) : void {
         this.isDragging = true;
         toggleDragState(false);
         stage.addChild(itemSprite);
         itemSprite.startDrag(true);
         itemSprite.x = param1.stageX;
         itemSprite.y = param1.stageY;
         itemSprite.addEventListener("mouseUp",this.endDrag);
         this.beginDragCallback();
      }
      
      private function endDrag(param1:MouseEvent) : void {
         this.isDragging = false;
         toggleDragState(true);
         itemSprite.stopDrag();
         itemSprite.removeEventListener("mouseUp",this.endDrag);
         dispatchEvent(new ItemTileEvent("ITEM_MOVE",this));
         this.endDragCallback();
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         this.setPendingDoubleClick(false);
         this.cancelDragCheck(null);
         this.stopDragging();
      }
   }
}
