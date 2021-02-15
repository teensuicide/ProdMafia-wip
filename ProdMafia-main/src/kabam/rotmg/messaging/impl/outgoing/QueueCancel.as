package kabam.rotmg.messaging.impl.outgoing {
import com.company.assembleegameclient.parameters.Parameters;

import flash.utils.IDataOutput;
public class QueueCancel extends OutgoingMessage {
   public var objectId:int;

   public function QueueCancel(id:uint, callback:Function) {
      super(id, callback);
   }

   override public function writeToOutput(data:IDataOutput) : void {
      data.writeInt(this.objectId);
   }

   override public function toString() : String {
      return formatToString("QUEUE_CANCEL", "objectId");
   }
}
}