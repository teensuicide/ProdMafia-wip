package kabam.rotmg.arena.model {
   import flash.display.BitmapData;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   
   public class ArenaLeaderboardEntry {
       
      
      public var playerBitmap:BitmapData;
      
      public var name:String;
      
      public var pet:PetVO;
      
      public var slotTypes:Vector.<int>;
      
      public var equipment:Vector.<int>;
      
      public var runtime:Number;
      
      public var currentWave:int;
      
      public var guildName:String;
      
      public var guildRank:int;
      
      public var rank:int = -1;
      
      public var isPersonalRecord:Boolean = false;
      
      public function ArenaLeaderboardEntry() {
         super();
      }
      
      public function isEqual(param1:ArenaLeaderboardEntry) : Boolean {
         return param1.name == this.name && this.runtime == param1.runtime && this.currentWave == param1.currentWave;
      }
      
      public function isBetterThan(param1:ArenaLeaderboardEntry) : Boolean {
         return this.currentWave > param1.currentWave || this.currentWave == param1.currentWave && this.runtime < param1.runtime;
      }
   }
}
