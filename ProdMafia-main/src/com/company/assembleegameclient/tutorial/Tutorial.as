package com.company.assembleegameclient.tutorial {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.PointUtil;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import kabam.rotmg.assets.EmbeddedData;
   
   public class Tutorial extends Sprite {
      
      public static const NEXT_ACTION:String = "Next";
      
      public static const MOVE_FORWARD_ACTION:String = "MoveForward";
      
      public static const MOVE_BACKWARD_ACTION:String = "MoveBackward";
      
      public static const ROTATE_LEFT_ACTION:String = "RotateLeft";
      
      public static const ROTATE_RIGHT_ACTION:String = "RotateRight";
      
      public static const MOVE_LEFT_ACTION:String = "MoveLeft";
      
      public static const MOVE_RIGHT_ACTION:String = "MoveRight";
      
      public static const UPDATE_ACTION:String = "Update";
      
      public static const ATTACK_ACTION:String = "Attack";
      
      public static const DAMAGE_ACTION:String = "Damage";
      
      public static const KILL_ACTION:String = "Kill";
      
      public static const SHOW_LOOT_ACTION:String = "ShowLoot";
      
      public static const TEXT_ACTION:String = "Text";
      
      public static const SHOW_PORTAL_ACTION:String = "ShowPortal";
      
      public static const ENTER_PORTAL_ACTION:String = "EnterPortal";
      
      public static const NEAR_REQUIREMENT:String = "Near";
      
      public static const EQUIP_REQUIREMENT:String = "Equip";
       
      
      public var gs_:GameSprite;
      
      public var steps_:Vector.<Step>;
      
      public var currStepId_:int = 0;
      
      private var darkBox_:Sprite;
      
      private var boxesBack_:Shape;
      
      private var boxes_:Shape;
      
      private var tutorialMessage_:TutorialMessage = null;
      
      private var lastTrackingStepTimestamp:uint;
      
      public function Tutorial(param1:GameSprite) {
         steps_ = new Vector.<Step>();
         darkBox_ = new Sprite();
         boxesBack_ = new Shape();
         boxes_ = new Shape();
         var _loc2_:* = null;
         var _loc3_:* = null;
         super();
         this.gs_ = param1;
         this.lastTrackingStepTimestamp = TimeUtil.getTrueTime();
         var _loc4_:* = EmbeddedData.tutorialXML.Step;
         var _loc7_:int = 0;
         var _loc6_:* = EmbeddedData.tutorialXML.Step;
         for each(_loc2_ in EmbeddedData.tutorialXML.Step) {
            this.steps_.push(new Step(_loc2_));
         }
         addChild(this.boxesBack_);
         addChild(this.boxes_);
         _loc3_ = this.darkBox_.graphics;
         _loc3_.clear();
         _loc3_.beginFill(0,0.1);
         _loc3_.drawRect(0,0,800,600);
         _loc3_.endFill();
         Parameters.data.needsTutorial = false;
         Parameters.save();
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      function doneAction(param1:String) : void {
         var _loc3_:* = undefined;
         var _loc8_:* = undefined;
         var _loc12_:* = undefined;
         var _loc11_:Boolean = false;
         var _loc2_:* = null;
         var _loc9_:Number = NaN;
         var _loc7_:* = null;
         var _loc10_:* = null;
         if(this.currStepId_ >= this.steps_.length) {
            return;
         }
         var _loc4_:Step = this.steps_[this.currStepId_];
         if(param1 != _loc4_.action_) {
            return;
         }
         var _loc6_:* = _loc4_.reqs_;
         var _loc16_:int = 0;
         var _loc15_:* = _loc4_.reqs_;
         while(true) {
            loop0:
            for each(_loc7_ in _loc4_.reqs_) {
               _loc10_ = this.gs_.map.player_;
               _loc3_ = _loc7_.type_;
               var _loc14_:* = _loc3_;
               switch(_loc14_) {
                  case "Near":
                     _loc11_ = false;
                     _loc3_ = 0;
                     _loc8_ = this.gs_.map.goDict_;
                     _loc14_ = 0;
                     var _loc13_:* = this.gs_.map.goDict_;
                     for each(_loc2_ in this.gs_.map.goDict_) {
                        if(_loc2_.objectType_ == _loc7_.objectType_) {
                           _loc9_ = PointUtil.distanceXY(_loc2_.x_,_loc2_.y_,_loc10_.x_,_loc10_.y_);
                           if(_loc9_ <= _loc7_.radius_) {
                              _loc11_ = true;
                              break;
                           }
                        }
                     }
                     if(_loc11_) {
                        continue;
                     }
                  case "Equip":
                     if(_loc10_.equipment_[_loc7_.slot_] != _loc7_.objectType_) {
                        break loop0;
                     }
                     continue;
                  default:
                     trace("ERROR: unrecognized req: " + _loc7_.type_);
                     continue;
               }
            }
            _loc12_ = this;
            this.currStepId_++;
            this.draw();
            return;
         }
      }
      
      private function draw() : void {
      }
      
      private function onAddedToStage(param1:Event) : void {
         addEventListener("enterFrame",this.onEnterFrame);
         this.draw();
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc5_:int = 0;
         var _loc7_:* = undefined;
         var _loc9_:* = undefined;
         var _loc18_:* = undefined;
         var _loc14_:int = 0;
         var _loc4_:* = undefined;
         var _loc16_:int = 0;
         var _loc17_:* = undefined;
         var _loc6_:int = 0;
         var _loc21_:* = null;
         var _loc12_:Boolean = false;
         var _loc10_:* = null;
         var _loc19_:int = 0;
         var _loc11_:* = null;
         var _loc2_:* = null;
         var _loc13_:* = null;
         var _loc3_:Boolean = false;
         var _loc15_:* = null;
         var _loc8_:Number = NaN;
         var _loc20_:Number = Math.abs(Math.sin(TimeUtil.getTrueTime() / 300));
         this.boxesBack_.filters = [new BlurFilter(5 + _loc20_ * 5,5 + _loc20_ * 5)];
         this.boxes_.graphics.clear();
         this.boxesBack_.graphics.clear();
         _loc6_ = 0;
         while(_loc6_ < this.steps_.length) {
            _loc21_ = this.steps_[_loc6_];
            _loc12_ = true;
            _loc5_ = 0;
            _loc7_ = _loc21_.reqs_;
            var _loc25_:int = 0;
            var _loc24_:* = _loc21_.reqs_;
            for each(_loc10_ in _loc21_.reqs_) {
               _loc13_ = this.gs_.map.player_;
               _loc9_ = _loc10_.type_;
               if("Near" !== _loc9_) {
                  trace("ERROR: unrecognized req: " + _loc10_.type_);
               } else {
                  _loc3_ = false;
                  _loc9_ = 0;
                  _loc18_ = this.gs_.map.goDict_;
                  var _loc23_:int = 0;
                  var _loc22_:* = this.gs_.map.goDict_;
                  for each(_loc15_ in this.gs_.map.goDict_) {
                     if(!(_loc15_.objectType_ != _loc10_.objectType_ || _loc10_.objectName_ != "" && _loc15_.name_ != _loc10_.objectName_)) {
                        _loc8_ = PointUtil.distanceXY(_loc15_.x_,_loc15_.y_,_loc13_.x_,_loc13_.y_);
                        if(_loc8_ <= _loc10_.radius_) {
                           _loc3_ = true;
                           break;
                        }
                     }
                  }
                  if(!_loc3_) {
                     _loc12_ = false;
                  }
               }
            }
            if(!_loc12_) {
               _loc21_.satisfiedSince_ = 0;
            } else {
               if(_loc21_.satisfiedSince_ == 0) {
                  _loc21_.satisfiedSince_ = TimeUtil.getTrueTime();
               }
               _loc19_ = TimeUtil.getTrueTime() - _loc21_.satisfiedSince_;
               _loc14_ = 0;
               _loc4_ = _loc21_.uiDrawBoxes_;
               var _loc27_:int = 0;
               var _loc26_:* = _loc21_.uiDrawBoxes_;
               for each(_loc11_ in _loc21_.uiDrawBoxes_) {
                  _loc11_.draw(5 * _loc20_,this.boxes_.graphics,_loc19_);
                  _loc11_.draw(6 * _loc20_,this.boxesBack_.graphics,_loc19_);
               }
               _loc16_ = 0;
               _loc17_ = _loc21_.uiDrawArrows_;
               var _loc29_:int = 0;
               var _loc28_:* = _loc21_.uiDrawArrows_;
               for each(_loc2_ in _loc21_.uiDrawArrows_) {
                  _loc2_.draw(5 * _loc20_,this.boxes_.graphics,_loc19_);
                  _loc2_.draw(6 * _loc20_,this.boxesBack_.graphics,_loc19_);
               }
            }
            _loc6_++;
         }
      }
   }
}
