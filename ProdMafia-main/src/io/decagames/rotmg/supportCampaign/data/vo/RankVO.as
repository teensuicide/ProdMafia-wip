package io.decagames.rotmg.supportCampaign.data.vo {
   public class RankVO {
       
      
      private var _points:int;
      
      private var _name:String;
      
      public function RankVO(param1:int, param2:String) {
         super();
         this._points = param1;
         this._name = param2;
      }
      
      public function get points() : int {
         return this._points;
      }
      
      public function get name() : String {
         return this._name;
      }
   }
}
