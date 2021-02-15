package com.company.assembleegameclient.map.partyoverlay {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.menu.Menu;
   import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
   import com.company.assembleegameclient.ui.tooltip.PlayerGroupToolTip;
   import flash.events.MouseEvent;
   
   public class PlayerArrow extends GameObjectArrow {
       
      
      public function PlayerArrow() {
         super(16777215,4179794,false);
      }
      
      protected function getMenu() : Menu {
         var _loc2_:Player = go_ as Player;
         if(_loc2_ == null || _loc2_.map_ == null) {
            return null;
         }
         var _loc1_:Player = _loc2_.map_.player_;
         if(_loc1_ == null) {
            return null;
         }
         return new PlayerGroupMenu(_loc2_.map_,this.getFullPlayerVec());
      }
      
      private function getFullPlayerVec() : Vector.<Player> {
         var _loc1_:* = null;
         var _loc3_:Vector.<Player> = new <Player>[go_ as Player];
         var _loc2_:* = extraGOs_;
         var _loc6_:int = 0;
         var _loc5_:* = extraGOs_;
         for each(_loc1_ in extraGOs_) {
            _loc3_.push(_loc1_ as Player);
         }
         return _loc3_;
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void {
         super.onMouseOver(param1);
         setToolTip(new PlayerGroupToolTip(this.getFullPlayerVec(),false));
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void {
         super.onMouseOut(param1);
         setToolTip(null);
      }
   }
}
