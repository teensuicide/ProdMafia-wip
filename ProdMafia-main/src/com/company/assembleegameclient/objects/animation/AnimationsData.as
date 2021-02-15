package com.company.assembleegameclient.objects.animation {
   public class AnimationsData {
       
      
      public var animations:Vector.<AnimationData>;
      
      public function AnimationsData(param1:XML) {
         animations = new Vector.<AnimationData>();
         var _loc2_:* = null;
         super();
         var _loc3_:* = param1.Animation;
         var _loc6_:int = 0;
         var _loc5_:* = param1.Animation;
         for each(_loc2_ in param1.Animation) {
            this.animations.push(new AnimationData(_loc2_));
         }
      }
   }
}
