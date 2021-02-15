package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.GraphicsBitmapFill;
   
   public class ParticleEffect extends GameObject {
       
      
      public var reducedDrawEnabled:Boolean;
      
      public function ParticleEffect() {
         super(null);
         objectId_ = getNextFakeObjectId();
         hasShadow_ = false;
         this.reducedDrawEnabled = false;
      }
      
      public static function fromProps(param1:EffectProperties, param2:GameObject) : ParticleEffect {
         if(Parameters.data.noParticlesMaster && !(param1.id == "Vortex" || param1.id == "Vent")) {
            return null;
         }
         var _loc3_:* = param1.id;
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case "Healing":
               return new HealingEffect(param2);
            case "Fountain":
               return new FountainEffect(param2,param1);
            case "FountainSnowy":
               return new FountainSnowyEffect(param2,param1);
            case "Snowflake":
               return new SnowflakeEffect(param2,param1);
            case "SkyBeam":
               return new SkyBeamEffect(param2,param1);
            case "Circle":
               return new CircleEffect(param2,param1);
            case "Heart":
               return new HeartEffect(param2,param1);
            case "ExplosionComplex":
               return new ExplosionComplexEffect(param2,param1);
            case "Gas":
               return new GasEffect(param2,param1);
            case "Vent":
               return new VentEffect(param2);
            case "Bubbles":
               return new BubbleEffect(param2,param1);
            case "Vortex":
               return new VortexEffect(param2,param1);
            case "XMLEffect":
               return new XMLEffect(param2,param1);
            case "CustomParticles":
               return ParticleGenerator.attachParticleGenerator(param1,param2);
            default:
               return null;
         }
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         if(this.reducedDrawEnabled) {
            return this.runEasyRendering(param1,param2);
         }
         return this.runNormalRendering(param1,param2);
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
      }
      
      public function runLiteRendering(param1:int, param2:int) : Boolean {
         return false;
      }
      
      public function runNormalRendering(param1:int, param2:int) : Boolean {
         return false;
      }
      
      public function runEasyRendering(param1:int, param2:int) : Boolean {
         return false;
      }
   }
}
