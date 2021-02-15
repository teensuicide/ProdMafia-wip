package kabam.rotmg.game.model {
   public class QuestModel {
      
      public static const LEVEL_REQUIREMENT:int = 0;
      
      public static const REMAINING_HEROES_REQUIREMENT:int = 1;
      
      public static const ORYX_KILLED:int = 2;
      
      public static const ORYX_THE_MAD_GOD:String = "Oryx the Mad God";
       
      
      private var _previousRealm:String = "";
      
      private var _currentQuestHero:String;
      
      private var _remainingHeroes:int = -1;
      
      private var _requirementsStates:Vector.<Boolean>;
      
      private var _hasOryxBeenKilled:Boolean;
      
      public function QuestModel() {
         _requirementsStates = new <Boolean>[false,false,false];
         super();
      }
      
      public function get previousRealm() : String {
         return this._previousRealm;
      }
      
      public function set previousRealm(param1:String) : void {
         this._previousRealm = param1;
      }
      
      public function get currentQuestHero() : String {
         return this._currentQuestHero;
      }
      
      public function set currentQuestHero(param1:String) : void {
         this._currentQuestHero = param1;
      }
      
      public function get remainingHeroes() : int {
         return this._remainingHeroes;
      }
      
      public function set remainingHeroes(param1:int) : void {
         this._remainingHeroes = param1;
      }
      
      public function get requirementsStates() : Vector.<Boolean> {
         return this._requirementsStates;
      }
      
      public function set requirementsStates(param1:Vector.<Boolean>) : void {
         this._requirementsStates = param1;
      }
      
      public function get hasOryxBeenKilled() : Boolean {
         return this._hasOryxBeenKilled;
      }
      
      public function set hasOryxBeenKilled(param1:Boolean) : void {
         this._hasOryxBeenKilled = param1;
      }
      
      public function resetRequirementsStates() : void {
         var _loc1_:int = 0;
         var _loc2_:int = this._requirementsStates.length;
         while(_loc1_ < _loc2_) {
            this._requirementsStates[_loc1_] = false;
            _loc1_++;
         }
      }
   }
}
