package kabam.rotmg.account.web.services {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.PaymentMethod;
   import com.company.assembleegameclient.util.offer.Offer;
   import com.company.assembleegameclient.util.offer.Offers;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.model.OfferModel;
   import kabam.rotmg.account.core.services.PurchaseGoldTask;
   
   public class WebPurchaseGoldTask extends BaseTask implements PurchaseGoldTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var offer:Offer;
      
      [Inject]
      public var offersModel:OfferModel;
      
      [Inject]
      public var paymentMethod:String;
      
      public function WebPurchaseGoldTask() {
         super();
      }
      
      override protected function startTask() : void {
         Parameters.data.paymentMethod = this.paymentMethod;
         Parameters.save();
         var _loc2_:Offers = this.offersModel.offers;
         var _loc1_:PaymentMethod = PaymentMethod.getPaymentMethodByLabel(this.paymentMethod);
         var _loc3_:String = _loc1_.getURL(_loc2_.tok,_loc2_.exp,this.offer);
         navigateToURL(new URLRequest(_loc3_),"_blank");
         completeTask(true);
      }
   }
}
