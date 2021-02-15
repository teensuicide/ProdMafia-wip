package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import flash.utils.Dictionary;
   
   public class ObjectProperties {
      
      private static var groupDict:Dictionary = new Dictionary();
      
      private static var groupCounter:int = 0;
       
      
      const unlistedBosses:Vector.<int> = new <int>[1337,2048,2340,2349,3448,3449,3452,3613,3622,4312,4324,4325,4326,5943,8200,24092,24327,24351,24363,24587,29003,29021,29039,29341,29342,29723,29764,30026,45104,45371,45076,28618,28619,32751,29793];
      
      public var type_:int;
      
      public var id_:String;
      
      public var displayId_:String;
      
      public var shadowSize_:int;
      
      public var desiredLoot_:Boolean;
      
      public var isPlayer_:Boolean = false;
      
      public var isEnemy_:Boolean = false;
      
      public var isQuest_:Boolean = false;
      
      public var isItem_:Boolean = false;
      
      public var drawOnGround_:Boolean = false;
      
      public var drawUnder_:Boolean = false;
      
      public var occupySquare_:Boolean = false;
      
      public var fullOccupy_:Boolean = false;
      
      public var enemyOccupySquare_:Boolean = false;
      
      public var static_:Boolean = false;
      
      public var noMiniMap_:Boolean = false;
      
      public var noHealthBar_:Boolean = false;
      
      public var healthBar_:int = 0;
      
      public var protectFromGroundDamage_:Boolean = false;
      
      public var protectFromSink_:Boolean = false;
      
      public var z_:Number = 0;
      
      public var flying_:Boolean = false;
      
      public var color_:int = -1;
      
      public var showName_:Boolean = false;
      
      public var dontFaceAttacks_:Boolean = false;
      
      public var dontFaceMovement_:Boolean = false;
      
      public var bloodProb_:Number = 0;
      
      public var bloodColor_:uint = 16711680;
      
      public var shadowColor_:uint = 0;
      
      public var sounds_:Object = null;
      
      public var portrait_:TextureData = null;
      
      public var minSize_:int = 100;
      
      public var maxSize_:int = 100;
      
      public var sizeStep_:int = 5;
      
      public var whileMoving_:WhileMovingProperties = null;
      
      public var oldSound_:String = null;
      
      public var projectiles_:Dictionary;

      public var maxRange:Number = -1;
      
      public var rateOfFire_:Number;
      
      public var angleCorrection_:Number = 0;
      
      public var rotation_:Number = 0;
      
      public var ignored:Boolean;
      
      public var excepted:Boolean;
      
      public var isGod_:Boolean;
      
      public var isCube_:Boolean;
      
      public var isPotion_:Boolean;
      
      public var boss_:Boolean = false;
      
      public var customBoss_:Boolean = false;
      
      public var stackable_:Boolean;
      
      public var stackGroup_:int = 0;
      
      public var slotType_:int = -2147483648;
      
      public var tier:int = -2147483648;

      public var maxQuickStack:int = -1;

      public var forgeProperties:ForgeProperties;

      public var class_:String;
      
      public function ObjectProperties(param1:XML) {
         var _loc4_:* = false;
         var _loc7_:* = undefined;
         var _loc5_:int = 0;
         var _loc10_:* = undefined;
         var _loc13_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc8_:* = undefined;
         projectiles_ = new Dictionary();
         var _loc9_:* = null;
         var _loc6_:* = null;
         super();
         if(param1 == null) {
            return;
         }
         this.type_ = int(param1.@type);
         this.id_ = String(param1.@id);
         this.class_ = param1.Class;
         if("DisplayId" in param1) {
            this.displayId_ = param1.DisplayId;
         }
         this.shadowSize_ = "ShadowSize" in param1?param1.ShadowSize:100;
         this.isPlayer_ = "Player" in param1;
         this.isEnemy_ = "Enemy" in param1;
         this.isQuest_ = "Quest" in param1;
         this.isItem_ = "Item" in param1;
         if(this.isItem_) {
            _loc4_ = false;
            if("Quantity" in param1 && "ExtraTooltipData" in param1) {
               _loc4_ = int(param1.ExtraTooltipData.EffectInfo.(@name == "Stack limit").@description) - param1.Quantity > 0;
            }
            if(_loc4_) {
               stackable_ = true;
               stackGroup_ = computeStackGroup(this.id_);
            }
         }
         if("SlotType" in param1) {
            this.slotType_ = param1.SlotType;
         }
         if("Tier" in param1) {
            this.tier = param1.Tier;
         }
         this.boss_ = "Quest" in param1;
         if(this.unlistedBosses.indexOf(this.type_) >= 0) {
            this.boss_ = true;
         }
         this.drawOnGround_ = "DrawOnGround" in param1;
         if(this.drawOnGround_ || "DrawUnder" in param1) {
            this.drawUnder_ = true;
         }
         this.occupySquare_ = "OccupySquare" in param1;
         this.fullOccupy_ = "FullOccupy" in param1;
         this.enemyOccupySquare_ = "EnemyOccupySquare" in param1;
         this.static_ = "Static" in param1;
         this.noMiniMap_ = "NoMiniMap" in param1;
         if("HealthBar" in param1) {
            this.healthBar_ = param1.HealthBar;
         }
         this.noHealthBar_ = "NoHealthBar" in param1;
         this.protectFromGroundDamage_ = "ProtectFromGroundDamage" in param1;
         this.protectFromSink_ = "ProtectFromSink" in param1;
         this.flying_ = "Flying" in param1;
         this.showName_ = "ShowName" in param1;
         this.dontFaceAttacks_ = "DontFaceAttacks" in param1;
         this.dontFaceMovement_ = "DontFaceMovement" in param1;
         this.isGod_ = "God" in param1;
         this.isCube_ = "Cube" in param1;
         this.isPotion_ = "Potion" in param1;
         this.maxQuickStack = "QuickslotAllowed" in param1 ? param1.QuickslotAllowed.@maxstack : -1;
         if("Z" in param1) {
            this.z_ = param1.Z;
         }
         if("Color" in param1) {
            this.color_ = param1.Color;
         }
         if("Size" in param1) {
            _loc3_ = param1.Size;
            this.maxSize_ = _loc3_;
            this.minSize_ = _loc3_;
            if(this.maxSize_ == -1) {
               _loc8_ = 0;
               this.maxSize_ = _loc8_;
               this.minSize_ = _loc8_;
            }
         } else {
            if("MinSize" in param1) {
               this.minSize_ = param1.MinSize;
            }
            if("MaxSize" in param1) {
               this.maxSize_ = param1.MaxSize;
            }
            if("SizeStep" in param1) {
               this.sizeStep_ = param1.SizeStep;
            }
         }
         this.oldSound_ = "OldSound" in param1?param1.OldSound:null;
         var _loc19_:int = 0;
         var _loc18_:* = param1.Projectile;
         for each(_loc9_ in param1.Projectile) {
            _loc2_ = _loc9_.@id;
            _loc13_ = new ProjectileProperties(_loc9_);
            this.projectiles_[_loc2_] = _loc13_;
            if(_loc13_.maxProjTravel_ > this.maxRange) {
               this.maxRange = _loc13_.maxProjTravel_;
            }
         }
         this.rateOfFire_ = "RateOfFire" in param1?param1.RateOfFire:1;
         this.angleCorrection_ = "AngleCorrection" in param1?param1.AngleCorrection * 0.785398163397448:0;
         this.rotation_ = "Rotation" in param1?param1.Rotation:0;
         if("BloodProb" in param1) {
            this.bloodProb_ = param1.BloodProb;
         }
         if("BloodColor" in param1) {
            this.bloodColor_ = param1.BloodColor;
         }
         if("ShadowColor" in param1) {
            this.shadowColor_ = param1.ShadowColor;
         }
         var _loc12_:* = param1.Sound;
         var _loc21_:int = 0;
         var _loc20_:* = param1.Sound;
         for each(_loc6_ in param1.Sound) {
            if(this.sounds_ == null) {
               this.sounds_ = {};
            }
            this.sounds_[int(_loc6_.@id)] = _loc6_.toString();
         }
         if("Portrait" in param1) {
            this.portrait_ = new TextureDataConcrete(XML(param1.Portrait));
         }
         if("WhileMoving" in param1) {
            this.whileMoving_ = new WhileMovingProperties(XML(param1.WhileMoving));
         }
      }
      
      public function loadSounds() : void {
         var _loc3_:* = null;
         if(this.sounds_ == null) {
            return;
         }
         var _loc1_:* = this.sounds_;
         var _loc5_:int = 0;
         var _loc4_:* = this.sounds_;
         for each(_loc3_ in this.sounds_) {
            SoundEffectLibrary.load(_loc3_);
         }
      }
      
      public function getSize() : int {
         if(this.minSize_ == this.maxSize_) {
            return this.minSize_;
         }
         var _loc1_:int = (this.maxSize_ - this.minSize_) / this.sizeStep_;
         return this.minSize_ + int(Math.random() * _loc1_) * this.sizeStep_;
      }
      
      private function computeStackGroup(param1:String) : int {
         var _loc2_:* = null;
         var _loc3_:int = param1.indexOf(" x");
         if(_loc3_ != -1) {
            _loc2_ = param1.substr(0,_loc3_);
            if(groupDict[_loc2_] == null) {
               groupCounter = Number(groupCounter) + 1;
               groupDict[_loc2_] = Number(groupCounter);
            }
            return groupDict[_loc2_];
         }
         return -1;
      }
   }
}

class WhileMovingProperties {
    
   
   public var z_:Number = 0;
   
   public var flying_:Boolean = false;
   
   function WhileMovingProperties(param1:XML) {
      super();
      if("Z" in param1) {
         this.z_ = param1.Z;
      }
      this.flying_ = "Flying" in param1;
   }
}
