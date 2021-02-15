package io.decagames.rotmg.pets.data.vo.requests {
import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class FeedPetRequestVO implements IUpgradePetRequestVO {


    public function FeedPetRequestVO(param1:int, param2:Vector.<SlotObjectData>, param3:int) {
        super();
        this.petInstanceId = param1;
        this.slotObjects = param2;
        this.paymentTransType = param3;
    }
    public var petInstanceId:int;
    public var slotObjects:Vector.<SlotObjectData>;
    public var paymentTransType:int;
}
}
