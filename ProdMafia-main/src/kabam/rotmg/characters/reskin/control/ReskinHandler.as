package kabam.rotmg.characters.reskin.control {
   import com.company.assembleegameclient.objects.Player;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.messaging.impl.outgoing.Reskin;
   
   public class ReskinHandler {
       
      
      [Inject]
      public var model:GameModel;
      
      [Inject]
      public var classes:ClassesModel;
      
      [Inject]
      public var factory:CharacterFactory;
      
      public function ReskinHandler() {
         super();
      }
      
      public function execute(param1:Reskin) : void {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         _loc2_ = param1.player || this.model.player;
         _loc4_ = param1.skinID;
         _loc5_ = this.classes.getCharacterClass(_loc2_.objectType_);
         _loc3_ = this.classes.getCharacterClass(65535);
         var _loc6_:CharacterSkin = _loc3_.skins.getSkin(_loc4_) || _loc5_.skins.getSkin(_loc4_);
         _loc2_.skinId = _loc4_;
         _loc2_.skin = this.factory.makeCharacter(_loc6_.template);
         _loc2_.isDefaultAnimatedChar = false;
      }
   }
}
