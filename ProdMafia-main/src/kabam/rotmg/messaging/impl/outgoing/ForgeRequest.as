package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class ForgeRequest extends OutgoingMessage {
   public var itemId:int;
   public var offers:Vector.<SlotObjectData>;

   public function ForgeRequest(id:uint, callback:Function) {
      this.offers = new Vector.<SlotObjectData>();
      super(id, callback);
   }

   override public function writeToOutput(data:IDataOutput) : void {
      data.writeInt(this.itemId);
      var offersLen:int = this.offers.length;
      data.writeInt(offersLen);
      for (var i:int = 0; i < offersLen; i++)
         this.offers[i].writeToOutput(data);
   }

   override public function toString() : String {
      return formatToString("FORGE_REQUEST", "itemId", "offers");
   }
}
}
