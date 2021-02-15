package kabam.rotmg.game.commands {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import com.company.assembleegameclient.util.TimeUtil;
   import kabam.rotmg.game.model.PotionInventoryModel;
   import kabam.rotmg.game.model.UseBuyPotionVO;
   import kabam.rotmg.messaging.impl.GameServerConnection;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.model.PotionModel;
   import robotlegs.bender.framework.api.ILogger;
   
   public class UseBuyPotionCommand {
       
      
      [Inject]
      public var vo:UseBuyPotionVO;
      
      [Inject]
      public var potInventoryModel:PotionInventoryModel;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var logger:ILogger;
      
      private var gsc:GameServerConnection;
      
      private var player:Player;
      
      private var potionId:int;
      
      private var count:int;
      
      private var potion:PotionModel;
      
      public function UseBuyPotionCommand() {
         gsc = GameServerConnection.instance;
         super();
      }
      
      public function execute() : void {
         this.player = this.hudModel.gameSprite.map.player_;
         if(this.player == null) {
            return;
         }
         this.potionId = this.vo.objectId;
         this.count = this.player.getPotionCount(this.potionId);
         this.potion = this.potInventoryModel.getPotionModel(this.potionId);
         if(this.count > 0) {
            this.usePotionIfEffective();
         }
      }
      
      private function usePotionIfEffective() : void {
         if(!this.isPlayerStatMaxed()) {
            this.sendServerRequest();
            SoundEffectLibrary.play("use_potion");
         }
      }
      
      private function isPlayerStatMaxed() : Boolean {
         if(this.potionId == 2594) {
            return this.player.hp_ >= this.player.maxHP_;
         }
         if(this.potionId == 2595) {
            return this.player.mp_ >= this.player.maxMP_;
         }
         return false;
      }
      
      private function sendServerRequest() : void {
         var _loc2_:int = PotionInventoryModel.getPotionSlot(this.vo.objectId);
         this.gsc.useItem(TimeUtil.getModdedTime(),this.player.objectId_,_loc2_,this.potionId,this.player.x_,this.player.y_,0);
      }
   }
}
