package kabam.rotmg.classes.control {
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.CharacterSkinState;
   import kabam.rotmg.classes.model.ClassesModel;
   
   public class ResetClassDataCommand {
       
      
      [Inject]
      public var classes:ClassesModel;
      
      public function ResetClassDataCommand() {
         super();
      }
      
      public function execute() : void {
         var _loc1_:int = 0;
         var _loc2_:int = this.classes.getCount();
         while(_loc1_ < _loc2_) {
            this.resetClass(this.classes.getClassAtIndex(_loc1_));
            _loc1_++;
         }
      }
      
      private function resetClass(param1:CharacterClass) : void {
         param1.setIsSelected(param1.id == 782);
         this.resetClassSkins(param1);
      }
      
      private function resetClassSkins(param1:CharacterClass) : void {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:CharacterSkin = param1.skins.getDefaultSkin();
         var _loc5_:int = param1.skins.getCount();
         while(_loc4_ < _loc5_) {
            _loc3_ = param1.skins.getSkinAt(_loc4_);
            if(_loc3_ != _loc2_) {
               this.resetSkin(param1.skins.getSkinAt(_loc4_));
            }
            _loc4_++;
         }
      }
      
      private function resetSkin(param1:CharacterSkin) : void {
         param1.setState(CharacterSkinState.LOCKED);
      }
   }
}
