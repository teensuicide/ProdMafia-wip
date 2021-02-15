package kabam.rotmg.account.web.services {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.PaymentMethod;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.PaymentData;
   import kabam.rotmg.account.core.model.OfferModel;
   import kabam.rotmg.account.core.services.MakePaymentTask;
   
   public class WebMakePaymentTask extends BaseTask implements MakePaymentTask {
       
      
      [Inject]
      public var data:PaymentData;
      
      [Inject]
      public var model:OfferModel;
      
      public function WebMakePaymentTask() {
         super();
      }
      
      override protected function startTask() : void {
         Parameters.data.paymentMethod = this.data.paymentMethod;
         Parameters.save();
         var _loc2_:PaymentMethod = PaymentMethod.getPaymentMethodByLabel(this.data.paymentMethod);
         var _loc1_:String = _loc2_.getURL(this.model.offers.tok,this.model.offers.exp,this.data.offer);
         navigateToURL(new URLRequest(_loc1_),"_blank");
         completeTask(true);
      }
   }
}
