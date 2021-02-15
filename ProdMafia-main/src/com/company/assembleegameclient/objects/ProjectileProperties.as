package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.util.ConditionEffect;
import flash.utils.Dictionary;

public class ProjectileProperties {


   public var bulletType_:int;

   public var objectId_:String;

   public var lifetime:int;

   public var realSpeed:Number;

   public var speed:Number;

   public var maxProjTravel_:Number;

   public var size_:int;

   public var minDamage_:int;

   public var maxDamage_:int;

   public var effects_:Vector.<uint> = null;

   public var multiHit_:Boolean;

   public var passesCover_:Boolean;

   public var armorPiercing_:Boolean;

   public var particleTrail_:Boolean;

   public var particleTrailIntensity_:int = -1;

   public var particleTrailLifetimeMS:int = -1;

   public var particleTrailColor_:int = 16711935;

   public var wavy_:Boolean;

   public var parametric:Boolean;

   public var boomerang_:Boolean;

   public var amplitude:Number;

   public var frequency:Number;

   public var magnitude:Number;

   public var isPetEffect_:Dictionary;

   public var faceDir_:Boolean;

   public var noRotation_:Boolean;

   public var acceleration:int;

   public var accelerationDelay:int;

   public var speedClamp:int;

   public function ProjectileProperties(param1:XML) {
      var _loc3_:* = undefined;
      super();
      this.bulletType_ = int(param1.@id);
      this.objectId_ = param1.ObjectId;
      this.lifetime = param1.LifetimeMS;
      this.speed = param1.Speed / 10000.0;
      this.realSpeed = param1.Speed;
      this.size_ = "Size" in param1?param1.Size:-1;
      if("Damage" in param1) {
         _loc3_ = param1.Damage;
         this.maxDamage_ = _loc3_;
         this.minDamage_ = _loc3_;
      } else {
         this.minDamage_ = param1.MinDamage;
         this.maxDamage_ = param1.MaxDamage;
      }
      for each(var _loc2_ in param1.ConditionEffect) {
         if(this.effects_ == null) {
            this.effects_ = new Vector.<uint>();
         }
         this.effects_.push(ConditionEffect.getConditionEffectFromName(_loc2_));
         if(_loc2_.attribute("target") == "1") {
            if(this.isPetEffect_ == null) {
               this.isPetEffect_ = new Dictionary();
            }
            this.isPetEffect_[ConditionEffect.getConditionEffectFromName(_loc2_)] = true;
         }
      }
      this.multiHit_ = "MultiHit" in param1;
      this.passesCover_ = "PassesCover" in param1;
      this.armorPiercing_ = "ArmorPiercing" in param1;
      this.particleTrail_ = "ParticleTrail" in param1;
      this.particleTrailColor_ = (this.particleTrail_ ? param1.ParticleTrail : 16711935);
      if(this.particleTrailColor_ == 0) {
         this.particleTrailColor_ = 16711935;
      }
      this.wavy_ = "Wavy" in param1;
      this.parametric = "Parametric" in param1;
      this.boomerang_ = "Boomerang" in param1;
      this.amplitude = ("Amplitude" in param1 ? param1.Amplitude : 0);
      this.frequency = ("Frequency" in param1 ? param1.Frequency : 1);
      this.magnitude = ("Magnitude" in param1 ? param1.Magnitude : 3);
      this.faceDir_ = "FaceDir" in param1;
      this.noRotation_ = "NoRotation" in param1;
      this.acceleration = ("Acceleration" in param1 ? param1.Acceleration : 0);
      this.accelerationDelay = ("AccelerationDelay" in param1 ? param1.AccelerationDelay : 0);
      this.speedClamp = ("SpeedClamp" in param1 ? param1.SpeedClamp : -1);
      if (this.acceleration == 0)
         this.maxProjTravel_ = this.speed * this.lifetime;
      else {
         var delayTime:int, maxSpeedTime:int, clampTime:int,
                 baseSpeed:Number = this.speed * this.lifetime, clampedSpeed:Number;
         if (this.accelerationDelay != 0)
            delayTime = Math.min(this.accelerationDelay, this.lifetime);
         if (this.speedClamp != -1) {
            clampedSpeed = this.speedClamp / 10000.0;
            var speedNeeded:Number = Math.abs(this.speedClamp - this.realSpeed);
            maxSpeedTime = speedNeeded / Math.abs(this.acceleration) * 1000.0;
            maxSpeedTime = Math.min(this.lifetime - this.accelerationDelay, maxSpeedTime);
            if (this.lifetime - this.accelerationDelay - maxSpeedTime > 0)
               clampTime = this.lifetime - this.accelerationDelay - maxSpeedTime;
         } else
            maxSpeedTime = this.lifetime - this.accelerationDelay;
         this.maxProjTravel_ = delayTime * baseSpeed +
                 maxSpeedTime * baseSpeed + (maxSpeedTime * maxSpeedTime / 1000.0) * (1/2) * (this.acceleration / 10000.0) +
                 clampTime * clampedSpeed;
      }
   }

