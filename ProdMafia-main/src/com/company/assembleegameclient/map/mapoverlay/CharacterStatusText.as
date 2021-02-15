package com.company.assembleegameclient.map.mapoverlay {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.ui.BaseSimpleText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class CharacterStatusText extends Sprite implements IMapOverlayElement {
       
      
      private const GLOW_FILTER:GlowFilter = new GlowFilter(0,1,4,4,2,1);
      
      public const MAX_DRIFT:int = 40;
      
      public var go_:GameObject;
      
      public var offset_:Point;
      
      public var color_:uint;
      
      public var lifetime_:int;
      
      public var offsetTime_:int;
      
      public var textDisplay:BaseSimpleText;
      
      private var startTime_:int = 0;
      
      public function CharacterStatusText(param1:GameObject, param2:uint, param3:int, param4:int = 0) {
         super();
         this.go_ = param1;
         this.offset_ = new Point(0,-param1.texture.height * (param1.size_ * 0.01) * 5 - 20);
         this.color_ = param2;
         this.lifetime_ = param3;
         this.offsetTime_ = param4;
         this.textDisplay = new BaseSimpleText(24,param2);
         this.textDisplay.setBold(true);
         this.textDisplay.filters = [GLOW_FILTER];
         this.textDisplay.x = -this.textDisplay.width * 0.5;
         this.textDisplay.y = -this.textDisplay.height * 0.5;
         addChild(this.textDisplay);
         visible = false;
      }
      
      public function draw(param1:Camera, param2:int) : Boolean {
         if(this.startTime_ == 0) {
            this.startTime_ = param2 + this.offsetTime_;
         }
         if(param2 < this.startTime_) {
            visible = false;
            return true;
         }
         var _loc3_:int = param2 - this.startTime_;
         if(this.lifetime_ != -1 && _loc3_ > this.lifetime_ || this.go_ && this.go_.map_ == null) {
            return false;
         }
         if(this.go_ == null || !this.go_.drawn_) {
            visible = false;
            return true;
         }
         visible = true;
         x = (!!this.go_?this.go_.posS_[0]:0) + (!!this.offset_?this.offset_.x:0);
         if(this.lifetime_ == -1) {
            y = (!!this.go_?this.go_.posS_[1]:0) + 26;
         } else {
            y = (!!this.go_?this.go_.posS_[1]:0) + (!!this.offset_?this.offset_.y:0) - _loc3_ / this.lifetime_ * 40;
         }
         return true;
      }
      
      public function getGameObject() : GameObject {
         return this.go_;
      }
      
      public function dispose() : void {
         this.go_ = null;
         if(parent) {
            parent.removeChild(this);
         }
      }
      
      public function setText(param1:String) : void {
         this.textDisplay.setText(param1);
         this.textDisplay.updateMetrics();
         var _loc3_:BitmapData = new BitmapData(this.textDisplay.width,this.textDisplay.height,true,0);
         var _loc2_:Bitmap = new Bitmap(_loc3_);
         _loc3_.draw(this.textDisplay,new Matrix());
         _loc2_.x = _loc2_.x - _loc2_.width * 0.5;
         _loc2_.y = _loc2_.y - _loc2_.height * 0.5;
         addChild(_loc2_);
         removeChild(this.textDisplay);
         this.textDisplay = null;
      }
   }
}
