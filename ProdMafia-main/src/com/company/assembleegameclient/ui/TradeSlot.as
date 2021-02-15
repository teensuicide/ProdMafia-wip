package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.util.GraphicsUtil;
   import com.company.util.MoreColorUtil;
   import com.company.util.SpriteUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.text.view.BitmapTextFactory;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   
   public class TradeSlot extends Slot implements TooltipAble {
      
      private static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      public static const EMPTY:int = -1;
      
      private static const DOSE_MATRIX:Matrix = makeDoseMatrix();
       
      
      public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();
      
      public var included_:Boolean;
      
      public var equipmentToolTipFactory:EquipmentToolTipFactory;
      
      private var id:uint;
      
      private var item_:int;
      
      private var overlay_:Shape;
      
      private var overlayFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var overlayPath_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      public function TradeSlot(param1:int, param2:Boolean, param3:Boolean, param4:int, param5:int, param6:Array, param7:uint) {
         equipmentToolTipFactory = new EquipmentToolTipFactory();
         overlayFill_ = new GraphicsSolidFill(16711310,1);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,overlayFill_);
         overlayPath_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[lineStyle_,overlayPath_,GraphicsUtil.END_STROKE];
         super(param4,param5,param6);
         this.id = param7;
         this.item_ = param1;
         this.included_ = param3;
         this.drawItemIfAvailable();
         if(!param2) {
            transform.colorTransform = MoreColorUtil.veryDarkCT;
         }
         this.overlay_ = this.getOverlay();
         addChild(this.overlay_);
         this.setIncluded(param3);
         this.hoverTooltipDelegate.setDisplayObject(this);
      }
      
      private static function makeDoseMatrix() : Matrix {
         var _loc1_:Matrix = new Matrix();
         _loc1_.translate(10,5);
         return _loc1_;
      }
      
      public function setIncluded(param1:Boolean) : void {
         this.included_ = param1;
         this.overlay_.visible = this.included_;
         if(this.included_) {
            fill_.color = 16764247;
         } else {
            fill_.color = 5526612;
         }
         drawBackground();
      }
      
      public function setShowToolTipSignal(param1:ShowTooltipSignal) : void {
         this.hoverTooltipDelegate.setShowToolTipSignal(param1);
      }
      
      public function getShowToolTip() : ShowTooltipSignal {
         return this.hoverTooltipDelegate.getShowToolTip();
      }
      
      public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void {
         this.hoverTooltipDelegate.setHideToolTipsSignal(param1);
      }
      
      public function getHideToolTips() : HideTooltipsSignal {
         return this.hoverTooltipDelegate.getHideToolTips();
      }
      
      public function setPlayer(param1:Player) : void {
         if(!this.isEmpty()) {
            this.hoverTooltipDelegate.tooltip = this.equipmentToolTipFactory.make(this.item_,param1,-1,"OTHER_PLAYER",this.id);
         }
      }
      
      public function isEmpty() : Boolean {
         return this.item_ == -1;
      }
      
      private function drawItemIfAvailable() : void {
         if(!this.isEmpty()) {
            this.drawItem();
         }
      }
      
      private function drawItem() : void {
         var _loc2_:* = null;
         var _loc4_:* = null;
         SpriteUtil.safeRemoveChild(this,backgroundImage_);
         var _loc5_:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.item_,40,true);
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[this.item_];
         if("Doses" in _loc1_) {
            _loc5_ = _loc5_.clone();
            _loc2_ = BitmapTextFactory.make(_loc1_.Doses,12,16777215,false,IDENTITY_MATRIX,false);
            _loc5_.draw(_loc2_,DOSE_MATRIX);
         }
         if("Quantity" in _loc1_) {
            _loc5_ = _loc5_.clone();
            _loc2_ = BitmapTextFactory.make(_loc1_.Quantity,12,16777215,false,IDENTITY_MATRIX,false);
            _loc5_.draw(_loc2_,DOSE_MATRIX);
         }
         var _loc3_:Point = offsets(this.item_,type_,false);
         _loc4_ = new Bitmap(_loc5_);
         _loc4_.x = 10 - _loc4_.width / 2 + _loc3_.x;
         _loc4_.y = 10 - _loc4_.height / 2 + _loc3_.y;
         SpriteUtil.safeAddChild(this,_loc4_);
      }
      
      private function getOverlay() : Shape {
         var _loc1_:Shape = new Shape();
         GraphicsUtil.clearPath(this.overlayPath_);
         GraphicsUtil.drawCutEdgeRect(0,0,20,20,4,cuts_,this.overlayPath_);
         _loc1_.graphics.drawGraphicsData(this.graphicsData_);
         return _loc1_;
      }
   }
}
