package com.company.assembleegameclient.objects.particles {
   public class ParticleLibrary {
      
      public static const propsLibrary_:Object = {};
       
      
      public function ParticleLibrary() {
         super();
      }
      
      public static function parseFromXML(param1:XML) : void {
         var _loc2_:* = null;
         var _loc3_:* = param1.Particle;
         var _loc6_:int = 0;
         var _loc5_:* = param1.Particle;
         for each(_loc2_ in param1.Particle) {
            propsLibrary_[_loc2_.@id] = new ParticleProperties(_loc2_);
         }
      }
   }
}
