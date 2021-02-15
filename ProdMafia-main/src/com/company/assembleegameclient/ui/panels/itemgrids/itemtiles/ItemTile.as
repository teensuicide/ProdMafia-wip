package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
   import com.company.assembleegameclient.util.FilterUtil;
   import com.company.assembleegameclient.util.TierUtil;
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class ItemTile extends Sprite {
      
      public static const WIDTH:int = 40;
      
      public static const HEIGHT:int = 40;
      
      public static const BORDER:int = 4;
       
      
      public var itemSprite:ItemTileSprite;
      
      public var tileId:int;
      
      public var ownerGrid:ItemGrid;
      
      public var blockingItemUpdates:Boolean;
      
      private var fill_:GraphicsSolidFill;
      
      private var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      private var restrictedUseIndicator:Shape;
      
      private var tierText:UILabel;
      
      private var itemContainer:Sprite;
      
      private var tagContainer:Sprite;
      
      private var isItemUsable:Boolean;
      
      private var decaUI:Boolean;
      
      private var decaBackground:SliceScalingBitmap;
      
      public function ItemTile(param1:int, param2:ItemGrid, param3:Boolean = false) {
         this.decaUI = param3;
         if(this.decaUI) {
            this.decaBackground = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",50);
            this.decaBackground.height = 50;
            this.decaBackground.y = -4;
            this.decaBackground.x = -4;
            this.decaBackground.transform.colorTransform = new ColorTransform(1.22,1.22,1.22);
            this.addChild(this.decaBackground);
         } else {
            this.fill_ = new GraphicsSolidFill(this.getBackgroundColor(),1);
            this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
            this.graphicsData_ = new <IGraphicsData>[this.fill_,this.path_,GraphicsUtil.END_FILL];
         }
         super();
         this.tileId = param1;
         this.ownerGrid = param2;
         this.init();
      }
      
      public function drawBackground(param1:Array) : void {
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         if(!this.decaUI) {
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(0,0,40,40,4,param1,this.path_);
            graphics.clear();
            graphics.drawGraphicsData(this.graphicsData_);
            _loc2_ = new GraphicsSolidFill(6036765,1);
            GraphicsUtil.clearPath(this.path_);
            _loc3_ = new <IGraphicsData>[_loc2_,this.path_,GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0,0,40,40,4,param1,this.path_);
            this.restrictedUseIndicator.graphics.drawGraphicsData(_loc3_);
            this.restrictedUseIndicator.cacheAsBitmap = true;
            this.restrictedUseIndicator.visible = false;
         }
      }
      
      public function setItem(param1:int) : Boolean {
         if(param1 == this.itemSprite.itemId) {
            return false;
         }
         if(this.blockingItemUpdates) {
            return true;
         }
         this.itemSprite.setType(param1);
         this.setTierTag();
         this.updateUseability(this.ownerGrid.curPlayer);
         return true;
      }
      
      public function setItemSprite(param1:ItemTileSprite) : void {
         if(!this.itemContainer) {
            this.itemContainer = new Sprite();
            addChild(this.itemContainer);
         }
         this.itemSprite = param1;
         this.itemSprite.x = 20;
         this.itemSprite.y = 20;
         this.itemContainer.addChild(this.itemSprite);
      }
      
      public function updateUseability(param1:Player) : void {
         var _loc2_:int = this.itemSprite.itemId;
         if(this.itemSprite.itemId != -1) {
            this.restrictedUseIndicator.visible = !ObjectLibrary.isUsableByPlayer(_loc2_,param1);
         } else {
            this.restrictedUseIndicator.visible = false;
         }
      }
      
      public function canHoldItem(param1:int) : Boolean {
         return true;
      }
      
      public function resetItemPosition() : void {
         this.setItemSprite(this.itemSprite);
      }
      
      public function getItemId() : int {
         return this.itemSprite.itemId;
      }
      
      public function setTierTag() : void {
         this.clearTierTag();
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[this.itemSprite.itemId];
         if(_loc1_) {
            this.tierText = TierUtil.getTierTag(_loc1_);
            if(this.tierText) {
               if(!this.tagContainer) {
                  this.tagContainer = new Sprite();
                  addChild(this.tagContainer);
               }
               this.tierText.filters = FilterUtil.getTextOutlineFilter();
               this.tierText.x = 40 - this.tierText.width;
               this.tierText.y = 25;
               this.toggleTierTag(Parameters.data.showTierTag);
               this.tagContainer.addChild(this.tierText);
            }
         }
      }
      
      public function toggleTierTag(param1:Boolean) : void {
         if(this.tierText) {
            this.tierText.visible = param1;
         }
      }
      
      protected function getBackgroundColor() : int {
         return 5526612;
      }
      
      protected function toggleDragState(param1:Boolean) : void {
         if(this.tierText && Parameters.data.showTierTag) {
            this.tierText.visible = param1;
         }
         if(!this.isItemUsable && !param1) {
            this.restrictedUseIndicator.visible = param1;
         }
      }
      
      private function init() : void {
         this.restrictedUseIndicator = new Shape();
         addChild(this.restrictedUseIndicator);
         this.setItemSprite(new ItemTileSprite());
      }
      
      private function clearTierTag() : void {
         if(this.tierText && this.tagContainer && this.tagContainer.contains(this.tierText)) {
            this.tagContainer.removeChild(this.tierText);
            this.tierText = null;
         }
      }
   }
}
