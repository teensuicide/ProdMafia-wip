package com.company.assembleegameclient.ui.panels.itemgrids {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
   import com.company.util.ArrayIterator;
   import com.company.util.IIterator;
   import kabam.lib.util.VectorAS3Util;
   
   public class EquippedGrid extends ItemGrid {
       
      
      private var tiles:Vector.<EquipmentTile>;
      
      private var _invTypes:Vector.<int>;
      
      public function EquippedGrid(param1:GameObject, param2:Vector.<int>, param3:Player, param4:int = 0) {
         super(param1,param3,param4);
         this._invTypes = param2;
         this.init();
      }
      
      override public function setItems(param1:Vector.<int>, param2:int = 0) : void {
         var _loc3_:int = 0;
         if(!param1) {
            return;
         }
         var _loc4_:int = param1.length;
         while(_loc3_ < this.tiles.length) {
            if(_loc3_ + param2 < _loc4_) {
               this.tiles[_loc3_].setItem(param1[_loc3_ + param2]);
            } else {
               this.tiles[_loc3_].setItem(-1);
            }
            this.tiles[_loc3_].updateDim(curPlayer);
            _loc3_++;
         }
      }
      
      public function dispose() : void {
         tiles.length = 0;
      }
      
      public function createInteractiveItemTileIterator() : IIterator {
         return new ArrayIterator(VectorAS3Util.toArray(this.tiles));
      }
      
      public function toggleTierTags(param1:Boolean) : void {
         var _loc4_:int = 0;
         var _loc3_:* = this.tiles;
         for each(var _loc2_ in this.tiles) {
            _loc2_.toggleTierTag(param1);
         }
      }
      
      private function init() : void {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         this.tiles = new Vector.<EquipmentTile>(4);
         while(_loc1_ < 4) {
            _loc2_ = new EquipmentTile(_loc1_,this,interactive);
            addToGrid(_loc2_,1,_loc1_);
            _loc2_.setType(this._invTypes[_loc1_]);
            this.tiles[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
   }
}