   public function calcMaxRange(speedMul:Number = 1, lifeMul:Number = 1) : Number {
      var life:int = int(this.lifetime * lifeMul), speedMod:Number = this.speed * speedMul;
      if (this.acceleration == 0)
         return speedMod * life;

      var delayTime:int, maxSpeedTime:int, clampTime:int, clampedSpeed:Number;
      if (this.accelerationDelay != 0)
         delayTime = Math.min(this.accelerationDelay, life);
      if (this.speedClamp != -1) {
         clampedSpeed = this.speedClamp / 10000.0;
         var speedNeeded:Number = Math.abs(this.speedClamp - (speedMod * 10000));
         maxSpeedTime = speedNeeded / Math.abs(this.acceleration) * 1000.0;
         maxSpeedTime = Math.min(life - this.accelerationDelay, maxSpeedTime);
         if (life - this.accelerationDelay - maxSpeedTime > 0)
            clampTime = life - this.accelerationDelay - maxSpeedTime;
      } else
         maxSpeedTime = life - this.accelerationDelay;
      return delayTime * speedMod +
              maxSpeedTime * speedMod + (maxSpeedTime * maxSpeedTime / 1000.0) * (1/2) * (this.acceleration / 10000.0) +
              clampTime * clampedSpeed;
   }

   public function calcAvgSpeed(speedMul:Number = 1, lifeMul:Number = 1) : Number {
      var life:int = int(this.lifetime * lifeMul), speedMod:Number = this.speed * speedMul;
      if (this.acceleration == 0)
         return speedMod;

      var delayTime:int, maxSpeedTime:int, clampTime:int,
              maxSpeed:Number, clampedSpeed:Number;
      if (this.accelerationDelay != 0)
         delayTime = Math.min(this.accelerationDelay, life);
      if (this.speedClamp != -1) {
         clampedSpeed = this.speedClamp / 10000.0;
         var speedNeeded:Number = Math.abs(this.speedClamp - (speedMod * 10000));
         maxSpeedTime = speedNeeded / Math.abs(this.acceleration) * 1000.0;
         maxSpeedTime = Math.min(life - this.accelerationDelay, maxSpeedTime);
         if (life - this.accelerationDelay - maxSpeedTime > 0)
            clampTime = life - this.accelerationDelay - maxSpeedTime;
         maxSpeed = clampedSpeed;
      } else {
         maxSpeedTime = life - this.accelerationDelay;
         maxSpeed = speedMod + (maxSpeedTime / 1000.0) * (this.acceleration / 10000.0);
      }

      return (delayTime * speedMod + maxSpeedTime * ((maxSpeed - speedMod) / 2) + clampTime * clampedSpeed) / life;
   }
}
}
