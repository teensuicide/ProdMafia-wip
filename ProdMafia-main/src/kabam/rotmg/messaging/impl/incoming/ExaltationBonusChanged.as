package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   
   public class ExaltationBonusChanged extends IncomingMessage {
      private var objType:int;
      private var attackProgress:int;
      private var defenseProgress:int;
      private var speedProgress:int;
      private var dexterityProgress:int;
      private var vitalityProgress:int;
      private var wisdomProgress:int;
      private var healthProgress:int;
      private var manaProgress:int;
      
      public function ExaltationBonusChanged(id:uint, callback:Function) {
         super(id, callback);
      }
      
      override public function parseFromInput(data:IDataInput) : void {
         this.objType = data.readShort();
         this.dexterityProgress = data.readByte();
         this.speedProgress = data.readByte();
         this.vitalityProgress = data.readByte();
         this.wisdomProgress = data.readByte();
         this.defenseProgress = data.readByte();
         this.attackProgress = data.readByte();
         this.manaProgress = data.readByte();
         this.healthProgress = data.readByte();
      }
      
      override public function toString() : String {
         return formatToString("EXALTATION_BONUS_CHANGED", "objType",
                 "attackProgress", "defenseProgress", "speedProgress",
                 "dexterityProgress", "vitalityProgress", "wisdomProgress",
                 "healthProgress", "manaProgress");
      }
   }
}