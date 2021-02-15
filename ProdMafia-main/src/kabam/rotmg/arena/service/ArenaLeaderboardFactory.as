package kabam.rotmg.arena.service {
   import com.company.util.ConversionUtil;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
   import kabam.rotmg.arena.model.CurrentArenaRunModel;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   
   public class ArenaLeaderboardFactory {
       
      
      [Inject]
      public var classesModel:ClassesModel;
      
      [Inject]
      public var factory:CharacterFactory;
      
      [Inject]
      public var currentRunModel:CurrentArenaRunModel;
      
      public function ArenaLeaderboardFactory() {
         super();
      }
      
      public function makeEntries(param1:XMLList) : Vector.<ArenaLeaderboardEntry> {
         var _loc3_:* = null;
         var _loc2_:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
         var _loc5_:int = 1;
         var _loc6_:* = param1;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc3_ in param1) {
            _loc2_.push(this.makeArenaEntry(_loc3_,_loc5_));
            _loc5_++;
         }
         _loc2_ = this.removeDuplicateUser(_loc2_);
         return this.addCurrentRun(_loc2_);
      }
      
      private function addCurrentRun(param1:Vector.<ArenaLeaderboardEntry>) : Vector.<ArenaLeaderboardEntry> {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc7_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc3_:* = null;
         var _loc2_:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
         if(this.currentRunModel.hasEntry()) {
            _loc7_ = false;
            _loc6_ = false;
            _loc5_ = 0;
            _loc4_ = param1;
            var _loc9_:int = 0;
            var _loc8_:* = param1;
            for each(_loc3_ in param1) {
               if(!_loc7_ && this.currentRunModel.entry.isBetterThan(_loc3_)) {
                  this.currentRunModel.entry.rank = _loc3_.rank;
                  _loc2_.push(this.currentRunModel.entry);
                  _loc7_ = true;
               }
               if(_loc3_.isPersonalRecord) {
                  _loc6_ = true;
               }
               if(_loc7_) {
                  _loc3_.rank = Number(_loc3_.rank) + 1;
               }
               _loc2_.push(_loc3_);
            }
            if(_loc2_.length < 20 && !_loc7_ && !_loc6_) {
               this.currentRunModel.entry.rank = _loc2_.length + 1;
               _loc2_.push(this.currentRunModel.entry);
            }
         }
         return _loc2_.length > 0?_loc2_:param1;
      }
      
      private function removeDuplicateUser(param1:Vector.<ArenaLeaderboardEntry>) : Vector.<ArenaLeaderboardEntry> {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc7_:Boolean = false;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = -1;
         if(this.currentRunModel.hasEntry()) {
            _loc7_ = false;
            _loc6_ = this.currentRunModel.entry;
            _loc5_ = 0;
            _loc4_ = param1;
            var _loc9_:int = 0;
            var _loc8_:* = param1;
            for each(_loc3_ in param1) {
               if(_loc3_.isPersonalRecord && _loc6_.isBetterThan(_loc3_)) {
                  _loc2_ = _loc3_.rank - 1;
                  _loc7_ = true;
               } else if(_loc7_) {
                  _loc3_.rank = Number(_loc3_.rank) - 1;
               }
            }
         }
         if(_loc2_ != -1) {
            param1.splice(_loc2_,1);
         }
         return param1;
      }
      
      private function makeArenaEntry(param1:XML, param2:int) : ArenaLeaderboardEntry {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc6_:ArenaLeaderboardEntry = new ArenaLeaderboardEntry();
         _loc6_.isPersonalRecord = "IsPersonalRecord" in param1;
         _loc6_.runtime = param1.Time;
         _loc6_.name = param1.PlayData.CharacterData.Name;
         _loc6_.rank = "Rank" in param1?param1.Rank:param2;
         var _loc5_:int = param1.PlayData.CharacterData.Texture;
         var _loc3_:int = param1.PlayData.CharacterData.Class;
         var _loc9_:CharacterClass = this.classesModel.getCharacterClass(_loc3_);
         var _loc11_:CharacterSkin = _loc9_.skins.getSkin(_loc5_);
         var _loc10_:int = "Tex1" in param1.PlayData.CharacterData?param1.PlayData.CharacterData.Tex1:0;
         var _loc4_:int = "Tex2" in param1.PlayData.CharacterData?param1.PlayData.CharacterData.Tex2:0;
         _loc6_.playerBitmap = this.factory.makeIcon(_loc11_.template,!!_loc11_.is16x16?50:100,_loc10_,_loc4_);
         _loc6_.equipment = ConversionUtil.toIntVector(param1.PlayData.CharacterData.Inventory);
         _loc6_.slotTypes = _loc9_.slotTypes;
         _loc6_.guildName = param1.PlayData.CharacterData.GuildName;
         _loc6_.guildRank = param1.PlayData.CharacterData.GuildRank;
         _loc6_.currentWave = param1.WaveNumber;
         if("Pet" in param1.PlayData) {
            _loc7_ = new PetVO();
            _loc8_ = new XML(param1.PlayData.Pet);
            _loc7_.apply(_loc8_);
            _loc6_.pet = _loc7_;
         }
         return _loc6_;
      }
   }
}
