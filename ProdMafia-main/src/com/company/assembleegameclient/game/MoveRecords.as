package com.company.assembleegameclient.game {
   import kabam.rotmg.messaging.impl.data.MoveRecord;
   
   public class MoveRecords {
       
      
      public var lastClearTime_:int = -1;
      
      public var records_:Vector.<MoveRecord>;
      
      public function MoveRecords() {
         records_ = new Vector.<MoveRecord>();
         super();
      }
      
      public function addRecord(param1:int, param2:Number, param3:Number) : void {
         if(this.lastClearTime_ < 0) {
            return;
         }
         var _loc7_:int = this.getId(param1);
         if(_loc7_ < 1 || _loc7_ > 10) {
            return;
         }
         if(this.records_.length == 0) {
            this.records_.push(new MoveRecord(param1,param2,param3));
            return;
         }
         var _loc4_:MoveRecord = this.records_[this.records_.length - 1];
         var _loc5_:int = this.getId(_loc4_.time_);
         if(_loc7_ != _loc5_) {
            this.records_.push(new MoveRecord(param1,param2,param3));
            return;
         }
         var _loc8_:int = this.getScore(_loc7_,param1);
         var _loc6_:int = this.getScore(_loc7_,_loc4_.time_);
         if(_loc8_ < _loc6_) {
            _loc4_.time_ = param1;
            _loc4_.x_ = param2;
            _loc4_.y_ = param3;
         }
      }
      
      public function clear(param1:int) : void {
         this.records_.length = 0;
         this.lastClearTime_ = param1;
      }
      
      private function getId(param1:int) : int {
         return (param1 - this.lastClearTime_ + 50) / 100;
      }
      
      private function getScore(param1:int, param2:int) : int {
         return Math.abs(param2 - this.lastClearTime_ - param1 * 100);
      }
   }
}
