package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.Point3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.particles.HitEffect;
import com.company.assembleegameclient.objects.particles.SparkParticle;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.FreeList;
import com.company.assembleegameclient.util.RandomUtil;
import com.company.assembleegameclient.util.TimeUtil;
import com.company.util.GraphicsUtil;
import com.company.util.Hit;
import com.company.util.PointUtil;
import com.company.util.Trig;
import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import kabam.rotmg.messaging.impl.GameServerConnection;

public class Projectile extends BasicObject {

   private static var objBullIdToObjId_:Dictionary = new Dictionary();


   public var props_:ObjectProperties;

   public var containerProps_:ObjectProperties;

   public var projProps:ProjectileProperties;

   public var texture_:BitmapData;

   public var bulletId_:uint;

   public var bIdMod2Flip:int;

   public var bIdMod4Flip:int;

   public var phase:Number;

   public var ownerId_:int;

   public var containerType_:int;

   public var burstId:int;

   public var bulletType_:uint;

   public var damagesEnemies_:Boolean;

   public var damagesPlayers_:Boolean;

   public var damage_:int;

   public var sound_:String;

   public var startX:Number;

   public var startY:Number;

   public var startTime_:int;

   public var lastUpdateElapsed:int;

   public var halfway_:Number;

   public var angle:Number = 0;

   public var prevDirAngle:Number = 0;

   public var lifetime:Number = 1.0;

   public var sinAngle:Number;

   public var cosAngle:Number;

   public var multiHitDict_:Dictionary;

   public var multiHitVec:Vector.<int>;

   public var p_:Point3D;

   public var lifeMul_:Number;

   public var speedMul:Number;

   public var speedMod:Number;

   public var projHasConditions:Boolean;

   protected var shadowGradientFill_:GraphicsGradientFill;

   protected var shadowPath_:GraphicsPath;

   public var curPos:Point;
   private var sinePos:Point;

   private var staticVector3D_:Vector3D;

