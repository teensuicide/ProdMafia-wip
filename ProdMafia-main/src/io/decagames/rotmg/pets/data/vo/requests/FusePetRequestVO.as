package io.decagames.rotmg.pets.data.vo.requests {
public class FusePetRequestVO implements IUpgradePetRequestVO {


    public function FusePetRequestVO(param1:int, param2:int, param3:int) {
        super();
        this.petInstanceIdOne = param1;
        this.petInstanceIdTwo = param2;
        this.paymentTransType = param3;
    }
    public var petInstanceIdOne:int;
    public var petInstanceIdTwo:int;
    public var paymentTransType:int;
}
}
