package kabam.rotmg.ui.view.components {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.GraphicsUtil;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.utils.Timer;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;
   
   public class PotionSlotView extends Sprite {
      
      public static const BUTTON_WIDTH:int = 84;
      
      private static const BUTTON_HEIGHT:int = 24;
      
      private static const SMALL_SIZE:int = 4;
      
      private static const CENTER_ICON_X:int = 6;
      
      public static const READABILITY_SHADOW_1:DropShadowFilter = new DropShadowFilter(0,0,0,1,4,4,2);
      
      public static const READABILITY_SHADOW_2:DropShadowFilter = new DropShadowFilter(0,0,0,1,4,4,3);
      
      private static const DOUBLE_CLICK_PAUSE:uint = 250;
      
      private static const DRAG_DIST:int = 3;
      
      private static var LEFT_ICON_X:int = -6;
       
      
      public var position:int;
      
      public var objectType:int = -1;
      public var itemCount:int;
      public var maxCount:int;
      public var w:int;
      
      public var click:NativeSignal;
      
      public var buyUse:Signal;
      
      public var drop:Signal;

      private var outerPath:GraphicsPath;

      private var innerPath:GraphicsPath;

      private var useGraphicsData:Vector.<IGraphicsData>;

      private var buyOuterGraphicsData:Vector.<IGraphicsData>;

      private var text:TextFieldDisplayConcrete;

      private var potionIconDraggableSprite:Sprite;
      
      private var potionIcon:Bitmap;
      
      private var bg:Sprite;
      
      private var grayscaleMatrix:ColorMatrixFilter;
      
      private var doubleClickTimer:Timer;
      
      private var dragStart:Point;
      
      private var pendingSecondClick:Boolean;
      
      private var isDragging:Boolean;
      
      public function PotionSlotView(cuts:Array, pos:int, w:int) {
         this.buyUse = new Signal();
         var lightGrayFill:GraphicsSolidFill = new GraphicsSolidFill(5526612, 1);
         var midGrayFill:GraphicsSolidFill = new GraphicsSolidFill(4078909, 1);
         outerPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         innerPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
         useGraphicsData = new <IGraphicsData>[lightGrayFill,outerPath,GraphicsUtil.END_FILL];
         buyOuterGraphicsData = new <IGraphicsData>[midGrayFill, outerPath, GraphicsUtil.END_FILL];
         super();
         mouseChildren = false;
         this.position = pos;
         this.grayscaleMatrix = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
         this.text = new TextFieldDisplayConcrete().setSize(12).setColor(16777215).setTextWidth(84).setTextHeight(16);
         this.text.filters = [READABILITY_SHADOW_1];
         this.bg = new Sprite();
         this.w = w;
         GraphicsUtil.clearPath(this.outerPath);
         GraphicsUtil.drawCutEdgeRect(0, 0, w - 4, 24, 4, cuts, this.outerPath);
         GraphicsUtil.drawCutEdgeRect(2, 2, w - 8, 20, 4, cuts, this.innerPath);
         this.bg.graphics.drawGraphicsData(this.buyOuterGraphicsData);
         addChild(this.bg);
         addChild(this.text);
         this.potionIconDraggableSprite = new Sprite();
         this.doubleClickTimer = new Timer(250,1);
         this.doubleClickTimer.addEventListener("timerComplete",this.onDoubleClickTimerComplete);
         addEventListener("mouseDown",this.onMouseDown);
         addEventListener("mouseUp",this.onMouseUp);
         addEventListener("mouseOut",this.onMouseOut);
         addEventListener("removedFromStage",this.onRemovedFromStage);
         this.click = new NativeSignal(this,"click",MouseEvent);
         this.drop = new Signal(DisplayObject);
      }
      
      public function setData(itemCount:int, maxCount:int, itemId:int = -1) : void {
         var _loc8_:* = null;
         var _loc7_:* = null;
         this.objectType = itemId;
         this.itemCount = itemCount;
         this.maxCount = maxCount;
         if (itemId != -1) {
            if (this.potionIcon != null && contains(this.potionIcon))
               removeChild(this.potionIcon);

            _loc8_ = ObjectLibrary.getRedrawnTextureFromType(itemId,55,false);
            this.potionIcon = new Bitmap(_loc8_);
            this.potionIcon.y = -11;
            addChild(this.potionIcon);
            _loc8_ = ObjectLibrary.getRedrawnTextureFromType(itemId,80,true);
            _loc7_ = new Bitmap(_loc8_);
            _loc7_.x = _loc7_.x - 30;
            _loc7_.y = _loc7_.y - 30;
            this.potionIconDraggableSprite.addChild(_loc7_);
         } else {
            if (this.potionIcon != null && contains(this.potionIcon))
               removeChild(this.potionIcon);
            if (this.text != null)
               this.text.setText("");
            this.potionIconDraggableSprite = new Sprite();
         }
         this.bg.graphics.clear();
         this.bg.graphics.drawGraphicsData(this.useGraphicsData);
         if (this.potionIcon)
            this.potionIcon.x = this.w == 88 ? 6 : -6;

         var hasItems:Boolean = itemCount > 0;
         if (hasItems) {
            this.setTextString(itemCount + "/" + maxCount);
            this.text.x = this.potionIcon.x + 35;
            this.text.y = 4;
            this.text.setBold(true);
            this.text.setSize(12);
         }
      }
      
      public function setTextString(param1:String) : void {
         this.text.setStringBuilder(new StaticStringBuilder(param1));
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
      
      private function beginDrag() : void {
         this.isDragging = true;
         this.potionIconDraggableSprite.startDrag(true);
         stage.addChild(this.potionIconDraggableSprite);
         this.potionIconDraggableSprite.addEventListener("mouseUp",this.endDrag);
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
            this.buyUse.dispatch();
         } else if(!this.pendingSecondClick) {
            this.setPendingDoubleClick(true);
         } else {
            this.setPendingDoubleClick(false);
            this.buyUse.dispatch();
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         if (this.objectType != -1)
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
            this.beginDrag();
         }
      }
      
      private function onDoubleClickTimerComplete(param1:TimerEvent) : void {
         this.setPendingDoubleClick(false);
      }
      
      private function endDrag(param1:MouseEvent) : void {
         this.isDragging = false;
         this.potionIconDraggableSprite.stopDrag();
         this.potionIconDraggableSprite.x = this.dragStart.x;
         this.potionIconDraggableSprite.y = this.dragStart.y;
         stage.removeChild(this.potionIconDraggableSprite);
         this.potionIconDraggableSprite.removeEventListener("mouseUp",this.endDrag);
         this.drop.dispatch(this.potionIconDraggableSprite.dropTarget);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         this.setPendingDoubleClick(false);
         this.cancelDragCheck(null);
         if(this.isDragging) {
            this.potionIconDraggableSprite.stopDrag();
         }
      }
   }
}
