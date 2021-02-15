package io.decagames.rotmg.pets.windows.yard.feed.items {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class FeedItem extends UIGridElement {
       
      
      private var imageBitmap:Bitmap;
      
      private var _item:InventoryTile;
      
      private var _feedPower:int;
      
      private var _selected:Boolean;
      
      public function FeedItem(param1:InventoryTile) {
         super();
         this._item = param1;
         this.renderBackground(4539717,0.25);
         this.renderItem();
      }
      
      public function get item() : InventoryTile {
         return this._item;
      }
      
      public function get feedPower() : int {
         return this._feedPower;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void {
         this._selected = param1;
         if(param1) {
            this.renderBackground(15306295,1);
         } else {
            this.renderBackground(4539717,0.25);
         }
      }
      
      public function get itemId() : int {
         return this._item.getItemId();
      }
      
      override public function dispose() : void {
         super.dispose();
         this.imageBitmap.bitmapData.dispose();
      }
      
      private function renderBackground(param1:uint, param2:Number) : void {
         graphics.clear();
         graphics.beginFill(param1,param2);
         graphics.drawRect(0,0,40,40);
      }
      
      private function renderItem() : void {
         var _loc2_:* = null;
         var _loc5_:* = null;
         this.imageBitmap = new Bitmap();
         var _loc3_:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._item.getItemId(),40,true);
         _loc3_ = _loc3_.clone();
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[this._item.getItemId()];
         this._feedPower = _loc1_.feedPower;
         if(_loc1_ && _loc1_.hasOwnProperty("Quantity")) {
            _loc2_ = BitmapTextFactory.make(_loc1_.Quantity,12,16777215,false,new Matrix(),true);
            _loc5_ = new Matrix();
            _loc5_.translate(8,7);
            _loc3_.draw(_loc2_,_loc5_);
         }
         this.imageBitmap.bitmapData = _loc3_;
         addChild(this.imageBitmap);
      }
   }
}
