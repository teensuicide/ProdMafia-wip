package com.company.assembleegameclient.objects.animation {
   public class AnimationData {
       
      
      public var prob_:Number = 1;
      
      public var period_:int;
      
      public var periodJitter_:int;
      
      public var sync_:Boolean = false;
      
      public var frames:Vector.<FrameData>;
      
      public function AnimationData(param1:XML) {
         frames = new Vector.<FrameData>();
         var _loc2_:* = null;
         super();
         if("@prob" in param1) {
            this.prob_ = Number(param1.@prob);
         }
         this.period_ = param1.@period * 1000;
         this.periodJitter_ = param1.@periodJitter * 1000;
         this.sync_ = String(param1.@sync) == "true";
         var _loc3_:* = param1.Frame;
         var _loc6_:int = 0;
         var _loc5_:* = param1.Frame;
         for each(_loc2_ in param1.Frame) {
            this.frames.push(new FrameData(_loc2_));
         }
      }
      
      public function getLastRun(param1:int) : int {
         if(this.sync_) {
            return int(param1 / this.period_) * this.period_;
         }
         return param1 + this.getPeriod() + 200 * Math.random();
      }
      
      public function getNextRun(param1:int) : int {
         if(this.sync_) {
            return int(param1 / this.period_) * this.period_ + this.period_;
         }
         return param1 + this.getPeriod();
      }
      
      private function getPeriod() : int {
         if(this.periodJitter_ == 0) {
            return this.period_;
         }
         return this.period_ - this.periodJitter_ + 2 * Math.random() * this.periodJitter_;
      }
   }
}
