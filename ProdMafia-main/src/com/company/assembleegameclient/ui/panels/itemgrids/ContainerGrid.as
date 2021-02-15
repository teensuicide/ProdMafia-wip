package com.company.assembleegameclient.ui.panels.itemgrids {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
   
   public class ContainerGrid extends ItemGrid {
       
      
      private const NUM_SLOTS:uint = 8;
      
      private var tiles:Vector.<InteractiveItemTile>;
      
      private var ignoreDraw:Boolean;
      
      public function ContainerGrid(param1:GameObject, param2:Player, param3:Boolean = false, param4:Boolean = false) {
         super(param1,param2,0,param4);
         this.ignoreDraw = param3;
         if(this.ignoreDraw) {
            return;
         }
         var _loc5_:* = null;
         var _loc6_:int = 0;
         this.tiles = new Vector.<InteractiveItemTile>(8);
         while(_loc6_ < 8) {
            _loc5_ = new InteractiveItemTile(_loc6_ + indexOffset,this,interactive);
            addToGrid(_loc5_,2,_loc6_);
            this.tiles[_loc6_] = _loc5_;
            _loc6_++;
         }
      }
      
      public function addTile(param1:InteractiveItemTile, param2:int) : void {
         add(param1,param2);
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
                  if(this.tiles[_loc3_].setItem(param1[_loc3_ + indexOffset])) {
                     _loc5_ = true;
                  }
               } else if(this.tiles[_loc3_].setItem(-1)) {
                  _loc5_ = true;
               }
               _loc3_++;
            }
            if(_loc5_) {
               refreshTooltip();
            }
         }
      }
   }
}
