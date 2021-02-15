package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.ImageSet;
   import com.company.util.MoreColorUtil;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class OrbEffect extends ParticleEffect {
      
      public static var images:Vector.<BitmapData>;
       
      
      public var go_:GameObject;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public var color3_:uint;
      
      public var duration_:int;
      
      public var rad_:Number;
      
      public var target_:Point;
      
      public function OrbEffect(param1:GameObject, param2:uint, param3:uint, param4:uint, param5:Number, param6:int, param7:Point) {
         super();
         this.go_ = param1;
         this.color1_ = param2;
         this.color2_ = param3;
         this.color3_ = param4;
         this.rad_ = param5;
         this.duration_ = param6;
         this.target_ = param7;
      }
      
      public static function initialize() : void {
         images = parseBitmapDataFromImageSet("lofiParticlesSkull");
      }
      
      private static function apply(param1:BitmapData, param2:uint) : BitmapData {
         var _loc3_:ColorTransform = MoreColorUtil.veryGreenCT;
         _loc3_.color = param2;
         var _loc4_:BitmapData = param1.clone();
         _loc4_.colorTransform(_loc4_.rect,_loc3_);
         return _loc4_;
      }
      
      private static function parseBitmapDataFromImageSet(param1:String) : Vector.<BitmapData> {
         var _loc6_:uint = 0;
         var _loc5_:BitmapData = null;
         var _loc2_:Vector.<BitmapData> = new Vector.<BitmapData>();
         var _loc3_:ImageSet = AssetLibrary.getImageSet(param1);
         var _loc4_:uint = _loc3_.images.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_) {
            _loc5_ = TextureRedrawer.redraw(_loc3_.images[_loc6_],120,true,11673446,true,5,1.4);
            if(_loc6_ == 8) {
               _loc5_ = apply(_loc5_,11673446);
            } else {
               _loc5_ = apply(_loc5_,3675232);
            }
            _loc2_.push(_loc5_);
            _loc6_++;
         }
         return _loc2_;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         x_ = this.target_.x;
         y_ = this.target_.y;
         map_.addObj(new SkullEffect(this.target_,images),this.target_.x,this.target_.y);
         return false;
      }
   }
}
