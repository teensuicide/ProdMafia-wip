package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.util.GraphicsUtil;
import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.geom.Matrix;

public class Container extends GameObject implements IInteractiveObject {


   public var isLoot_:Boolean;

   public var canHaveSoulbound_:Boolean;

   public var drawMeBig_:Boolean;

   public var ownerId_:String;

   private var lastEquips:Vector.<int>;

   private var icons_:Vector.<BitmapData> = null;

   public function Container(param1:XML) {
      lastEquips = new <int>[0,0,0,0,0,0,0,0];
      super(param1);
      isInteractive_ = true;
      this.isLoot_ = "Loot" in param1;
      this.canHaveSoulbound_ = "CanPutSoulboundObjects" in param1;
      this.ownerId_ = "";
   }

   override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
      if(!super.addTo(param1,param2,param3)) {
         return false;
      }
      if(map_.player_ == null) {
         return true;
      }
      var _loc5_:Number = map_.player_.getDistSquared(map_.player_.x_,map_.player_.y_,param2,param3);
      if(this.isLoot_) {
         if(Parameters.announcedBags.indexOf(this.objectId_) == -1) {
            if(this.isWhiteBag()) {
               if(Parameters.data.showWhiteBagEffect) {
                  true;
                  this.map_.player_.textNotification("White Bag!",16777215,2000,true);
               }
            } else if(shouldOrangeBagNotify()) {
               true;
               this.map_.player_.textNotification("Orange Bag!",16744736,2000,true);
            }
         }
         if(_loc5_ < 100) {
            SoundEffectLibrary.play("loot_appears");
         }
         if(shouldSendBag(this.objectType_)) {
            this.drawMeBig_ = true;
         }
      }
      return true;
   }

   override public function removeFromMap() : void {
      super.removeFromMap();
   }

   override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
      super.draw(param1,param2,param3);
      if(Parameters.data.lootPreview) {
         drawItems(param1,param2,param3);
      }
   }

   public function setOwnerId(param1:String) : void {
      this.ownerId_ = param1;
      var _loc2_:Boolean = this.isBoundToCurrentAccount();
      isInteractive_ = this.ownerId_ == "" || _loc2_;
   }

   public function isBoundToCurrentAccount() : Boolean {
      return map_.player_.accountId_ == this.ownerId_;
   }

   public function getPanel(param1:GameSprite) : Panel {
      var _loc2_:Player = param1 && param1.map?param1.map.player_:null;
      return new ContainerGrid(this,_loc2_);
   }

   public function updateItemSprites(param1:Vector.<BitmapData>) : void {
      var _loc3_:int = 0;
      var _loc2_:* = null;
      var _loc5_:int = -1;
      var _loc4_:uint = this.equipment_.length;
      _loc3_ = 0;
      while(_loc3_ < _loc4_) {
         _loc5_ = this.equipment_[_loc3_];
         _loc2_ = ObjectLibrary.getItemIcon(_loc5_);
         param1.push(_loc2_);
         _loc3_++;
      }
   }

   public function vectorsAreEqual(curEquips:Vector.<int>) : Boolean {
      for (var i:int = 0; i < 8; i++)
         if (curEquips[i] != lastEquips[i])
            return false;
      return true;
   }

   public function drawItems(_arg_1:Vector.<GraphicsBitmapFill>, _arg_2:Camera, _arg_3:int):void {
      var _local6:Number = NaN;
      var _local8:Number = NaN;
      var _local13:int = 0;
      var _local10:int = 0;
      var _local14:BitmapData = null;
      var _local12:GraphicsBitmapFill = null;
      if (this.icons_ == null) {
         this.icons_ = new Vector.<BitmapData>();
         this.icons_.length = 0;
         updateItemSprites(this.icons_);
      } else if (!vectorsAreEqual(equipment_)) {
         this.icons_.length = 0;
         lastEquips[0] = equipment_[0];
         lastEquips[1] = equipment_[1];
         lastEquips[2] = equipment_[2];
         lastEquips[3] = equipment_[3];
         lastEquips[4] = equipment_[4];
         lastEquips[5] = equipment_[5];
         lastEquips[6] = equipment_[6];
         lastEquips[7] = equipment_[7];
         updateItemSprites(this.icons_);
      }
      var _local9:Number = posS_[3];
      var _local11:Number = this.vS_[1];
      var _local7:int = this.icons_.length;
      _local13 = 0;
      while (_local13 < _local7) {
         _local14 = this.icons_[_local13];
         _local12 = new GraphicsBitmapFill(_local14, new Matrix(), false, false);
         _local10 = _local13 * 0.25;
         _local6 = _local9 - _local14.width * 2 + _local13 % 4 * _local14.width;
         _local8 = _local11 - _local14.height * 0.5 + _local10 * (_local14.height + 5) - (_local10 * 5 + 20);
         _local12.matrix.identity();
         _local12.matrix.translate(_local6, _local8);
         _arg_1.push(_local12);
         _local13++;
      }
   }

   private function shouldOrangeBagNotify() : Boolean {
      return Parameters.data.showOrangeBagEffect && (this.objectType_ == 1295 || this.objectType_ == 1727);
   }

   private function shouldSendBag(param1:int) : Boolean {
      return param1 >= 1287 && param1 <= 1289 || param1 == 1291 || param1 == 1292 || param1 >= 1294 && param1 <= 1296 || param1 == 1708 || param1 >= 1722 && param1 <= 1728;
   }

   private function isWhiteBag() : Boolean {
      return this.objectType_ == 1292 || this.objectType_ == 1296;
   }
}
}
