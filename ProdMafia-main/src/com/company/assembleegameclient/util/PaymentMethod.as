package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.util.offer.Offer;
   import flash.net.URLVariables;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.application.api.ApplicationSetup;
   import kabam.rotmg.core.StaticInjectorContext;
   
   public class PaymentMethod {
      
      public static const GO_METHOD:PaymentMethod = new PaymentMethod("Payments.GoogleCheckout","co","");
      
      public static const PAYPAL_METHOD:PaymentMethod = new PaymentMethod("Payments.Paypal","ps","P3");
      
      public static const CREDITS_METHOD:PaymentMethod = new PaymentMethod("Payments.CreditCards","ps","CH");
      
      public static const PAYMENT_METHODS:Vector.<PaymentMethod> = new <PaymentMethod>[GO_METHOD,PAYPAL_METHOD,CREDITS_METHOD];
       
      
      public var label_:String;
      
      public var provider_:String;
      
      public var paymentid_:String;
      
      public function PaymentMethod(param1:String, param2:String, param3:String) {
         super();
         this.label_ = param1;
         this.provider_ = param2;
         this.paymentid_ = param3;
      }
      
      public static function getPaymentMethodByLabel(param1:String) : PaymentMethod {
         var _loc2_:* = null;
         var _loc3_:* = PAYMENT_METHODS;
         var _loc6_:int = 0;
         var _loc5_:* = PAYMENT_METHODS;
         for each(_loc2_ in PAYMENT_METHODS) {
            if(_loc2_.label_ == param1) {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getURL(param1:String, param2:String, param3:Offer) : String {
         var _loc6_:Account = StaticInjectorContext.getInjector().getInstance(Account);
         var _loc4_:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
         var _loc7_:URLVariables = new URLVariables();
         _loc7_["tok"] = param1;
         _loc7_["exp"] = param2;
         _loc7_["guid"] = _loc6_.getUserId();
         _loc7_["provider"] = this.provider_;
         var _loc5_:* = this.provider_;
         var _loc8_:* = _loc5_;
         switch(_loc8_) {
            case "co":
               _loc7_["jwt"] = param3.jwt_;
               break;
            case "ps":
               _loc7_["jwt"] = param3.jwt_;
               _loc7_["price"] = param3.price_.toString();
               _loc7_["paymentid"] = this.paymentid_;
         }
         return _loc4_.getAppEngineUrl(true) + "/credits/add?" + _loc7_.toString();
      }
   }
}
