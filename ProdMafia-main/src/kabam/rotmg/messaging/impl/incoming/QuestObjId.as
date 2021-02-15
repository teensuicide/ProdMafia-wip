package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.CompressedInt;

public class QuestObjId extends IncomingMessage {
    public var objectId_:int;
    public var idk:Vector.<int>;

    public function QuestObjId(id:uint, callback:Function) {
        this.idk = new Vector.<int>();
        super(id, callback);
    }

    override public function parseFromInput(data:IDataInput) : void {
        this.objectId_ = data.readInt();
        var len:int = CompressedInt.read(data);
        for (var i:int = 0; i < len; i++) {
            this.idk.push(CompressedInt.read(data));
            trace("Quest" + i, this.idk[i]);
        }
    }

    override public function toString() : String {
        return formatToString("QUESTOBJID","objectId_", "idk");
    }
}
}
