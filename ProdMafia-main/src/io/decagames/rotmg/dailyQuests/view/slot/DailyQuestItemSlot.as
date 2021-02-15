package io.decagames.rotmg.dailyQuests.view.slot {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import io.decagames.rotmg.utils.colors.GreyScale;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class DailyQuestItemSlot extends Sprite {
      
      public static const SELECTED_BORDER_SIZE:int = 2;
      
      public static const SLOT_SIZE:int = 40;
       
      
      private var imageContainer:Sprite;
      
      private var backgroundShape:Shape;
      
      private var hasItem:Boolean;
      
      private var imageBitmap:Bitmap;
      
      private var _itemID:int;
      
      private var _type:String;
      
      private var _isSlotsSelectable:Boolean;
      
      public var _selected:Boolean;
      
      public function DailyQuestItemSlot(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false) {
         super();
         this._itemID = param1;
         this._type = param2;
         this._isSlotsSelectable = param4;
         this.hasItem = param3;
         this.imageBitmap = new Bitmap();
         this.imageContainer = new Sprite();
         addChild(this.imageContainer);
         this.imageContainer.x = Math.round(20);
         this.imageContainer.y = Math.round(20);
         this.createBackground();
         this.renderItem();
      }
      
      public function get itemID() : int {
         return this._itemID;
      }
      
      public function get type() : String {
         return this._type;
      }
      
      public function get isSlotsSelectable() : Boolean {
         return this._isSlotsSelectable;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void {
         this._selected = param1;
         this.createBackground();
         this.renderItem();
      }
      
      public function dispose() : void {
         if(this.imageBitmap && this.imageBitmap.bitmapData) {
            this.imageBitmap.bitmapData.dispose();
         }
      }
      
      private function createBackground() : void {
         if(!this.backgroundShape) {
            this.backgroundShape = new Shape();
            this.imageContainer.addChild(this.backgroundShape);
         }
         this.backgroundShape.graphics.clear();
         if(this.isSlotsSelectable) {
            if(this._selected) {
               this.backgroundShape.graphics.beginFill(14846006,1);
               this.backgroundShape.graphics.drawRect(-2,-2,44,44);
               this.backgroundShape.graphics.beginFill(14846006,1);
            } else {
               this.backgroundShape.graphics.beginFill(4539717,1);
            }
         } else {
            this.backgroundShape.graphics.beginFill(!!this.hasItem?1286144:4539717,1);
         }
         this.backgroundShape.graphics.drawRect(0,0,40,40);
         this.backgroundShape.x = -Math.round(22);
         this.backgroundShape.y = -Math.round(22);
      }
      
      private function renderItem() : void {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(this.imageBitmap.bitmapData) {
            this.imageBitmap.bitmapData.dispose();
         }
         var _loc4_:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._itemID,80,true);
         _loc4_ = _loc4_.clone();
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[this._itemID];
         if(_loc1_ && _loc1_.hasOwnProperty("Quantity")) {
            _loc3_ = BitmapTextFactory.make(_loc1_.Quantity,12,16777215,false,new Matrix(),true);
            _loc2_ = new Matrix();
            _loc2_.translate(8,7);
            _loc4_.draw(_loc3_,_loc2_);
         }
         this.imageBitmap.bitmapData = _loc4_;
         if(this.isSlotsSelectable && !this._selected) {
            GreyScale.setGreyScale(_loc4_);
         }
         if(!this.imageBitmap.parent) {
            this.imageBitmap.x = -Math.round(this.imageBitmap.width / 2);
            this.imageBitmap.y = -Math.round(this.imageBitmap.height / 2);
            this.imageContainer.addChild(this.imageBitmap);
         }
      }
   }
}
