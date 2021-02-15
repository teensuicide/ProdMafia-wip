package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.CompressedInt;
   
   public class VaultContent extends IncomingMessage {
       
      
      public var vaultContents:Vector.<int>;
      
      public var giftContents:Vector.<int>;
      
      public var potionContents:Vector.<int>;
      
      public var vaultUpgradeCost:int;
      
      public var potionUpgradeCost:int;
      
      public var currentPotionMax:int;
      
      public var nextPotionMax:int;
      
      public function VaultContent(param1:uint, param2:Function) {
         this.vaultContents = new Vector.<int>();
         this.giftContents = new Vector.<int>();
         this.potionContents = new Vector.<int>();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void {
         var _loc4_:int = 0;
         CompressedInt.read(param1);
         CompressedInt.read(param1);
         CompressedInt.read(param1);
         CompressedInt.read(param1);
         var _loc3_:int = CompressedInt.read(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc3_) {
            this.vaultContents.push(CompressedInt.read(param1));
            _loc4_++;
         }
         var _loc5_:int = CompressedInt.read(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc5_) {
            this.giftContents.push(CompressedInt.read(param1));
            _loc4_++;
         }
         var _loc2_:int = CompressedInt.read(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_) {
            this.potionContents.push(CompressedInt.read(param1));
            _loc4_++;
         }
         this.vaultUpgradeCost = param1.readShort();
         this.potionUpgradeCost = param1.readShort();
         this.currentPotionMax = param1.readShort();
         this.nextPotionMax = param1.readShort();
      }
      
      override public function toString() : String {
         return formatToString("VAULT_CONTENT","vaultContents","giftContents","potionContents","vaultUpgradeCost","potionUpgradeCost","currentPotionMax","nextPotionMax");
      }
   }
}
