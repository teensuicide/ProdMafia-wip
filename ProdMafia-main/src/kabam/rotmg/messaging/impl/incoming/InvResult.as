package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class InvResult extends IncomingMessage {
   public var result:Boolean;
   public var fromResultData:SlotObjectData;
   public var toResultData:SlotObjectData;

   public function InvResult(id:uint, callback:Function) {
      this.fromResultData = new SlotObjectData();
      this.toResultData = new SlotObjectData();
      super(id, callback);
   }

   override public function parseFromInput(data:IDataInput) : void {
      this.result = data.readBoolean();
      this.fromResultData.parseFromInput(data);
      this.toResultData.parseFromInput(data);
   }

   override public function toString() : String {
      return formatToString("INVRESULT", "result", "fromData", "toData");
   }
}
}
