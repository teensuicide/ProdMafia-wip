package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import flash.display.GraphicsBitmapFill;
   
   public class Character extends GameObject {
       
      
      public var hurtSound_:String;
      
      public var deathSound_:String;
      
      public function Character(param1:XML) {
         super(param1);
         this.hurtSound_ = "HitSound" in param1?param1.HitSound:"monster/default_hit";
         SoundEffectLibrary.load(this.hurtSound_);
         this.deathSound_ = "DeathSound" in param1?param1.DeathSound:"monster/default_death";
         SoundEffectLibrary.load(this.deathSound_);
      }
      
      public static function green2red(param1:int) : int {
         if(param1 > 50) {
            return 65280 + 327680 * (100 - param1);
         }
         return 16776960 - 1280 * (50 - param1);
      }
      
      public static function green2redu(param1:uint) : uint {
         if(param1 > 50) {
            return 65280 + 327680 * (100 - param1);
         }
         return 16776960 - 1280 * (50 - param1);
      }
      
      override public function damage(param1:Boolean, param2:int, param3:Vector.<uint>, param4:Boolean, param5:Projectile, param6:Boolean = false) : void {
         super.damage(param1,param2,param3,param4,param5,param6);
         if(dead_) {
            SoundEffectLibrary.play(this.deathSound_);
         } else if(param5 || param2 > 0) {
            SoundEffectLibrary.play(this.hurtSound_);
         }
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         super.draw(param1,param2,param3);
      }
      
      public function barLength(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : int {
         var _loc6_:int = 0;
         if(param4) {
            _loc6_ = param3 * param1 * 0.01;
            if(param5) {
               return _loc6_ > param2?_loc6_:int(param2);
            }
            return _loc6_;
         }
         return param1;
      }
   }
}
