package kabam.rotmg.messaging.impl.incoming {

import flash.utils.IDataInput;

public class ExaltationRedeemInfo extends IncomingMessage {
    public function ExaltationRedeemInfo(id:uint, callback:Function) {
        super(id, callback);
    }

    override public function parseFromInput(data:IDataInput) : void {
        // exists, failure->24, doesn't exist->29
        // 4-24 identical in both cases, all d.e. identical
    }

    override public function toString() : String {
        return formatToString("EXALTATION_REDEEM_INFO");
    }
}
}