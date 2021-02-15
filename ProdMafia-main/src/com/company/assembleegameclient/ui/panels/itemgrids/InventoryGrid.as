package com.company.assembleegameclient.ui.panels.itemgrids {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
   
   public class InventoryGrid extends ItemGrid {
       
      
      private const NUM_SLOTS:uint = 8;
      
      private var isBackpack:Boolean;
      
      private var _tiles:Vector.<InventoryTile>;
      
      public function InventoryGrid(param1:GameObject, param2:Player, param3:int = 0, param4:Boolean = false) {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         super(param1,param2,param3);
         this._tiles = new Vector.<InventoryTile>(8);
         this.isBackpack = param4;
         while(_loc6_ < 8) {
            _loc5_ = new InventoryTile(_loc6_ + indexOffset,this,interactive);
            _loc5_.addTileNumber(_loc6_ + 1);
            addToGrid(_loc5_,2,_loc6_);
            this._tiles[_loc6_] = _loc5_;
            _loc6_++;
         }
      }
      
      public function get tiles() : Vector.<InventoryTile> {
         return this._tiles.concat();
      }
      
      override public function setItems(param1:Vector.<int>, param2:int = 0) : void {
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1) {
            _loc5_ = false;
            _loc4_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < 8) {
               if(_loc3_ + indexOffset < _loc4_) {
                  if(this._tiles[_loc3_].setItem(param1[_loc3_ + indexOffset])) {
                     _loc5_ = true;
                  }
               } else if(this._tiles[_loc3_].setItem(-1)) {
                  _loc5_ = true;
               }
               _loc3_++;
            }
            if(_loc5_) {
               refreshTooltip();
            }
         }
      }
      
      public function getItemById(param1:int) : InventoryTile {
         var _loc2_:* = null;
         var _loc3_:* = this._tiles;
         var _loc6_:int = 0;
         var _loc5_:* = this._tiles;
         for each(_loc2_ in this._tiles) {
            if(_loc2_.getItemId() == param1) {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function toggleTierTags(param1:Boolean) : void {
         var _loc4_:int = 0;
         var _loc3_:* = this._tiles;
         for each(var _loc2_ in this._tiles) {
            _loc2_.toggleTierTag(param1);
         }
      }
   }
}
