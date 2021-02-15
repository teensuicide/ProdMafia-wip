package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.TextureData;
   import com.company.assembleegameclient.objects.TextureDataConcrete;
   import com.company.assembleegameclient.objects.animation.AnimationsData;
   
   public class ParticleProperties {
       
      
      public var id_:String;
      
      public var textureData_:TextureData;
      
      public var size_:int = 100;
      
      public var z_:Number = 0.0;
      
      public var duration_:Number = 0.0;
      
      public var animationsData_:AnimationsData = null;
      
      public function ParticleProperties(param1:XML) {
         super();
         this.id_ = param1.@id;
         this.textureData_ = new TextureDataConcrete(param1);
         if("Size" in param1) {
            this.size_ = Number(param1.Size);
         }
         if("Z" in param1) {
            this.z_ = Number(param1.Z);
         }
         if("Duration" in param1) {
            this.duration_ = Number(param1.Duration);
         }
         if("Animation" in param1) {
            this.animationsData_ = new AnimationsData(param1);
         }
      }
   }
}
