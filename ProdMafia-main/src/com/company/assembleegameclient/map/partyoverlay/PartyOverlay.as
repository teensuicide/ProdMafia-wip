package com.company.assembleegameclient.map.partyoverlay {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.objects.Party;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PartyOverlay extends Sprite {
       
      
      public var map_:Map;
      
      public var partyMemberArrows_:Vector.<PlayerArrow> = null;
      
      public var questArrow_:QuestArrow;
      
      public function PartyOverlay(param1:Map) {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         super();
         this.map_ = param1;
         this.partyMemberArrows_ = new Vector.<PlayerArrow>(6,true);
         while(_loc2_ < 6) {
            _loc3_ = new PlayerArrow();
            this.partyMemberArrows_[_loc2_] = _loc3_;
            addChild(_loc3_);
            _loc2_++;
         }
         this.questArrow_ = new QuestArrow(this.map_);
         addChild(this.questArrow_);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      public function draw(param1:Camera, param2:int) : void {
         var _loc11_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc6_:* = null;
         if(this.map_.player_ == null) {
            return;
         }
         var _loc4_:Party = this.map_.party_;
         var _loc9_:uint = _loc4_.members_.length;
         _loc3_ = 0;
         while(_loc3_ < 6) {
            _loc8_ = this.partyMemberArrows_[_loc3_];
            if(!_loc8_.mouseOver_) {
               if(_loc3_ >= _loc9_) {
                  _loc8_.setGameObject(null);
               } else {
                  _loc10_ = _loc4_.members_[_loc3_];
                  if(_loc10_.drawn_ || _loc10_.map_ == null || _loc10_.dead_) {
                     _loc8_.setGameObject(null);
                  } else {
                     _loc8_.setGameObject(_loc10_);
                     _loc7_ = 0;
                     while(_loc7_ < _loc3_) {
                        _loc6_ = this.partyMemberArrows_[_loc7_];
                        _loc11_ = _loc8_.x - _loc6_.x;
                        _loc5_ = _loc8_.y - _loc6_.y;
                        if(_loc11_ * _loc11_ + _loc5_ * _loc5_ < 64) {
                           if(!_loc6_.mouseOver_) {
                              _loc6_.addGameObject(_loc10_);
                           }
                           _loc8_.setGameObject(null);
                           break;
                        }
                        _loc7_++;
                     }
                     _loc8_.draw(param2,param1);
                  }
               }
            }
            _loc3_++;
         }
         if(!this.questArrow_.mouseOver_) {
            this.questArrow_.draw(param2,param1);
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         GameObjectArrow.removeMenu();
      }
   }
}
