package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.map.Square;
   import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
   import com.company.assembleegameclient.objects.animation.Animations;
   import com.company.assembleegameclient.objects.animation.AnimationsData;
   import com.company.assembleegameclient.objects.particles.ExplosionEffect;
   import com.company.assembleegameclient.objects.particles.HitEffect;
   import com.company.assembleegameclient.objects.particles.ParticleEffect;
   import com.company.assembleegameclient.objects.particles.ShockerEffect;
   import com.company.assembleegameclient.objects.particles.SpritesProjectEffect;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import com.company.assembleegameclient.util.AnimatedChar;
   import com.company.assembleegameclient.util.ConditionEffect;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.BitmapUtil;
   import com.company.util.CachingColorTransformer;
   import com.company.util.ConversionUtil;
   import com.company.util.GraphicsUtil;
   import com.company.util.MoreColorUtil;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.display.GraphicsGradientFill;
   import flash.display.GraphicsPath;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import io.decagames.rotmg.pets.data.PetsModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   import kabam.rotmg.stage3D.GraphicsFillExtra;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class GameObject extends BasicObject {
      
      protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
      
      protected static const CURSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.redFilterMatrix);
      
      protected static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      private static const ZERO_LIMIT:Number = 1.0E-5;
      
      private static const NEGATIVE_ZERO_LIMIT:Number = -1.0E-5;
      
      public static const ATTACK_PERIOD:int = 300;
      
      private static const DEFAULT_HP_BAR_Y_OFFSET:int = 6;
      
      public static const radius_:Number = 0.5;
       
      
      public var nameBitmapData_:BitmapData = null;
      
      public var shockEffect:ShockerEffect;
      
      public var spritesProjectEffect:SpritesProjectEffect;
      
      public var statusFlash_:StatusFlashDescription = null;
      
      public var name_:String;
      
      public var facing_:Number = 0;
      
      public var flying:Boolean = false;
      
      public var attackAngle_:Number = 0;
      
      public var attackStart_:int = 0;
      
      public var animatedChar_:AnimatedChar = null;
      
      public var texture:BitmapData = null;
      
      public var mask_:BitmapData = null;
      
      public var randomTextureData_:Vector.<TextureData> = null;
      
      public var effect_:ParticleEffect = null;
      
      public var animations_:Animations = null;
      
      public var dead_:Boolean = false;
      
      public var deadCounter_:uint = 0;
      
      public var texturingCache_:Dictionary = null;
      
      public var maxHP_:int = 200;
      
      public var hp_:int = 200;
      
      public var size_:int = 100;
      
      public var level_:int = -1;
      
      public var defense_:int = 0;
      
      public var slotTypes_:Vector.<int> = null;
      
      public var equipment_:Vector.<int> = null;
      
      public var lockedSlot:Vector.<int> = null;
      
      public var supporterPoints:int = 0;
      
      public var isInteractive_:Boolean = false;
      
      public var objectType_:int;
      
      public var sinkLevel:int = 0;
      
      public var hallucinatingTexture_:BitmapData = null;
      
      public var flash:FlashDescription = null;
      
      public var connectType_:int = -1;
      
      public var fakeBag_:Boolean;
      
      public var hasShock:Boolean;
      
      public var isQuiet:Boolean;
      
      public var isWeak:Boolean;
      
      public var isSlowed:Boolean;
      
      public var isSick:Boolean;
      
      public var isDazed:Boolean;
      
      public var isStunned:Boolean;
      
      public var isBlind:Boolean;
      
      public var isDrunk:Boolean;
      
      public var isBleeding:Boolean;
      
      public var isConfused:Boolean;
      
      public var isStunImmune:Boolean;
      
      public var isInvisible:Boolean;
      
      public var isParalyzed:Boolean;
      
      public var isSpeedy:Boolean;
      
      public var isNinjaSpeedy:Boolean;
      
      public var isHallucinating:Boolean;
      
      public var isHealing:Boolean;
      
      public var isDamaging:Boolean;
      
      public var isBerserk:Boolean;
      
      public var isPaused:Boolean;
      
      public var isStasis:Boolean;
      
      public var isInvincible:Boolean;
      
      public var isInvulnerable:Boolean;
      
      public var isArmored:Boolean;
      
      public var isArmorBroken:Boolean;
      
      public var isArmorBrokenImmune:Boolean;
      
      public var isSlowedImmune:Boolean;
      
      public var isSlowedImmuneVar:Boolean;
      
      public var isUnstable:Boolean;
      
      public var isShowPetEffectIcon:Boolean;
      
      public var isDarkness:Boolean;
      
      public var isParalyzeImmune:Boolean;
      
      public var isDazedImmune:Boolean;
      
      public var isPetrified:Boolean;
      
      public var isPetrifiedImmune:Boolean;
      
      public var isCursed:Boolean;
      
      public var isCursedImmune:Boolean;
      
      public var isSilenced:Boolean;
      
      public var isExposed:Boolean;
      
      public var mobInfoShown:Boolean;
      
      public var footer_:Boolean;
      
      public var lastPercent:String;
      
      public var myPet:Boolean;
      
      public var jittery:Boolean = false;
      
      public var iconCache:Vector.<BitmapData>;
      
      public var rangeCache:Dictionary;
      
      public var props_:ObjectProperties;
      
      public var condition_:Vector.<uint>;
      
      public var posAtTick_:Point;
      
      public var tickPosition_:Point;
      
      public var moveVec_:Vector3D;
      
      public var myLastTickId_:int = -1;
      
      protected var portrait_:BitmapData = null;
      
      protected var tex1Id_:int = 0;
      
      protected var tex2Id_:int = 0;
      
      protected var lastTickUpdateTime_:int = 0;
      
      protected var shadowGradientFill_:GraphicsGradientFill = null;
      
      protected var shadowPath_:GraphicsPath = null;
      
      protected var bitmapFill:GraphicsBitmapFill;
      
      protected var rangeBitmapFill:GraphicsBitmapFill;
      
      protected var path_:GraphicsPath;
      
      protected var vS_:Vector.<Number>;
      
      protected var uvt_:Vector.<Number>;
      
      protected var fillMatrix_:Matrix;
      
      protected var rangeFillMatrix:Matrix;
      
      protected var hpBarFillMatrix:Matrix;
      
      protected var hpBarOutlineFillMatrix:Matrix;
      
      protected var hpBarBackFillMatrix:Matrix;
      
      private var nameFill_:GraphicsBitmapFill = null;
      
      private var namePath_:GraphicsPath = null;
      
      private var isShocked:Boolean;
      
      private var isShockedTransformSet:Boolean = false;
      
      private var isCharging:Boolean;
      
      private var isChargingTransformSet:Boolean = false;
      
      private var nextBulletId_:uint = 1;
      
      private var sizeMult_:Number = 1;
      
      private var isStasisImmune_:Boolean = false;
      
      private var isInvincibleXML:Boolean = false;
      
      private var isStunImmuneVar:Boolean = false;
      
      private var isParalyzeImmuneVar:Boolean = false;
      
      private var isDazedImmuneVar:Boolean = false;
      
      private var hpBarOutlineFill:GraphicsBitmapFill = null;
      
      private var hpBarBackFill:GraphicsBitmapFill = null;
      
      private var hpBarFill:GraphicsBitmapFill = null;
      
      private var icons_:Vector.<BitmapData> = null;
      
      private var iconFills_:Vector.<GraphicsBitmapFill> = null;
      
      private var iconPaths_:Vector.<GraphicsPath> = null;
      
      private var lastCon1:uint = 0;
      
      private var lastCon2:uint = 0;
      
      public function GameObject(param1:XML) {
         var _loc6_:* = 0;
         var _loc5_:int = 0;
         var _loc3_:* = undefined;
         iconCache = new Vector.<BitmapData>();
         rangeCache = new Dictionary();
         props_ = ObjectLibrary.defaultProps_;
         condition_ = new <uint>[0,0];
         posAtTick_ = new Point();
         tickPosition_ = new Point();
         moveVec_ = new Vector3D();
         bitmapFill = new GraphicsBitmapFill(null,null,false,false);
         rangeBitmapFill = new GraphicsBitmapFill(null,null,false,false);
         path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,null);
         vS_ = new Vector.<Number>();
         uvt_ = new Vector.<Number>();
         fillMatrix_ = new Matrix();
         rangeFillMatrix = new Matrix();
         this.hpBarFillMatrix = new Matrix();
         this.hpBarOutlineFillMatrix = new Matrix();
         this.hpBarBackFillMatrix = new Matrix();
         super();
         if(param1 == null) {
            return;
         }
         this.objectType_ = int(param1.@type);
         this.props_ = ObjectLibrary.propsLibrary_[this.objectType_];
         hasShadow_ = this.props_.shadowSize_ > 0;
         var _loc2_:TextureData = ObjectLibrary.typeToTextureData_[this.objectType_];
         this.texture = _loc2_.texture_;
         this.mask_ = _loc2_.mask_;
         this.animatedChar_ = _loc2_.animatedChar_;
         this.randomTextureData_ = _loc2_.randomTextureData_;
         if(_loc2_.effectProps_) {
            this.effect_ = ParticleEffect.fromProps(_loc2_.effectProps_,this);
         }
         if(this.texture) {
            this.sizeMult_ = this.texture.height * 0.125;
         }
         var _loc4_:AnimationsData = ObjectLibrary.typeToAnimationsData_[this.objectType_];
         if(_loc4_) {
            this.animations_ = new Animations(_loc4_);
         }
         z_ = this.props_.z_;
         this.flying = this.props_.flying_;
         if("MaxHitPoints" in param1) {
            _loc3_ = param1.MaxHitPoints;
            this.maxHP_ = _loc3_;
            this.hp_ = _loc3_;
         }
         if("Defense" in param1) {
            this.defense_ = param1.Defense;
         }
         if("SlotTypes" in param1) {
            this.slotTypes_ = ConversionUtil.toIntVector(param1.SlotTypes);
            this.equipment_ = new Vector.<int>(this.slotTypes_.length);
            _loc6_ = uint(this.equipment_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_) {
               this.equipment_[_loc5_] = -1;
               _loc5_++;
            }
            this.lockedSlot = new Vector.<int>(this.slotTypes_.length);
         }
         if("Tex1" in param1) {
            this.tex1Id_ = param1.Tex1;
         }
         if("Tex2" in param1) {
            this.tex2Id_ = param1.Tex2;
         }
         if("StunImmune" in param1) {
            this.isStunImmuneVar = true;
         }
         if("ParalyzeImmune" in param1) {
            this.isParalyzeImmuneVar = true;
         }
         if("SlowedImmune" in param1) {
            this.isSlowedImmuneVar = true;
         }
         if("DazedImmune" in param1) {
            this.isDazedImmuneVar = true;
         }
         if("StasisImmune" in param1) {
            this.isStasisImmune_ = true;
         }
         if("Invincible" in param1) {
            this.isInvincibleXML = true;
         }
         this.props_.loadSounds();
      }
      
      public static function outputPositions(param1:GameObject) : String {
         return "X: " + round2(param1.x_) + ", Y: " + round2(param1.y_) + ", pX: " + round2(param1.posAtTick_.x) + ", pY: " + round2(param1.posAtTick_.y) + ", tX: " + round2(param1.tickPosition_.x) + ", tY: " + round2(param1.tickPosition_.y);
      }
      
      public static function round2(param1:Number) : Number {
         return param1 * 100 * 0.01;
      }
      
      override public function dispose() : void {
         super.dispose();
         this.texture = null;
         if(this.portrait_) {
            this.portrait_.dispose();
            this.portrait_ = null;
         }
         this.clearTextureCache();
         this.texturingCache_ = null;
         this.slotTypes_ = null;
         this.equipment_ = null;
         this.lockedSlot = null;
         if(this.nameBitmapData_) {
            this.nameBitmapData_.dispose();
            this.nameBitmapData_ = null;
         }
         this.nameFill_ = null;
         this.namePath_ = null;
         this.bitmapFill = null;
         this.path_.commands = null;
         this.path_.data = null;
         this.vS_ = null;
         this.uvt_ = null;
         this.fillMatrix_ = null;
         this.rangeFillMatrix = null;
         this.icons_ = null;
         this.iconFills_ = null;
         this.iconPaths_ = null;
         this.shadowGradientFill_ = null;
         if(this.shadowPath_) {
            this.shadowPath_.commands = null;
            this.shadowPath_.data = null;
            this.shadowPath_ = null;
         }
         this.footer_ = false;
         var _loc3_:int = 0;
         var _loc2_:* = this.rangeCache;
         for each(var _loc1_ in this.rangeCache) {
            _loc1_.dispose();
         }
         this.rangeCache = null;
      }
      
      override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
         map_ = param1;
         var _loc4_:* = param2;
         this.tickPosition_.x = _loc4_;
         this.posAtTick_.x = _loc4_;
         _loc4_ = param3;
         this.tickPosition_.y = _loc4_;
         this.posAtTick_.y = _loc4_;
         if(!this.moveTo(param2,param3)) {
            map_ = null;
            return false;
         }
         if(this.effect_ != null) {
            map_.addObj(this.effect_,param2,param3);
         }
         return true;
      }
      
      override public function removeFromMap() : void {
         if(square && this.props_.static_) {
            if(square.obj_ == this) {
               square.obj_ = null;
            }
            square = null;
         }
         if(this.effect_) {
            map_.removeObj(this.effect_.objectId_);
         }
         super.removeFromMap();
         this.dispose();
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc4_:int = 0;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Boolean = false;
         if(Parameters.data.showMobInfo) {
            if(!this.mobInfoShown && this.props_.isEnemy_) {
               this.mobInfo("" + this.objectType_);
               this.mobInfoShown = true;
            }
         } else {
            this.mobInfoShown = false;
         }
         if(!(this.moveVec_.x == 0 && this.moveVec_.y == 0)) {
            if(this.myLastTickId_ < map_.gs_.gsc_.lastTickId_) {
               this.moveVec_.x = 0;
               this.moveVec_.y = 0;
               this.moveTo(this.tickPosition_.x,this.tickPosition_.y);
            } else {
               _loc4_ = param1 - this.lastTickUpdateTime_;
               _loc6_ = this.posAtTick_.x + _loc4_ * this.moveVec_.x;
               _loc5_ = this.posAtTick_.y + _loc4_ * this.moveVec_.y;
               this.moveTo(_loc6_,_loc5_);
               _loc3_ = true;
            }
         }
         if(this.props_.whileMoving_) {
            if(!_loc3_) {
               z_ = this.props_.z_;
               this.flying = this.props_.flying_;
            } else {
               z_ = this.props_.whileMoving_.z_;
               this.flying = this.props_.whileMoving_.flying_;
            }
         }
         return true;
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc7_:BitmapData = this.getTexture(param2,TimeUtil.getModdedTime());
         if(!_loc7_) {
            return;
         }
         var _loc4_:Boolean = this.props_ && (this.props_.isEnemy_ || this.props_.isPlayer_) && !this.isInvincible && (this.props_.isPlayer_ || !this.isInvulnerable) && !this.props_.noMiniMap_;
         if(this.props_.drawOnGround_) {
            if(Parameters.lowCPUMode || square.faces_.length == 0) {
               return;
            }
            this.path_.data = square.faces_[0].face.vout_;
            this.bitmapFill.bitmapData = _loc7_;
            square.baseTexMatrix_.calculateTextureMatrix(this.path_.data);
            this.bitmapFill.matrix = square.baseTexMatrix_.tToS_;
            param1.push(this.bitmapFill);
            return;
         }
         if(this.props_ && !this.isInvincible) {
            if(this.props_.isEnemy_ && !this.props_.noMiniMap_) {
               _loc4_ = true;
            } else if(this.props_.isPlayer_) {
               if(this == this.map_.player_) {
                  _loc4_ = true;
               } else if(Parameters.data.showHPBarOnAlly) {
                  _loc4_ = true;
               }
            }
         }
         var _loc9_:int = _loc7_.width;
         var _loc11_:int = _loc7_.height;
         var _loc8_:int = square.sink + this.sinkLevel;
         if(_loc8_ > 0 && this.flying) {
            _loc8_ = 0;
         }
         if(_loc8_ != 0) {
            GraphicsFillExtra.setSinkLevel(this.bitmapFill,Math.max(_loc8_ / _loc11_ * 1.65 - 0.02,0));
            _loc8_ = -_loc8_ + 0.02;
         } else if(_loc8_ == 0 && GraphicsFillExtra.getSinkLevel(this.bitmapFill) != 0) {
            GraphicsFillExtra.clearSink(this.bitmapFill);
         }
         this.vS_.length = 0;
         this.vS_.push(posS_[3] - _loc9_ / 2,posS_[4] - _loc11_ + _loc8_,posS_[3] + _loc9_ / 2,posS_[4] - _loc11_ + _loc8_,posS_[3] + _loc9_ / 2,posS_[4],posS_[3] - _loc9_ / 2,posS_[4]);
         if(!(Parameters.data.alphaOnOthers && this.props_.isPlayer_ && this != this.map_.player_)) {
            if(this.flash != null) {
               if(!this.flash.doneAt(param3)) {
                  this.flash.applyGPU(_loc7_,param3);
               } else {
                  this.flash = null;
                  GraphicsFillExtra.clearColorTransform(_loc7_);
               }
            } else if(GraphicsFillExtra.getColorTransform(_loc7_) != null) {
               GraphicsFillExtra.clearColorTransform(_loc7_);
            }
         }
         if(this.statusFlash_ != null) {
            if(!this.statusFlash_.doneAt(param3)) {
               this.statusFlash_.applyGPUTextureColorTransform(_loc7_,param3);
            } else {
               this.statusFlash_ = null;
            }
         }
         this.bitmapFill.bitmapData = _loc7_;
         this.fillMatrix_.identity();
         this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
         this.bitmapFill.matrix = this.fillMatrix_;
         param1.push(this.bitmapFill);
         var _loc10_:Player = this.map_.player_;
         if(Parameters.data.showRange && _loc10_.objectId_ == this.objectId_ && _loc10_.range != -1) {
            this.rangeBitmapFill.bitmapData = this.getRangeCircle(this.map_.player_.range);
            this.rangeFillMatrix.identity();
            this.rangeFillMatrix.translate(posS_[3] - this.rangeBitmapFill.bitmapData.width / 2,posS_[4] - this.rangeBitmapFill.bitmapData.height / 2 + (_loc8_ == 0?-30:_loc8_));
            this.rangeBitmapFill.matrix = this.rangeFillMatrix;
            param1.push(this.rangeBitmapFill);
         }
         if(Parameters.data.alphaOnOthers && this.props_.isPlayer_ && this != this.map_.player_) {
            return;
         }
         if(!this.isPaused && (this.condition_[0] || uint(this.condition_[1])) && !(this is Pet)) {
            this.drawConditionIcons(param1,param2,param3);
         }
         if(this.props_.showName_ && this.name_ && this.name_.length != 0) {
            this.drawName(param1,param2,false);
         }
         if(_loc4_) {
            if(this.props_.healthBar_ != -1 && this.bHPBarParamCheck()) {
               this.drawHpBar(param1,!!this.props_.healthBar_?this.props_.healthBar_:this.props_.isPlayer_ && this != map_.player_?13:0);
            }
         }
         if(!this.dead_ && Parameters.data.showDamageOnEnemy) {
            _loc5_ = Parameters.dmgCounter[this.objectId_];
            if(isNaN(_loc5_) || _loc5_ <= 0) {
               return;
            }
            _loc6_ = (_loc5_ / this.maxHP_ * 100).toFixed(2) + "%";
            if(_loc6_ != this.lastPercent) {
               var _loc12_:* = _loc6_;
               this.lastPercent = _loc12_;
               this.name_ = _loc12_;
               if(this.nameBitmapData_) {
                  this.nameBitmapData_.dispose();
               }
               this.nameBitmapData_ = null;
            }
            this.drawName(param1,param2,true);
         }
      }
      
      public function updateStatuses() : void {
         isPaused = isPaused_();
         isStasis = isStasis_();
         isInvincible = isInvincible_();
         isInvulnerable = isInvulnerable_();
         isArmored = isArmored_();
         isArmorBroken = isArmorBroken_();
         isArmorBrokenImmune = isArmorBrokenImmune_();
         isStunImmune = isStunImmune_();
         isSlowedImmune = isSlowedImmune_();
         isShowPetEffectIcon = isShowPetEffectIcon_();
         isParalyzeImmune = isParalyzeImmune_();
         isDazedImmune = isDazedImmune_();
         isPetrified = isPetrified_();
         isPetrifiedImmune = isPetrifiedImmune_();
         isCursed = isCursed_();
         isCursedImmune = isCursedImmune_();
      }
      
      public function damageWithDefense(param1:int, param2:int, param3:Boolean, param4:Vector.<uint>) : int {
         if(param3 || (param4[0] & 67108864) != 0) {
            param2 = 0;
         } else if((param4[0] & 33554432) != 0) {
            param2 = param2 * 1.5;
         }
         if((param4[1] & 131072) != 0) {
            param2 = param2 - 20;
         }
         var _loc5_:int = param1 * 3 / 20;
         var _loc6_:int = Math.max(_loc5_,param1 - param2);
         if((param4[0] & 16777216) != 0) {
            _loc6_ = 0;
         }
         if((param4[1] & 8) != 0) {
            _loc6_ = _loc6_ * 0.9;
         }
         if((param4[1] & 64) != 0) {
            _loc6_ = _loc6_ * 1.25;
         }
         return _loc6_;
      }
      
      public function setObjectId(param1:int) : void {
         var _loc2_:* = null;
         objectId_ = param1;
         if(this.randomTextureData_) {
            _loc2_ = this.randomTextureData_[objectId_ % this.randomTextureData_.length];
            this.texture = _loc2_.texture_;
            this.mask_ = _loc2_.mask_;
            this.animatedChar_ = _loc2_.animatedChar_;
         }
      }
      
      public function setTexture(param1:int) : void {
         var _loc2_:TextureData = ObjectLibrary.typeToTextureData_[param1];
         this.texture = _loc2_.texture_;
         this.mask_ = _loc2_.mask_;
         this.animatedChar_ = _loc2_.animatedChar_;
      }
      
      public function setAltTexture(param1:int) : void {
         var _loc3_:* = null;
         var _loc2_:TextureData = ObjectLibrary.typeToTextureData_[this.objectType_];
         if(param1 == 0) {
            _loc3_ = _loc2_;
         } else {
            _loc3_ = _loc2_.getAltTextureData(param1);
            if(_loc3_ == null) {
               return;
            }
         }
         this.texture = _loc3_.texture_;
         this.mask_ = _loc3_.mask_;
         this.animatedChar_ = _loc3_.animatedChar_;
         if(this.effect_) {
            this.map_.removeObj(this.effect_.objectId_);
            this.effect_ = null;
         }
         if(_loc3_.effectProps_ && !Parameters.data.noParticlesMaster) {
            this.effect_ = ParticleEffect.fromProps(_loc3_.effectProps_,this);
            if(this.map_) {
               this.map_.addObj(this.effect_,x_,y_);
            }
         }
      }
      
      public function setTex1(param1:int) : void {
         if(param1 == this.tex1Id_) {
            return;
         }
         this.tex1Id_ = param1;
         this.texturingCache_ = new Dictionary();
         this.portrait_ = null;
      }
      
      public function setTex2(param1:int) : void {
         if(param1 == this.tex2Id_) {
            return;
         }
         this.tex2Id_ = param1;
         this.texturingCache_ = new Dictionary();
         this.portrait_ = null;
      }
      
      public function playSound(param1:int) : void {
         SoundEffectLibrary.play(this.props_.sounds_[param1]);
      }
      
      public function isQuiet_() : Boolean {
         return (this.condition_[0] & 2) != 0;
      }
      
      public function isWeak_() : Boolean {
         return (this.condition_[0] & 4) != 0;
      }
      
      public function isSlowed_() : Boolean {
         return (this.condition_[0] & 8) != 0;
      }
      
      public function isSick_() : Boolean {
         return (this.condition_[0] & 16) != 0;
      }
      
      public function isDazed_() : Boolean {
         return (this.condition_[0] & 32) != 0;
      }
      
      public function isStunned_() : Boolean {
         return (this.condition_[0] & 64) != 0;
      }
      
      public function isBlind_() : Boolean {
         if((256 & Parameters.data.ccdebuffBitmask) > 0) {
            return false;
         }
         return (this.condition_[0] & 128) != 0;
      }
      
      public function isDrunk_() : Boolean {
         if((1024 & Parameters.data.ccdebuffBitmask) > 0) {
            return false;
         }
         return (this.condition_[0] & 512) != 0;
      }
      
      public function isBleeding_() : Boolean {
         return (this.condition_[0] & 32768) != 0;
      }
      
      public function isConfused_() : Boolean {
         if((2048 & Parameters.data.ccdebuffBitmask) > 0) {
            return false;
         }
         return (this.condition_[0] & 1024) != 0;
      }
      
      public function isStunImmune_() : Boolean {
         return (this.condition_[0] & 2048) != 0 || this.isStunImmuneVar;
      }
      
      public function isInvisible_() : Boolean {
         return (this.condition_[0] & 4096) != 0;
      }
      
      public function isParalyzed_() : Boolean {
         return (this.condition_[0] & 8192) != 0;
      }
      
      public function isSpeedy_() : Boolean {
         return (this.condition_[0] & 16384) != 0;
      }
      
      public function isNinjaSpeedy_() : Boolean {
         return (this.condition_[0] & 268435456) != 0;
      }
      
      public function isHallucinating_() : Boolean {
         if((512 & Parameters.data.ccdebuffBitmask) > 0) {
            return false;
         }
         return (this.condition_[0] & 256) != 0;
      }
      
      public function isHealing_() : Boolean {
         return (this.condition_[0] & 131072) != 0;
      }
      
      public function isDamaging_() : Boolean {
         return (this.condition_[0] & 262144) != 0;
      }
      
      public function isBerserk_() : Boolean {
         return (this.condition_[0] & 524288) != 0;
      }
      
      public function isPaused_() : Boolean {
         return (this.condition_[0] & 1048576) != 0;
      }
      
      public function isStasis_() : Boolean {
         return (this.condition_[0] & ConditionEffect.STASIS_BIT) != 0;
      }
      
      public function isInvincible_() : Boolean {
         return this.isInvincibleXML || (this.condition_[0] & 8388608) != 0;
      }
      
      public function isInvulnerable_() : Boolean {
         return (this.condition_[0] & 16777216) != 0;
      }
      
      public function isArmored_() : Boolean {
         return (this.condition_[0] & 33554432) != 0;
      }
      
      public function isArmorBroken_() : Boolean {
         return (this.condition_[0] & 67108864) != 0;
      }
      
      public function isStasisImmune() : Boolean {
         return this.isStasisImmune_ || (this.condition_[0] & 4194304) != 0;
      }
      
      public function isArmorBrokenImmune_() : Boolean {
         return (this.condition_[0] & 65536) != 0;
      }
      
      public function isSlowedImmune_() : Boolean {
         return this.isSlowedImmuneVar || (this.condition_[1] & 1) != 0;
      }
      
      public function isUnstable_() : Boolean {
         if((1073741824 & Parameters.data.ccdebuffBitmask) > 0) {
            return false;
         }
         return (this.condition_[0] & 536870912) != 0;
      }
      
      public function isShowPetEffectIcon_() : Boolean {
         return (this.condition_[1] & 37) != 0;
      }
      
      public function isDarkness_() : Boolean {
         if((-2147483648 & Parameters.data.ccdebuffBitmask) > 0) {
            return false;
         }
         return (this.condition_[1] & 1073741824) != 0;
      }
      
      public function isParalyzeImmune_() : Boolean {
         return this.isParalyzeImmuneVar || (this.condition_[1] & 4) != 0;
      }
      
      public function isDazedImmune_() : Boolean {
         return this.isDazedImmuneVar || (this.condition_[1] & 2) != 0;
      }
      
      public function isPetrified_() : Boolean {
         return (this.condition_[1] & 8) != 0;
      }
      
      public function isPetrifiedImmune_() : Boolean {
         return (this.condition_[1] & 16) != 0;
      }
      
      public function isCursed_() : Boolean {
         return (this.condition_[1] & 64) != 0;
      }
      
      public function isCursedImmune_() : Boolean {
         return (this.condition_[1] & 128) != 0;
      }
      
      public function isSilenced_() : Boolean {
         return (this.condition_[1] & 65536) != 0;
      }
      
      public function isExposed_() : Boolean {
         return (this.condition_[1] & 131072) != 0;
      }
      
      public function isInspired() : Boolean {
         return (this.condition_[1] & 134217728) != 0;
      }
      
      public function isSafe(param1:int = 20) : Boolean {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = map_.goDict_;
         var _loc8_:int = 0;
         var _loc7_:* = map_.goDict_;
         for each(_loc2_ in map_.goDict_) {
            if(_loc2_ is Character && _loc2_.props_.isEnemy_) {
               _loc5_ = x_ > _loc2_.x_?x_ - _loc2_.x_:Number(_loc2_.x_ - x_);
               _loc3_ = y_ > _loc2_.y_?y_ - _loc2_.y_:Number(_loc2_.y_ - y_);
               if(_loc5_ < param1 && _loc3_ < param1) {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function getName() : String {
         return this.name_ == null || this.name_ == ""?ObjectLibrary.typeToDisplayId_[this.objectType_]:this.name_;
      }
      
      public function getColor() : uint {
         if(this.props_.color_ != -1) {
            return this.props_.color_;
         }
         return BitmapUtil.mostCommonColor(this.texture);
      }
      
      public function getBulletId() : uint {
         var _loc1_:uint = this.nextBulletId_;
         this.nextBulletId_ = (this.nextBulletId_ + 1) % 128;
         return _loc1_;
      }
      
      public function distTo(param1:WorldPosData) : Number {
         var _loc2_:Number = param1.x_ - x_;
         var _loc3_:Number = param1.y_ - y_;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function toggleShockEffect(param1:Boolean) : void {
         if(param1) {
            this.isShocked = true;
         } else {
            this.isShocked = false;
            this.isShockedTransformSet = false;
         }
      }
      
      public function toggleChargingEffect(param1:Boolean) : void {
         if(param1) {
            this.isCharging = true;
         } else {
            this.isCharging = false;
            this.isChargingTransformSet = false;
         }
      }
      
      public function moveTo(param1:Number, param2:Number) : Boolean {
         var _loc3_:Square = map_.getSquare(param1,param2);
         if(_loc3_ == null) {
            return false;
         }
         x_ = param1;
         y_ = param2;
         if(this.props_.static_) {
            if(square) {
               square.obj_ = null;
            }
            _loc3_.obj_ = this;
         }
         square = _loc3_;
         return true;
      }
      
      public function footer(param1:String) : void {
         var _loc2_:CharacterStatusText = new CharacterStatusText(this,16777215,-1);
         _loc2_.setText(param1);
         map_.mapOverlay_.addStatusText(_loc2_);
         this.footer_ = _loc2_;
      }
      
      public function mobInfo(param1:String) : void {
         var _loc2_:CharacterStatusText = new CharacterStatusText(this,16777215,2147483647);
         _loc2_.setText(param1);
         map_.mapOverlay_.addStatusText(_loc2_);
      }
      
      public function onGoto(param1:Number, param2:Number, param3:int) : void {
         this.moveTo(param1,param2);
         this.lastTickUpdateTime_ = param3;
         this.tickPosition_.x = param1;
         this.tickPosition_.y = param2;
         this.posAtTick_.x = param1;
         this.posAtTick_.y = param2;
         this.moveVec_.x = 0;
         this.moveVec_.y = 0;
      }
      
      public function onTickPos(param1:Number, param2:Number, param3:int, param4:int) : void {
         if(this.myLastTickId_ < map_.gs_.gsc_.lastTickId_) {
            this.moveTo(this.tickPosition_.x,this.tickPosition_.y);
         }
         this.lastTickUpdateTime_ = map_.gs_.lastUpdate_;
         this.tickPosition_.x = param1;
         this.tickPosition_.y = param2;
         this.posAtTick_.x = x_;
         this.posAtTick_.y = y_;
         this.moveVec_.x = (this.tickPosition_.x - this.posAtTick_.x) / param3;
         this.moveVec_.y = (this.tickPosition_.y - this.posAtTick_.y) / param3;
         this.myLastTickId_ = param4;
         param1 = Math.atan2(this.moveVec_.y,this.moveVec_.x);
         param2 = param1;
         this.jittery = param2 > param1 + 0.785398163397448 || param2 < param1 - 0.785398163397448;
      }
      
      public function damage(param1:Boolean, param2:int, param3:Vector.<uint>, param4:Boolean, param5:Projectile, param6:Boolean = false) : void {
         var _loc16_:int = 0;
         var _loc14_:* = undefined;
         var _loc7_:* = undefined;
         var _loc11_:int = 0;
         var _loc17_:int = 0;
         var _loc12_:* = undefined;
         var _loc20_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc19_:CharacterStatusText = null;
         var _loc18_:* = null;
         var _loc8_:* = null;
         var _loc15_:* = null;
         if(param4) {
            this.dead_ = true;
         } else if(param3) {
            param4 = !Parameters.data.ignoreStatusText;
            _loc11_ = 0;
            _loc16_ = 0;
            _loc14_ = param3;
            var _loc23_:int = 0;
            var _loc22_:* = param3;
            for each(_loc17_ in param3) {
               _loc10_ = null;
               if(param5 && param5.projProps.isPetEffect_ && param5.projProps.isPetEffect_[_loc17_]) {
                  _loc18_ = StaticInjectorContext.getInjector().getInstance(PetsModel);
                  _loc8_ = _loc18_.getActivePet();
                  if(_loc8_) {
                     _loc10_ = ConditionEffect.effects_[_loc17_];
                     if(param4) {
                        this.showConditionEffectPet(_loc11_,_loc10_.name_);
                     }
                     _loc11_ = _loc11_ + 500;
                  }
               } else {
                  _loc9_ = !!param6?16711935:16711680;
                  _loc7_ = _loc17_;
                  var _loc21_:* = _loc7_;
                  switch(_loc21_) {
                     case ConditionEffect.DEAD:
                        break;
                     case ConditionEffect.WEAK:
                     case ConditionEffect.SICK:
                     case ConditionEffect.BLIND:
                     case ConditionEffect.HALLUCINATING:
                     case ConditionEffect.DRUNK:
                     case ConditionEffect.CONFUSED:
                     case ConditionEffect.STUN_IMMUNE:
                     case ConditionEffect.INVISIBLE:
                     case ConditionEffect.SPEEDY:
                     case ConditionEffect.BLEEDING:
                     case ConditionEffect.HEXED:
                     case ConditionEffect.STASIS_IMMUNE:
                     case ConditionEffect.NINJA_SPEEDY:
                     case ConditionEffect.DARKNESS:
                     case ConditionEffect.UNSTABLE:
                     case ConditionEffect.PETRIFIED_IMMUNE:
                     case ConditionEffect.SILENCED:
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        break;
                     case ConditionEffect.QUIET:
                        if(this.map_.player_ == this) {
                           this.map_.player_.mp_ = 0;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        break;
                     case ConditionEffect.STASIS:
                        if(this.isStasisImmune_) {
                           _loc19_ = new CharacterStatusText(this,16711680,3000);
                           _loc19_.setText("Immune");
                           map_.mapOverlay_.addStatusText(_loc19_);
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        break;
                     case ConditionEffect.SLOWED:
                        if(this.isSlowedImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        break;
                     case ConditionEffect.ARMOR_BROKEN:
                        if(this.isArmorBrokenImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        break;
                     case ConditionEffect.STUNNED:
                        if(this.isStunImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        this.isStunned = true;
                        break;
                     case ConditionEffect.DAZED:
                        if(this.isDazedImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        this.isDazed = true;
                        break;
                     case ConditionEffect.PARALYZED:
                        if(this.isParalyzeImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        this.isParalyzed = true;
                        break;
                     case ConditionEffect.PETRIFIED:
                        if(this.isPetrifiedImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        this.isPetrified = true;
                        break;
                     case ConditionEffect.CURSE:
                        if(this.isCursedImmune) {
                           if(param4) {
                              _loc19_ = new CharacterStatusText(this,16711680,3000);
                              _loc19_.setText("Immune");
                              this.map_.mapOverlay_.addStatusText(_loc19_);
                              break;
                           }
                           break;
                        }
                        _loc10_ = ConditionEffect.effects_[_loc17_];
                        break;
                     case ConditionEffect.GROUND_DAMAGE:
                        _loc13_ = true;
                        break;
                  }
                  if(_loc10_) {
                     if(_loc17_ < 32) {
                        if((this.condition_[0] | _loc10_.bit_) != this.condition_[0]) {
                           this.condition_[0] = this.condition_[0] | _loc10_.bit_;
                        } else {
                           continue;
                        }
                     } else if((this.condition_[1] | _loc10_.bit_) != this.condition_[1]) {
                        this.condition_[1] = this.condition_[1] | _loc10_.bit_;
                     } else {
                        continue;
                     }
                     _loc15_ = _loc10_.localizationKey_;
                     if(!Parameters.data.ignoreStatusText) {
                        this.showConditionEffect(_loc11_,_loc15_);
                     }
                     _loc11_ = _loc11_ + 500;
                  }
               }
            }
         }
         if(!(this.props_.isEnemy_ && Parameters.data.disableEnemyParticles) && !(!this.props_.isEnemy_ && Parameters.data.disablePlayersHitParticles) && this.texture) {
            if(!Parameters.data.liteParticle) {
               _loc12_ = this.getBloodComposition(this.objectType_,this.texture,this.props_.bloodProb_,this.props_.bloodColor_);
               if(this.dead_) {
                  map_.addObj(new ExplosionEffect(_loc12_,this.size_,30),x_,y_);
               } else if(param5) {
                  map_.addObj(new HitEffect(_loc12_,this.size_,10,param5.angle,param5.projProps.speed),x_,y_);
               } else {
                  map_.addObj(new ExplosionEffect(_loc12_,this.size_,10),x_,y_);
               }
            } else {
               _loc12_ = this.getBloodComposition(this.objectType_,this.texture,this.props_.bloodProb_,this.props_.bloodColor_);
               if(this.dead_) {
                  map_.addObj(new ExplosionEffect(_loc12_,this.size_,30),x_,y_);
               } else if(param5) {
                  map_.addObj(new HitEffect(_loc12_,this.size_,10,param5.angle,param5.projProps.speed),x_,y_);
               } else {
                  map_.addObj(new ExplosionEffect(_loc12_,this.size_,10),x_,y_);
               }
            }
         }
         if(!param1 && (Parameters.data.noEnemyDamage && this.props_.isEnemy_ || Parameters.data.noAllyDamage && this.props_.isPlayer_)) {
            return;
         }
         if(param2 > 0 && !this.dead_ && this.map_) {
            if(Parameters.data.autoDecrementHP && this != this.map_.player_) {
               this.hp_ = this.hp_ - param2;
            }
            _loc20_ = this.isArmorBroken || param5 && param5.projProps.armorPiercing_ || _loc13_ || param6;
            this.showDamageText(param2,_loc20_);
         }
      }
      
      public function showConditionEffect(param1:int, param2:String) : void {
         var _loc3_:CharacterStatusText = null;
         if(this.texture) {
            _loc3_ = new CharacterStatusText(this,16711680,3000,param1);
            _loc3_.setText(param2);
            map_.mapOverlay_.addStatusText(_loc3_);
         }
      }
      
      public function showConditionEffectPet(param1:int, param2:String) : void {
         var _loc3_:CharacterStatusText = null;
         if(this.texture) {
            _loc3_ = new CharacterStatusText(this,16711680,3000,param1);
            _loc3_.setText("Pet " + param2);
            map_.mapOverlay_.addStatusText(_loc3_);
         }
      }
      
      public function showDamageText(param1:int, param2:Boolean) : void {
         var _loc3_:String = null;
         var _loc4_:CharacterStatusText = null;
         if(this.texture) {
            _loc3_ = "-" + param1;
            if(!Parameters.data.dynamicHPcolor) {
               _loc4_ = new CharacterStatusText(this,!!param2?9437439:16711680,1000);
            } else {
               _loc4_ = new CharacterStatusText(this,!!param2?9437439:Character.green2redu((this.hp_ - param1) * 100 / this.maxHP_),1000);
            }
            _loc4_.setText(_loc3_);
            map_.mapOverlay_.addStatusText(_loc4_);
         }
      }
      
      public function drawName(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:Boolean) : void {
         if(Parameters.lowCPUMode) {
            return;
         }
         if(this.nameBitmapData_ == null) {
            this.nameBitmapData_ = this.makeNameBitmapData();
            this.nameFill_ = new GraphicsBitmapFill(null,new Matrix(),false,false);
         }
         var _loc6_:int = this.nameBitmapData_.width * 0.5 + 1;
         var _loc4_:Vector.<Number> = new Vector.<Number>();
         _loc4_.length = 0;
         if(param3) {
            _loc4_.push(posS_[0] - _loc6_,posS_[1] + 12,posS_[0] + _loc6_,posS_[1] + 12,posS_[0] + _loc6_,posS_[1] + 42,posS_[0] - _loc6_,posS_[1] + 42);
         } else {
            _loc4_.push(posS_[0] - _loc6_,posS_[1],posS_[0] + _loc6_,posS_[1],posS_[0] + _loc6_,posS_[1] + 30,posS_[0] - _loc6_,posS_[1] + 30);
         }
         this.nameFill_.bitmapData = this.nameBitmapData_;
         var _loc5_:Matrix = this.nameFill_.matrix;
         _loc5_.identity();
         _loc5_.translate(_loc4_[0],_loc4_[1]);
         param1.push(this.nameFill_);
      }
      
      public function useAltTexture(param1:String, param2:int) : void {
         this.texture = AssetLibrary.getImageFromSet(param1,param2);
         this.sizeMult_ = this.texture.height * 0.125;
      }
      
      public function getPortrait() : BitmapData {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(this.portrait_ == null) {
            _loc2_ = this.props_.portrait_ != null?this.props_.portrait_.getTexture():this.texture;
            _loc1_ = 4 / _loc2_.width * 100;
            this.portrait_ = TextureRedrawer.resize(_loc2_,this.mask_,_loc1_,true,this.tex1Id_,this.tex2Id_);
            this.portrait_ = GlowRedrawer.outlineGlow(this.portrait_,0);
         }
         return this.portrait_;
      }
      
      public function setAttack(param1:int, param2:Number) : void {
         this.attackAngle_ = param2;
         this.attackStart_ = TimeUtil.getModdedTime();
      }
      
      public function drawConditionIcons(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc9_:* = null;
         var _loc13_:* = null;
         var _loc6_:int = param3 * 0.002;
         if(this.icons_ == null) {
            this.icons_ = new Vector.<BitmapData>();
            this.iconFills_ = new Vector.<GraphicsBitmapFill>();
            this.iconPaths_ = new Vector.<GraphicsPath>();
            this.icons_.length = 0;
            _loc10_ = this.condition_[0];
            _loc8_ = this.condition_[1];
            ConditionEffect.getConditionEffectIcons(_loc10_,this.icons_,_loc6_);
            ConditionEffect.getConditionEffectIcons2(_loc8_,this.icons_,_loc6_);
         } else {
            _loc10_ = this.condition_[0];
            _loc8_ = this.condition_[1];
            if(this.lastCon1 != _loc10_ || this.lastCon2 != _loc8_) {
               this.lastCon1 = _loc10_;
               this.lastCon2 = _loc8_;
               this.icons_.length = 0;
               ConditionEffect.getConditionEffectIcons(_loc10_,this.icons_,_loc6_);
               ConditionEffect.getConditionEffectIcons2(_loc8_,this.icons_,_loc6_);
            }
         }
         var _loc15_:Number = this.posS_[3];
         var _loc14_:Number = this.vS_[1];
         var _loc7_:int = this.icons_.length;
         param3 = 0;
         while(param3 < _loc7_) {
            _loc11_ = this.icons_[param3];
            if(param3 >= this.iconFills_.length) {
               this.iconFills_.push(new GraphicsBitmapFill(null,new Matrix(),false,false));
               this.iconPaths_.push(new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>()));
               _loc7_ = this.icons_.length;
            }
            _loc12_ = this.iconFills_[param3];
            _loc9_ = this.iconPaths_[param3];
            _loc12_.bitmapData = _loc11_;
            _loc5_ = _loc15_ - _loc11_.width * _loc7_ * 0.5 + param3 * _loc11_.width;
            _loc4_ = _loc14_ - _loc11_.height * 0.5;
            _loc9_.data.length = 0;
            (_loc9_.data as Vector.<Number>).push(_loc5_,_loc4_,_loc5_ + _loc11_.width,_loc4_,_loc5_ + _loc11_.width,_loc4_ + _loc11_.height,_loc5_,_loc4_ + _loc11_.height);
            _loc13_ = _loc12_.matrix;
            _loc13_.identity();
            _loc13_.translate(_loc5_,_loc4_);
            param1.push(_loc12_);
            param3++;
         }
      }
      
      public function clearTextureCache() : void {
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(this.texturingCache_ != null) {
            var _loc9_:int = 0;
            var _loc8_:* = this.texturingCache_;
            for each(_loc5_ in this.texturingCache_) {
               _loc1_ = _loc5_ as BitmapData;
               if(_loc1_ != null) {
                  _loc1_.dispose();
               } else {
                  _loc3_ = _loc5_ as Dictionary;
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc3_;
                  for each(_loc4_ in _loc3_) {
                     _loc2_ = _loc4_ as BitmapData;
                     if(_loc2_ != null) {
                        _loc2_.dispose();
                     }
                  }
               }
            }
         }
         this.texturingCache_ = new Dictionary();
      }
      
      public function toString() : String {
         return "[" + getQualifiedClassName(this) + " id: " + objectId_ + " itemType: " + ObjectLibrary.typeToDisplayId_[this.objectType_] + " pos: " + x_ + ", " + y_ + "]";
      }
      
      public function setSize(param1:int) : void {
         if(param1 == this.size_) {
            return;
         }
         this.size_ = param1;
         this.texturingCache_ = new Dictionary();
         this.portrait_ = null;
      }
      
      protected function makeNameBitmapData() : BitmapData {
         return BitmapTextFactory.make(this.name_,16,16777215,true,IDENTITY_MATRIX,true);
      }
      
      protected function getHallucinatingTexture() : BitmapData {
         if(this.hallucinatingTexture_ == null) {
            this.hallucinatingTexture_ = AssetLibrary.getImageFromSet("lofiChar8x8",int(Math.random() * 239));
         }
         return this.hallucinatingTexture_;
      }
      
      protected function getRangeCircle(param1:Number = -1) : BitmapData {
         var _loc5_:Number = (param1 == -1?this.props_.maxRange:Number(param1)) * 75 * 0.72;
         if(rangeCache[_loc5_]) {
            return rangeCache[_loc5_];
         }
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.lineStyle(5,16711935);
         _loc2_.graphics.drawCircle(0,0,_loc5_);
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc4_:Rectangle = _loc2_.getBounds(_loc2_);
         var _loc6_:Matrix = new Matrix();
         _loc6_.translate(-_loc4_.x,-_loc4_.y);
         _loc3_.draw(_loc2_,_loc6_);
         rangeCache[_loc5_] = _loc3_;
         return _loc3_;
      }
      
      protected function getTexture(param1:Camera, param2:int) : BitmapData {
         var _loc7_:* = NaN;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc13_:int = 0;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc4_:* = null;
         if(this is Pet) {
            _loc6_ = this as Pet;
            if(this.condition_[0] != 0 && !this.isPaused) {
               if(_loc6_.skinId != 32912) {
                  _loc6_.setSkin(32912);
               }
            } else if(!_loc6_.isDefaultAnimatedChar) {
               _loc6_.setDefaultSkin();
            }
         }
         var _loc5_:BitmapData = this.texture;
         var _loc12_:int = this.size_;
         if(this is Container && Parameters.data.bigLootBags && (this as Container).drawMeBig_) {
            _loc12_ = 200;
         }
         if(_loc5_.height == 64) {
            _loc12_ = 25;
         }
         if(this.animatedChar_) {
            _loc7_ = 0;
            _loc8_ = 0;
            if(param2 < this.attackStart_ + 300) {
               if(!this.props_.dontFaceAttacks_) {
                  this.facing_ = this.attackAngle_;
               }
               _loc7_ = Number((param2 - this.attackStart_) % 300 / 300);
               _loc8_ = 2;
            } else if(this.moveVec_.x != 0 || this.moveVec_.y != 0) {
               _loc3_ = 0.5 / this.moveVec_.length;
               _loc3_ = _loc3_ + (400 - _loc3_ % 400);
               if(this.moveVec_.x > 0.00001 || this.moveVec_.x < -0.00001 || this.moveVec_.y > 0.00001 || this.moveVec_.y < -0.00001) {
                  if(!this.props_.dontFaceMovement_) {
                     this.facing_ = Math.atan2(this.moveVec_.y,this.moveVec_.x);
                  }
                  _loc8_ = 1;
               } else {
                  _loc8_ = 0;
               }
               _loc7_ = Number(param2 % _loc3_ / _loc3_);
            }
            _loc10_ = this.animatedChar_.imageFromFacing(this.facing_,param1,_loc8_,_loc7_);
            _loc5_ = _loc10_.image_;
            _loc9_ = _loc10_.mask_;
         } else if(this.animations_) {
            _loc11_ = this.animations_.getTexture(param2);
            if(_loc11_) {
               _loc5_ = _loc11_;
            }
         }
         if(this.props_.drawOnGround_) {
            return _loc5_;
         }
         if(param1.isHallucinating_) {
            _loc13_ = _loc5_ == null?8:_loc5_.width;
            _loc5_ = this.getHallucinatingTexture();
            _loc9_ = null;
            _loc12_ = this.size_ * Math.min(1.5,_loc13_ / _loc5_.width);
         }
         if(!(this is Pet)) {
            if(this.isStasis || this.isPetrified) {
               _loc5_ = CachingColorTransformer.filterBitmapData(_loc5_,PAUSED_FILTER);
            }
         }
         if(this.tex1Id_ == 0 && this.tex2Id_ == 0) {
            if(this.isCursed && Parameters.data.curseIndication) {
               _loc5_ = TextureRedrawer.redraw(_loc5_,_loc12_,false,16711680);
            } else {
               _loc5_ = TextureRedrawer.redraw(_loc5_,_loc12_,false,0,true,5,0);
            }
         } else {
            _loc4_ = null;
            if(this.texturingCache_ == null) {
               this.texturingCache_ = new Dictionary();
            } else {
               _loc4_ = this.texturingCache_[_loc5_];
            }
            if(_loc4_ == null) {
               _loc4_ = TextureRedrawer.resize(_loc5_,_loc9_,_loc12_,false,this.tex1Id_,this.tex2Id_);
               _loc4_ = GlowRedrawer.outlineGlow(_loc4_,0);
               this.texturingCache_[_loc5_] = _loc4_;
            }
            _loc5_ = _loc4_;
         }
         if(_loc6_ && !this.myPet && Parameters.data.alphaOnOthers && !map_.isPetYard) {
            _loc5_ = CachingColorTransformer.alphaBitmapData(_loc5_,Parameters.data.alphaMan);
         }
         return _loc5_;
      }
      
      protected function drawHpBar(param1:Vector.<GraphicsBitmapFill>, param2:int = 6) : void {
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:uint = 0;
         if(this.hpBarFill == null || this.hpBarOutlineFill == null || this.hpBarBackFill == null) {
            this.hpBarFill = new GraphicsBitmapFill();
            this.hpBarOutlineFill = new GraphicsBitmapFill();
            this.hpBarBackFill = new GraphicsBitmapFill();
         }
         if(this.hp_ > this.maxHP_) {
            this.maxHP_ = this.hp_;
         }
         this.hpBarOutlineFill.bitmapData = TextureRedrawer.redrawSolidSquare(this is Player && (this as Player).icMS != -1?15911214:1118481,42,7,-1);
         this.hpBarBackFill.bitmapData = TextureRedrawer.redrawSolidSquare(1118481,40,5,-1);
         var _loc7_:int = posS_[0];
         var _loc4_:int = posS_[1];
         this.hpBarOutlineFillMatrix.identity();
         this.hpBarOutlineFillMatrix.translate(_loc7_ - 20 - 1 - 5,_loc4_ + param2 - 1);
         this.hpBarOutlineFill.matrix = this.hpBarOutlineFillMatrix;
         this.hpBarBackFillMatrix.identity();
         this.hpBarBackFillMatrix.translate(_loc7_ - 20 - 5,_loc4_ + param2);
         this.hpBarBackFill.matrix = this.hpBarBackFillMatrix;
         param1.push(this.hpBarOutlineFill);
         param1.push(this.hpBarBackFill);
         var _loc5_:int = this.hp_;
         if(_loc5_ > 0) {
            _loc6_ = _loc5_ / this.maxHP_;
            _loc8_ = _loc6_ * 40;
            _loc3_ = Character.green2redu(_loc6_ * 100);
            this.hpBarFill.bitmapData = TextureRedrawer.redrawSolidSquare(_loc3_,_loc8_,5,-1);
            this.hpBarFillMatrix.identity();
            this.hpBarFillMatrix.translate(_loc7_ - 20 - 5,_loc4_ + param2);
            this.hpBarFill.matrix = this.hpBarFillMatrix;
            param1.push(this.hpBarFill);
         }
      }
      
      private function bHPBarParamCheck() : Boolean {
         return Parameters.data.HPBar == 1 || Parameters.data.HPBar == 2 && this.props_.isEnemy_ || Parameters.data.HPBar == 3 && (this == map_.player_ || this.props_.isEnemy_) || Parameters.data.HPBar == 4 && this == map_.player_ || Parameters.data.HPBar == 5 && this.props_.isPlayer_;
      }
   }
}
