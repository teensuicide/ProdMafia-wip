package kabam.rotmg.account.core.model {
   import com.company.assembleegameclient.util.offer.Offers;
   
   public class OfferModel {
      
      public static const TIME_BETWEEN_REQS:int = 300000;
       
      
      public var lastOfferRequestTime:int;
      
      public var lastOfferRequestGUID:String;
      
      public var offers:Offers;
      
      public function OfferModel() {
         super();
      }
   }
}
