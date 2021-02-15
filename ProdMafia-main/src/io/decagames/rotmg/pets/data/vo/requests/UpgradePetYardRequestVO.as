package io.decagames.rotmg.pets.data.vo.requests {
public class UpgradePetYardRequestVO implements IUpgradePetRequestVO {


    public function UpgradePetYardRequestVO(param1:int, param2:int) {
        super();
        this.objectID = param1;
        this.paymentTransType = param2;
    }
    public var objectID:int;
    public var paymentTransType:int;
}
}
