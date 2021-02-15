package com.company.assembleegameclient.util.offer {
   public class Offers {
      
      private static const BEST_DEAL:String = "(Best deal)";
      
      private static const MOST_POPULAR:String = "(Most popular)";
       
      
      public var tok:String;
      
      public var exp:String;
      
      public var offerList:Vector.<Offer>;
      
      public function Offers(param1:XML) {
         super();
         this.tok = param1.Tok;
         this.exp = param1.Exp;
         this.makeOffers(param1);
      }
      
      private function makeOffers(param1:XML) : void {
         this.makeOfferList(param1);
         this.sortOfferList();
         this.defineBonuses();
         this.defineMostPopularTagline();
         this.defineBestDealTagline();
      }
      
      private function makeOfferList(param1:XML) : void {
         var _loc2_:* = null;
         this.offerList = new Vector.<Offer>(0);
         var _loc3_:* = param1.Offer;
         var _loc6_:int = 0;
         var _loc5_:* = param1.Offer;
         for each(_loc2_ in param1.Offer) {
            this.offerList.push(this.makeOffer(_loc2_));
         }
      }
      
      private function makeOffer(param1:XML) : Offer {
         var _loc2_:String = param1.Id;
         var _loc4_:Number = param1.Price;
         var _loc3_:int = param1.RealmGold;
         var _loc5_:String = param1.CheckoutJWT;
         var _loc7_:String = param1.Data;
         var _loc6_:String = "Currency" in param1?param1.Currency:null;
         return new Offer(_loc2_,_loc4_,_loc3_,_loc5_,_loc7_,_loc6_);
      }
      
      private function sortOfferList() : void {
         this.offerList.sort(this.sortOffers);
      }
      
      private function defineBonuses() : void {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this.offerList.length == 0) {
            return;
         }
         var _loc5_:int = this.offerList[0].realmGold_;
         var _loc1_:int = this.offerList[0].price_;
         var _loc3_:Number = _loc5_ / _loc1_;
         var _loc2_:int = 1;
         while(_loc2_ < this.offerList.length) {
            _loc4_ = this.offerList[_loc2_].realmGold_;
            _loc8_ = this.offerList[_loc2_].price_;
            _loc7_ = _loc8_ * _loc3_;
            _loc6_ = _loc4_ - _loc7_;
            this.offerList[_loc2_].bonus = _loc6_ / _loc8_;
            _loc2_++;
         }
      }
      
      private function sortOffers(param1:Offer, param2:Offer) : int {
         return param1.price_ - param2.price_;
      }
      
      private function defineMostPopularTagline() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.offerList;
         var _loc5_:int = 0;
         var _loc4_:* = this.offerList;
         for each(_loc3_ in this.offerList) {
            if(_loc3_.price_ == 10) {
               _loc3_.tagline = "(Most popular)";
            }
         }
      }
      
      private function defineBestDealTagline() : void {
         this.offerList[this.offerList.length - 1].tagline = "(Best deal)";
      }
   }
}
