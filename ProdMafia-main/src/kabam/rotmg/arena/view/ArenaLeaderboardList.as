package kabam.rotmg.arena.view {
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import kabam.lib.ui.api.Size;
   import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
   import kabam.rotmg.util.components.VerticalScrollingList;
   
   public class ArenaLeaderboardList extends Sprite {
       
      
      private const MAX_SIZE:int = 20;
      
      private var listItemPool:Vector.<DisplayObject>;
      
      private var scrollList:VerticalScrollingList;
      
      public function ArenaLeaderboardList() {
         var _loc1_:int = 0;
         listItemPool = new Vector.<DisplayObject>(20);
         scrollList = new VerticalScrollingList();
         super();
         while(_loc1_ < 20) {
            this.listItemPool[_loc1_] = new ArenaLeaderboardListItem();
            _loc1_++;
         }
         this.scrollList.setSize(new Size(786,400));
         addChild(this.scrollList);
      }
      
      public function setItems(param1:Vector.<ArenaLeaderboardEntry>, param2:Boolean) : void {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         while(_loc5_ < this.listItemPool.length) {
            _loc4_ = _loc5_ < param1.length?param1[_loc5_]:null;
            _loc3_ = this.listItemPool[_loc5_] as ArenaLeaderboardListItem;
            _loc3_.apply(_loc4_,param2);
            _loc5_++;
         }
         this.scrollList.setItems(this.listItemPool);
      }
   }
}
