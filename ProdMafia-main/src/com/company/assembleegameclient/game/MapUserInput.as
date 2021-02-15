package com.company.assembleegameclient.game {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.assembleegameclient.util.TimeUtil;
import com.company.util.PointUtil;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;
import flash.system.Capabilities;
import flash.utils.Timer;

import io.decagames.rotmg.social.SocialPopupView;
import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.lib.net.impl.SocketServerModel;

import kabam.rotmg.chat.control.ParseChatMessageSignal;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.ui.model.TabStripModel;
import kabam.rotmg.ui.signals.EnterGameSignal;
import kabam.rotmg.ui.signals.ToggleRealmQuestsDisplaySignal;

import net.hires.debug.Stats;

import org.swiftsuspenders.Injector;

import flash.geom.Point;

import flash.utils.Timer;


public class MapUserInput {

   public static var stats_:Stats = new Stats();

   [Inject]
   public var msgSignal:ParseChatMessageSignal;

   public var gs:GameSprite;

   public var followPos:Point;

   public var mouseDown_:Boolean = false;

   public var autofire_:Boolean = false;

   public var held:Boolean = false;

   public var heldX:int = 0;

   public var heldY:int = 0;

   public var heldAngle:Number = 0;

   public var useBuyPotionSignal:UseBuyPotionSignal;

   private var moveLeft_:Boolean = false;

   public var moveRecords_:MoveRecords;

   private var moveRight_:Boolean = false;

   private var moveUp_:Boolean = false;

   private var moveDown_:Boolean = false;

   private var isWalking:Boolean = false;

   private var rotateLeft_:Boolean = false;

   private var rotateRight_:Boolean = false;

   private var specialKeyDown_:Boolean = false;

   private var enablePlayerInput_:Boolean = true;

   private var giftStatusUpdateSignal:GiftStatusUpdateSignal;

   private var addTextLine:AddTextLineSignal;

   private var setTextBoxVisibility:SetTextBoxVisibilitySignal;

   private var statsTabHotKeyInputSignal:StatsTabHotKeyInputSignal;

   private var toggleRealmQuestsDisplaySignal:ToggleRealmQuestsDisplaySignal;

   private var miniMapZoom:MiniMapZoomSignal;

   private var potionInventoryModel:PotionInventoryModel;

   private var openDialogSignal:OpenDialogSignal;

   private var closeDialogSignal:CloseDialogsSignal;

   private var closePopupByClassSignal:ClosePopupByClassSignal;

   private var tabStripModel:TabStripModel;

   private var layers:Layers;

   private var exitGame:ExitGameSignal;

   private var isFriendsListOpen:Boolean;

   public var delayTimer:Timer;
   private var timer:Timer;

   public function MapUserInput(param1:GameSprite) {
      super();
      this.gs = param1;
      this.gs.addEventListener("addedToStage",this.onAddedToStage,false,0,true);
      this.gs.addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      var _loc2_:Injector = StaticInjectorContext.getInjector();
      this.giftStatusUpdateSignal = _loc2_.getInstance(GiftStatusUpdateSignal);
      this.addTextLine = _loc2_.getInstance(AddTextLineSignal);
      this.setTextBoxVisibility = _loc2_.getInstance(SetTextBoxVisibilitySignal);
      this.miniMapZoom = _loc2_.getInstance(MiniMapZoomSignal);
      this.useBuyPotionSignal = _loc2_.getInstance(UseBuyPotionSignal);
      this.potionInventoryModel = _loc2_.getInstance(PotionInventoryModel);
      this.tabStripModel = _loc2_.getInstance(TabStripModel);
      this.layers = _loc2_.getInstance(Layers);
      this.statsTabHotKeyInputSignal = _loc2_.getInstance(StatsTabHotKeyInputSignal);
      this.toggleRealmQuestsDisplaySignal = _loc2_.getInstance(ToggleRealmQuestsDisplaySignal);
      this.exitGame = _loc2_.getInstance(ExitGameSignal);
      this.openDialogSignal = _loc2_.getInstance(OpenDialogSignal);
      this.closeDialogSignal = _loc2_.getInstance(CloseDialogsSignal);
      this.closePopupByClassSignal = _loc2_.getInstance(ClosePopupByClassSignal);
      this.msgSignal = _loc2_.getInstance(ParseChatMessageSignal);
   }

   public static function addIgnore(param1:int) : String {
      var _loc2_:* = null;
      var _loc5_:int = 0;
      var _loc4_:* = Parameters.data.AAIgnore;
      for each(var _loc3_ in Parameters.data.AAIgnore) {
         if(_loc3_ == param1) {
            return param1 + " already exists in Ignore list";
         }
      }
      if(param1 in ObjectLibrary.propsLibrary_) {
         Parameters.data.AAIgnore.push(param1);
         _loc2_ = ObjectLibrary.propsLibrary_[param1];
         _loc2_.ignored = true;
         return "Successfully added " + param1 + " to Ignore list";
      }
      return "Failed to add " + param1 + " to Ignore list (no known object with this itemType)";
   }

   public static function remIgnore(param1:int) : String {
      var _loc4_:int = 0;
      var _loc2_:* = null;
      var _loc3_:uint = Parameters.data.AAIgnore.length;
      _loc4_ = 0;
      while(_loc4_ < _loc3_) {
         if(Parameters.data.AAIgnore[_loc4_] == param1) {
            Parameters.data.AAIgnore.splice(_loc4_,1);
            if(param1 in ObjectLibrary.propsLibrary_) {
               _loc2_ = ObjectLibrary.propsLibrary_[param1];
               _loc2_.ignored = false;
            }
            return "Successfully removed " + param1 + " from Ignore list";
         }
         _loc4_++;
      }
      return param1 + " not found in Ignore list";
   }

   public function clearInput() : void {
      this.moveLeft_ = false;
      this.moveRight_ = false;
      this.moveUp_ = false;
      this.moveDown_ = false;
      this.isWalking = false;
      this.rotateLeft_ = false;
      this.rotateRight_ = false;
      this.mouseDown_ = false;
      this.autofire_ = false;
      this.setPlayerMovement();
   }

   public function setEnablePlayerInput(param1:Boolean) : void {
      if(this.enablePlayerInput_ != param1) {
         this.enablePlayerInput_ = param1;
         this.clearInput();
      }
   }

   public function teleQuest(param1:Player) : void {
      var _loc3_:* = NaN;
      var _loc4_:int = 0;
      var _loc5_:Number = NaN;
      var _loc7_:* = null;
      var _loc2_:int = gs.map.quest_.objectId_;
      if(_loc2_ > 0) {
         _loc7_ = gs.map.quest_.getObject(_loc2_);
         if(_loc7_) {
            _loc3_ = Infinity;
            _loc4_ = -1;
            var _loc9_:int = 0;
            var _loc8_:* = this.gs.map.goDict_;
            for each(var _loc6_ in this.gs.map.goDict_) {
               if(_loc6_ is Player && !_loc6_.isInvisible && !_loc6_.isPaused) {
                  _loc5_ = (_loc6_.x_ - _loc7_.x_) * (_loc6_.x_ - _loc7_.x_) + (_loc6_.y_ - _loc7_.y_) * (_loc6_.y_ - _loc7_.y_);
                  if(_loc5_ < _loc3_) {
                     _loc3_ = _loc5_;
                     _loc4_ = _loc6_.objectId_;
                  }
               }
            }
            if(_loc4_ == param1.objectId_) {
               param1.textNotification("You are closest!",16777215,1500,false);
            } else {
               this.gs.gsc_.teleport(_loc4_);
               param1.textNotification("Teleporting to " + this.gs.map.goDict_[_loc4_].name_,16777215,1500,false);
            }
         }
      } else {
         param1.textNotification("You have no quest!",16777215,1500,false);
      }
   }

   public function selectAimMode() : void {
      var _loc2_:String = "";
      var _loc1_:int = (Parameters.data.aimMode + 1) % 4;
      switch(int(_loc1_)) {
         case 0:
            _loc2_ = "AimMode: Mouse";
            break;
         case 1:
            _loc2_ = "AimMode: Health";
            break;
         case 2:
            _loc2_ = "AimMode: Closest";
            break;
         case 3:
            _loc2_ = "AimMode: Random";
      }
      if(this.gs && this.gs.map && this.gs.map.player_) {
         this.gs.map.player_.textNotification(_loc2_,16777215,2000,false);
      }
      Parameters.data.aimMode = _loc1_;
   }

   private function fixJoystick(param1:Vector3D) : Vector3D {
      var _loc2_:Number = param1.length;
      if(_loc2_ < 0.2) {
         param1.x = 0;
         param1.y = 0;
      } else {
         param1.normalize();
         param1.scaleBy((_loc2_ - 0.2) / 0.8);
      }
      return param1;
   }

   private function setPlayerMovement() : void {
      var _loc1_:Player = this.gs.map.player_;
      if(_loc1_) {
         if(this.enablePlayerInput_) {
            _loc1_.setRelativeMovement((!!this.rotateRight_?1:0) - (!!this.rotateLeft_?1:0),(!!this.moveRight_?1:0) - (!!this.moveLeft_?1:0),(!!this.moveDown_?1:0) - (!!this.moveUp_?1:0));
         } else {
            _loc1_.setRelativeMovement(0,0,0);
         }
         _loc1_.isWalking = this.isWalking;
      }
   }

   private function useItem(itemId:int) : void {
      if (this.tabStripModel.currentSelection == "Backpack")
         itemId += 8;

      this.gs.gsc_.useItem_new(this.gs.map.player_, itemId);
   }

   private function togglePerformanceStats() : void {
      if(Parameters.data.liteMonitor) {
         if(this.gs.stats) {
            this.gs.stats.visible = false;
            this.gs.stats = null;
         } else {
            this.gs.addStats();
            this.gs.statsStart = TimeUtil.getTrueTime();
            this.gs.stage.dispatchEvent(new Event("resize"));
         }
      } else if(this.gs.contains(stats_)) {
         this.gs.removeChild(stats_);
         this.gs.removeChild(this.gs.gsc_.jitterWatcher_);
         this.gs.gsc_.disableJitterWatcher();
      } else {
         this.gs.addChild(stats_);
         this.gs.gsc_.enableJitterWatcher();
         this.gs.gsc_.jitterWatcher_.y = stats_.height;
         this.gs.addChild(this.gs.gsc_.jitterWatcher_);
      }
      Parameters.data.perfStats = !Parameters.data.perfStats;
      Parameters.save();
   }

   public function onMiddleClick(param1:MouseEvent) : void {
      var _loc5_:* = NaN;
      var _loc6_:Number = NaN;
      var _loc2_:* = null;
      var _loc3_:* = null;
      if(this.gs.map) {
         _loc2_ = this.gs.map.player_.sToW(this.gs.map.mouseX,this.gs.map.mouseY);
         _loc5_ = Infinity;
         var _loc8_:int = 0;
         var _loc7_:* = this.gs.map.goDict_;
         for each(var _loc4_ in this.gs.map.goDict_) {
            if(_loc4_.props_.isEnemy_) {
               _loc6_ = PointUtil.distanceSquaredXY(_loc4_.x_,_loc4_.y_,_loc2_.x,_loc2_.y);
               if(_loc6_ < _loc5_) {
                  _loc5_ = _loc6_;
                  _loc3_ = _loc4_;
               }
            }
         }
         if(_loc3_) {
            this.gs.map.quest_.setObject(_loc3_.objectId_);
         }
      }
   }

   public function onRightMouseDown_forWorld(param1:MouseEvent) : void {
      if(Parameters.data.rightClickOption == "Quest") {
         Parameters.questFollow = true;
      } else if(Parameters.data.rightClickOption == "Ability") {
         this.gs.map.player_.sbAssist(this.gs.map.mouseX,this.gs.map.mouseY);
      } else if(Parameters.data.rightClickOption == "Camera") {
         held = true;
         heldX = Main.STAGE.mouseX;
         heldY = Main.STAGE.mouseY;
         heldAngle = Parameters.data.cameraAngle;
      }
   }

   public function onRightMouseUp_forWorld(param1:MouseEvent) : void {
      Parameters.questFollow = false;
      held = false;
   }

   public function onRightMouseDown(param1:MouseEvent) : void {
   }

   public function onRightMouseUp(param1:MouseEvent) : void {
   }

   public function onMouseDown(param1:MouseEvent) : void {
      var _loc6_:Number = NaN;
      var _loc4_:int = 0;
      var _loc3_:* = null;
      var _loc2_:Number = NaN;
      var _loc7_:Number = NaN;
      var _loc5_:Player = this.gs.map.player_;
      if(param1.target.name == null) {
         this.mouseDown_ = true;
      }
      if(_loc5_ == null) {
         return;
      }
      if(!this.enablePlayerInput_) {
         return;
      }
      if(param1.shiftKey) {
         _loc4_ = _loc5_.equipment_[1];
         if(_loc4_ == -1) {
            return;
         }
         _loc3_ = ObjectLibrary.xmlLibrary_[_loc4_];
         if(_loc3_ == null || "EndMpCost" in _loc3_) {
            return;
         }
         if(_loc5_.isUnstable) {
            _loc2_ = Math.random() * 600 - this.gs.map.x;
            _loc7_ = Math.random() * 600 - this.gs.map.y;
         } else {
            _loc2_ = this.gs.map.mouseX;
            _loc7_ = this.gs.map.mouseY;
         }
         if(param1.target.name == null) {
            _loc5_.useAltWeapon(_loc2_,_loc7_,1);
         }
         return;
      }
      if(param1.target.name == null) {
         if(_loc5_.isUnstable) {
            _loc5_.attemptAttackAngle(Math.random() * 6.28318530717959);
         } else {
            _loc5_.attemptAttackAngle(Math.atan2(this.gs.map.mouseY,this.gs.map.mouseX));
         }
      }
   }

   public function onMouseUp(param1:MouseEvent) : void {
      this.mouseDown_ = false;
      var _loc2_:Player = this.gs.map.player_;
      if(_loc2_ == null) {
         return;
      }
      _loc2_.isShooting = false;
   }

   private function onAddedToStage(param1:Event) : void {
      var _loc2_:Stage = this.gs.stage;
      _loc2_.addEventListener("activate",this.onActivate,false,0,true);
      _loc2_.addEventListener("deactivate",this.onDeactivate,false,0,true);
      _loc2_.addEventListener("keyDown",this.onKeyDown,false,0,true);
      _loc2_.addEventListener("keyUp",this.onKeyUp,false,0,true);
      _loc2_.addEventListener("mouseWheel",this.onMouseWheel,false,0,true);
      _loc2_.addEventListener("mouseDown",this.onMouseDown,false,0,true);
      _loc2_.addEventListener("mouseUp",this.onMouseUp,false,0,true);
      _loc2_.addEventListener("rightMouseDown",this.onRightMouseDown_forWorld,false,0,true);
      _loc2_.addEventListener("rightMouseUp",this.onRightMouseUp_forWorld,false,0,true);
      _loc2_.addEventListener("enterFrame",this.onEnterFrame,false,0,true);
      _loc2_.addEventListener("rightMouseDown",this.onRightMouseDown,false,0,true);
      _loc2_.addEventListener("rightMouseUp",this.onRightMouseUp,false,0,true);
   }

   private function onRemovedFromStage(param1:Event) : void {
      var _loc2_:Stage = this.gs.stage;
      _loc2_.removeEventListener("activate",this.onActivate);
      _loc2_.removeEventListener("deactivate",this.onDeactivate);
      _loc2_.removeEventListener("keyDown",this.onKeyDown);
      _loc2_.removeEventListener("keyUp",this.onKeyUp);
      _loc2_.removeEventListener("mouseWheel",this.onMouseWheel);
      _loc2_.removeEventListener("mouseDown",this.onMouseDown);
      _loc2_.removeEventListener("mouseUp",this.onMouseUp);
      _loc2_.removeEventListener("rightMouseDown",this.onRightMouseDown_forWorld);
      _loc2_.removeEventListener("rightMouseUp",this.onRightMouseUp_forWorld);
      _loc2_.removeEventListener("enterFrame",this.onEnterFrame);
      _loc2_.removeEventListener("rightMouseDown",this.onRightMouseDown);
      _loc2_.removeEventListener("rightMouseUp",this.onRightMouseUp);
   }

   private function onActivate(param1:Event) : void {
   }

   private function onDeactivate(param1:Event) : void {
      this.clearInput();
   }

   private function onMouseWheel(param1:MouseEvent) : void {
      if(param1.delta > 0) {
         this.miniMapZoom.dispatch("IN");
      } else {
         this.miniMapZoom.dispatch("OUT");
      }
   }

   private function onEnterFrame(param1:Event) : void {
      var _loc2_:Number = NaN;
      var _loc3_:Player = this.gs.map.player_;
      if (_loc3_) {
         _loc3_.mousePos_.x = this.gs.map.mouseX;
         _loc3_.mousePos_.y = this.gs.map.mouseY;
         if (this.enablePlayerInput_) {
            if (this.mouseDown_) {
               if (!_loc3_.isUnstable) {
                  _loc2_ = Math.atan2(this.gs.map.mouseY, this.gs.map.mouseX);
                  _loc3_.attemptAttackAngle(_loc2_);
                  _loc3_.attemptAutoAbility(_loc2_);
               } else {
                  _loc2_ = Math.random() * 6.28318530717959;
                  _loc3_.attemptAttackAngle(_loc2_);
                  _loc3_.attemptAutoAbility(_loc2_);
               }
            } else if (Parameters.data.AAOn || this.autofire_ || Parameters.data.AutoAbilityOn) {
               if (!_loc3_.isUnstable) {
                  _loc2_ = Math.atan2(this.gs.map.mouseY, this.gs.map.mouseX);
                  _loc3_.attemptAutoAim(_loc2_);
               } else {
                  _loc3_.attemptAutoAim(Math.random() * 6.28318530717959);
               }
            }
         }
      }
   }

   private function onKeyDown(param1:KeyboardEvent) : void {
      var _loc11_:* = null;
      var _loc18_:int = 0;
      _loc11_ = null;
      nonEmpty = undefined;
      var _loc22_:* = undefined;
      var _loc4_:* = null;
      var _loc7_:Number = NaN;
      var _loc23_:Number = NaN;
      var _loc3_:Boolean = false;
      var _loc21_:int = 0;
      var _loc9_:* = NaN;
      var _loc14_:Number = NaN;
      var _loc10_:int = 0;
      var _loc12_:* = undefined;
      var _loc20_:* = null;
      var _loc5_:* = null;
      var _loc2_:* = null;
      var _loc15_:* = null;
      var _loc19_:Stage = this.gs.stage;
      var _loc16_:uint = param1.keyCode;
      var player:Player = this.gs.map.player_;
      if(_loc19_.focus) {
         return;
      }
      var _loc26_:* = _loc16_;
      switch(_loc26_) {
         case Parameters.data.noClipKey:
            if(Parameters.data.noClip && !player.square.isWalkable()) {
               player.levelUpEffect("Can\'t turn off No Clip: Unwalkable tile");
               return;
            }
            Parameters.data.noClip = !Parameters.data.noClip;
            Parameters.save();
            player.levelUpEffect(!!Parameters.data.noClip?"No Clip: ON":"No Clip: OFF");
            return;

         case Parameters.data.tpCursor:
            if(Parameters.data.noClip && !player.square.isWalkable()) {
               player.levelUpEffect("Can\'t turn off No Clip: Unwalkable tile");
               return;
            }
            if(Parameters.data.noClip) {
               return;
            }
            Parameters.data.noClip = !Parameters.data.noClip;
            Parameters.save();
            player.levelUpEffect("Tp'd");

            this.gs.map.player_.x_ = Number((Math.cos(Parameters.data.cameraAngle) * this.gs.map.mouseX * Parameters.data.tpMulti - Math.sin(Parameters.data.cameraAngle) * this.gs.map.mouseY) * 0.02 + this.gs.map.player_.x_);
            this.gs.map.player_.y_ = Number((Math.cos(Parameters.data.cameraAngle) * this.gs.map.mouseY * Parameters.data.tpMulti + Math.sin(Parameters.data.cameraAngle) * this.gs.map.mouseX) * 0.02 + this.gs.map.player_.y_);

            this.delayTimer = new Timer(Parameters.data.pauseDelay, 1);
            this.delayTimer.addEventListener("timerComplete", this.onTimerComplete);
            this.delayTimer.start();
            return;

         case Parameters.data.noClipPause:
            var pauseState:Boolean = this.gs.map.player_.isPaused_();
            if (pauseState)
               this.gs.gsc_.setCondition(ConditionEffect.PAUSED, 0);
            else {
               var isSafe:Boolean = true;
               for each (var go:GameObject in this.gs.map.goDict_)
                  if (go.props_.isEnemy_ &&
                          PointUtil.distanceSquaredXY(go.x_, go.y_, player.x_, player.y_) <= 9 * 9) {
                     isSafe = false;
                     break;
                  }

               if (isSafe)
                  this.gs.gsc_.setCondition(ConditionEffect.PAUSED, int.MAX_VALUE);
               else {
                  player.levelUpEffect("Not safe to pause!");
                  return;
               }
            }
            if(Parameters.data.noClip && !player.square.isWalkable()) {
               player.levelUpEffect("Can\'t turn off No Clip: Unwalkable tile");
               return;
            }
            Parameters.data.noClip = !Parameters.data.noClip;
            Parameters.save();
            player.levelUpEffect(!!Parameters.data.noClip?"No Clip: ON":"No Clip: OFF");
            return;
         case Parameters.data.walkKey:
            this.isWalking = true;
            return;
         case Parameters.data.pauseAnywhere:
            var pauseState:Boolean = this.gs.map.player_.isPaused_();
            if (pauseState)
               this.gs.gsc_.setCondition(ConditionEffect.PAUSED, 0);
            else {
               var isSafe:Boolean = true;
               for each (var go:GameObject in this.gs.map.goDict_)
                  if (go.props_.isEnemy_ &&
                          PointUtil.distanceSquaredXY(go.x_, go.y_, player.x_, player.y_) <= 9 * 9) {
                     isSafe = false;
                     break;
                  }

               if (isSafe)
                  this.gs.gsc_.setCondition(ConditionEffect.PAUSED, int.MAX_VALUE);
               else {
                  player.levelUpEffect("Not safe to pause!");
                  return;
               }
            }
            player.levelUpEffect(pauseState ? "Pause: OFF" : "Pause: ON");
            return;
              /*case KeyCodes.PAGE_DOWN:
                 var vault:GameObject = null;
                 for each (var go:GameObject in gs.map.goDict_)
                    if (go.objectType_ == 0x504) {
                       vault = go;
                       break;
                    }

                 var empty:Vector.<int> = new Vector.<int>();

                 for (var i:int = 4; i < player.equipment_.length; i++)
                    if (player.equipment_[i] == -1)
                       empty.push(i);

                 for (i = 0; i < Math.min(empty.length, vault.equipment_.length); i++)
                    gs.gsc_.invSwap(gs.map.player_,
                            vault,
                            i,
                            vault.equipment_[i],
                            gs.map.player_,
                            empty[i],
                            -1,
                            i * 550);

                 if (Parameters.lastRecon)
                    gs.dispatchEvent(Parameters.lastRecon);
                 return;*/
         case Parameters.data.depositKey:
            var vault:GameObject = null;
            for each (var go:GameObject in gs.map.goDict_)
               if (go.objectType_ == 0x504/*0x743*/) {
                  vault = go;
                  break;
               }

            var i:int = 4;
            var nonEmpty:Vector.<int> = new Vector.<int>();

            for (; i < player.equipment_.length; i++)
               if (player.equipment_[i] != -1)
                  nonEmpty.push(i);

            var filled:int = 0;
            for (i = 0; i < vault.equipment_.length; i++)
               if (vault.equipment_[i] == -1) {
                  gs.gsc_.invSwap(gs.map.player_,
                          gs.map.player_,
                          nonEmpty[i],
                          gs.map.player_.equipment_[nonEmpty[i]],
                          vault,
                          i,
                          vault.equipment_[i],
                          filled * 550);
                  filled++;
                  if (filled >= nonEmpty.length)
                     break;
               }


            if (Parameters.lastRecon)
               gs.dispatchEvent(Parameters.lastRecon);
            return;
         default:
            if(_loc16_ == Parameters.data.moveUp) {
               this.moveUp_ = true;
            } else if(_loc16_ == Parameters.data.moveDown) {
               this.moveDown_ = true;
            } else if(_loc16_ == Parameters.data.moveLeft) {
               this.moveLeft_ = true;
            } else if(_loc16_ == Parameters.data.moveRight) {
               this.moveRight_ = true;
            } else if(_loc16_ == Parameters.data.rotateLeft) {
               if(Parameters.data.allowRotation) {
                  this.rotateLeft_ = true;
               }
            } else if(_loc16_ == Parameters.data.rotateRight) {
               if(Parameters.data.allowRotation) {
                  this.rotateRight_ = true;
               }
            } else if(_loc16_ == Parameters.data.resetToDefaultCameraAngle) {
               Parameters.data.cameraAngle = Parameters.data.defaultCameraAngle;
               Parameters.save();
               this.gs.camera_.nonPPMatrix_ = new Matrix3D();
               this.gs.camera_.nonPPMatrix_.appendScale(50,50,50);
            } else if(_loc16_ == Parameters.data.useSpecial) {
               if(player) {
                  if(!this.specialKeyDown_) {
                     if(player.isUnstable) {
                        _loc7_ = Math.random() * 600 - _loc19_.width * 0.5;
                        _loc23_ = Math.random() * 600 - _loc19_.height * 0.5;
                     } else {
                        _loc7_ = this.gs.map.mouseX;
                        _loc23_ = this.gs.map.mouseY;
                     }
                     _loc3_ = player.useAltWeapon(_loc7_,_loc23_,1);
                     if(_loc3_) {
                        this.specialKeyDown_ = true;
                     }
                  }
               }
            } else if(_loc16_ == Parameters.data.autofireToggle) {
               if(player) {
                  _loc12_ = !this.autofire_;
                  this.autofire_ = _loc12_;
                  player.isShooting = _loc12_;
               }
            } else if(_loc16_ == Parameters.data.escapeToNexus || _loc16_ == Parameters.data.escapeToNexus2) {
               if(player) {
                  this.gs.gsc_.disconnect();
                  this.gs.dispatchEvent(Parameters.reconNexus);
               }
               Parameters.data.needsRandomRealm = false;
               Parameters.save();
               StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal).dispatch();
            } else if(_loc16_ == Parameters.data.useInvSlot1) {
               this.useItem(4);
            } else if(_loc16_ == Parameters.data.useInvSlot2) {
               this.useItem(5);
            } else if(_loc16_ == Parameters.data.useInvSlot3) {
               this.useItem(6);
            } else if(_loc16_ == Parameters.data.useInvSlot4) {
               this.useItem(7);
            } else if(_loc16_ == Parameters.data.useInvSlot5) {
               this.useItem(8);
            } else if(_loc16_ == Parameters.data.useInvSlot6) {
               this.useItem(9);
            } else if(_loc16_ == Parameters.data.useInvSlot7) {
               this.useItem(10);
            } else if(_loc16_ == Parameters.data.useInvSlot8) {
               this.useItem(11);
            } else if(_loc16_ == Parameters.data.quickSlotKey1) {
               player = this.gs.map.player_;
               if (player && player.quickSlotCount1 > 0) {
                  this.gs.gsc_.useItem(TimeUtil.getModdedTime(),
                          player.objectId_, 1000000, player.quickSlotItem1,
                          player.x_, player.y_, 1);

                  var newCount:int = player.quickSlotCount1 - 1;
                  if (newCount <= 0) {
                     player.quickSlotCount1 = 0;
                     player.quickSlotItem1 = -1;
                  } else player.quickSlotCount1 = newCount;
               }
            } else if (_loc16_ == Parameters.data.quickSlotKey2) {
               player = this.gs.map.player_;
               if (player && player.quickSlotCount2 > 0) {
                  this.gs.gsc_.useItem(TimeUtil.getModdedTime(),
                          player.objectId_, 1000001, player.quickSlotItem2,
                          player.x_, player.y_, 1);

                  var newCount:int = player.quickSlotCount2 - 1;
                  if (newCount <= 0) {
                     player.quickSlotCount2 = 0;
                     player.quickSlotItem2 = -1;
                  } else player.quickSlotCount2 = newCount;
               }
            } else if (_loc16_ == Parameters.data.quickSlotKey3) {
               player = this.gs.map.player_;
               if (player && player.quickSlotCount3 > 0 && player.quickSlotUpgrade) {
                  this.gs.gsc_.useItem(TimeUtil.getModdedTime(),
                          player.objectId_, 1000002, player.quickSlotItem3,
                          player.x_, player.y_, 1);

                  var newCount:int = player.quickSlotCount3 - 1;
                  if (newCount <= 0) {
                     player.quickSlotCount3 = 0;
                     player.quickSlotItem3 = -1;
                  } else player.quickSlotCount3 = newCount;
               }
            } else if(_loc16_ == Parameters.data.toggleHPBar) {
               Parameters.data.HPBar = Parameters.data.HPBar != 0?0:1;
            } else if(_loc16_ == Parameters.data.toggleProjectiles) {
               Parameters.data.disableAllyShoot = Parameters.data.disableAllyShoot != 0?0:1;
            } else if(_loc16_ == Parameters.data.miniMapZoomOut) {
               this.miniMapZoom.dispatch("OUT");
            } else if(_loc16_ == Parameters.data.miniMapZoomIn) {
               this.miniMapZoom.dispatch("IN");
            } else if(_loc16_ == Parameters.data.togglePerformanceStats) {
               this.togglePerformanceStats();
            } else if(_loc16_ == Parameters.data.toggleMasterParticles) {
               Parameters.data.noParticlesMaster = !Parameters.data.noParticlesMaster;
            } else if(_loc16_ == Parameters.data.friendList) {
               this.isFriendsListOpen = !this.isFriendsListOpen;
               if(this.isFriendsListOpen) {
                  _loc20_ = StaticInjectorContext.getInjector().getInstance(ShowPopupSignal);
                  _loc20_.dispatch(new SocialPopupView());
               } else {
                  this.closeDialogSignal.dispatch();
                  this.closePopupByClassSignal.dispatch(SocialPopupView);
               }
            } else if(_loc16_ == Parameters.data.options) {
               this.clearInput();
               this.layers.overlay.addChild(new Options(this.gs));
            } else if(_loc16_ == Parameters.data.TombCycleKey) {
               _loc22_ = Parameters.data.TombCycleBoss;
               var _loc25_ = _loc22_;
               switch(_loc25_) {
                  case 3368:
                  default:
                     addIgnore(3366);
                     addIgnore(32692);
                     addIgnore(3367);
                     addIgnore(32693);
                     remIgnore(3368);
                     remIgnore(32694);
                     player.textNotification("Bes",16771743,1500,true);
                     Parameters.data.TombCycleBoss = 3366;
                     break;
                  case 3366:
                     addIgnore(3367);
                     addIgnore(32693);
                     addIgnore(3368);
                     addIgnore(32694);
                     remIgnore(3366);
                     remIgnore(32692);
                     player.textNotification("Nut",10481407,1500,true);
                     Parameters.data.TombCycleBoss = 3367;
                     break;
                  case 3367:
                     addIgnore(3368);
                     addIgnore(32694);
                     addIgnore(3366);
                     addIgnore(32692);
                     remIgnore(3367);
                     remIgnore(32693);
                     player.textNotification("Geb",11665311,1500,true);
                     Parameters.data.TombCycleBoss = 3368;
               }
               Parameters.save();
            } else if(_loc16_ == Parameters.data.anchorTeleport) {
               this.gs.gsc_.playerText("/teleport " + Parameters.data.anchorName);
            } else if(_loc16_ == Parameters.data.toggleCentering) {
               Parameters.data.centerOnPlayer = !Parameters.data.centerOnPlayer;
               Parameters.save();
            } else if(_loc16_ == Parameters.data.toggleFullscreen) {
               if(Capabilities.playerType == "Desktop") {
                  Parameters.data.fullscreenMode = !Parameters.data.fullscreenMode;
                  Parameters.save();
                  _loc19_.displayState = !!Parameters.data.fullscreenMode?"fullScreenInteractive":"normal";
               }
            } else if(_loc16_ == Parameters.data.toggleRealmQuestDisplay) {
               this.toggleRealmQuestsDisplaySignal.dispatch();
            } else if(_loc16_ == Parameters.data.switchTabs) {
               this.statsTabHotKeyInputSignal.dispatch();
            } else if(_loc16_ == Parameters.data.AutoAbilityHotkey) {
               Parameters.data.AutoAbilityOn = !Parameters.data.AutoAbilityOn;
               player.textNotification(!!Parameters.data.AutoAbilityOn?"AutoAbility enabled":"AutoAbility disabled",16777215,2000,false);
            } else if(_loc16_ != Parameters.data.ignoreSpeedyKey) {
               if(_loc16_ == Parameters.data.AAHotkey) {
                  Parameters.data.AAOn = !Parameters.data.AAOn;
                  if(player && !mouseDown_ && !Parameters.data.AAOn) {
                     player.isShooting = false;
                  }
                  player.textNotification(!!Parameters.data.AAOn?"AutoAim enabled":"AutoAim disabled",16777215,2000,false);
               } else if(_loc16_ == Parameters.data.AAModeHotkey) {
                  this.selectAimMode();
               } else if(_loc16_ == Parameters.data.AutoLootHotkey) {
                  Parameters.data.AutoLootOn = !Parameters.data.AutoLootOn;
                  player.textNotification(!!Parameters.data.AutoLootOn?"AutoLoot enabled":"AutoLoot disabled",16777215,2000,false);
               } else if(_loc16_ == Parameters.data.resetClientHP) {
                  player.clientHp = player.hp_;
               } else if(_loc16_ == Parameters.data.QuestTeleport) {
                  if(player) {
                     teleQuest(player);
                  }
               } else if(_loc16_ == Parameters.data.TextPause) {
                  this.gs.gsc_.playerText("/pause");
               } else if(_loc16_ == Parameters.data.TextThessal) {
                  this.gs.gsc_.playerText("He lives and reigns and conquers the world");
               } else if(_loc16_ == Parameters.data.TextDraconis) {
                  this.gs.gsc_.playerText("black");
               } else if(_loc16_ == Parameters.data.TextCem) {
                  this.gs.gsc_.playerText("ready");
               }
               if(_loc16_ == Parameters.data.SelfTPHotkey) {
                  this.gs.gsc_.teleport(player.objectId_);
               } else if(_loc16_ != Parameters.data.syncFollowHotkey) {
                  if(_loc16_ != Parameters.data.syncLeadHotkey) {
                     if(_loc16_ != Parameters.data.requestPuriHotkey) {
                        if(_loc16_ == Parameters.data.TogglePlayerFollow) {
                           Parameters.followingName = !Parameters.followingName;
                           player.textNotification(!!Parameters.followingName?"Following: on":"Following: off",16776960);
                        } else if(_loc16_ == Parameters.data.PassesCoverHotkey) {
                           Parameters.data.PassesCover = !Parameters.data.PassesCover;
                           player.textNotification(!!Parameters.data.PassesCover?"Projectile Noclip on":"Projectile Noclip off");
                        } else if(_loc16_ == Parameters.data.LowCPUModeHotKey) {
                           Parameters.lowCPUMode = !Parameters.lowCPUMode;
                           player.textNotification(!!Parameters.lowCPUMode?"Low CPU on":"Low CPU off");
                        } else if(_loc16_ == Parameters.data.ReconRealm) {
                           if(Parameters.data.lastRealmIP != "127.0.0.1") {
                              StaticInjectorContext.getInjector().getInstance(EnterGameSignal).dispatch();
                              _loc4_ = new GameInitData();
                              _loc4_.server = new Server();
                              _loc4_.server.port = 2050;
                              _loc4_.server.setName(Parameters.data.lastRealmIP);
                              _loc4_.server.address = Parameters.data.lastRealmIP;
                              _loc4_.createCharacter = false;
                              _loc4_.charId = this.gs.gsc_.charId_;
                              _loc4_.isNewGame = true;
                              StaticInjectorContext.getInjector().getInstance(PlayGameSignal).dispatch(_loc4_);
                              StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal).dispatch();
                           }
                        } else if(_loc16_ == Parameters.data.DrinkAllHotkey) {
                           _loc5_ = player.getClosestBag(true);
                           if(_loc5_) {
                              _loc21_ = TimeUtil.getTrueTime();
                              _loc9_ = Number(player.x_);
                              _loc14_ = player.y_;
                              _loc10_ = 0;
                              while(_loc10_ < 8) {
                                 if(_loc5_.equipment_[_loc10_] != -1) {
                                    gs.gsc_.useItem(_loc21_,_loc5_.objectId_,_loc10_,_loc5_.equipment_[_loc10_],_loc9_,_loc14_,1);
                                 }
                                 _loc10_++;
                              }
                           }
                        } else if(_loc16_ == Parameters.data.tradeNearestPlayerKey) {
                           _loc9_ = Infinity;
                           var _loc30_:int = 0;
                           var _loc29_:* = this.gs.map.goDict_;
                           for each(var _loc13_ in this.gs.map.goDict_) {
                              if(_loc13_ is Player && (_loc13_ as Player).nameChosen_ && player != _loc13_) {
                                 _loc14_ = player.getDistSquared(player.x_,player.y_,_loc13_.x_,_loc13_.y_);
                                 if(_loc14_ < _loc9_) {
                                    _loc2_ = _loc13_;
                                    _loc9_ = _loc14_;
                                 }
                              }
                           }
                           if(_loc2_) {
                              this.gs.gsc_.requestTrade(_loc2_.name_);
                           }
                        }
                        if(_loc16_ == Parameters.data.sayCustom1) {
                           if(Parameters.data.customMessage1.length > 0) {
                              msgSignal.dispatch(Parameters.data.customMessage1);
                           }
                        } else if(_loc16_ == Parameters.data.sayCustom2) {
                           if(Parameters.data.customMessage2.length > 0) {
                              msgSignal.dispatch(Parameters.data.customMessage2);
                           }
                        } else if(_loc16_ == Parameters.data.sayCustom3) {
                           if(Parameters.data.customMessage3.length > 0) {
                              msgSignal.dispatch(Parameters.data.customMessage3);
                           }
                        } else if(_loc16_ == Parameters.data.sayCustom4) {
                           if(Parameters.data.customMessage4.length > 0) {
                              msgSignal.dispatch(Parameters.data.customMessage4);
                           }
                        } else if(_loc16_ == Parameters.data.aimAtQuest) {
                           if(this.gs.map.quest_.objectId_ >= 0) {
                              _loc15_ = this.gs.map.goDict_[this.gs.map.quest_.objectId_];
                              Parameters.data.cameraAngle = Math.atan2(player.y_ - _loc15_.y_,player.x_ - _loc15_.x_) - 1.5707963267949;
                              Parameters.save();
                           }
                        }
                     }
                  }
               }
            }
            this.setPlayerMovement();
            return;
      }
   }
   private function onTimerComplete(_arg_1:TimerEvent):void {
      this.delayTimer.removeEventListener("timerComplete", this.onTimerComplete);
      if(Parameters.data.noClip) {
         Parameters.data.noClip = !Parameters.data.noClip;
      }
   }

   private function onKeyUp(param1:KeyboardEvent) : void {
      var _loc2_:Number = NaN;
      var _loc3_:Number = NaN;
      var _loc4_:* = param1.keyCode;
      switch(_loc4_) {
         case Parameters.data.walkKey:
            this.isWalking = false;
            break;
         case Parameters.data.moveUp:
            this.moveUp_ = false;
            break;
         case Parameters.data.moveDown:
            this.moveDown_ = false;
            break;
         case Parameters.data.moveLeft:
            this.moveLeft_ = false;
            break;
         case Parameters.data.moveRight:
            this.moveRight_ = false;
            break;
         case Parameters.data.rotateLeft:
            this.rotateLeft_ = false;
            break;
         case Parameters.data.rotateRight:
            this.rotateRight_ = false;
            break;
         case Parameters.data.useSpecial:
            if(this.specialKeyDown_) {
               this.specialKeyDown_ = false;
               _loc2_ = NaN;
               _loc3_ = NaN;
               if(this.gs.map.player_.isUnstable) {
                  _loc2_ = Math.random() * 600 - this.gs.map.x;
                  _loc3_ = Math.random() * 600 - this.gs.map.y;
               } else {
                  _loc2_ = this.gs.map.mouseX;
                  _loc3_ = this.gs.map.mouseY;
               }
               this.gs.map.player_.useAltWeapon(this.gs.map.mouseX,this.gs.map.mouseY,2);
               break;
            }
      }
      this.setPlayerMovement();
   }
}
}
