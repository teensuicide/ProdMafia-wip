package com.company.assembleegameclient.objects.animation {
   import flash.display.BitmapData;
   
   public class Animations {
       
      
      public var animationsData_:AnimationsData;
      
      public var nextRun_:Vector.<int> = null;
      
      public var running_:RunningAnimation = null;
      
      public function Animations(param1:AnimationsData) {
         super();
         this.animationsData_ = param1;
      }
      
      public function getTexture(param1:int) : BitmapData {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = 0;
         if(this.nextRun_ == null) {
            this.nextRun_ = new Vector.<int>();
            _loc5_ = 0;
            _loc4_ = this.animationsData_.animations;
            var _loc11_:int = 0;
            var _loc10_:* = this.animationsData_.animations;
            for each(_loc7_ in this.animationsData_.animations) {
               this.nextRun_.push(_loc7_.getLastRun(param1));
            }
         }
         if(this.running_) {
            _loc6_ = this.running_.getTexture(param1);
            if(_loc6_) {
               return _loc6_;
            }
            this.running_ = null;
         }
         var _loc9_:uint = this.nextRun_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc9_) {
            _loc2_ = this.nextRun_[_loc8_];
            if(param1 > _loc2_) {
               _loc3_ = _loc2_;
               _loc7_ = this.animationsData_.animations[_loc8_];
               this.nextRun_[_loc8_] = _loc7_.getNextRun(param1);
               if(!(_loc7_.prob_ != 1 && Math.random() > _loc7_.prob_)) {
                  this.running_ = new RunningAnimation(_loc7_,_loc3_);
                  return this.running_.getTexture(param1);
               }
            }
            _loc8_++;
         }
         return null;
      }
   }
}

import com.company.assembleegameclient.objects.animation.AnimationData;
import com.company.assembleegameclient.objects.animation.FrameData;
import flash.display.BitmapData;

class RunningAnimation {
    
   
   public var animationData_:AnimationData;
   
   public var length_:uint;
   
   public var start_:int;
   
   public var frameId_:int;
   
   public var frameStart_:int;
   
   public var texture_:BitmapData;
   
   function RunningAnimation(param1:AnimationData, param2:int) {
      super();
      this.animationData_ = param1;
      this.length_ = this.animationData_.frames.length;
      this.start_ = param2;
      this.frameId_ = 0;
      this.frameStart_ = param2;
      this.texture_ = null;
   }
   
   public function getTexture(param1:int) : BitmapData {
      var _loc2_:FrameData = this.animationData_.frames[this.frameId_];
      while(param1 - this.frameStart_ > _loc2_.time_) {
         if(this.frameId_ >= this.length_ - 1) {
            return null;
         }
         this.frameStart_ = this.frameStart_ + _loc2_.time_;
         this.frameId_++;
         _loc2_ = this.animationData_.frames[this.frameId_];
         this.texture_ = null;
      }
      if(this.texture_ == null) {
         this.texture_ = _loc2_.textureData_.getTexture(Math.random() * 100);
      }
      return this.texture_;
   }
}
