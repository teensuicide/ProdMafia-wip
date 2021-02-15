package kabam.rotmg.arena.model {
   public class ArenaLeaderboardModel {
      
      public static const FILTERS:Vector.<ArenaLeaderboardFilter> = Vector.<ArenaLeaderboardFilter>([new ArenaLeaderboardFilter("ArenaLeaderboard.allTime","alltime"),new ArenaLeaderboardFilter("ArenaLeaderboard.weekly","weekly"),new ArenaLeaderboardFilter("ArenaLeaderbaord.yourRank","personal")]);
       
      
      public function ArenaLeaderboardModel() {
         super();
      }
      
      public function clearFilters() : void {
         var _loc3_:* = null;
         var _loc1_:* = FILTERS;
         var _loc5_:int = 0;
         var _loc4_:* = FILTERS;
         for each(_loc3_ in FILTERS) {
            _loc3_.clearEntries();
         }
      }
   }
}
