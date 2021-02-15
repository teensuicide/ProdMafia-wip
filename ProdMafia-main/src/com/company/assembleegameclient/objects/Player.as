package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Square;
   import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
   import com.company.assembleegameclient.objects.particles.HealingEffect;
   import com.company.assembleegameclient.objects.particles.LevelUpEffect;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import com.company.assembleegameclient.util.AnimatedChar;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.assembleegameclient.util.FreeList;
   import com.company.assembleegameclient.util.MaskedImage;
   import com.company.assembleegameclient.util.PlayerUtil;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.rotmg.graphics.StarGraphic;
   import com.company.util.CachingColorTransformer;
   import com.company.util.ConversionUtil;
   import com.company.util.IntPoint;
   import com.company.util.MoreColorUtil;
   import com.company.util.MoreStringUtil;
import com.company.util.Trig;
import com.company.util.PointUtil;
import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
import flash.utils.setTimeout;

import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.game.model.UseBuyPotionVO;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import kabam.rotmg.messaging.impl.incoming.Text;
   import kabam.rotmg.text.view.BitmapTextFactory;
   import org.osflash.signals.Signal;
   import org.swiftsuspenders.Injector;
   
   public class Player extends Character {

      public static const MS_BETWEEN_TELEPORT:int = 10000;

      public static const MS_REALM_TELEPORT:int = 120000;

      private static const MOVE_THRESHOLD:Number = 0.4;

      private static const NEARBY:Vector.<Point> = new <Point>[new Point(0,0),new Point(1,0),new Point(0,1),new Point(1,1)];

      public static var isAdmin:Boolean = false;

      public static var isMod:Boolean = false;

      private static var newP:Point = new Point();


      private const MIN_MOVE_SPEED:Number = 0.004;

      private const MAX_MOVE_SPEED:Number = 0.0096;

      private const DIF_MOVE_SPEED:Number = 0.0056;

      private const MIN_ATTACK_FREQ:Number = 0.0015;

      private const MAX_ATTACK_FREQ:Number = 0.008;

      private const DIF_ATTACK_FREQ:Number = 0.0065;

      private const MIN_ATTACK_MULT:Number = 0.5;

      private const MAX_ATTACK_MULT:Number = 2;

      private const DIF_ATTACK_MULT:Number = 1.5;

      private const DEFAULT_DROPSHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0,0,0,0.5,6,6,1);

      private const lightBlueCT:ColorTransform = new ColorTransform(0.541176470588235,0.596078431372549,0.870588235294118);

      private const darkBlueCT:ColorTransform = new ColorTransform(0.192156862745098,0.301960784313725,0.858823529411765);

      private const redCT:ColorTransform = new ColorTransform(0.756862745098039,0.152941176470588,0.176470588235294);

      private const orangeCT:ColorTransform = new ColorTransform(0.968627450980392,0.576470588235294,0.117647058823529);

      private const yellowCT:ColorTransform = new ColorTransform(1,1,0);

      private const hpPotionVO:UseBuyPotionVO = new UseBuyPotionVO(2594,1000000);

      private const mpPotionVO:UseBuyPotionVO = new UseBuyPotionVO(2595,1000001);

      private const RANK_OFFSET_MATRIX:Matrix = new Matrix(1,0,0,1,2,4);

      private const NAME_OFFSET_MATRIX:Matrix = new Matrix(1,0,0,1,20,1);

      public var unlockedBlueprints:Vector.<int> = new <int>[];

      public var isWalking:Boolean = false;

      public var projectileLifeMult:Number = 1.0;

      public var projectileSpeedMult:Number = 1.0;

      public var className:String;

      public var xpTimer:int;

      public var skinId:int;

      public var skin:AnimatedChar;

      public var isShooting:Boolean;

      public var accountId_:String = "";

      public var forgefire:int = 0;
      public var credits_:int = 0;

      public var numStars_:int = 0;

      public var starsBg_:int = 0;

      public var fame_:int = 0;

      public var nameChosen_:Boolean = false;

      public var currFame_:int = -1;

      public var nextClassQuestFame_:int = -1;

      public var legendaryRank_:int = -1;

      public var guildName_:String = null;

      public var guildRank_:int = -1;

      public var isFellowGuild_:Boolean = false;

      public var breath_:int = -1;

      public var maxMP_:int = 200;

      public var mp_:Number = 0;

      public var nextLevelExp_:int = 1000;

      public var exp_:int = 0;

      public var attack_:int = 0;

      public var speed_:int = 0;

      public var dexterity_:int = 0;

      public var vitality_:int = 0;

      public var wisdom:int = 0;

      public var mpZeroed_:Boolean = false;

      public var maxHPBoost_:int = 0;

      public var maxMPBoost_:int = 0;

      public var attackBoost_:int = 0;

      public var defenseBoost_:int = 0;

      public var speedBoost_:int = 0;

      public var vitalityBoost_:int = 0;

      public var wisdomBoost_:int = 0;

      public var dexterityBoost_:int = 0;

      public var exaltedHealth:int = 0;

      public var exaltedMana:int = 0;

      public var exaltedAttack:int = 0;

      public var exaltedDefense:int = 0;

      public var exaltedSpeed:int = 0;

      public var exaltedVitality:int = 0;

      public var exaltedWisdom:int = 0;

      public var exaltedDexterity:int = 0;

      public var exaltationDamageMultiplier:Number = 100;

      public var xpBoost_:int = 0;

      public var healthPotionCount_:int = 0;

      public var magicPotionCount_:int = 0;

      public var attackMax_:int = 0;

      public var defenseMax_:int = 0;

      public var speedMax_:int = 0;

      public var dexterityMax_:int = 0;

      public var vitalityMax_:int = 0;

      public var wisdomMax_:int = 0;

      public var maxHPMax_:int = 0;

      public var maxMPMax_:int = 0;

      public var hasBackpack_:Boolean = false;

      public var supporterFlag:int = 0;

      public var starred_:Boolean = false;

      public var ignored_:Boolean = false;

      public var distSqFromThisPlayer_:Number = 0;

      public var relMoveVec_:Point = null;

      public var conMoveVec:Point = null;

      public var attackPeriod_:int = 0;

      public var nextAltAttack_:int = 0;

      public var nextTeleportAt_:int = 0;

      public var lastTpTime_:int = 0;

      public var dropBoost:int = 0;

      public var tierBoost:int = 0;

      public var isDefaultAnimatedChar:Boolean = true;

      public var projectileIdSetOverrideNew:String = "";

      public var projectileIdSetOverrideOld:String = "";

      public var addTextLine:AddTextLineSignal;

      public var fakeTex1:int = -1;

      public var fakeTex2:int = -1;

      public var followLanded:Boolean = false;

      public var hpLog:Number = 0;

      public var clientHp:int = 100;

      public var syncedChp:int;

      public var healBuffer:int = 0;

      public var healBufferTime:int = 0;

      public var autoNexusNumber:int = 0;

      public var requestHealNumber:int = 0;

      public var autoHpPotNumber:int = 0;

      public var autoHealNumber:int = 0;

      public var autoMpPotNumber:int = 0;

      public var autoMpPercentNumber:int = 0;

      public var lastHpPotTime:int = 0;

      public var lastMpPotTime:int = 0;

      public var ticksHPLastOff:int = 0;

      public var lastHealRequest:int = 0;

      public var checkStacks:Boolean = false;

      public var isJumping:Boolean = false;

      public var jumpStart:int = -1;

      public var jumpDist:Number = 0;

      public var jumpRot:Number = 0;

      public var petType:int;

      public var petSize:int;

      public var followPos:Point;

      public var followVec:Point;

      public var walkPos:Point;

      public var mousePos_:Point;

      public var creditsWereChanged:Signal;

      public var fameWasChanged:Signal;

      public var supporterFlagWasChanged:Signal;

      public var range:Number = -1;

      protected var rotate_:Number = 0;

      protected var moveMultiplier_:Number = 1;

      protected var healingEffect_:HealingEffect = null;

      protected var nearestMerchant_:Merchant = null;

      protected var breathBarFillMatrix:Matrix;

      protected var breathBarBackFillMatrix:Matrix;

      private var prevWeaponId:int = -1;

      private var prevLifeMult:Number = -1;

      private var prevSpeedMult:Number = -1;

      private var famePortrait_:BitmapData = null;

      private var hallucinatingMaskedTex:MaskedImage;

      private var factory:CharacterFactory;

      private var supportCampaignModel:SupporterCampaignModel;

      private var breathBarBackFill:GraphicsBitmapFill = null;

      private var breathBarFill:GraphicsBitmapFill = null;

      private var lastAutoAbilityAttempt:int = 0;

      private var previousDamaging:Boolean = false;

      private var previousWeak:Boolean = false;

      private var previousBerserk:Boolean = false;

      private var previousDaze:Boolean = false;

      private var lastDamage:int;

      private var ip_:IntPoint;

      public var icMS:int = -1;

      private var prevTime:int = -1;
      public var quickSlotItem1:int;
      public var quickSlotItem2:int;
      public var quickSlotItem3:int;
      public var quickSlotCount1:int;
      public var quickSlotCount2:int;
      public var quickSlotCount3:int;
      public var quickSlotUpgrade:Boolean;

      public function Player(param1:XML) {
         followPos = new Point(0,0);
         followVec = new Point(0,0);
         walkPos = new Point(0,0);
         mousePos_ = new Point(0,0);
         creditsWereChanged = new Signal();
         fameWasChanged = new Signal();
         supporterFlagWasChanged = new Signal();
         ip_ = new IntPoint();
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         this.addTextLine = _loc2_.getInstance(AddTextLineSignal);
         this.factory = _loc2_.getInstance(CharacterFactory);
         this.supportCampaignModel = _loc2_.getInstance(SupporterCampaignModel);
         super(param1);
         this.attackMax_ = int(param1.Attack.@max);
         this.defenseMax_ = int(param1.Defense.@max);
         this.speedMax_ = int(param1.Speed.@max);
         this.dexterityMax_ = int(param1.Dexterity.@max);
         this.vitalityMax_ = int(param1.HpRegen.@max);
         this.wisdomMax_ = int(param1.MpRegen.@max);
         this.maxHPMax_ = int(param1.MaxHitPoints.@max);
         this.maxMPMax_ = int(param1.MaxMagicPoints.@max);
         this.className = param1.@id;
         this.texturingCache_ = new Dictionary();
         this.breathBarFillMatrix = new Matrix();
         this.breathBarBackFillMatrix = new Matrix();
      }

      public static function fromPlayerXML(param1:String, param2:XML) : Player {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:Player = null;
         var _loc7_:* = param1;
         var _loc6_:* = param2;
         _loc3_ = _loc6_.ObjectType;
         try {
            _loc4_ = ObjectLibrary.xmlLibrary_[_loc3_];
            _loc5_ = new Player(_loc4_);
            _loc5_.name_ = _loc7_;
            _loc5_.level_ = _loc6_.Level;
            _loc5_.exp_ = _loc6_.Exp;
            _loc5_.equipment_ = ConversionUtil.toIntVector(_loc6_.Equipment);
            _loc5_.calculateStatBoosts();
            _loc5_.lockedSlot = new Vector.<int>(_loc5_.equipment_.length);
            _loc5_.maxHP_ = _loc5_.maxHPBoost_ + int(_loc6_.MaxHitPoints);
            _loc5_.hp_ = int(_loc6_.HitPoints);
            _loc5_.maxMP_ = _loc5_.maxMPBoost_ + int(_loc6_.MaxMagicPoints);
            _loc5_.mp_ = int(_loc6_.MagicPoints);
            _loc5_.attack_ = _loc5_.attackBoost_ + int(_loc6_.Attack);
            _loc5_.defense_ = _loc5_.defenseBoost_ + int(_loc6_.Defense);
            _loc5_.speed_ = _loc5_.speedBoost_ + int(_loc6_.Speed);
            _loc5_.dexterity_ = _loc5_.dexterityBoost_ + int(_loc6_.Dexterity);
            _loc5_.vitality_ = _loc5_.vitalityBoost_ + int(_loc6_.HpRegen);
            _loc5_.wisdom = _loc5_.wisdomBoost_ + int(_loc6_.MpRegen);
            _loc5_.tex1Id_ = !!_loc6_.hasOwnProperty("Tex1")?int(_loc6_.Tex1):0;
            _loc5_.tex2Id_ = !!_loc6_.hasOwnProperty("Tex2")?int(_loc6_.Tex2):0;
            _loc5_.hasBackpack_ = _loc6_.HasBackpack == "1";
         }
         catch(error:Error) {
            throw new Error("Type: 0x" + _loc3_.toString(16) + " doesn\'t exist. " + error.message);
         }
         return _loc5_;
      }

      override public function moveTo(param1:Number, param2:Number) : Boolean {
         var _loc3_:Boolean = super.moveTo(param1,param2);
         if(map_.gs_.isSafeMap) {
            this.nearestMerchant_ = this.getNearbyMerchant();
         }
         return _loc3_;
      }

      public function combatTrigger() : int {
         var _loc3_:int = 0;
         var _loc5_:Vector.<Number> = new <Number>[1,0.75,0.5,0.25];
         var _loc1_:int = 0;
         var _loc2_:int = this.defense_;
         var _loc4_:int = Math.floor(_loc2_ / 15);
         _loc3_ = 0;
         while(_loc3_ < _loc4_) {
            _loc1_ = _loc1_ + 15 * _loc5_[Math.min(_loc3_,3)];
            _loc3_++;
         }
         _loc1_ = _loc1_ + _loc2_ % 15 * _loc5_[Math.min(Math.max(0,_loc4_ - 1),3)];
         return _loc1_;
      }

      public function icTime() : Number {
         return Math.max(7000 - this.vitality_ * 40,1000);
      }

      override public function updateStatuses() : void {
         if(this.map_.player_ == this) {
            this.isWeak = this.isWeak_();
            this.isSlowed = this.isSlowed_();
            this.isSick = this.isSick_();
            this.isDazed = this.isDazed_();
            this.isStunned = this.isStunned_();
            this.isBlind = this.isBlind_();
            this.isDrunk = this.isDrunk_();
            this.isBleeding = this.isBleeding_();
            this.isConfused = this.isConfused_();
            this.isParalyzed = this.isParalyzed_();
            this.isSpeedy = this.isSpeedy_();
            this.isNinjaSpeedy = this.isNinjaSpeedy_();
            this.isHallucinating = this.isHallucinating_();
            this.isDamaging = this.isDamaging_();
            this.isBerserk = this.isBerserk_();
            this.isUnstable = this.isUnstable_();
            this.isDarkness = this.isDarkness_();
            this.isSilenced = this.isSilenced_();
            this.isExposed = this.isExposed_();
            this.isQuiet = this.isQuiet_();
         }
         this.isInvisible = this.isInvisible_();
         this.isHealing = this.isHealing_();
         super.updateStatuses();
      }

      override public function update(param1:int, param2:int) : Boolean {
         var _loc17_:int = 0;
         var _loc23_:* = false;
         var _loc15_:* = false;
         var _loc19_:* = false;
         var _loc7_:ProjectileProperties = null;
         var _loc4_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc18_:* = null;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc12_:Number = NaN;
         if(this.map_.player_ == this) {
            if(this.isPaused) {
               return true;
            }
            this.calcHealth(param1 - map_.gs_.lastUpdate_);
            if(this.checkHealth(param1)) {
               return false;
            }
            _loc17_ = this.equipment_[0];
            _loc23_ = this.prevWeaponId != _loc17_;
            _loc15_ = this.prevLifeMult != this.projectileLifeMult;
            _loc19_ = this.prevSpeedMult != this.projectileSpeedMult;
            if(_loc17_ != -1) {
               if(this.range == -1 || _loc23_ || _loc15_ || _loc19_) {
                  _loc7_ = ObjectLibrary.propsLibrary_[_loc17_].projectiles_[0];
                  this.range = _loc7_.calcMaxRange(this.projectileSpeedMult, this.projectileLifeMult);
                  this.range = Math.min(this.range, 16);
                  if(_loc23_) {
                     this.prevWeaponId = _loc17_;
                  }
                  if(_loc15_) {
                     this.prevLifeMult = this.projectileLifeMult;
                  }
                  if(_loc19_) {
                     this.prevSpeedMult = this.projectileSpeedMult;
                  }
               }
            } else {
               this.range = -1;
            }
            if(this.icMS != -1 && TimeUtil.getTrueTime() - this.icMS >= this.icTime() * Parameters.data.timeScale) {
               this.icMS = -1;
            }
            this.checkMana(param1);
            _loc9_ = false;
            if(followPos.x != 0 && followPos.y != 0) {
               if(Parameters.followingName && Parameters.followName != "" && Parameters.followPlayer) {
                  if(this.followLanded) {
                     this.followVec.x = 0;
                     this.followVec.y = 0;
                     this.followLanded = false;
                  } else {
                     _loc9_ = true;
                     if(param1 - this.lastTpTime_ > Parameters.data.fameTpCdTime && getDistSquared(x_,y_,Parameters.followPlayer.tickPosition_.x,Parameters.followPlayer.tickPosition_.y) > Parameters.data.teleDistance) {
                        lastTpTime_ = param1;
                        teleToClosestPoint(followPos);
                     }
                     this.follow(this.followPos.x,this.followPos.y);
                  }
               }
            }
            if(Parameters.questFollow) {
               if(this.followLanded) {
                  this.followVec.x = 0;
                  this.followVec.y = 0;
                  this.followLanded = false;
               } else if(map_.quest_.objectId_ > 0) {
                  _loc6_ = map_.goDict_[map_.quest_.objectId_];
                  if(_loc6_) {
                     this.followPos.x = _loc6_.x_;
                     this.followPos.y = _loc6_.y_;
                  }
                  _loc9_ = true;
                  this.follow(this.followPos.x,this.followPos.y);
               } else {
                  this.followPos.x = this.x_;
                  this.followPos.y = this.y_;
                  this.follow(this.followPos.x,this.followPos.y);
               }
            } else if(Parameters.VHS == 2) {
               if(this.followLanded || getDistSquared(x_,y_,followPos.x,followPos.y) <= 0.2) {
                  if(Parameters.VHSRecordLength > 0) {
                     if(Parameters.VHSIndex >= Parameters.VHSRecordLength) {
                        Parameters.VHSIndex = 0;
                     }
                     _loc4_ = Parameters.VHSIndex;
                     Parameters.VHSIndex++;
                     Parameters.VHSNext = Parameters.VHSRecord[_loc4_];
                     this.followPos.x = Parameters.VHSNext.x;
                     this.followPos.y = Parameters.VHSNext.y;
                     this.followLanded = false;
                  }
               } else {
                  _loc9_ = true;
                  this.follow(this.followPos.x,this.followPos.y);
               }
            } else if(Parameters.VHS == 1) {
               if(this.x_ != -1 && this.y_ != -1) {
                  if(Parameters.VHSRecord.length == 0) {
                     Parameters.VHSRecord.push(new Point(this.x_,this.y_));
                  } else {
                     _loc10_ = Parameters.VHSRecord[Parameters.VHSRecord.length - 1];
                     if(_loc10_.x != this.x_ || _loc10_.y != this.y_) {
                        _loc11_ = this.getDistSquared(this.x_,this.y_,_loc10_.x,_loc10_.y);
                        if(_loc11_ >= 1) {
                           Parameters.VHSRecord.push(new Point(this.x_,this.y_));
                        }
                     }
                  }
               }
            } else if(Parameters.bazaarJoining) {
               if(this.map_.isNexus) {
                  _loc18_ = this.map_.findObject(1872);
                  if(_loc18_) {
                     _loc9_ = true;
                     _loc11_ = this.getDist(x_,y_,_loc18_.x_,_loc18_.y_);
                     this.followPos.x = _loc18_.x_;
                     if(Math.abs(_loc18_.y_ - this.y_) > 0.8 && (Math.abs(_loc18_.x_ - this.x_) < 0.5 || _loc11_ < Parameters.bazaarDist)) {
                        this.followPos.y = _loc18_.y_;
                     } else {
                        this.followPos.y = this.y_;
                     }
                     this.follow(this.followPos.x,this.followPos.y);
                     if(_loc11_ <= 1) {
                        followLanded = true;
                        _loc9_ = false;
                        this.map_.gs_.gsc_.usePortal(_loc18_.objectId_);
                     }
                  } else if(Parameters.bazaarLR == "left") {
                     this.followPos.x = this.x_ - 2;
                     this.followPos.y = this.y_;
                     this.follow(-1,-1);
                     _loc9_ = true;
                  } else if(Parameters.bazaarLR == "right") {
                     this.followPos.x = this.x_ + 2;
                     this.followPos.y = this.y_;
                     this.follow(-1,-1);
                     _loc9_ = true;
                  }
               } else {
                  Parameters.bazaarJoining = false;
               }
            }
            if(!_loc9_) {
               this.followVec.x = 0;
               this.followVec.y = 0;
            }
            if(!(map_.isVault && !Parameters.data.autoLootInVault)
                    && !isPaused && Parameters.data.AutoLootOn) {
               this.autoLoot(param1);
            }
            if(Parameters.swapINVandBP) {
               if(this.hasBackpack_) {
                  if(map_.gs_.lastUpdate_ - map_.gs_.gsc_.lastInvSwapTime >= 500) {
                     while(Parameters.swapINVandBPcounter <= 8) {
                        _loc20_ = Parameters.swapINVandBPcounter + 4;
                        _loc21_ = Parameters.swapINVandBPcounter + 12;
                        _loc4_ = Parameters.swapINVandBPcounter;
                        Parameters.swapINVandBPcounter++;
                        if(_loc4_ >= 8) {
                           Parameters.swapINVandBP = false;
                           Parameters.swapINVandBPcounter = 0;
                           break;
                        }
                        if(!(equipment_[_loc20_] == -1 && equipment_[_loc21_] == -1) && equipment_[_loc20_] != equipment_[_loc21_]) {
                           map_.gs_.gsc_.invSwap(this,this,_loc21_,equipment_[_loc21_],this,_loc20_,equipment_[_loc20_]);
                           break;
                        }
                     }
                  }
               }
            }
         }
         var _loc5_:* = 0;
         var _loc22_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Vector3D = null;
         var _loc16_:Number = NaN;
         var _loc3_:int = 0;
         var _loc8_:Vector.<uint> = null;
         if(!this.isPaused) {
            if(!this.map_.gs_.isSafeMap) {
               if(this.tierBoost) {
                  this.tierBoost = this.tierBoost - param2;
                  if(this.tierBoost < 0) {
                     this.tierBoost = 0;
                  }
               }
               if(this.dropBoost) {
                  this.dropBoost = this.dropBoost - param2;
                  if(this.dropBoost < 0) {
                     this.dropBoost = 0;
                  }
               }
            }
            if(this.xpTimer) {
               this.xpTimer = this.xpTimer - param2;
               if(this.xpTimer < 0) {
                  this.xpTimer = 0;
               }
            }
            if(this.isHealing && !Parameters.data.noParticlesMaster) {
               if(this.healingEffect_ == null) {
                  this.healingEffect_ = new HealingEffect(this);
                  this.map_.addObj(this.healingEffect_,x_,y_);
               }
            }
         }
         if(this.healingEffect_) {
            this.map_.removeObj(this.healingEffect_.objectId_);
            this.healingEffect_ = null;
         }
         if(this.relMoveVec_) {
            _loc5_ = Number(Parameters.data.cameraAngle);
            if(this.rotate_ != 0) {
               _loc5_ = Number(_loc5_ + param2 * 0.003 * this.rotate_);
               Parameters.data.cameraAngle = _loc5_;
            }
            if(this.relMoveVec_.x != 0 || this.relMoveVec_.y != 0) {
               this.walkPos = new Point(0,0);
               if(_loc9_) {
                  _loc9_ = false;
               }
               _loc22_ = this.getMoveSpeed();
               _loc14_ = Math.atan2(this.relMoveVec_.y,this.relMoveVec_.x);
               if(this.square.props_.slideAmount_ > 0 && !Parameters.data.ignoreIce) {
                  _loc13_ = new Vector3D();
                  _loc13_.x = _loc22_ * Math.cos(_loc5_ + _loc14_);
                  _loc13_.y = _loc22_ * Math.sin(_loc5_ + _loc14_);
                  _loc13_.z = 0;
                  _loc16_ = _loc13_.length;
                  _loc13_.scaleBy(-(this.square.props_.slideAmount_ - 1));
                  this.moveVec_.scaleBy(this.square.props_.slideAmount_);
                  if(this.moveVec_.length < _loc16_) {
                     this.moveVec_ = this.moveVec_.add(_loc13_);
                  }
               } else {
                  this.moveVec_.x = _loc22_ * Math.cos(_loc5_ + _loc14_);
                  this.moveVec_.y = _loc22_ * Math.sin(_loc5_ + _loc14_);
               }
            } else if(this.conMoveVec && (this.conMoveVec.x != 0 || this.conMoveVec.y != 0)) {
               this.walkPos = new Point(0,0);
               _loc22_ = this.getMoveSpeed();
               _loc12_ = PointUtil.distanceXY(0,0,this.conMoveVec.x,this.conMoveVec.y);
               if(_loc12_ < 1) {
                  _loc22_ = _loc22_ * _loc12_;
               }
               _loc14_ = -Math.atan2(this.conMoveVec.y,this.conMoveVec.x);
               if(this.square.props_.slideAmount_ > 0 && !Parameters.data.ignoreIce) {
                  _loc13_ = new Vector3D();
                  _loc13_.x = _loc22_ * Math.cos(_loc5_ + _loc14_);
                  _loc13_.y = _loc22_ * Math.sin(_loc5_ + _loc14_);
                  _loc13_.z = 0;
                  _loc16_ = _loc13_.length;
                  _loc13_.scaleBy(-(this.square.props_.slideAmount_ - 1));
                  this.moveVec_.scaleBy(this.square.props_.slideAmount_);
                  if(this.moveVec_.length < _loc16_) {
                     this.moveVec_ = this.moveVec_.add(_loc13_);
                  }
               } else {
                  this.moveVec_.x = _loc22_ * Math.cos(_loc5_ + _loc14_);
                  this.moveVec_.y = _loc22_ * Math.sin(_loc5_ + _loc14_);
               }
            } else if(this.walkPos.x != 0 || this.walkPos.y != 0) {
               _loc22_ = this.getMoveSpeed();
               _loc14_ = Math.atan2(this.walkPos.y - this.y_,this.walkPos.x - this.x_);
               if(this.square.props_.slideAmount_ > 0 && !Parameters.data.ignoreIce) {
                  _loc13_ = new Vector3D();
                  _loc13_.x = _loc22_ * Math.cos(_loc14_);
                  _loc13_.y = _loc22_ * Math.sin(_loc14_);
                  _loc13_.z = 0;
                  _loc16_ = _loc13_.length;
                  _loc13_.scaleBy(-(this.square.props_.slideAmount_ - 1));
                  this.moveVec_.scaleBy(this.square.props_.slideAmount_);
                  if(this.moveVec_.length < _loc16_) {
                     this.moveVec_ = this.moveVec_.add(_loc13_);
                  }
               } else {
                  this.moveVec_.x = _loc22_ * Math.cos(_loc14_);
                  this.moveVec_.y = _loc22_ * Math.sin(_loc14_);
               }
            } else if(_loc9_ && this.followPos && (this.followVec.x != 0 || this.followVec.y != 0)) {
               _loc22_ = this.getMoveSpeed();
               _loc14_ = Math.atan2(this.followVec.y,this.followVec.x);
               if(this.square.props_.slideAmount_ > 0 && !Parameters.data.ignoreIce) {
                  _loc13_ = new Vector3D();
                  _loc13_.x = _loc22_ * Math.cos(_loc14_);
                  _loc13_.y = _loc22_ * Math.sin(_loc14_);
                  _loc13_.z = 0;
                  _loc16_ = _loc13_.length;
                  _loc13_.scaleBy(-(this.square.props_.slideAmount_ - 1));
                  this.moveVec_.scaleBy(this.square.props_.slideAmount_);
                  if(this.moveVec_.length < _loc16_) {
                     this.moveVec_ = this.moveVec_.add(_loc13_);
                  }
               } else {
                  this.moveVec_.x = _loc22_ * Math.cos(_loc14_);
                  this.moveVec_.y = _loc22_ * Math.sin(_loc14_);
               }
            } else if(!Parameters.data.ignoreIce && this.moveVec_.length > 0.00012 && this.square.props_.slideAmount_ > 0) {
               this.moveVec_.scaleBy(this.square.props_.slideAmount_);
            } else {
               this.moveVec_.x = 0;
               this.moveVec_.y = 0;
            }
            if(this.square && this.square.props_ && this.square.props_.push_ && !Parameters.data.ignoreIce) {
               this.moveVec_.x = this.moveVec_.x - this.square.props_.animate_.dx_ * 0.001;
               this.moveVec_.y = this.moveVec_.y - this.square.props_.animate_.dy_ * 0.001;
            }
            if(_loc9_) {
               this.walkTo_follow(this.x_ + param2 * this.moveVec_.x,this.y_ + param2 * this.moveVec_.y);
            } else {
               this.walkTo(this.x_ + param2 * this.moveVec_.x,this.y_ + param2 * this.moveVec_.y);
            }
         } else if(!super.update(param1,param2)) {
            return false;
         }
         if(this.map_.player_ == this) {
            if(this.square && this.square.props_ && this.square.props_.maxDamage_ > 0 && (!!Parameters.data.reducedLava?this.lastDamage + 500 < param1:this.square.lastDamage_ + 500 < param1) && !this.isInvincible && (square.obj_ == null || square.obj_.props_ == null || !this.square.obj_.props_.protectFromGroundDamage_) && !Parameters.data.noClip) {
               _loc3_ = map_.gs_.gsc_.getNextDamage(this.square.props_.minDamage_,this.square.props_.maxDamage_);
               if(this.subtractDamage(_loc3_,param1)) {
                  return false;
               }
               _loc8_ = new <uint>[99];
               damage(true,_loc3_,_loc8_,hp_ <= _loc3_,null);
               this.map_.gs_.gsc_.groundDamage(param1,x_,y_);
               this.square.lastDamage_ = param1;
               this.lastDamage = param1;
            }
         }
         return true;
      }

      override protected function makeNameBitmapData() : BitmapData {
         var _loc1_:BitmapData = BitmapTextFactory.make(!!name_?name_:className,16,this.getNameColor(),true,NAME_OFFSET_MATRIX,true);
         _loc1_.draw(FameUtil.numStarsToIcon(this.numStars_), RANK_OFFSET_MATRIX);
         return _loc1_;
      }

      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         if(this != map_.player_ && !this.starred_ && (Parameters.lowCPUMode || Parameters.data.hideLockList)) {
            return;
         }
         if(this.prevTime != -1 && this == this.map_.player_ && conMoveVec) {
            this.walkTo(x_ + (param3 - this.prevTime) * conMoveVec.x,y_ + (param3 - this.prevTime) * conMoveVec.y);
         }
         this.prevTime = param3;
         super.draw(param1,param2,param3);
         if(this != map_.player_) {
            if(!Parameters.data.alphaOnOthers || this.starred_) {
               drawName(param1,param2,false);
            }
         } else if(this.breath_ >= 0) {
            this.drawBreathBar(param1,param3);
         }
      }

      override protected function getTexture(param1:Camera, param2:int) : BitmapData {
         var _loc8_:int = 0;
         var _loc5_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc13_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         if(this.isShooting || param2 < attackStart_ + this.attackPeriod_) {
            facing_ = attackAngle_;
            _loc10_ = (param2 - attackStart_) % this.attackPeriod_ / this.attackPeriod_;
            _loc11_ = 2;
         } else if(moveVec_.x != 0 || moveVec_.y != 0) {
            _loc8_ = 3.5 / this.getMoveSpeed();
            if(moveVec_.y != 0 || moveVec_.x != 0) {
               facing_ = Math.atan2(moveVec_.y,moveVec_.x);
            }
            _loc10_ = param2 % _loc8_ / _loc8_;
            _loc11_ = 1;
         }
         if(this.isHexed()) {
            this.isDefaultAnimatedChar && this.setToRandomAnimatedCharacter();
         } else if(!this.isDefaultAnimatedChar) {
            this.makeSkinTexture();
         }
         if(param1.isHallucinating_) {
            _loc9_ = new MaskedImage(getHallucinatingTexture(),null);
         } else {
            _loc9_ = animatedChar_.imageFromFacing(facing_,param1,_loc11_,_loc10_);
         }
         var _loc3_:int = tex1Id_;
         var _loc6_:int = tex2Id_;
         if(fakeTex1 != -1) {
            _loc3_ = fakeTex1;
         }
         if(fakeTex2 != -1) {
            _loc6_ = fakeTex2;
         }
         if(this.nearestMerchant_) {
            _loc4_ = texturingCache_[this.nearestMerchant_];
            if(_loc4_ == null) {
               texturingCache_[this.nearestMerchant_] = new Dictionary();
            } else {
               _loc13_ = _loc4_[_loc9_];
            }
            _loc3_ = this.nearestMerchant_.getTex1Id(tex1Id_);
            _loc6_ = this.nearestMerchant_.getTex2Id(tex2Id_);
         } else {
            _loc13_ = texturingCache_[_loc9_];
         }
         if(_loc13_ == null) {
            _loc13_ = TextureRedrawer.resize(_loc9_.image_,_loc9_.mask_,size_,false,_loc3_,_loc6_);
            if(this.nearestMerchant_ != null) {
               texturingCache_[this.nearestMerchant_][_loc9_] = _loc13_;
            } else {
               texturingCache_[_loc9_] = _loc13_;
            }
         }
         if(hp_ < maxHP_ * 0.2) {
            _loc5_ = Math.abs(Math.sin(param2 * 0.005)) * 10 * 0.1;
            _loc7_ = new ColorTransform(1,1,1,1,_loc5_ * 128,-_loc5_ * 128,-_loc5_ * 128);
            _loc13_ = CachingColorTransformer.transformBitmapData(_loc13_,_loc7_);
         }
         var _loc12_:BitmapData = texturingCache_[_loc13_];
         if(_loc12_ == null) {
            if(this == this.map_.player_) {
               if(Parameters.VHS == 1) {
                  _loc12_ = GlowRedrawer.outlineGlow(_loc13_,65280);
               } else if(Parameters.VHS == 2) {
                  _loc12_ = GlowRedrawer.outlineGlow(_loc13_,16768256);
               } else if(this.hasSupporterFeature(1)) {
                  _loc12_ = GlowRedrawer.outlineGlow(_loc13_,13395711,1.4,false,true);
               } else {
                  _loc12_ = GlowRedrawer.outlineGlow(_loc13_,this.legendaryRank_ == -1?0:16711680);
               }
            } else if(this.hasSupporterFeature(1)) {
               _loc12_ = GlowRedrawer.outlineGlow(_loc13_,13395711,1.4,false,true);
            } else {
               _loc12_ = GlowRedrawer.outlineGlow(_loc13_,this.legendaryRank_ == -1?0:16711680);
            }
            texturingCache_[_loc13_] = _loc12_;
         }
         if(Parameters.data.alphaOnOthers && (this.objectId_ != map_.player_.objectId_ && (!this.starred_ || this.isFellowGuild_ && Parameters.data.showAOGuildies))) {
            _loc12_ = CachingColorTransformer.alphaBitmapData(_loc12_,Parameters.data.alphaMan);
         } else if(this.isPaused || this.isStasis || this.isPetrified) {
            _loc12_ = CachingColorTransformer.filterBitmapData(_loc12_,PAUSED_FILTER);
         } else if(this.isInvisible) {
            _loc12_ = CachingColorTransformer.alphaBitmapData(_loc12_,0.4);
         }
         return _loc12_;
      }

      override public function getPortrait() : BitmapData {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(portrait_ == null) {
            _loc2_ = animatedChar_.imageFromDir(0,0,0);
            _loc1_ = 4 / _loc2_.image_.width * 100;
            portrait_ = TextureRedrawer.resize(_loc2_.image_,_loc2_.mask_,_loc1_,true,tex1Id_,tex2Id_);
            portrait_ = GlowRedrawer.outlineGlow(portrait_,0);
         }
         return portrait_;
      }

      override public function setAttack(param1:int, param2:Number) : void {
         var _loc4_:XML = ObjectLibrary.xmlLibrary_[param1];
         if(_loc4_ == null) {
            return;
         }
         var _loc3_:Number = !("RateOfFire" in _loc4_) ? 1 : _loc4_.RateOfFire;
         this.attackPeriod_ = 1 / this.attackFrequency() * (1 / _loc3_);
         super.setAttack(param1,param2);
      }

      override public function removeFromMap() : void {
         if(Parameters.followingName && Parameters.data.followIntoPortals && this.name_.toUpperCase() == Parameters.followName) {
            var _loc3_:int = 0;
            var _loc2_:* = map_.goDict_;
            for each(var _loc1_ in map_.goDict_) {
               if(_loc1_ is Portal && this.getDistSquared(x_,y_,_loc1_.x_,_loc1_.y_) <= 1) {
                  this.map_.gs_.gsc_.usePortal(_loc1_.objectId_);
                  break;
               }
            }
         }
         if(Parameters.followPlayer && objectId_ == Parameters.followPlayer.objectId_) {
            Parameters.followPlayer = null;
         }
         super.removeFromMap();
      }

      public function getDistFromSelf(param1:Number, param2:Number) : Number {
         var _loc3_:Number = param1 - this.x_;
         var _loc4_:Number = param2 - this.y_;
         return Math.sqrt(_loc4_ * _loc4_ + _loc3_ * _loc3_);
      }

      public function getFameBonus() : Number {
         var _loc3_:int = 0;
         var _loc2_:XML = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 4) {
            if(equipment_ && equipment_.length > _loc1_) {
               _loc3_ = equipment_[_loc1_];
               if(_loc3_ != -1) {
                  _loc2_ = ObjectLibrary.xmlLibrary_[_loc3_];
                  if(_loc2_ != null && _loc2_.hasOwnProperty("FameBonus")) {
                     _loc4_ = _loc4_ + Number(_loc2_.FameBonus);
                  }
               }
            }
            _loc1_++;
         }
         return _loc4_ / 100;
      }

      public function calculateStatBoosts() : void {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc7_:* = undefined;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         this.maxHPBoost_ = 0;
         this.maxMPBoost_ = 0;
         this.attackBoost_ = 0;
         this.defenseBoost_ = 0;
         this.speedBoost_ = 0;
         this.vitalityBoost_ = 0;
         this.wisdomBoost_ = 0;
         this.dexterityBoost_ = 0;
         while(_loc1_ < 4) {
            if(equipment_ && equipment_.length > _loc1_) {
               _loc3_ = equipment_[_loc1_];
               if(_loc3_ != -1) {
                  _loc6_ = ObjectLibrary.xmlLibrary_[_loc3_];
                  if(_loc6_ != null && _loc6_.hasOwnProperty("ActivateOnEquip")) {
                     _loc5_ = 0;
                     _loc4_ = _loc6_.ActivateOnEquip;
                     var _loc12_:int = 0;
                     var _loc11_:* = _loc6_.ActivateOnEquip;
                     for each(_loc9_ in _loc6_.ActivateOnEquip) {
                        if(_loc9_.toString() == "IncrementStat") {
                           _loc8_ = _loc9_.@stat;
                           _loc2_ = _loc9_.@amount;
                           _loc7_ = _loc8_;
                           var _loc10_:* = _loc7_;
                           switch(_loc10_) {
                              case 0:
                                 this.maxHPBoost_ = this.maxHPBoost_ + _loc2_;
                                 continue;
                              case 3:
                                 this.maxMPBoost_ = this.maxMPBoost_ + _loc2_;
                                 continue;
                              case 20:
                                 this.attackBoost_ = this.attackBoost_ + _loc2_;
                                 continue;
                              case 21:
                                 this.defenseBoost_ = this.defenseBoost_ + _loc2_;
                                 continue;
                              case 22:
                                 this.speedBoost_ = this.speedBoost_ + _loc2_;
                                 continue;
                              case 26:
                                 this.vitalityBoost_ = this.vitalityBoost_ + _loc2_;
                                 continue;
                              case 27:
                                 this.wisdomBoost_ = this.wisdomBoost_ + _loc2_;
                                 continue;
                              case 28:
                                 this.dexterityBoost_ = this.dexterityBoost_ + _loc2_;
                              default:
                                 continue;
                           }
                        } else {
                           continue;
                        }
                     }
                  }
               }
            }
            _loc1_++;
         }
      }

      public function setRelativeMovement(param1:Number, param2:Number, param3:Number) : void {
         var _loc4_:Number = NaN;
         this.rotate_ = param1;
         if(!this.relMoveVec_) {
            this.relMoveVec_ = new Point();
         }
         this.relMoveVec_.x = param2;
         this.relMoveVec_.y = param3;
         if(this.isConfused) {
            _loc4_ = this.relMoveVec_.x;
            this.relMoveVec_.x = -this.relMoveVec_.y;
            this.relMoveVec_.y = -_loc4_;
            this.rotate_ = -this.rotate_;
         }
      }

      public function setCredits(param1:int) : void {
         this.credits_ = param1;
         this.creditsWereChanged.dispatch();
      }

      public function setFame(param1:int) : void {
         this.fame_ = param1;
         this.fameWasChanged.dispatch();
      }

      public function setSupporterFlag(param1:int) : void {
         this.supporterFlag = param1;
         this.supporterFlagWasChanged.dispatch();
      }

      public function hasSupporterFeature(param1:int) : Boolean {
         return (this.supporterFlag & param1) == param1;
      }

      public function setGuildName(param1:String) : void {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:Boolean = false;
         this.guildName_ = param1;
         var _loc2_:Player = map_.player_;
         if(_loc2_ == this) {
            _loc5_ = 0;
            _loc4_ = map_.goDict_;
            var _loc9_:int = 0;
            var _loc8_:* = map_.goDict_;
            for each(_loc7_ in map_.goDict_) {
               _loc6_ = _loc7_ as Player;
               if(_loc6_ != null && _loc6_ != this) {
                  _loc6_.setGuildName(_loc6_.guildName_);
               }
            }
         } else {
            _loc3_ = _loc2_ && _loc2_.guildName_ && _loc2_.guildName_ != "" && _loc2_.guildName_ == this.guildName_;
            if(_loc3_ != this.isFellowGuild_) {
               this.isFellowGuild_ = _loc3_;
               if(this.nameBitmapData_) {
                  this.nameBitmapData_.dispose();
               }
               this.nameBitmapData_ = null;
            }
         }
      }

      public function isTeleportEligible(param1:Player) : Boolean {
         return !(param1.dead_ || param1.isPaused || param1.isInvisible);
      }

      public function msUtilTeleport() : int {
         var _loc1_:int = TimeUtil.getTrueTime();
         return Math.max(0,this.nextTeleportAt_ - _loc1_);
      }

      public function teleportTo(param1:Player) : Boolean {
         map_.gs_.gsc_.teleport(param1.objectId_);
         return true;
      }

      public function levelUpEffect(param1:String, param2:Boolean = true) : void {
         if(param2 && !Parameters.data.noParticlesMaster) {
            this.levelUpParticleEffect();
         }
         var _loc3_:CharacterStatusText = new CharacterStatusText(this,65280,2000);
         _loc3_.setText(param1);
         map_.mapOverlay_.addStatusText(_loc3_);
      }

      public function handleLevelUp(param1:Boolean) : void {
         SoundEffectLibrary.play("level_up");
         if(param1) {
            this.levelUpEffect("New Class Unlocked!",false);
            this.levelUpEffect("Level Up!");
         } else {
            this.levelUpEffect("Level Up!");
         }
         if(this == this.map_.player_) {
            this.clientHp = this.maxHP_;
         }
      }

      public function levelUpParticleEffect(param1:uint = 4278255360) : void {
         map_.addObj(new LevelUpEffect(this,param1,20),x_,y_);
      }

      public function handleExpUp(param1:int) : void {
         if(level_ == 20 && !bForceExp()) {
            return;
         }
         var _loc2_:CharacterStatusText = new CharacterStatusText(this,65280,1000);
         _loc2_.setText("+" + param1 + " EXP");
         map_.mapOverlay_.addStatusText(_loc2_);
      }

      public function updateFame(param1:int) : void {
         var _loc2_:CharacterStatusText = new CharacterStatusText(this,14835456,2000);
         _loc2_.setText("+" + param1 + " Fame");
         map_.mapOverlay_.addStatusText(_loc2_);
      }

      public function walkTo(param1:Number, param2:Number) : Boolean {
         this.modifyMove(param1,param2,newP);
         if(Math.abs(newP.x - walkPos.x) <= 0.1 && Math.abs(newP.y - walkPos.y) <= 0.1) {
            this.walkPos = new Point(0,0);
         }
         return this.moveTo(newP.x,newP.y);
      }

      public function smoothWalkTo(param1:Number, param2:Number) : Boolean {
         return false;
      }

      public function walkTo_follow(param1:Number, param2:Number) : Boolean {
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.modifyMove(param1,param2,newP);
         if(Parameters.followingName || Parameters.questFollow) {
            if(!this.followLanded && isValidPosition(this.followPos.x,this.followPos.y)) {
               _loc4_ = Math.abs(this.x_ - this.followPos.x);
               _loc3_ = Math.abs(this.y_ - this.followPos.y);
               _loc5_ = Math.abs(this.x_ - newP.x);
               _loc6_ = Math.abs(this.y_ - newP.y);
               if(_loc5_ >= _loc4_ && _loc6_ >= _loc3_) {
                  newP.x = followPos.x;
                  newP.y = followPos.y;
                  this.followLanded = true;
               }
            }
         }
         return this.moveTo(newP.x,newP.y);
      }

      public function modifyMove(param1:Number, param2:Number, param3:Point) : void {
         var _loc6_:Boolean = false;
         if(this.isParalyzed || this.isPetrified) {
            param3.x = x_;
            param3.y = y_;
            return;
         }
         var _loc5_:Number = param1 - x_;
         var _loc8_:Number = param2 - y_;
         if(_loc5_ < 0.4 && _loc5_ > -0.4 && _loc8_ < 0.4 && _loc8_ > -0.4) {
            this.modifyStep(param1,param2,param3);
            return;
         }
         var _loc7_:Number = 0.4 / Math.max(Math.abs(_loc5_),Math.abs(_loc8_));
         var _loc4_:* = 0;
         param3.x = x_;
         param3.y = y_;
         while(!_loc6_) {
            if(_loc4_ + _loc7_ >= 1) {
               _loc7_ = 1 - _loc4_;
               _loc6_ = true;
            }
            this.modifyStep(param3.x + _loc5_ * _loc7_,param3.y + _loc8_ * _loc7_,param3);
            _loc4_ = Number(_loc4_ + _loc7_);
         }
      }

      public function modifyStep(param1:Number, param2:Number, param3:Point) : void {
         var _loc8_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = x_ % 0.5 == 0 && param1 != x_ || int(x_ / 0.5) != int(param1 / 0.5);
         var _loc9_:Boolean = y_ % 0.5 == 0 && param2 != y_ || int(y_ / 0.5) != int(param2 / 0.5);
         if(!_loc6_ && !_loc9_ || this.isValidPosition(param1,param2)) {
            param3.x = param1;
            param3.y = param2;
            return;
         }
         if(_loc6_) {
            _loc8_ = param1 > x_?int(param1 * 2) / 2:Number(int(x_ * 2) / 2);
            if(int(_loc8_) > int(x_)) {
               _loc8_ = _loc8_ - 0.01;
            }
         }
         if(_loc9_) {
            _loc5_ = param2 > y_?int(param2 * 2) / 2:Number(int(y_ * 2) / 2);
            if(int(_loc5_) > int(y_)) {
               _loc5_ = _loc5_ - 0.01;
            }
         }
         if(!_loc6_) {
            param3.x = param1;
            param3.y = _loc5_;
            if(square != null && square.props_.slideAmount_ != 0) {
               this.resetMoveVector(false);
            }
            return;
         }
         if(!_loc9_) {
            param3.x = _loc8_;
            param3.y = param2;
            if(square != null && square.props_.slideAmount_ != 0) {
               this.resetMoveVector(true);
            }
            return;
         }
         var _loc4_:Number = param1 > x_?param1 - _loc8_:Number(_loc8_ - param1);
         var _loc7_:Number = param2 > y_?param2 - _loc5_:Number(_loc5_ - param2);
         if(_loc4_ > _loc7_) {
            if(this.isValidPosition(param1,_loc5_)) {
               param3.x = param1;
               param3.y = _loc5_;
               return;
            }
            if(this.isValidPosition(_loc8_,param2)) {
               param3.x = _loc8_;
               param3.y = param2;
               return;
            }
         } else {
            if(this.isValidPosition(_loc8_,param2)) {
               param3.x = _loc8_;
               param3.y = param2;
               return;
            }
            if(this.isValidPosition(param1,_loc5_)) {
               param3.x = param1;
               param3.y = _loc5_;
               return;
            }
         }
         param3.x = _loc8_;
         param3.y = _loc5_;
      }

      public function isValidPosition(param1:Number, param2:Number) : Boolean {
         if(Parameters.data.noClip) {
            return true;
         }
         var _loc5_:Square = map_.getSquare(param1,param2);
         if(square != _loc5_ && (_loc5_ == null || !_loc5_.isWalkable())) {
            return false;
         }
         var _loc4_:Number = param1 - int(param1);
         var _loc3_:Number = param2 - int(param2);
         if(_loc4_ < 0.5) {
            if(this.isFullOccupy(param1 - 1,param2)) {
               return false;
            }
            if(_loc3_ < 0.5) {
               if(this.isFullOccupy(param1,param2 - 1) || this.isFullOccupy(param1 - 1,param2 - 1)) {
                  return false;
               }
            } else if(_loc3_ > 0.5) {
               if(this.isFullOccupy(param1,param2 + 1) || this.isFullOccupy(param1 - 1,param2 + 1)) {
                  return false;
               }
            }
         } else if(_loc4_ > 0.5) {
            if(this.isFullOccupy(param1 + 1,param2)) {
               return false;
            }
            if(_loc3_ < 0.5) {
               if(this.isFullOccupy(param1,param2 - 1) || this.isFullOccupy(param1 + 1,param2 - 1)) {
                  return false;
               }
            } else if(_loc3_ > 0.5) {
               if(this.isFullOccupy(param1,param2 + 1) || this.isFullOccupy(param1 + 1,param2 + 1)) {
                  return false;
               }
            }
         } else if(_loc3_ < 0.5) {
            if(this.isFullOccupy(param1,param2 - 1)) {
               return false;
            }
         } else if(_loc3_ > 0.5) {
            if(this.isFullOccupy(param1,param2 + 1)) {
               return false;
            }
         }
         return true;
      }

      public function isFullOccupy(param1:Number, param2:Number) : Boolean {
         var _loc3_:Square = map_.lookupSquare(param1,param2);
         return _loc3_ == null || _loc3_.tileType == 255 || _loc3_.obj_ != null && _loc3_.obj_.props_.fullOccupy_;
      }

      public function follow(param1:Number, param2:Number) : void {
         followVec.x = followPos.x - x_;
         followVec.y = followPos.y - y_;
      }

      public function calcFollowPos() : Point {
         var _loc16_:int = 0;
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:Point = new Point();
         var _loc13_:Point = new Point();
         var _loc14_:Point = new Point();
         var _loc11_:Point = new Point();
         var _loc2_:int = -2147483648;
         var _loc15_:* = -2147483648;
         var _loc1_:* = 0;
         var _loc12_:Number = Parameters.data.densityThreshold * Parameters.data.densityThreshold;
         var _loc20_:int = 0;
         var _loc19_:* = this.map_.vulnPlayerDict_;
         for each(_loc4_ in this.map_.vulnPlayerDict_) {
            if(_loc4_ != this) {
               _loc1_ = 100000000000;
               _loc16_ = 0;
               _loc2_ = 0;
               _loc14_.x = 0;
               _loc14_.y = 0;
               _loc11_.x = 0;
               _loc11_.y = 0;
               var _loc18_:int = 0;
               var _loc17_:* = this.map_.vulnPlayerDict_;
               for each(_loc6_ in this.map_.vulnPlayerDict_) {
                  if(_loc6_ != this && _loc6_ != _loc4_) {
                     _loc10_ = _loc6_ as Player;
                     if(!(_loc10_.numStars_ < 3 && _loc10_.currFame_ < 100)) {
                        _loc1_ = getDistSquared(_loc6_.x_,_loc6_.y_,_loc4_.x_,_loc4_.y_);
                        if(_loc1_ < _loc12_) {
                           _loc2_++;
                           _loc16_++;
                           _loc14_.x = _loc14_.x + _loc6_.x_;
                           _loc14_.y = _loc14_.y + _loc6_.y_;
                           _loc11_.x = _loc11_.x + _loc6_.moveVec_.x;
                           _loc11_.y = _loc11_.y + _loc6_.moveVec_.y;
                        }
                     }
                  }
               }
               if(_loc16_ != 0) {
                  _loc14_.x = _loc14_.x / _loc16_;
                  _loc14_.y = _loc14_.y / _loc16_;
                  _loc11_.x = _loc11_.x / _loc16_;
                  _loc11_.y = _loc11_.y / _loc16_;
                  if(_loc2_ > _loc15_) {
                     _loc15_ = _loc2_;
                     _loc3_.x = _loc14_.x;
                     _loc3_.y = _loc14_.y;
                     _loc13_.x = _loc11_.x;
                     _loc13_.y = _loc11_.y;
                  }
               }
            }
         }
         if(_loc15_ < 3) {
            Parameters.warnDensity = true;
            return new Point(followPos.x,followPos.y);
         }
         Parameters.warnDensity = true;
         if(_loc13_.length > 1) {
            _loc13_.normalize(1);
         }
         _loc1_ = Parameters.data.trainOffset * 0.01;
         var _loc9_:Number = _loc3_.x + _loc13_.x * (_loc12_ * _loc1_) + Parameters.famePoint.x;
         var _loc8_:Number = _loc3_.y + _loc13_.y * (_loc12_ * _loc1_) + Parameters.famePoint.y;
         var _loc5_:Number = _loc9_ - _loc14_.x;
         var _loc7_:Number = _loc8_ - _loc14_.y;
         if(_loc5_ * _loc5_ + _loc7_ * _loc7_ >= Parameters.data.fameDistDelta * Parameters.data.fameDistDelta) {
            _loc14_.x = _loc9_;
            _loc14_.y = _loc8_;
         } else {
            _loc14_.x = x_;
            _loc14_.y = y_;
         }
         return _loc14_;
      }

      public function dungeonMove() : void {
      }

      public function teleToClosestPoint(param1:Point) : void {
         var _loc3_:Number = NaN;
         var _loc4_:* = Infinity;
         var _loc2_:int = -1;
         var _loc7_:int = 0;
         var _loc6_:* = this.map_.goDict_;
         for each(var _loc5_ in this.map_.goDict_) {
            if(_loc5_ is Player && !_loc5_.isInvisible && !_loc5_.isPaused) {
               _loc3_ = (_loc5_.x_ - param1.x) * (_loc5_.x_ - param1.x) + (_loc5_.y_ - param1.y) * (_loc5_.y_ - param1.y);
               if(_loc3_ < _loc4_) {
                  _loc4_ = _loc3_;
                  _loc2_ = _loc5_.objectId_;
               }
            }
         }
         if(_loc2_ == this.objectId_) {
            this.textNotification("You are closest!",16777215,1500,false);
            return;
         }
         this.map_.gs_.gsc_.teleport(_loc2_);
         this.textNotification("Teleporting to " + this.map_.goDict_[_loc2_].name_,16777215,1500,false);
      }

      public function attemptAttackAngle(param1:Number) : void {
         if(this.equipment_[0] == -1) {
            return;
         }
         this.shoot(Parameters.data.cameraAngle + param1);
      }

      public function attemptAutoAim(param1:Number) : void {
         var _loc2_:int = this.equipment_[0];
         var _loc3_:int = TimeUtil.getModdedTime();
         if(_loc2_ != -1) {
            if(Parameters.data.AAOn) {
               if(!this.shootAutoAimWeaponAngle(_loc2_,_loc3_) && this.map_.gs_.mui_.autofire_ && !this.map_.gs_.isSafeMap) {
                  this.shoot(Parameters.data.cameraAngle + param1,_loc3_);
               }
            } else if(this.map_.gs_.mui_.autofire_) {
               this.shoot(Parameters.data.cameraAngle + param1,_loc3_);
            }
         }
         this.attemptAutoAbility(param1,_loc3_,this.equipment_[1]);
      }

      public function attemptAutoAbility(param1:Number, param2:int = -1, param3:int = 0) : void {
         if(param3 == 0) {
            param3 = this.equipment_[1];
         }
         if(param2 == -1) {
            param2 = map_.gs_.lastUpdate_;
         }
         if(param3 != -1 && Parameters.data.AutoAbilityOn && !this.map_.gs_.isSafeMap && Parameters.abi && this.mp_ >= this.autoMpPercentNumber) {
            this.shootAutoAimAbilityAngle(param3,param2);
         }
      }

      public function shootAutoAimWeaponAngle(param1:int, param2:int) : Boolean {
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         if(this.isStunned_() || this.isPaused_() || this.isPetrified_()) {
            return false;
         }
         var _loc3_:ObjectProperties = ObjectLibrary.getPropsFromType(param1);
         this.attackPeriod_ = 1 / this.attackFrequency() * (1 / _loc3_.rateOfFire_);
         if(param2 < attackStart_ + this.attackPeriod_) {
            return false;
         }
         var _loc10_:Vector3D = new Vector3D(this.x_,this.y_);
         var _loc9_:Point = this.sToW(this.mousePos_.x,this.mousePos_.y);
         var _loc4_:Vector3D = new Vector3D(_loc9_.x,_loc9_.y);
         var _loc8_:ProjectileProperties = _loc3_.projectiles_[0];
         if(this.isUnstable) {
            this.attackStart_ = param2;
            this.attackAngle_ = Math.random() * 6.28318530717959;
            this.doShoot(this.attackStart_,param1,ObjectLibrary.xmlLibrary_[param1],this.attackAngle_,true,true,true);
            return true;
         }
         _loc6_ = this.calcAimAngle(_loc8_.calcAvgSpeed(this.projectileSpeedMult, this.projectileLifeMult),
                 _loc8_.calcMaxRange(this.projectileSpeedMult, this.projectileLifeMult) +
                 Parameters.data.aaDistance, _loc10_, _loc4_);
         if(_loc6_) {
            _loc7_ = Math.atan2(_loc6_.y - this.y_,_loc6_.x - this.x_);
            this.attackStart_ = param2;
            this.attackAngle_ = _loc7_;
            this.doShoot(this.attackStart_,param1,ObjectLibrary.xmlLibrary_[param1],_loc7_,true,true,true);
            return true;
         }
         this.isShooting = false;
         return false;
      }

      public function shootAutoAimAbilityAngle(param1:int, param2:int) : void {
         var _loc11_:* = undefined;
         var _loc15_:int = 0;
         var _loc13_:* = undefined;
         var _loc12_:* = undefined;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc5_:ProjectileProperties = null;
         var _loc7_:XML = ObjectLibrary.xmlLibrary_[param1];
         if(!this.canUseAltWeapon(param2,_loc7_)) {
            return;
         }
         if(param2 - this.lastAutoAbilityAttempt <= 550) {
            return;
         }
         var _loc10_:Point = this.sToW(this.mousePos_.x,this.mousePos_.y);
         param2 = TimeUtil.getModdedTime();
         var _loc14_:* = this.objectType_;
         var _loc18_:* = _loc14_;
         switch(_loc18_) {
            case 784:
               this.priestHeal(param2);
               this.lastAutoAbilityAttempt = param2;
               return;
            case 768:
               _loc11_ = _loc7_.Activate;
               _loc15_ = 0;
               _loc13_ = new XMLList("");
               var _loc16_:* = _loc7_.Activate;
               var _loc17_:int = 0;
               var _loc19_:* = new XMLList("");
               if(_loc7_.Activate.(text() == "Teleport") == "Teleport") {
                  return;
               }
            case 797:
            case 799:
               this.useAltWeapon(this.x_,this.y_,1,param2,true,_loc7_);
               this.lastAutoAbilityAttempt = param2;
               return;
            case 806:
               if(!this.isNinjaSpeedy) {
                  this.useAltWeapon(this.x_,this.y_,1,param2,true,_loc7_);
                  this.lastAutoAbilityAttempt = param2;
               }
               return;
            case 801:
            case 800:
            case 802:
               if(this.necroHeal()) {
                  this.lastAutoAbilityAttempt = param2;
               }
               return;
            case 804:
               _loc12_ = _loc7_.Activate;
               _loc6_ = 0;
               _loc11_ = new XMLList("");
               var _loc20_:* = _loc7_.Activate;
               var _loc21_:int = 0;
               _loc16_ = new XMLList("");
               if(_loc7_.Activate.(text() == "Teleport") == "Teleport") {
                  return;
               }
               _loc8_ = Parameters.data.spamPrismNumber;
               if(_loc8_ > 0) {
                  _loc9_ = 0;
                  var _loc23_:int = 0;
                  var _loc22_:* = this.map_.goDict_;
                  for each(var _loc3_ in this.map_.goDict_) {
                     if(_loc3_.props_.isEnemy_ && this.getDistSquared(this.x_,this.y_,_loc3_.x_,_loc3_.y_) <= 225) {
                        _loc9_++;
                        if(_loc9_ > _loc8_) {
                           this.useAltWeapon(this.x_,this.y_,1,param2,true,_loc7_);
                           this.lastAutoAbilityAttempt = param2;
                           return;
                        }
                     }
                  }
               }
               return;
            case 798:
            case 775:
               _loc5_ = ObjectLibrary.getPropsFromType(param1).projectiles_[0];
               if(_loc5_) {
                  _loc5_ = ObjectLibrary.getPropsFromType(param1).projectiles_[0];
                  if(this.isUnstable) {
                     _loc4_ = new Vector3D(Math.random() - 0.5,Math.random() - 0.5);
                  } else {
                     _loc4_ = this.calcAimAngle(_loc5_.speed,_loc5_.maxProjTravel_,new Vector3D(this.x_,this.y_),new Vector3D(_loc10_.x,_loc10_.y),true);
                  }
                  if(_loc4_) {
                     this.useAltWeapon(_loc4_.x,_loc4_.y,1,param2,true,_loc7_);
                     lastAutoAbilityAttempt = param2;
                  }
               }
               return;
            case 805:
               if(this.isUnstable) {
                  _loc4_ = null;
               } else {
                  _loc4_ = this.calcAimAngle(NaN,7,new Vector3D(this.x_,this.y_),new Vector3D(_loc10_.x,_loc10_.y));
               }
               if(_loc4_) {
                  this.useAltWeapon(_loc4_.x,_loc4_.y,1,param2,true,_loc7_);
                  lastAutoAbilityAttempt = param2;
               }
               return;
            case 782:
               if(this.isUnstable) {
                  _loc4_ = null;
               } else {
                  _loc4_ = this.calcAimAngle(NaN,12,new Vector3D(this.x_,this.y_),new Vector3D(_loc10_.x,_loc10_.y));
               }
               if(_loc4_) {
                  this.useAltWeapon(_loc4_.x,_loc4_.y,1,param2,true,_loc7_);
                  lastAutoAbilityAttempt = param2;
               }
               return;
            case 803:
               if(this.isUnstable) {
                  _loc4_ = new Vector3D(Math.random() - 0.5,Math.random() - 0.5);
               } else if(Parameters.data.mysticAAShootGroup) {
                  if(this.necroHeal()) {
                     this.lastAutoAbilityAttempt = param2;
                  }
               } else {
                  this.useAltWeapon(this.x_,this.y_,1,param2,true,_loc7_);
                  lastAutoAbilityAttempt = param2;
               }
               return;
            case 785:
               if(this.isUnstable) {
                  _loc4_ = null;
               } else {
                  _loc4_ = this.calcAimAngle(NaN,getWakiRange(param1),new Vector3D(this.x_,this.y_),new Vector3D(_loc10_.x,_loc10_.y));
               }
               if(_loc4_) {
                  this.useAltWeapon(_loc4_.x,_loc4_.y,1,param2,true,_loc7_);
                  lastAutoAbilityAttempt = param2;
               }
               return;
            default:
               return;
         }
      }

      public function getWakiRange(param1:int) : Number {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case 8994:
               return 4.6;
            case 9152:
               return 6.4;
            default:
               return 4.4;
         }
      }

      public function calcAimAngle(param1:Number, param2:Number, param3:Vector3D, param4:Vector3D, param5:Boolean = false) : Vector3D {
         var _loc23_:int = 0;
         var _loc24_:* = undefined;
         var _loc28_:int = 0;
         var _loc30_:* = undefined;
         var _loc14_:int = 0;
         var _loc21_:int = 0;
         var _loc25_:Boolean = false;
         var _loc19_:GameObject = null;
         var _loc18_:* = null;
         param2 = param2 * param2;
         var _loc27_:Vector3D = new Vector3D();
         var _loc26_:* = Infinity;
         var _loc29_:* = Infinity;
         var _loc12_:* = -2147483648;
         var _loc13_:* = -2147483648;
         var _loc7_:int = Parameters.data.AABoundingDist;
         _loc7_ = _loc7_ * _loc7_;
         var _loc16_:Boolean = Parameters.data.damageIgnored;
         var _loc11_:Boolean = Parameters.data.autoaimAtInvulnerable;
         var _loc8_:Boolean = Parameters.data.shootAtWalls;
         var _loc9_:Boolean = Parameters.data.onlyAimAtExcepted;
         var _loc20_:Boolean = Parameters.data.AATargetLead;
         var _loc22_:int = Parameters.data.spellbombHPThreshold;
         var _loc10_:int = Parameters.data.skullHPThreshold;
         var _loc17_:Boolean = Parameters.data.BossPriority;
         var _loc15_:Vector.<GameObject> = new Vector.<GameObject>();
         var _loc6_:Boolean = true;
         do {
            _loc14_ = Parameters.data.aimMode;
            if(_loc14_ == 0) {
               var _loc32_:int = 0;
               var _loc31_:* = this.map_.vulnEnemyDict_;
               for each(_loc19_ in this.map_.vulnEnemyDict_) {
                  _loc25_ = _loc19_.props_.boss_ || _loc19_.props_.customBoss_;
                  if(!(!_loc8_ && !(_loc19_ is Character))) {
                     if(!(_loc17_ && !_loc25_)) {
                        if(!(_loc19_.dead_ || _loc19_.props_.ignored && !_loc16_ || !_loc19_.props_.excepted && _loc9_ || !_loc11_ && _loc19_.isInvulnerable)) {
                           if(isNaN(param1)) {
                              if(!(param2 == 144 && _loc19_.maxHP_ < _loc22_)) {
                                 if(!(param2 == 49 && _loc19_.maxHP_ < _loc10_)) {
                                    _loc27_ = new Vector3D(_loc19_.tickPosition_.x,_loc19_.tickPosition_.y);
                                 }
                              }
                           } else if(!(param5 && _loc19_.maxHP_ < _loc22_)) {
                              if(_loc19_.jittery || !_loc20_) {
                                 _loc27_ = new Vector3D(_loc19_.x_,_loc19_.y_);
                              } else {
                                 _loc27_ = this.leadPos(param3,new Vector3D(_loc19_.x_,_loc19_.y_),new Vector3D(_loc19_.moveVec_.x,_loc19_.moveVec_.y),param1);
                              }
                           }
                           if(_loc27_) {
                              _loc26_ = this.getDistSquared(_loc19_.x_,_loc19_.y_,this.x_,this.y_);
                              if(_loc26_ <= param2) {
                                 _loc26_ = this.getDistSquared(_loc19_.x_,_loc19_.y_,param4.x,param4.y);
                                 if(_loc26_ <= _loc7_) {
                                    if(_loc17_ && _loc25_) {
                                       _loc6_ = false;
                                       _loc18_ = _loc27_;
                                    } else if(_loc26_ <= _loc29_) {
                                       _loc29_ = _loc26_;
                                       _loc18_ = _loc27_;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            } else if(_loc14_ == 1) {
               var _loc34_:int = 0;
               var _loc33_:* = this.map_.vulnEnemyDict_;
               for each(_loc19_ in this.map_.vulnEnemyDict_) {
                  _loc25_ = _loc19_.props_.boss_ || _loc19_.props_.customBoss_;
                  if(!(!_loc8_ && !(_loc19_ is Character))) {
                     if(!(_loc17_ && !_loc25_)) {
                        if(!(_loc19_.dead_ || _loc19_.props_.ignored && !_loc16_ || !_loc19_.props_.excepted && _loc9_ || !_loc11_ && _loc19_.isInvulnerable)) {
                           if(isNaN(param1)) {
                              if(!(param2 == 144 && _loc19_.maxHP_ < _loc22_)) {
                                 if(!(param2 == 49 && _loc19_.maxHP_ < _loc10_)) {
                                    _loc27_ = new Vector3D(_loc19_.tickPosition_.x,_loc19_.tickPosition_.y);
                                 }
                              }
                           } else if(_loc19_.jittery || !_loc20_) {
                              _loc27_ = new Vector3D(_loc19_.x_,_loc19_.y_);
                           } else {
                              _loc27_ = this.leadPos(param3,new Vector3D(_loc19_.x_,_loc19_.y_),new Vector3D(_loc19_.moveVec_.x,_loc19_.moveVec_.y),param1);
                           }
                           if(_loc27_) {
                              if(_loc19_.maxHP_ >= _loc12_) {
                                 if(_loc19_.maxHP_ == _loc12_) {
                                    if(_loc19_.hp_ <= _loc13_) {
                                       _loc26_ = this.getDistSquared(_loc19_.x_,_loc19_.y_,this.x_,this.y_);
                                       if(!(_loc19_.hp_ == _loc13_ && _loc26_ > _loc29_)) {
                                          if(_loc26_ < param2) {
                                             _loc12_ = _loc19_.maxHP_;
                                             _loc13_ = _loc19_.hp_;
                                             _loc18_ = _loc27_;
                                             _loc29_ = _loc26_;
                                          }
                                       }
                                    }
                                 }
                                 _loc26_ = this.getDistSquared(_loc19_.x_,_loc19_.y_,this.x_,this.y_);
                                 if(_loc26_ < param2) {
                                    if(_loc17_ && _loc25_) {
                                       _loc6_ = false;
                                       _loc18_ = _loc27_;
                                    } else {
                                       _loc12_ = _loc19_.maxHP_;
                                       _loc13_ = _loc19_.hp_;
                                       _loc29_ = _loc26_;
                                       _loc18_ = _loc27_;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            } else if(_loc14_ == 2) {
               _loc23_ = 0;
               _loc24_ = this.map_.vulnEnemyDict_;
               var _loc36_:int = 0;
               var _loc35_:* = this.map_.vulnEnemyDict_;
               for each(_loc19_ in this.map_.vulnEnemyDict_) {
                  _loc25_ = _loc19_.props_.boss_ || _loc19_.props_.customBoss_;
                  if(!(!_loc8_ && !(_loc19_ is Character))) {
                     if(!(_loc17_ && !_loc25_)) {
                        if(!(_loc19_.dead_ || _loc19_.props_.ignored && !_loc16_ || !_loc19_.props_.excepted && _loc9_ || !_loc11_ && _loc19_.isInvulnerable)) {
                           if(isNaN(param1)) {
                              if(!(param2 == 144 && _loc19_.maxHP_ < _loc22_)) {
                                 if(!(param2 == 49 && _loc19_.maxHP_ < _loc10_)) {
                                    _loc27_ = new Vector3D(_loc19_.tickPosition_.x,_loc19_.tickPosition_.y);
                                 } else {
                                    continue;
                                 }
                              } else {
                                 continue;
                              }
                           } else if(_loc19_.jittery || !_loc20_) {
                              _loc27_ = new Vector3D(_loc19_.x_,_loc19_.y_);
                           } else {
                              _loc27_ = this.leadPos(param3,new Vector3D(_loc19_.x_,_loc19_.y_),new Vector3D(_loc19_.moveVec_.x,_loc19_.moveVec_.y),param1);
                           }
                           if(_loc27_) {
                              _loc26_ = this.getDistSquared(_loc19_.x_,_loc19_.y_,this.x_,this.y_);
                              if(_loc26_ < param2) {
                                 if(_loc17_ && _loc25_) {
                                    _loc6_ = false;
                                    _loc18_ = _loc27_;
                                    break;
                                 }
                                 if(_loc26_ < _loc29_) {
                                    _loc29_ = _loc26_;
                                    _loc18_ = _loc27_;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            } else if(_loc14_ == 3) {
               _loc15_.length = 0;
               _loc21_ = 0;
               _loc28_ = 0;
               _loc30_ = this.map_.vulnEnemyDict_;
               var _loc38_:int = 0;
               var _loc37_:* = this.map_.vulnEnemyDict_;
               for each(_loc19_ in this.map_.vulnEnemyDict_) {
                  _loc25_ = _loc19_.props_.boss_ || _loc19_.props_.customBoss_;
                  if(!(!_loc8_ && !(_loc19_ is Character))) {
                     if(!(_loc17_ && !_loc25_)) {
                        if(!(_loc19_.dead_ || _loc19_.props_.ignored && !_loc16_ || !_loc19_.props_.excepted && _loc9_ || !_loc11_ && _loc19_.isInvulnerable)) {
                           if(isNaN(param1)) {
                              if(!(param2 == 144 && _loc19_.maxHP_ < _loc22_)) {
                                 if(!(param2 == 49 && _loc19_.maxHP_ < _loc10_)) {
                                    _loc27_ = new Vector3D(_loc19_.tickPosition_.x,_loc19_.tickPosition_.y);
                                 } else {
                                    continue;
                                 }
                              } else {
                                 continue;
                              }
                           } else if(_loc19_.jittery || !_loc20_) {
                              _loc27_ = new Vector3D(_loc19_.x_,_loc19_.y_);
                           } else {
                              _loc27_ = this.leadPos(param3,new Vector3D(_loc19_.x_,_loc19_.y_),new Vector3D(_loc19_.moveVec_.x,_loc19_.moveVec_.y),param1);
                           }
                           if(_loc27_) {
                              _loc26_ = this.getDistSquared(_loc19_.x_,_loc19_.y_,this.x_,this.y_);
                              if(_loc26_ < param2) {
                                 if(_loc17_ && _loc25_) {
                                    _loc6_ = false;
                                    _loc18_ = _loc27_;
                                    break;
                                 }
                                 _loc15_.push(_loc19_);
                                 _loc21_++;
                              }
                           }
                        }
                     }
                  }
               }
               if(_loc21_ != 0) {
                  _loc19_ = _loc15_[int(Math.random() * _loc21_)];
                  if(isNaN(param1)) {
                     _loc27_ = new Vector3D(_loc19_.tickPosition_.x,_loc19_.tickPosition_.y);
                  } else if(_loc19_.jittery || !_loc20_) {
                     _loc27_ = new Vector3D(_loc19_.x_,_loc19_.y_);
                  } else {
                     _loc27_ = this.leadPos(param3,new Vector3D(_loc19_.x_,_loc19_.y_),new Vector3D(_loc19_.moveVec_.x,_loc19_.moveVec_.y),param1);
                  }
                  _loc18_ = _loc27_;
               }
            }
            if(_loc17_) {
               if(_loc6_) {
                  _loc17_ = false;
               }
            } else {
               _loc6_ = false;
            }
         }
         while(_loc6_);

         return _loc18_;
      }

      public function leadPos(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : Vector3D {
         var _loc6_:Vector3D = param2.subtract(param1);
         var _loc11_:Number = 2 * (param3.dotProduct(param3) - param4 * param4);
         var _loc9_:Number = 2 * _loc6_.dotProduct(param3);
         var _loc10_:Number = _loc6_.dotProduct(_loc6_);
         var _loc7_:Number = Math.sqrt(_loc9_ * _loc9_ - 2 * _loc11_ * _loc10_);
         var _loc5_:Number = (-_loc9_ + _loc7_) / _loc11_;
         var _loc8_:Number = (-_loc9_ - _loc7_) / _loc11_;
         if(_loc5_ < _loc8_ && _loc5_ >= 0) {
            param3.scaleBy(_loc5_);
         } else if(_loc8_ >= 0) {
            param3.scaleBy(_loc8_);
         } else {
            return null;
         }
         return param2.add(param3);
      }

      public function getDist(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param2 - param4;
         return Math.sqrt(_loc6_ * _loc6_ + _loc5_ * _loc5_);
      }

      public function getDistSquared(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param2 - param4;
         return _loc6_ * _loc6_ + _loc5_ * _loc5_;
      }

      public function getDistObj(param1:GameObject, param2:GameObject) : Number {
         var _loc4_:Number = param1.x_ - param2.x_;
         var _loc3_:Number = param1.y_ - param2.y_;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }

      public function getDistSquaredObj(param1:GameObject, param2:GameObject) : Number {
         var _loc4_:Number = param1.x_ - param2.x_;
         var _loc3_:Number = param1.y_ - param2.y_;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_;
      }

      public function necroHeal() : Boolean {
         var _loc1_:Point = this.getNecroTarget();
         if(_loc1_) {
            return this.useAltWeapon(_loc1_.x,_loc1_.y,1,-1,true);
         }
         return false;
      }

      public function priestHeal(param1:int) : void {
         if(this.hp_ <= this.autoHealNumber || this.clientHp <= this.autoHealNumber || this.syncedChp <= this.autoHealNumber) {
            this.useAltWeapon(this.x_,this.y_,1,param1,true);
         }
      }

      public function getNecroTarget() : Point {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc9_:int = -1;
         var _loc7_:int = Parameters.data.skullHPThreshold;
         var _loc1_:int = Parameters.data.skullTargets;
         var _loc8_:Number = ObjectLibrary.xmlLibrary_[this.equipment_[1]].Activate.@radius;
         var _loc5_:* = map_.vulnEnemyDict_;
         var _loc11_:int = 0;
         var _loc10_:* = map_.vulnEnemyDict_;
         for each(var _loc2_ in map_.vulnEnemyDict_) {
            if(!_loc2_.isInvulnerable && !_loc2_.isStasis && !_loc2_.isInvincible && !_loc2_.isPaused) {
               if(_loc2_.maxHP_ >= _loc7_ && _loc2_ is Character && this.getDistSquared(_loc2_.x_,_loc2_.y_,this.x_,this.y_) <= 225) {
                  _loc9_ = this.getNumNearbyEnemies(_loc2_,_loc8_);
                  if(_loc9_ > _loc1_ && _loc9_ > _loc3_) {
                     _loc4_ = _loc2_;
                     _loc3_ = Number(_loc9_);
                  }
               }
            }
         }
         if(_loc3_ < _loc1_ || _loc4_ == null) {
            return null;
         }
         return new Point(_loc4_.x_,_loc4_.y_);
      }

      public function getNumNearbyEnemies(param1:GameObject, param2:int) : int {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         param2 = param2 * param2;
         var _loc3_:int = Parameters.data.skullHPThreshold;
         var _loc4_:* = map_.vulnEnemyDict_;
         var _loc9_:int = 0;
         var _loc8_:* = map_.vulnEnemyDict_;
         for each(_loc7_ in map_.vulnEnemyDict_) {
            if(_loc7_.maxHP_ >= _loc3_ && _loc7_ is Character && this.getDistSquared(_loc7_.x_,_loc7_.y_,param1.x_,param1.y_) <= param2) {
               _loc6_++;
            }
         }
         return _loc6_;
      }

      public function autoLoot(param1:int = -1) : void {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ObjectProperties = null;
         if(param1 == -1) {
            param1 = TimeUtil.getModdedTime();
         }
         if(param1 - this.map_.gs_.gsc_.lastInvSwapTime <= 500) {
            return;
         }
         if(this.isInventoryFull()) {
            return;
         }
         var _loc7_:int = 0;
         var _loc6_:* = this.map_.goDict_;
         for each(var _loc5_ in this.map_.goDict_) {
            if(_loc5_ is Container && _loc5_.objectType_ != 1284 && _loc5_.objectType_ != 1860 && _loc5_.equipment_ && getDistSquared(this.x_,this.y_,_loc5_.x_,_loc5_.y_) <= 1) {
               _loc4_ = 0;
               while(_loc4_ < 8) {
                  _loc2_ = _loc5_.equipment_[_loc4_];
                  if(_loc2_ != -1) {
                     _loc3_ = ObjectLibrary.propsLibrary_[_loc2_];
                     if(_loc3_) {
                        if(_loc3_.desiredLoot_ || Parameters.data.autoLootUpgrades && checkForUpgrade(_loc3_)) {
                           pickup(_loc5_,_loc4_,_loc2_);
                        }
                     }
                  }
                  _loc4_++;
               }
               continue;
            }
         }
      }

      public function checkForUpgrade(param1:ObjectProperties) : Boolean {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         if(param1.slotType_ != -2147483648) {
            _loc3_ = 0;
            while(_loc3_ < 4) {
               _loc2_ = this.slotTypes_[_loc3_];
               if(param1.slotType_ == _loc2_) {
                  if(this.equipment_ && this.equipment_[_loc3_] == -1) {
                     return true;
                  }
                  _loc4_ = ObjectLibrary.propsLibrary_[this.equipment_[_loc3_]];
                  if(_loc4_ && _loc4_.tier != -2147483648 && param1.tier > _loc4_.tier) {
                     return true;
                  }
               }
               _loc3_++;
            }
         }
         return false;
      }

      public function drink(param1:GameObject, param2:int, param3:int) : void {
         this.map_.gs_.gsc_.useItem_new(param1,param2);
         SoundEffectLibrary.play("use_potion");
      }

      public function pickup(fromGO:GameObject, fromSlotId:int, fromItemId:int) : void {
         var props:ObjectProperties = ObjectLibrary.propsLibrary_[fromItemId];
         if (this.quickSlotItem1 == fromItemId
                 && this.quickSlotCount1 < props.maxQuickStack) {
            this.map_.gs_.gsc_.invSwapRaw(x_, y_,
                    fromGO.objectId_, fromSlotId, fromItemId,
                    objectId_, 1000000, fromItemId);
            this.quickSlotCount1++;
            return;
         }

         if (this.quickSlotItem2 == fromItemId
                 && this.quickSlotCount2 < props.maxQuickStack) {
            this.map_.gs_.gsc_.invSwapRaw(x_, y_,
                    fromGO.objectId_, fromSlotId, fromItemId,
                    objectId_, 1000001, fromItemId);
            this.quickSlotCount2++;
            return;
         }

         if (this.quickSlotItem3 == fromItemId
                 && this.quickSlotCount3 < props.maxQuickStack) {
            this.map_.gs_.gsc_.invSwapRaw(x_, y_,
                    fromGO.objectId_, fromSlotId, fromItemId,
                    objectId_, 1000002, fromItemId);
            this.quickSlotCount3++;
            return;
         }

         var localSlotId:int  = findItem(this.equipment_,-1,4,false,this.hasBackpack_?20:12);
         if (localSlotId != -1)
            this.map_.gs_.gsc_.invSwapRaw(x_, y_,
                    fromGO.objectId_, fromSlotId, fromItemId,
                    objectId_, localSlotId, -1);
      }

      public function findItems(param1:Vector.<int>, param2:Vector.<int>, param3:int = 0) : int {
         var _loc4_:* = 0;
         var _loc5_:int = param1.length;
         _loc4_ = param3;
         while(_loc4_ < _loc5_) {
            if(param2.indexOf(param1[_loc4_]) >= 0) {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }

      public function findItem(param1:Vector.<int>, param2:int, param3:int = 0, param4:Boolean = false, param5:int = 8) : int {
         var _loc6_:* = -1;
         if(param4) {
            _loc6_ = param3;
            while(_loc6_ < param5) {
               if(param1[_loc6_] != param2) {
                  return _loc6_;
               }
               _loc6_++;
            }
         } else {
            _loc6_ = param3;
            while(_loc6_ < param5) {
               if(param1[_loc6_] == param2) {
                  return _loc6_;
               }
               _loc6_++;
            }
         }
         return -1;
      }

      public function calcHealthPercent() : void {
         this.autoHpPotNumber = Parameters.data.autoHPPercent * 0.01 * this.maxHP_;
         this.autoNexusNumber = Parameters.data.AutoNexus * 0.01 * this.maxHP_;
         this.autoHealNumber = Parameters.data.AutoHealPercentage * 0.01 * this.maxHP_;
      }

      public function calcManaPercent() : void {
         if(Parameters.data.autoMPPercent < 0) {
            this.autoMpPotNumber = -1;
         } else {
            this.autoMpPotNumber = Parameters.data.autoMPPercent * 0.01 * this.maxMP_;
         }
         if(Parameters.data.AAMinManaPercent < 0) {
            this.autoMpPercentNumber = -1;
         } else {
            this.autoMpPercentNumber = Parameters.data.AAMinManaPercent * 0.01 * this.maxMP_;
         }
      }

      public function triggerHealBuffer() : void {
         if(this.healBuffer > 0) {
            this.addHealth(this.healBuffer);
            this.healBuffer = 0;
            this.healBufferTime = 2147483647;
         }
      }

      public function maxHpChanged(param1:int) : void {
         if(param1 < this.maxHP_) {
            if(this.clientHp > this.maxHP_) {
               this.clientHp = this.maxHP_;
            }
         }
      }

      public function addHealth(param1:int) : void {
         this.clientHp = this.clientHp + param1;
         if(this.clientHp > this.maxHP_) {
            this.clientHp = this.maxHP_;
         }
      }

      public function subtractDamage(param1:int, param2:int = -1) : Boolean {
         if(param2 == -1) {
            param2 = TimeUtil.getModdedTime();
         }
         if(param1 >= combatTrigger()) {
            this.icMS = TimeUtil.getTrueTime();
         }
         this.clientHp = this.clientHp - param1;
         this.syncedChp = this.syncedChp - param1;
         return this.checkHealth(param2);
      }

      public function checkHealth(time:int = -1) : Boolean {
         var len:int = 0;
         var equipId:int = 0;
         var slotId:int = 0;
         if (!this.map_.gs_.isSafeMap) {
            if (Parameters.data.AutoNexus == 0 || Parameters.suicideMode) {
               return false;
            }
            if (this.clientHp <= this.autoNexusNumber || this.hp_ <= this.autoNexusNumber || this.syncedChp <= this.autoNexusNumber) {
               this.map_.gs_.gsc_.disconnect();
               this.addTextLine.dispatch(ChatMessage.make("*Help*","You were saved at " + this.hp_ + " health (" + this.clientHp + " chp)"));
               this.map_.gs_.dispatchEvent(Parameters.reconNexus);
               return true;
            }
            if (!this.isSick && this.autoHpPotNumber != 0 && (this.hp_ <= this.autoHpPotNumber || this.clientHp <= this.autoHpPotNumber || this.syncedChp <= this.autoHpPotNumber) && time - this.lastHpPotTime > Parameters.data.autohpPotDelay) {
               len = this.hasBackpack_ ? 20 : 12;
               slotId = 4;
               while (slotId < len) {
                  equipId = this.equipment_[slotId];
                  if (Parameters.hpPotions.indexOf(equipId) != -1) {
                     if (time == -1)
                        time = TimeUtil.getModdedTime();

                     this.map_.gs_.gsc_.useItem(time, this.objectId_, slotId, equipId, this.x_, this.y_, 1);

                     if (time == -1)
                        time = TimeUtil.getModdedTime();
                     this.lastHpPotTime = time;

                     return false;
                  }
                  slotId++;
               }

               if (Parameters.hpPotions.indexOf(quickSlotItem1) != -1
                       && quickSlotCount1 > 0) {
                  this.map_.gs_.gsc_.useItem(time, this.objectId_,
                          1000000, quickSlotItem1,
                          this.x_, this.y_, 1);

                  quickSlotCount1--;
                  if (quickSlotCount1 <= 0)
                     quickSlotItem1 = -1;

                  if (time == -1)
                     time = TimeUtil.getModdedTime();
                  this.lastHpPotTime = time;
                  return false;
               }

               if (Parameters.hpPotions.indexOf(quickSlotItem2) != -1
                       && quickSlotCount2 > 0) {
                  this.map_.gs_.gsc_.useItem(time, this.objectId_,
                          1000001, quickSlotItem2,
                          this.x_, this.y_, 1);

                  quickSlotCount2--;
                  if (quickSlotCount2 <= 0)
                     quickSlotItem2 = -1;

                  if (time == -1)
                     time = TimeUtil.getModdedTime();
                  this.lastHpPotTime = time;
                  return false;
               }

               if (Parameters.hpPotions.indexOf(quickSlotItem3) != -1
                       && quickSlotCount3 > 0) {
                  this.map_.gs_.gsc_.useItem(time, this.objectId_,
                          1000002, quickSlotItem3,
                          this.x_, this.y_, 1);

                  quickSlotCount3--;
                  if (quickSlotCount3 <= 0)
                     quickSlotItem3 = -1;

                  if (time == -1)
                     time = TimeUtil.getModdedTime();
                  this.lastHpPotTime = time;
                  return false;
               }
            }
         }
         return false;
      }

      public function checkMana(param1:int = -1) : void {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(!this.map_.gs_.isSafeMap) {
            if(param1 == -1) {
               param1 = TimeUtil.getModdedTime();
            }
            if(this.autoMpPotNumber == 0 || this.isQuiet_() || param1 - lastMpPotTime < Parameters.data.autompPotDelay) {
               return;
            }
            if(this.autoMpPotNumber == -1) {
               _loc2_ = equipment_[1];
               if(_loc2_ == -1) {
                  return;
               }
               _loc3_ = ObjectLibrary.xmlLibrary_[_loc2_];
               if(this.mp_ > _loc3_.MpCost) {
                  return;
               }
               lookForMpPotAndDrink(param1);
            } else if(this.mp_ <= this.autoMpPotNumber) {
               lookForMpPotAndDrink(param1);
            }
         }
      }

      public function onMove() : void {
         var _loc1_:Square = null;
         if(map_) {
            _loc1_ = map_.getSquare(x_,y_);
            if(_loc1_ && _loc1_.props_ && _loc1_.props_.sinking_) {
               sinkLevel = Math.min(sinkLevel + 1,18);
               this.moveMultiplier_ = 0.1 + (1 - sinkLevel / 18) * (_loc1_.props_.speed_ - 0.1);
            } else {
               sinkLevel = 0;
               this.moveMultiplier_ = !!_loc1_.props_?_loc1_.props_.speed_:100;
            }
         }
      }

      public function attackFrequency() : Number {
         if(this.isDazed) {
            return 0.0015;
         }
         var _loc1_:Number = 0.0015 + this.dexterity_ * 0.0133333333333333 * 0.0065;
         if(this.isBerserk) {
            _loc1_ = _loc1_ * 1.25;
         }
         return _loc1_;
      }

      public function canUseAltWeapon(param1:int = -1, param2:XML = null) : Boolean {
         if(param1 == -1) {
            param1 = TimeUtil.getModdedTime();
         }
         if(map_ == null) {
            return false;
         }
         if(this.isQuiet_()) {
            return false;
         }
         if(this.isSilenced) {
            return false;
         }
         if(this.isPaused) {
            return false;
         }
         if(param1 < this.nextAltAttack_) {
            return false;
         }
         var _loc3_:int = equipment_[1];
         if(_loc3_ == -1) {
            return false;
         }
         if(param2 == null) {
            param2 = ObjectLibrary.xmlLibrary_[_loc3_];
         }
         if(param2.Activate == "Shoot" && this.isStunned) {
            return false;
         }
         if(param2.MpCost > this.mp_) {
            return false;
         }
         return true;
      }

      public function getFamePortrait(param1:int) : BitmapData {
         var _loc2_:* = null;
         if(this.famePortrait_ == null) {
            _loc2_ = animatedChar_.imageFromDir(0,0,0);
            param1 = 4 / _loc2_.image_.width * param1;
            this.famePortrait_ = TextureRedrawer.resize(_loc2_.image_,_loc2_.mask_,param1,true,tex1Id_,tex2Id_);
            this.famePortrait_ = GlowRedrawer.outlineGlow(this.famePortrait_,0);
         }
         return this.famePortrait_;
      }

      public function useAltWeapon(param1:Number, param2:Number, param3:int, param4:int = -1, param5:Boolean = false, param6:XML = null) : Boolean {
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc11_:int = 0;
         var _loc23_:int = 0;
         var _loc17_:* = null;
         var _loc14_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc27_:* = null;
         var _loc9_:Number = NaN;
         var _loc20_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc25_:Boolean = false;
         var _loc16_:* = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc28_:* = null;
         var _loc15_:ProjectileProperties = null;
         var _loc24_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:* = null;
         var _loc29_:* = null;
         if(param4 == -1) {
            param4 = TimeUtil.getModdedTime();
         }
         if(map_ == null || this.isPaused) {
            return false;
         }
         var _loc10_:int = equipment_[1];
         if(_loc10_ == -1) {
            return false;
         }
         if(param6 == null) {
            param6 = ObjectLibrary.xmlLibrary_[_loc10_];
         }
         if(param6 == null || !("Usable" in param6)) {
            return false;
         }
         if(this.isQuiet) {
            SoundEffectLibrary.play("error");
            return false;
         }
         if(this.isSilenced) {
            SoundEffectLibrary.play("error");
            return false;
         }
         if(param6.Activate == "Shoot" && this.isStunned) {
            SoundEffectLibrary.play("error");
            return false;
         }
         if(param3 == 1) {
            _loc7_ = 0;
            _loc8_ = param6.Activate;
            var _loc31_:int = 0;
            var _loc30_:* = param6.Activate;
            for each(_loc29_ in param6.Activate) {
               _loc16_ = _loc29_.toString();
               if(_loc16_ == "TeleportLimit") {
                  _loc14_ = _loc29_.@maxDistance;
                  _loc27_ = new Point(x_ + _loc14_ * Math.cos(_loc21_),y_ + _loc14_ * Math.sin(_loc21_));
                  if(!this.isValidPosition(_loc27_.x,_loc27_.y)) {
                     SoundEffectLibrary.play("error");
                     return false;
                  }
               }
               if(_loc16_ == "Teleport" || _loc16_ == "ObjectToss") {
                  _loc22_ = true;
                  _loc25_ = true;
               }
               if(_loc16_ == "BulletNova" || _loc16_ == "PoisonGrenade" || _loc16_ == "VampireBlast" || _loc16_ == "Trap" || _loc16_ == "BoostRange" || _loc16_ == "StasisBlast") {
                  _loc22_ = true;
               }
               if(_loc16_ == "Shoot") {
                  _loc20_ = true;
               }
               if(_loc16_ == "BulletCreate") {
                  _loc21_ = Math.atan2(param2 - y_,param1 - x_);
                  _loc12_ = Math.sqrt(param1 * param1 + param2 * param2) / 50;
                  _loc13_ = Math.max(this.getAttribute(_loc29_,"minDistance",0),Math.min(this.getAttribute(_loc29_,"maxDistance",4.4),_loc12_));
                  _loc28_ = new Point(x_ + _loc13_ * Math.cos(_loc21_),y_ + _loc13_ * Math.sin(_loc21_));
                  _loc15_ = ObjectLibrary.propsLibrary_[_loc10_].projectiles_[0];
                  _loc24_ = _loc15_.speed * _loc15_.lifetime / 20000;
                  _loc18_ = _loc21_ + this.getAttribute(_loc29_,"offsetAngle",90) * 0.0174532925199433;
                  _loc19_ = new Point(_loc28_.x + _loc24_ * Math.cos(_loc18_ + 3.14159265358979),_loc28_.y + _loc24_ * Math.sin(_loc18_ + 3.14159265358979));
                  if(this.isFullOccupy(_loc19_.x + 0.5,_loc19_.y + 0.5)) {
                     SoundEffectLibrary.play("error");
                     return false;
                  }
               }
            }
         }
         if(param5) {
            _loc17_ = new Point(param1,param2);
            _loc21_ = Math.atan2(param2 - y_,param1 - x_);
         } else {
            _loc21_ = Parameters.data.cameraAngle + Math.atan2(param2,param1);
            if(_loc22_) {
               _loc17_ = sToW(param1,param2);
            } else {
               _loc14_ = Math.sqrt(param1 * param1 + param2 * param2) * 0.02;
               _loc17_ = new Point(x_ + _loc14_ * Math.cos(_loc21_),y_ + _loc14_ * Math.sin(_loc21_));
            }
         }
         if(objectType_ == 804 || _loc10_ == 2650 && _loc25_) {
            if(_loc17_ == null) {
               SoundEffectLibrary.play("error");
               return false;
            }
            if(!isValidPosition(_loc17_.x,_loc17_.y)) {
               SoundEffectLibrary.play("error");
               return false;
            }
         }
         if(param3 == 1) {
            if(param4 < this.nextAltAttack_) {
               SoundEffectLibrary.play("error");
               return false;
            }
            _loc11_ = param6.MpCost;
            if(_loc11_ > this.mp_) {
               SoundEffectLibrary.play("no_mana");
               return false;
            }
            _loc23_ = 550;
            if("Cooldown" in param6) {
               _loc23_ = param6.Cooldown * 1000;
            }
            this.nextAltAttack_ = param4 + _loc23_;
            this.mpZeroed_ = false;
            if(_loc17_) {
               map_.gs_.gsc_.useItem(param4,objectId_,1,_loc10_,_loc17_.x,_loc17_.y,param3);
            } else {
               map_.gs_.gsc_.useItem(param4,objectId_,1,_loc10_,x_,y_,param3);
            }
            if(_loc20_) {
               this.doShoot(param4,_loc10_,param6,_loc21_,false,false,false);
            }
         } else if("MultiPhase" in param6) {
            map_.gs_.gsc_.useItem(param4,objectId_,1,_loc10_,_loc17_.x,_loc17_.y,param3);
            _loc11_ = param6.MpEndCost;
            if(_loc11_ <= this.mp_ && !this.mpZeroed_ && !map_.isPetYard && !map_.isQuestRoom) {
               this.doShoot(param4,_loc10_,param6,_loc21_,false,false,false);
            }
         }
         return true;
      }

      public function getAttribute(param1:XML, param2:String, param3:Number = 0) : Number {
         return !!param1.hasOwnProperty("@" + param2)?param1[param2]:param3;
      }

      public function isHexed() : Boolean {
         return (condition_[0] & 134217728) != 0;
      }

      public function isInventoryFull() : Boolean {
         var _loc2_:int = 0;
         if(equipment_ == null) {
            return false;
         }
         var _loc1_:uint = equipment_.length;
         _loc2_ = 4;
         while(_loc2_ < _loc1_) {
            if(equipment_[_loc2_] == -1) {
               return false;
            }
            _loc2_++;
         }
         return true;
      }

      public function nextAvailableInventorySlot() : int {
         var _loc2_:int = 0;
         var _loc1_:uint = !!this.hasBackpack_?equipment_.length:equipment_.length - 8;
         _loc2_ = 4;
         while(_loc2_ < _loc1_) {
            if(equipment_[_loc2_] <= 0) {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }

      public function numberOfAvailableSlots() : int {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:uint = !!this.hasBackpack_?equipment_.length:equipment_.length - 8;
         _loc2_ = 4;
         while(_loc2_ < _loc3_) {
            if(equipment_[_loc2_] <= 0) {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }

      public function swapInventoryIndex(param1:String) : int {
         var _loc3_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:* = 0;
         if(!this.hasBackpack_) {
            return -1;
         }
         if(param1 == "Backpack") {
            _loc2_ = 4;
            _loc4_ = 12;
         } else {
            _loc2_ = 12;
            _loc4_ = uint(equipment_.length);
         }
         _loc3_ = _loc2_;
         while(_loc3_ < _loc4_) {
            if(equipment_[_loc3_] <= 0) {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }

      public function getPotionCount(param1:int) : int {
         var _loc2_:* = int(param1) - 2594;
         switch(_loc2_) {
            case 0:
               return this.healthPotionCount_;
            case 1:
               return this.magicPotionCount_;
            default:
               return 0;
         }
      }

      public function getTex1() : int {
         return tex1Id_;
      }

      public function getTex2() : int {
         return tex2Id_;
      }

      public function getClosestBag(param1:Boolean) : Container {
         var _loc2_:Number = NaN;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = Infinity;
         var _loc4_:* = map_.goDict_;
         var _loc9_:int = 0;
         var _loc8_:* = map_.goDict_;
         for each(_loc6_ in map_.goDict_) {
            if(_loc6_ is Container) {
               _loc2_ = getDistSquared(_loc6_.x_,_loc6_.y_,x_,y_);
               if(_loc2_ < _loc3_) {
                  if(param1) {
                     if(_loc2_ <= 1) {
                        _loc7_ = _loc6_;
                     }
                  } else {
                     _loc7_ = _loc6_;
                  }
                  _loc3_ = _loc2_;
               }
            }
         }
         return _loc7_ as Container;
      }

      public function getClosestPortal(param1:Boolean) : Portal {
         var _loc2_:Number = NaN;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = Infinity;
         var _loc4_:* = map_.goDict_;
         var _loc9_:int = 0;
         var _loc8_:* = map_.goDict_;
         for each(_loc6_ in map_.goDict_) {
            if(_loc6_ is Portal) {
               _loc2_ = getDistSquared(_loc6_.x_,_loc6_.y_,x_,y_);
               if(_loc2_ < _loc3_) {
                  if(param1) {
                     if(_loc2_ <= 1) {
                        _loc7_ = _loc6_;
                     }
                  } else {
                     _loc7_ = _loc6_;
                  }
                  _loc3_ = _loc2_;
               }
            }
         }
         return _loc7_ as Portal;
      }

      public function getClosestChest(param1:Boolean) : Container {
         var _loc7_:Number = NaN;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = Infinity;
         var _loc4_:* = map_.goDict_;
         var _loc9_:int = 0;
         var _loc8_:* = map_.goDict_;
         for each(_loc6_ in map_.goDict_) {
            if(_loc6_.objectType_ == 1284) {
               _loc7_ = getDistSquared(_loc6_.x_,_loc6_.y_,x_,y_);
               if(_loc7_ < _loc3_) {
                  if(param1) {
                     if(_loc7_ <= 1) {
                        _loc2_ = _loc6_;
                     }
                  } else {
                     _loc2_ = _loc6_;
                  }
                  _loc3_ = _loc7_;
               }
            }
         }
         return _loc2_ as Container;
      }

      public function sToW(param1:Number, param2:Number) : Point {
         var _loc6_:Number = Parameters.data.cameraAngle;
         var _loc5_:Number = Math.cos(_loc6_);
         var _loc3_:Number = Math.sin(_loc6_);
         param1 = param1 / 50;
         param2 = param2 / 50;
         var _loc4_:Number = param1 * _loc5_ - param2 * _loc3_;
         var _loc7_:Number = param1 * _loc3_ + param2 * _loc5_;
         return new Point(this.x_ + _loc4_,this.y_ + _loc7_);
      }

      public function wToS_opti(param1:Number, param2:Number) : Point {
         var _loc4_:Number = Parameters.data.cameraAngle;
         var _loc3_:Number = Math.cos(_loc4_);
         _loc4_ = Math.sin(_loc4_);
         var _loc5_:Point = new Point(param1 - x_,param2 - y_);
         param1 = (_loc5_.x * _loc3_ + _loc5_.y * _loc4_) * 50.5;
         param2 = (_loc5_.y * _loc3_ - _loc5_.x * _loc4_) * 50.5;
         _loc5_.x = param1;
         _loc5_.y = param2;
         return _loc5_;
      }

      public function handleTradePotsCommand(param1:Text) : void {
         var _loc12_:int = 0;
         if(MoreStringUtil.countCharInString(param1.text_,".") != 7) {
            return;
         }
         if(!this.map_.goDict_[param1.objectId_]) {
            return;
         }
         var _loc10_:Player = this.map_.goDict_[param1.objectId_] as Player;
         if(getDistSquared(this.x_,this.y_,_loc10_.x_,_loc10_.y_) > 0.01) {
            return;
         }
         var _loc13_:Array = param1.text_.substring(2).split(".");
         var _loc4_:int = _loc13_[0];
         var _loc3_:int = _loc13_[1];
         var _loc8_:int = _loc13_[2];
         var _loc6_:int = _loc13_[3];
         var _loc7_:int = _loc13_[4];
         var _loc11_:int = _loc13_[5];
         var _loc5_:int = _loc13_[6];
         var _loc2_:int = _loc13_[7];
         var _loc9_:Vector.<Boolean> = new <Boolean>[false,false,false,false,false,false,false,false,false,false,false,false];
         if(_loc4_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(0,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc3_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(2,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc8_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(1,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc6_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(3,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc7_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(4,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc11_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(5,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc5_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(6,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc2_ > 0) {
            _loc12_ = 4;
            while(_loc12_ < 12) {
               if(isPotId(7,this.equipment_[_loc12_])) {
                  _loc9_[_loc12_] = true;
               }
               _loc12_++;
            }
         }
         if(_loc9_.indexOf(true) > -1) {
            this.addTextLine.dispatch(ChatMessage.make("Potions","We have a potion " + _loc10_.name_ + " needs!"));
            this.map_.gs_.gsc_.playerText("/trade " + param1.name_);
            Parameters.givingPotions = true;
            Parameters.potionsToTrade = _loc9_;
            Parameters.recvrName = param1.name_;
            return;
         }
         this.addTextLine.dispatch(ChatMessage.make("Potions","We have nothing they need"));
      }

      public function isPotId(param1:int, param2:int) : Boolean {
         switch(int(param1)) {
            case 0:
               return param2 == 2591 || param2 == 5465 || param2 == 9064;
            case 1:
               return param2 == 2592 || param2 == 5466 || param2 == 9065;
            case 2:
               return param2 == 2593 || param2 == 5467 || param2 == 9066;
            case 3:
               return param2 == 2636 || param2 == 5470 || param2 == 9069;
            case 4:
               return param2 == 2612 || param2 == 5468 || param2 == 9067;
            case 5:
               return param2 == 2613 || param2 == 5469 || param2 == 9068;
            case 6:
               return param2 == 2793 || param2 == 5471 || param2 == 9070;
            case 7:
               return param2 == 2794 || param2 == 5472 || param2 == 9071;
            default:
               return false;
         }
      }

      public function getPotType(param1:int) : int {
         if(param1 == 2591 || param1 == 5465 || param1 == 9064) {
            return 0;
         }
         if(param1 == 2592 || param1 == 5466 || param1 == 9065) {
            return 1;
         }
         if(param1 == 2593 || param1 == 5467 || param1 == 9066) {
            return 2;
         }
         if(param1 == 2636 || param1 == 5470 || param1 == 9069) {
            return 3;
         }
         if(param1 == 2612 || param1 == 5468 || param1 == 9067) {
            return 4;
         }
         if(param1 == 2613 || param1 == 5469 || param1 == 9068) {
            return 5;
         }
         if(param1 == 2793 || param1 == 5471 || param1 == 9070) {
            return 6;
         }
         if(param1 == 2794 || param1 == 5472 || param1 == 9071) {
            return 7;
         }
         return -1;
      }

      public function shouldDrink(param1:int) : Boolean {
         if(param1 == 0) {
            return attackMax_ - (attack_ - attackBoost_) > 0;
         }
         if(param1 == 1) {
            return defenseMax_ - (defense_ - defenseBoost_) > 0;
         }
         if(param1 == 2) {
            return speedMax_ - (speed_ - speedBoost_) > 0;
         }
         if(param1 == 3) {
            return dexterityMax_ - (dexterity_ - dexterityBoost_) > 0;
         }
         if(param1 == 4) {
            return vitalityMax_ - (vitality_ - vitalityBoost_) > 0;
         }
         if(param1 == 5) {
            return wisdomMax_ - (wisdom - wisdomBoost_) > 0;
         }
         if(param1 == 6) {
            return Math.ceil((maxHPMax_ - (maxHP_ - maxHPBoost_)) * 0.2) > 0;
         }
         if(param1 == 7) {
            return Math.ceil((maxMPMax_ - (maxMP_ - maxMPBoost_)) * 0.2) > 0;
         }
         return false;
      }

      public function textNotification(param1:String, param2:int = 16777215, param3:int = 2000, param4:Boolean = false) : void {
         var _loc5_:CharacterStatusText = null;
         if(param4) {
            map_.addObj(new LevelUpEffect(this,param2 | 2130706432,20),x_,y_);
         }
         _loc5_ = new CharacterStatusText(this,param2,param3);
         _loc5_.setText(param1);
         map_.mapOverlay_.addStatusText(_loc5_);
      }

      public function sbAssist(x:int, y:int) : void {
         var equipId:int = this.equipment_[1];
         var xml:XML = ObjectLibrary.xmlLibrary_[equipId];
         var _loc10_:Number = NaN;
         var _loc6_:* = null;
         if(equipId == -1) {
            return;
         }
         var _loc12_:int = 0;
         var _loc11_:* = xml.Activate;
         for each(var _loc3_ in xml.Activate) {
            if(_loc3_.toString() == "Teleport") {
               this.useAltWeapon(x,y,1,-1,false);
               return;
            }
         }
         var _loc7_:Point = sToW(x,y);
         var _loc4_:* = Infinity;
         var _loc14_:int = 0;
         var _loc13_:* = map_.vulnEnemyDict_;
         for each(var _loc5_ in map_.vulnEnemyDict_) {
            _loc10_ = getDistSquared(_loc5_.x_,_loc5_.y_,_loc7_.x,_loc7_.y);
            if(_loc10_ < _loc4_) {
               _loc4_ = _loc10_;
               _loc6_ = _loc5_;
            }
         }
         if(_loc4_ <= 25) {
            this.useAltWeapon(_loc6_.x_,_loc6_.y_,1,-1,true);
         } else {
            this.useAltWeapon(x,y,1,-1,false);
         }
      }

      public function jump() : void {
      }

      protected function drawBreathBar(param1:Vector.<GraphicsBitmapFill>, param2:int) : void {
         var _loc6_:int = 0;
         if(this.breathBarFill == null || this.breathBarBackFill == null) {
            this.breathBarFill = new GraphicsBitmapFill();
            this.breathBarBackFill = new GraphicsBitmapFill();
         }
         var _loc5_:* = 1118481;
         if(this.breath_ <= 20) {
            _loc5_ = uint(MoreColorUtil.lerpColor(1118481,16711680,Math.abs(Math.sin(param2 / 300)) * ((20 - this.breath_) / 20)));
         }
         this.breathBarBackFill.bitmapData = TextureRedrawer.redrawSolidSquare(_loc5_,42,7,-1);
         var _loc3_:int = posS_[0];
         var _loc4_:int = posS_[1];
         this.breathBarBackFillMatrix.identity();
         this.breathBarBackFillMatrix.translate(_loc3_ - 20 - 5 - 1,_loc4_ + 9 - 1);
         this.breathBarBackFill.matrix = this.breathBarBackFillMatrix;
         param1.push(this.breathBarBackFill);
         if(this.breath_ > 0) {
            _loc6_ = this.breath_ * 0.4;
            this.breathBarFill.bitmapData = TextureRedrawer.redrawSolidSquare(2542335,_loc6_,5,-1);
            this.breathBarFillMatrix.identity();
            this.breathBarFillMatrix.translate(_loc3_ - 20 - 5,_loc4_ + 9);
            this.breathBarFill.matrix = this.breathBarFillMatrix;
            param1.push(this.breathBarFill);
         }
      }

      private function bForceExp() : Boolean {
         return Parameters.data.forceEXP == 1 || Parameters.data.forceEXP == 2 && map_.player_ == this;
      }

      private function getNearbyMerchant() : Merchant {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = x_ - x_ > 0.5?1:-1;
         var _loc1_:int = y_ - y_ > 0.5?1:-1;
         var _loc6_:* = NEARBY;
         var _loc8_:int = 0;
         var _loc7_:* = NEARBY;
         for each(_loc3_ in NEARBY) {
            this.ip_.x_ = x_ + _loc5_ * _loc3_.x;
            this.ip_.y_ = y_ + _loc1_ * _loc3_.y;
            _loc2_ = map_.merchLookup_[this.ip_];
            if(_loc2_) {
               return this.getDistSquared(_loc2_.x_,_loc2_.y_,x_,y_) < 1?_loc2_:null;
            }
         }
         return null;
      }

      private function resetMoveVector(param1:Boolean) : void {
         moveVec_.scaleBy(-0.5);
         if(param1) {
            moveVec_.y = moveVec_.y * -1;
         } else {
            moveVec_.x = moveVec_.x * -1;
         }
      }

      private function calcHealth(param1:int) : void {
         var _loc5_:Number = param1 * 0.001;
         var _loc6_:Number = 1 + 0.12 * this.vitality_ * (this.icMS != -1?1:2);
         var _loc3_:Boolean = this.map_.isTrench && this.breath_ == 0;
         if(!this.isSick && !this.isBleeding_()) {
            this.hpLog = this.hpLog + _loc6_ * _loc5_;
            if(this.isHealing_()) {
               this.hpLog = this.hpLog + 20 * (_loc5_ / Parameters.data.timeScale);
            }
         } else if(this.isBleeding_()) {
            this.hpLog = this.hpLog - 20 * (_loc5_ / Parameters.data.timeScale);
         }
         if(_loc3_) {
            this.hpLog = this.hpLog - 94 * _loc5_;
         }
         var _loc2_:int = this.hpLog;
         var _loc4_:Number = this.hpLog - _loc2_;
         this.hpLog = _loc4_;
         this.clientHp = this.clientHp + _loc2_;
         if(this.clientHp > this.maxHP_) {
            this.clientHp = this.maxHP_;
         }
      }

      private function lookForMpPotAndDrink(param1:int) : void {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = !!this.hasBackpack_?20:12;
         _loc3_ = 4;
         while(_loc3_ < _loc5_) {
            _loc2_ = this.equipment_[_loc3_];
            if(_loc2_ == 2595 || _loc2_ == 3098) {
               this.map_.gs_.gsc_.useItem(param1,this.objectId_,_loc3_,_loc2_,this.x_,this.y_,1);
               _loc4_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc4_) {
            this.lastMpPotTime = param1;
         }
      }

      private function numStarsToImage(param1:int) : Sprite {
         var _loc3_:uint = ObjectLibrary.playerChars_.length;
         var _loc2_:Sprite = new StarGraphic();
         if(param1 < _loc3_) {
            _loc2_.transform.colorTransform = lightBlueCT;
         } else if(param1 < _loc3_ * 2) {
            _loc2_.transform.colorTransform = darkBlueCT;
         } else if(param1 < _loc3_ * 3) {
            _loc2_.transform.colorTransform = redCT;
         } else if(param1 < _loc3_ * 4) {
            _loc2_.transform.colorTransform = orangeCT;
         } else if(param1 < _loc3_ * 5) {
            _loc2_.transform.colorTransform = yellowCT;
         }
         return _loc2_;
      }

      private function getNameColor() : uint {
         return PlayerUtil.getPlayerNameColor(this);
      }

      private function getMoveSpeed() : Number {
         var _loc1_:Number = NaN;
         if(this.isSlowed) {
            return 0.004 * this.moveMultiplier_;
         }
         _loc1_ = 0.004 + this.speed_ * 0.0133333333333333 * 0.0056;
         if(this.isSpeedy || this.isNinjaSpeedy) {
            _loc1_ = _loc1_ * 1.5;
         }
         return _loc1_ * this.moveMultiplier_ * (!!this.isWalking?0.5:1);
      }

      private function attackMultiplier() : Number {
         if(this.isWeak) {
            return 0.5;
         }
         var _loc1_:Number = 0.5 + this.attack_ * 0.0133333333333333 * 1.5;
         if(this.isDamaging) {
            _loc1_ = _loc1_ * 1.25;
         }
         return _loc1_ * this.exaltationDamageMultiplier / 100;
      }

      private function makeSkinTexture() : void {
         if(!this.skin) {
            return;
         }
         var _loc1_:MaskedImage = this.skin.imageFromAngle(0,0,0);
         animatedChar_ = this.skin;
         texture = _loc1_.image_;
         mask_ = _loc1_.mask_;
         this.isDefaultAnimatedChar = true;
      }

      private function setToRandomAnimatedCharacter() : void {
         var _loc4_:Vector.<XML> = ObjectLibrary.hexTransforms_;
         var _loc1_:uint = Math.floor(Math.random() * _loc4_.length);
         var _loc3_:int = _loc4_[_loc1_].@type;
         var _loc2_:TextureData = ObjectLibrary.typeToTextureData_[_loc3_];
         texture = _loc2_.texture_;
         mask_ = _loc2_.mask_;
         animatedChar_ = _loc2_.animatedChar_;
         this.isDefaultAnimatedChar = false;
      }

      private function shoot(param1:Number, param2:int = -1, param3:Boolean = false) : void {
         if(map_ == null || this.isStunned_() || this.isPaused_() || this.isPetrified_()) {
            return;
         }
         var _loc5_:int = equipment_[0];
         if(_loc5_ == -1) {
            this.addTextLine.dispatch(ChatMessage.make("*Error*","player.noWeaponEquipped"));
            return;
         }
         var _loc4_:XML = ObjectLibrary.xmlLibrary_[_loc5_];
         if(param2 == -1) {
            param2 = TimeUtil.getModdedTime();
         }
         var _loc6_:Number = !("RateOfFire" in _loc4_) ? 1 : _loc4_.RateOfFire;
         this.attackPeriod_ = 1 / this.attackFrequency() * (1 / _loc6_);
         if(param2 < attackStart_ + this.attackPeriod_) {
            return;
         }
         attackAngle_ = param1;
         attackStart_ = param2;
         this.doShoot(attackStart_,_loc5_,_loc4_,attackAngle_,true,true,param3);
      }

      private function doShoot(param1:int, param2:int, param3:XML, param4:Number, param5:Boolean, param6:Boolean, param7:Boolean = false) : void {
         var _loc12_:* = 0;
         var _loc18_:Projectile = null;
         var _loc8_:int = 0;
         var _loc20_:int = 0;
         var _loc19_:Number = NaN;
         var _loc14_:int = 0;
         var _loc17_:int = 0;
         var _loc13_:int = ("NumProjectiles" in param3?int(param3.NumProjectiles):1);
         var _loc10_:Number = ("ArcGap" in param3?Number(param3.ArcGap):11.25) * Trig.toRadians;
         var mod:Number = _loc10_ * (_loc13_ - 1);
         var _loc9_:Number = param4 - mod / 2.0;
         var _loc11_:Number = (param6?this.projectileLifeMult:1);
         var _loc16_:Number = (param6?this.projectileSpeedMult:1);
         if(!isNaN(param4)) {
            this.isShooting = param5;
         }
         if(param2 == 580 && (Parameters.data.cultiststaffDisable || param7)) {
            _loc9_ = _loc9_ + 3.14159265358979;
         }
         _loc17_ = 0;
         while(_loc17_ < _loc13_) {
            _loc12_ = uint(getBulletId());
            if(param2 == 8608 && Parameters.data.ethDisable) {
               _loc9_ = _loc9_ + (_loc12_ % 2 != 0?0.0436332312998582:-0.0436332312998582);
            } else if(param2 == 588 && Parameters.data.offsetVoidBow) {
               _loc9_ = _loc9_ + (_loc12_ % 2 != 0?0.06:-0.06);
            } else if(param2 == 596 && Parameters.data.offsetColossus) {
               _loc9_ = _loc9_ + (_loc12_ % 2 != 0?Parameters.data.coloOffset:-Parameters.data.coloOffset);
            } else if(param2 == 30053 && Parameters.data.offsetCelestialBlade) {
               _loc9_ = _loc9_ + (_loc12_ % 2 != 0?0.12:-0.12);
            }
            _loc18_ = FreeList.newObject(Projectile) as Projectile;
            if(param5 && this.projectileIdSetOverrideNew != "") {
               _loc18_.reset(param2,0,objectId_,_loc12_,_loc9_,param1,this.projectileIdSetOverrideNew,this.projectileIdSetOverrideOld,_loc11_,_loc16_);
            } else {
               _loc18_.reset(param2,0,objectId_,_loc12_,_loc9_,param1,"","",_loc11_,_loc16_);
            }
            _loc8_ = _loc18_.projProps.minDamage_;
            _loc20_ = _loc18_.projProps.maxDamage_;
            _loc19_ = (param5?Number(this.attackMultiplier()):1);
            _loc14_ = map_.gs_.gsc_.getNextDamage(_loc8_,_loc20_) * _loc19_;
            if(param1 > map_.gs_.moveRecords_.lastClearTime_ + 600) {
               _loc14_ = 0;
            }
            _loc18_.setDamage(_loc14_);
            if(_loc17_ == 0 && _loc18_.sound_) {
               SoundEffectLibrary.play(_loc18_.sound_,0.75,false);
            }
            map_.addObj(_loc18_,x_ + Math.cos(param4) * 0.3,y_ + Math.sin(param4) * 0.3);
            map_.gs_.gsc_.playerShoot(param1,_loc18_);
            _loc9_ = _loc9_ + _loc10_;
            _loc17_++;
         }
      }
   }
}
