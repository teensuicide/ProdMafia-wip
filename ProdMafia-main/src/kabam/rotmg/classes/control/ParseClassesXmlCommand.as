package kabam.rotmg.classes.control {
   import kabam.rotmg.assets.model.CharacterTemplate;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterClassStat;
   import kabam.rotmg.classes.model.CharacterClassUnlock;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.CharacterSkinState;
   import kabam.rotmg.classes.model.ClassesModel;
   
   public class ParseClassesXmlCommand {
       
      
      [Inject]
      public var data:XML;
      
      [Inject]
      public var classes:ClassesModel;
      
      public function ParseClassesXmlCommand() {
         super();
      }
      
      public function execute() : void {
         var _loc1_:* = null;
         var _loc2_:XMLList = this.data.Object;
         var _loc4_:int = 0;
         var _loc3_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            this.parseCharacterClass(_loc1_);
         }
      }
      
      private function parseCharacterClass(param1:XML) : void {
         var _loc2_:int = param1.@type;
         var _loc3_:CharacterClass = this.classes.getCharacterClass(_loc2_);
         this.populateCharacter(_loc3_,param1);
      }
      
      private function populateCharacter(param1:CharacterClass, param2:XML) : void {
         var _loc3_:* = null;
         param1.id = param2.@type;
         param1.name = param2.DisplayId == undefined?param2.@id:param2.DisplayId;
         param1.description = param2.Description;
         param1.hitSound = param2.HitSound;
         param1.deathSound = param2.DeathSound;
         param1.bloodProb = param2.BloodProb;
         param1.slotTypes = this.parseIntList(param2.SlotTypes);
         param1.defaultEquipment = this.parseIntList(param2.Equipment);
         param1.hp = this.parseCharacterStat(param2,"MaxHitPoints");
         param1.mp = this.parseCharacterStat(param2,"MaxMagicPoints");
         param1.attack = this.parseCharacterStat(param2,"Attack");
         param1.defense = this.parseCharacterStat(param2,"Defense");
         param1.speed = this.parseCharacterStat(param2,"Speed");
         param1.dexterity = this.parseCharacterStat(param2,"Dexterity");
         param1.hpRegeneration = this.parseCharacterStat(param2,"HpRegen");
         param1.mpRegeneration = this.parseCharacterStat(param2,"MpRegen");
         param1.unlockCost = param2.UnlockCost;
         var _loc5_:int = 0;
         var _loc4_:* = param2.UnlockLevel;
         for each(_loc3_ in param2.UnlockLevel) {
            param1.unlocks.push(this.parseUnlock(_loc3_));
         }
         param1.skins.addSkin(this.makeDefaultSkin(param2),true);
      }
      
      private function makeDefaultSkin(param1:XML) : CharacterSkin {
         var _loc2_:String = param1.AnimatedTexture.File;
         var _loc3_:int = param1.AnimatedTexture.Index;
         var _loc4_:CharacterSkin = new CharacterSkin();
         _loc4_.id = 0;
         _loc4_.name = "Skins.Classic";
         _loc4_.template = new CharacterTemplate(_loc2_,_loc3_);
         _loc4_.setState(CharacterSkinState.OWNED);
         _loc4_.setIsSelected(true);
         return _loc4_;
      }
      
      private function parseUnlock(param1:XML) : CharacterClassUnlock {
         var _loc2_:CharacterClassUnlock = new CharacterClassUnlock();
         _loc2_.level = param1.@level;
         _loc2_.character = this.classes.getCharacterClass(param1.@type);
         return _loc2_;
      }
      
      private function parseCharacterStat(param1:XML, param2:String) : CharacterClassStat {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:XML = param1[param2][0];
         var _loc8_:int = 0;
         var _loc7_:* = param1.LevelIncrease;
         for each(_loc6_ in param1.LevelIncrease) {
            if(_loc6_.text() == param2) {
               _loc5_ = _loc6_;
            }
         }
         _loc4_ = new CharacterClassStat();
         _loc4_.initial = int(_loc3_.toString());
         _loc4_.max = _loc3_.@max;
         _loc4_.rampMin = !!_loc5_?_loc5_.@min:0;
         _loc4_.rampMax = !!_loc5_?_loc5_.@max:0;
         return _loc4_;
      }
      
      private function parseIntList(param1:String) : Vector.<int> {
         var _loc5_:int = 0;
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = _loc2_.length;
         var _loc4_:Vector.<int> = new Vector.<int>(_loc3_,true);
         while(_loc5_ < _loc3_) {
            _loc4_[_loc5_] = int(_loc2_[_loc5_]);
            _loc5_++;
         }
         return _loc4_;
      }
   }
}
