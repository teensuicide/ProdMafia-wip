package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class ServerPlayerShoot extends IncomingMessage {
       
      
      public var bulletId_:uint;
      
      public var ownerId_:int;
      
      public var containerType_:int;
      
      public var startingPos_:WorldPosData;
      
      public var angle_:Number;
      
      public var damage_:int;
      
      public function ServerPlayerShoot(param1:uint, param2:Function) {
         this.startingPos_ = new WorldPosData();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void {
         this.bulletId_ = param1.readUnsignedByte();
         this.ownerId_ = param1.readInt();
         this.containerType_ = param1.readInt();
         this.startingPos_.parseFromInput(param1);
         this.angle_ = param1.readFloat();
         this.damage_ = param1.readShort();
      }
      
      override public function toString() : String {
         return formatToString("SHOOT","bulletId_","ownerId_","containerType_","startingPos_","angle_","damage_");
      }
   }
}
