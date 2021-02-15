package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.ImageSet;
   import com.company.util.MoreColorUtil;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class ThunderEffect extends ParticleEffect {
      
      private static var impactImages:Vector.<BitmapData>;
      
      private static var beamImages:Vector.<BitmapData>;
       
      
      public var go_:GameObject;
      
      public function ThunderEffect(param1:GameObject) {
         super();
         this.go_ = param1;
         x_ = this.go_.x_;
         y_ = this.go_.y_;
      }
      
      public static function initialize() : void {
         beamImages = parseBitmapDataFromImageSet(6,"lofiParticlesBeam",16768115);
         impactImages = prepareThunderImpactImages(parseBitmapDataFromImageSet(13,"lofiParticlesElectric"));
      }
      
      private static function prepareThunderImpactImages(param1:Vector.<BitmapData>) : Vector.<BitmapData> {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_) {
            if(_loc3_ == 8) {
               param1[_loc3_] = applyColorTransform(param1[_loc3_],16768115);
            } else if(_loc3_ == 7) {
               param1[_loc3_] = applyColorTransform(param1[_loc3_],16777215);
            } else {
               param1[_loc3_] = applyColorTransform(param1[_loc3_],16751104);
            }
            _loc3_++;
         }
         return param1;
      }
      
      private static function applyColorTransform(param1:BitmapData, param2:uint) : BitmapData {
         var _loc3_:ColorTransform = MoreColorUtil.veryGreenCT;
         _loc3_.color = param2;
         var _loc4_:BitmapData = param1.clone();
         _loc4_.colorTransform(_loc4_.rect,_loc3_);
         return _loc4_;
      }
      
      private static function parseBitmapDataFromImageSet(param1:uint, param2:String, param3:uint = 0) : Vector.<BitmapData> {
         var _loc7_:uint = 0;
         var _loc4_:BitmapData = null;
         var _loc5_:Vector.<BitmapData> = new Vector.<BitmapData>();
         var _loc6_:ImageSet = AssetLibrary.getImageSet(param2);
         var _loc8_:* = param1;
         _loc7_ = 0;
         while(_loc7_ < _loc8_) {
            _loc4_ = TextureRedrawer.redraw(_loc6_.images[_loc7_],120,true,16768115,true,5,1.4);
            if(param3 != 0) {
               _loc4_ = applyColorTransform(_loc4_,param3);
            }
            _loc5_.push(_loc4_);
            _loc7_++;
         }
         return _loc5_;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         this.runEffect();
         return false;
      }
      
      private function runEffect() : void {
         map_.addObj(new AnimatedEffect(beamImages,2,0,240),x_,y_);
         map_.addObj(new AnimatedEffect(impactImages,0,80,360),x_,y_);
      }
   }
}