   public function Projectile() {
      this.p_ = new Point3D(100);
      this.curPos = new Point();
      this.sinePos = new Point();
      this.staticVector3D_ = new Vector3D();
      this.shadowGradientFill_ = new GraphicsGradientFill("radial",[0,0],[0.5,0],null,new Matrix());
      this.shadowPath_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,new Vector.<Number>());
      super();
   }

   public static function findObjId(param1:int, param2:uint) : int {
      return objBullIdToObjId_[param2 << 24 | param1];
   }

   public static function getNewObjId(param1:int, param2:uint) : int {
      var _loc3_:int = getNextFakeObjectId();
      objBullIdToObjId_[param2 << 24 | param1] = _loc3_;
      return _loc3_;
   }

   public static function removeObjId(param1:int, param2:uint) : void {
   }

   public static function dispose() : void {
      objBullIdToObjId_ = new Dictionary();
   }

   override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
      var _loc4_:Player = null;
      this.startX = param2;
      this.startY = param3;
      this.curPos = new Point(this.startX, this.startY);
      if(!super.addTo(param1,param2,param3)) {
         return false;
      }
      if(!this.containerProps_.flying_ && square.sink) {
         this.z_ = 0.1;
      } else {
         _loc4_ = param1.goDict_[this.ownerId_] as Player;
         if(_loc4_ != null && _loc4_.sinkLevel > 0) {
            this.z_ = 0.5 - 0.4 * (_loc4_.sinkLevel / 18);
         }
      }
      return true;
   }

   override public function removeFromMap() : void {
      super.removeFromMap();
      removeObjId(this.ownerId_,this.bulletId_);
      this.multiHitDict_ = null;
      this.multiHitVec = null;
      FreeList.deleteObject(this);
   }

   override public function update(param1:int, param2:int) : Boolean {
      var _loc4_:* = undefined;
      var _loc14_:* = undefined;
      var _loc15_:* = undefined;
      var _loc5_:Player = null;
      var _loc3_:* = false;
      var _loc8_:Boolean = false;
      var _loc6_:Boolean = false;
      var _loc13_:int = 0;
      var _loc9_:* = false;
      var _loc11_:GameObject = null;
      var _loc19_:* = null;
      var _loc17_:* = undefined;
      var _loc10_:int = 0;
      var _loc12_:* = 0;
      var elapsed:int = param1 - this.startTime_;
      if (elapsed > this.lifetime)
         return false;

      var gsc:GameServerConnection = this.map_.gs_.gsc_;
      this.curPos = this.positionAt(elapsed);
      if (!moveTo(this.curPos.x + this.sinePos.x,this.curPos.y + this.sinePos.y) || this.square.tileType == 65535) {
         if(this.damagesPlayers_) {
            gsc.squareHit(param1,this.bulletId_,this.ownerId_);
         } else if(this.square.obj_) {
            if(!Parameters.data.noParticlesMaster || !Parameters.data.liteParticle) {
               if(!this.texture_) {
                  _loc15_ = getColors(this.texture_);
                  this.map_.addObj(new HitEffect(_loc15_,100,3,this.angle,this.projProps.speed),this.curPos.x + this.sinePos.x,this.curPos.y + this.sinePos.y);
               }
            }
         }
         return false;
      }
      _loc5_ = this.map_.player_;
      if(!(this.ownerId_ == _loc5_.objectId_ && Parameters.data.PassesCover)) {
         _loc11_ = this.square.obj_;
         if(_loc11_) {
            _loc19_ = _loc11_.props_;
            if((!_loc19_.isEnemy_ || !this.damagesEnemies_) && (_loc19_.enemyOccupySquare_ || !this.projProps.passesCover_ && _loc19_.occupySquare_)) {
               if(this.damagesPlayers_) {
                  gsc.otherHit(param1,this.bulletId_,this.ownerId_,_loc11_.objectId_);
               } else if(!Parameters.data.noParticlesMaster) {
                  if(!this.texture_) {
                     _loc15_ = getColors(this.texture_);
                     this.map_.addObj(new HitEffect(_loc15_,100,3,this.angle,this.projProps.speed),this.curPos.x + this.sinePos.x,this.curPos.y + this.sinePos.y);
                  }
               }
               return false;
            }
         }
      }
      _loc11_ = getHit(this.curPos.x + this.sinePos.x,this.curPos.y + this.sinePos.y);
      if(_loc11_) {
         _loc3_ = _loc5_ != null;
         _loc8_ = _loc11_.props_.isEnemy_;
         _loc6_ = _loc3_ && !_loc5_.isPaused && (this.damagesPlayers_ || _loc8_ && this.ownerId_ == _loc5_.objectId_);
         if(_loc6_) {
            _loc13_ = _loc11_.damageWithDefense(this.damage_,_loc11_.defense_,this.projProps.armorPiercing_,_loc11_.condition_);
            _loc9_ = _loc11_.hp_ <= _loc13_;
            if(_loc11_ == _loc5_) {
               if(!Parameters.data.noClip && _loc5_.subtractDamage(_loc13_,param1)) {
                  return false;
               }
               _loc17_ = this.projProps.effects_;
               if(_loc17_) {
                  elapsed = _loc17_.length;
                  _loc3_ = false;
                  _loc10_ = 0;
                  while(_loc10_ < elapsed) {
                     _loc12_ = uint(_loc17_[_loc10_]);
                     if(_loc12_ > 32) {
                        _loc12_ = uint(1 << _loc12_ & Parameters.data.ssdebuffBitmask2);
                     } else {
                        _loc12_ = uint(1 << _loc12_ - 32 & Parameters.data.ssdebuffBitmask);
                     }
                     if(_loc12_ > 0) {
                        _loc3_ = true;
                     }
                     _loc10_++;
                  }
                  if(_loc3_) {
                     _loc11_.damage(true,_loc13_,null,false,this);
                  } else {
                     _loc11_.damage(true,_loc13_,this.projProps.effects_,false,this);
                     if(!Parameters.data.noClip) {
                        this.map_.gs_.hitQueue.push(new Hit(this.bulletId_,this.ownerId_));
                     }
                  }
               } else {
                  _loc11_.damage(true,_loc13_,this.projProps.effects_,false,this);
                  if(!Parameters.data.noClip) {
                     this.map_.gs_.hitQueue.push(new Hit(this.bulletId_,this.ownerId_));
                  }
               }
            } else if(_loc11_.props_.isEnemy_) {
               gsc.enemyHit(param1,this.bulletId_,_loc11_.objectId_,_loc9_);
               _loc11_.damage(true,_loc13_,this.projProps.effects_,_loc9_,this);
               if(isNaN(Parameters.dmgCounter[_loc11_.objectId_])) {
                  Parameters.dmgCounter[_loc11_.objectId_] = 0;
               }
               _loc4_ = _loc11_.objectId_;
               _loc14_ = Parameters.dmgCounter[_loc4_] + _loc13_;
               Parameters.dmgCounter[_loc4_] = _loc14_;
            } else if(!projProps.multiHit_) {
               gsc.otherHit(param1,this.bulletId_,this.ownerId_,_loc11_.objectId_);
            }
         }
         if(this.projProps.multiHit_) {
            this.multiHitDict_[_loc11_.objectId_] = true;
         } else {
            return false;
         }
      }
      return true;
   }

   override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
      var _loc9_:* = NaN;
      var _loc4_:int = 0;
      if(!Parameters.drawProj_) {
         return;
      }
      var _loc8_:BitmapData = this.texture_;
      if(!Parameters.data.noRotate) {
         _loc9_ = Number(props_.rotation_ == 0?0:Number(param3 / this.props_.rotation_));
      } else {
         _loc9_ = 0;
      }
      this.staticVector3D_.x = this.x_;
      this.staticVector3D_.y = this.y_;
      this.staticVector3D_.z = this.z_;
      var _loc7_:Number = this.projProps.faceDir_ || Parameters.data.projFace?getDirectionAngle(TimeUtil.getModdedTime()):Number(this.angle);
      var _loc5_:Number = !!this.projProps.noRotation_?param2.angleRad_ + props_.angleCorrection_:Number(_loc7_ - param2.angleRad_ + this.props_.angleCorrection_ + _loc9_);
      p_.draw(param1,this.staticVector3D_,_loc5_,param2.wToS_,param2,_loc8_);
      if(this.projProps.particleTrail_ && !(Parameters.data.noParticlesMaster || Parameters.data.liteParticle)) {
         _loc4_ = 0;
         while(_loc4_ < 3) {
            if(!(this.map_ != null && this.map_.player_.objectId_ != this.ownerId_) || !(this.projProps.particleTrailIntensity_ == -1 && Math.random() * 100 > this.projProps.particleTrailIntensity_)) {
               this.map_.addObj(new SparkParticle(100,this.projProps.particleTrailColor_,this.projProps.particleTrailLifetimeMS != -1?this.projProps.particleTrailLifetimeMS:600,0.5,RandomUtil.plusMinus(3),RandomUtil.plusMinus(3)),this.x_,this.y_);
            }
            _loc4_++;
         }
      }
   }

   public function reset(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:int, param7:String = "", param8:String = "", param9:Number = 1.0, param10:Number = 1.0, param11:ObjectProperties = null, param12:ProjectileProperties = null, param13:int = 0) : void {
      var _loc14_:Number = NaN;
      clear();
      this.containerType_ = param1;
      this.bulletType_ = param2;
      this.ownerId_ = param3;
      this.bulletId_ = param4;
      this.burstId = param13;
      this.bIdMod2Flip = (this.bulletId_ % 2 ? 1 : -1);
      this.bIdMod4Flip = (this.bulletId_ % 4 < 2 ? 1 : -1);
      this.phase = (this.bulletId_ % 2 == 0 ? 0 : Math.PI);
      this.angle = Trig.boundToPI(param5);
      this.sinAngle = Math.sin(this.angle);
      this.cosAngle = Math.cos(this.angle);
      this.startTime_ = param6;
      this.lifeMul_ = param9;
      this.speedMul = param10;
      this.objectId_ = getNewObjId(this.ownerId_,this.bulletId_);
      z_ = 0.5;
      if(param11 == null) {
         this.containerProps_ = ObjectLibrary.propsLibrary_[this.containerType_];
      } else {
         this.containerProps_ = param11;
      }
      if(param12 == null) {
         this.projProps = this.containerProps_.projectiles_[param2];
      } else {
         this.projProps = param12;
      }
      this.lifetime = this.projProps.lifetime * param9;
      this.halfway_ = this.lifetime * this.projProps.speed * 0.5;
      this.projHasConditions = this.projProps.effects_;
      var _loc15_:String = param7 != "" && this.projProps.objectId_ == param8?param7:this.projProps.objectId_;
      this.props_ = ObjectLibrary.getPropsFromId(_loc15_);
      this.hasShadow_ = this.props_.shadowSize_ > 0;
      var _loc16_:TextureData = ObjectLibrary.typeToTextureData_[this.props_.type_];
      this.texture_ = _loc16_.getTexture(this.objectId_);
      this.damagesPlayers_ = this.containerProps_.isEnemy_;
      this.damagesEnemies_ = !this.damagesPlayers_;
      this.sound_ = this.containerProps_.oldSound_;
      this.multiHitDict_ = !!this.projProps.multiHit_?new Dictionary():null;
      this.multiHitVec = !!this.projProps.multiHit_?new Vector.<int>(0):null;
      if(this.projProps.size_ >= 0) {
         _loc14_ = this.projProps.size_;
      } else {
         _loc14_ = ObjectLibrary.getSizeFromType(this.containerType_);
      }
      this.p_.setSize(_loc14_ * 0.01 * 8);
      this.damage_ = 0;
      this.lastUpdateElapsed = 0;
      this.sinePos = new Point();
      this.speedMod = 0;
   }

   public function setDamage(param1:int) : void {
      this.damage_ = param1;
   }

   public function moveTo(param1:Number, param2:Number) : Boolean {
      var _loc6_:* = null;
      var _loc5_:Number = NaN;
      var _loc4_:Number = NaN;
      var _loc3_:Square = map_.getSquare(param1,param2);
      if(_loc3_ == null) {
         return false;
      }
      this.x_ = param1;
      this.y_ = param2;
      this.square = _loc3_;
      if(Parameters.data.autoDodge && this.damagesPlayers_) {
         _loc6_ = this.map_.player_;
         _loc5_ = 0.25 * (this.projProps.speed / 100);
         if(PointUtil.distanceSquaredXY(_loc6_.x_,_loc6_.y_,this.x_,this.y_) <= 0.5 + _loc5_) {
            _loc4_ = map_.enumGOAngles();
            _loc6_.walkPos.x = _loc6_.x_ + 0.25 * Math.cos(_loc4_);
            _loc6_.walkPos.y = _loc6_.y_ + 0.25 * Math.sin(_loc4_);
         }
      }
      return true;
   }

   public function getHit(param1:Number, param2:Number) : GameObject {
      var _loc3_:Number = NaN;
      var _loc4_:Number = NaN;
      var _loc6_:Number = NaN;
      var _loc7_:* = 1.79769313486232e308;
      var _loc8_:* = null;
      var _loc5_:GameObject = null;
      if(this.damagesEnemies_) {
         for each(_loc5_ in this.map_.vulnEnemyDict_) {
            if(!(_loc5_.isInvulnerable && Parameters.data.passThroughInvuln && !this.projHasConditions)) {
               _loc3_ = _loc5_.x_ > param1?_loc5_.x_ - param1:Number(param1 - _loc5_.x_);
               if(_loc3_ <= 0.5) {
                  _loc4_ = _loc5_.y_ > param2?_loc5_.y_ - param2:Number(param2 - _loc5_.y_);
                  if(_loc4_ <= 0.5 && !(this.projProps.multiHit_ && this.multiHitDict_[_loc5_.objectId_])) {
                     return _loc5_;
                  }
               }
            }
         }
      } else if(this.damagesPlayers_) {
         for each(_loc5_ in this.map_.vulnPlayerDict_) {
            if(!(this.projProps.multiHit_ && this.multiHitDict_[_loc5_.objectId_])) {
               _loc3_ = _loc5_.x_ > param1?_loc5_.x_ - param1:Number(param1 - _loc5_.x_);
               if(_loc3_ <= 0.5) {
                  _loc4_ = _loc5_.y_ > param2?_loc5_.y_ - param2:Number(param2 - _loc5_.y_);
                  if(_loc4_ <= 0.5) {
                     if(!(this.projProps.multiHit_ && this.multiHitDict_[_loc5_.objectId_]) && _loc5_ == this.map_.player_) {
                        return _loc5_;
                     }
                     _loc6_ = _loc3_ * _loc3_ + _loc4_ * _loc4_;
                     if(_loc6_ < _loc7_) {
                        _loc7_ = _loc6_;
                        _loc8_ = _loc5_;
                     }
                  }
               }
            }
         }
      }
      return _loc8_;
   }

   private function positionAt(elapsed:int) : Point {
      var periodFactor:Number = NaN;
      var amplitudeFactor:Number = NaN;
      var theta:Number = NaN;
      var t:Number = NaN;
      var x:Number = NaN;
      var y:Number = NaN;
      var halfway:Number = NaN;
      var deflection:Number = NaN;
      var p:Point = new Point();
      p.x = this.startX;
      p.y = this.startY;
      var dist:Number, baseSpeed:Number = this.projProps.speed * this.speedMul;
      if (this.projProps.acceleration == 0 || elapsed < this.projProps.accelerationDelay)
         dist = elapsed * baseSpeed;
      else {
         var timeTillMaxSpeed:int;
         var timeClamped:int, clampedSpeed:Number;
         if (this.projProps.speedClamp != -1) {
            clampedSpeed = this.projProps.speedClamp / 10000.0;
            var speedNeeded:Number = Math.abs(this.projProps.speedClamp - (this.projProps.realSpeed * this.speedMul));
            timeTillMaxSpeed = speedNeeded / Math.abs(this.projProps.acceleration) * 1000.0;
            timeTillMaxSpeed = Math.min(elapsed - this.projProps.accelerationDelay, timeTillMaxSpeed);
            if (elapsed - this.projProps.accelerationDelay - timeTillMaxSpeed > 0)
               timeClamped = elapsed - this.projProps.accelerationDelay - timeTillMaxSpeed;
         } else
            timeTillMaxSpeed = this.lifetime - this.projProps.accelerationDelay;
         dist = this.projProps.accelerationDelay * baseSpeed +
                 timeTillMaxSpeed * baseSpeed + (timeTillMaxSpeed * timeTillMaxSpeed / 1000.0) * (1/2) * (this.projProps.acceleration / 10000.0) +
                 timeClamped * clampedSpeed;
      }

      if (this.projProps.wavy_) {
         periodFactor = 6 * Math.PI;
         amplitudeFactor = Math.PI / 64;
         theta = this.angle + amplitudeFactor * Math.sin(this.phase + periodFactor * elapsed / 1000);
         p.x += dist * Math.cos(theta);
         p.y += dist * Math.sin(theta);
      } else if (this.projProps.parametric) {
         t = elapsed / this.projProps.lifetime * 2 * Math.PI;
         x = Math.sin(t) * this.bIdMod2Flip;
         y = Math.sin(2 * t) * this.bIdMod4Flip;
         p.x += (x * this.cosAngle - y * this.sinAngle) * this.projProps.magnitude;
         p.y += (x * this.sinAngle + y * this.cosAngle) * this.projProps.magnitude;
      } else {
         if (this.projProps.boomerang_) {
            // todo: make the halfway actually halfway for accel projs
            halfway = this.projProps.lifetime * (this.projProps.speed * this.speedMul) / 2;
            if (dist > halfway)
               dist = halfway - (dist - halfway);
         }
         p.x += dist * this.cosAngle;
         p.y += dist * this.sinAngle;
         if (this.projProps.amplitude != 0) {
            deflection = this.projProps.amplitude * Math.sin(this.phase + elapsed / this.projProps.lifetime * this.projProps.frequency * 2 * Math.PI);
            p.x += deflection * Math.cos(this.angle + Math.PI / 2);
            p.y += deflection * Math.sin(this.angle + Math.PI / 2);
         }
      }

      return p;
   }

   private function getDirectionAngle(time:int) : Number {
      var elapsed:int = time - this.startTime_;
      var futurePos:Point = this.positionAt(elapsed + 16);

      var xDelta:Number = futurePos.x - x_;
      var yDelta:Number = futurePos.y - y_;
      if (xDelta == 0 && yDelta == 0)
         return this.prevDirAngle;

      var angle:Number = Math.atan2(yDelta, xDelta);
      this.prevDirAngle = angle;
      return angle;
   }
}
}
