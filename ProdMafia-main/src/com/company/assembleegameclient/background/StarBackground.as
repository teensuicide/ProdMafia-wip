package com.company.assembleegameclient.background {
   import com.company.assembleegameclient.map.Camera;
   import com.company.util.AssetLibrary;
   import com.company.util.ImageSet;
   import com.company.util.PointUtil;
   import flash.display.IGraphicsData;
   
   public class StarBackground extends Background {
       
      
      public var stars_:Vector.<Star>;
      
      protected var graphicsData_:Vector.<IGraphicsData>;
      
      public function StarBackground() {
         var _loc1_:int = 0;
         stars_ = new Vector.<Star>();
         graphicsData_ = new Vector.<IGraphicsData>();
         super();
         visible = true;
         while(_loc1_ < 100) {
            this.tryAddStar();
            _loc1_++;
         }
      }
      
      override public function draw(param1:Camera, param2:int) : void {
         var _loc3_:* = null;
         this.graphicsData_.length = 0;
         var _loc4_:* = this.stars_;
         var _loc7_:int = 0;
         var _loc6_:* = this.stars_;
         for each(_loc3_ in this.stars_) {
            _loc3_.draw(this.graphicsData_,param1,param2);
         }
         graphics.clear();
         graphics.drawGraphicsData(this.graphicsData_);
      }
      
      private function tryAddStar() : void {
         var _loc2_:* = null;
         var _loc1_:ImageSet = AssetLibrary.getImageSet("stars");
         var _loc3_:Star = new Star(Math.random() * 1000 - 500,Math.random() * 1000 - 500,4 * (0.5 + 0.5 * Math.random()),_loc1_.images[int(_loc1_.images.length * Math.random())]);
         var _loc4_:* = this.stars_;
         var _loc7_:int = 0;
         var _loc6_:* = this.stars_;
         for each(_loc2_ in this.stars_) {
            if(PointUtil.distanceXY(_loc3_.x_,_loc3_.y_,_loc2_.x_,_loc2_.y_) < 3) {
               return;
            }
         }
         this.stars_.push(_loc3_);
      }
   }
}

import com.company.assembleegameclient.map.Camera;
import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;

class Star {
   
   protected static const sqCommands:Vector.<int> = new <int>[1,2,2,2];
   
   protected static const END_FILL:GraphicsEndFill = new GraphicsEndFill();
    
   
   public var x_:Number;
   
   public var y_:Number;
   
   public var scale_:Number;
   
   public var bitmap_:BitmapData;
   
   protected var bitmapFill_:GraphicsBitmapFill;
   
   protected var path_:GraphicsPath;
   
   private var w_:Number;
   
   private var h_:Number;
   
   function Star(param1:Number, param2:Number, param3:Number, param4:BitmapData) {
      bitmapFill_ = new GraphicsBitmapFill(null,new Matrix(),false,false);
      path_ = new GraphicsPath(Star.sqCommands,new Vector.<Number>());
      super();
      this.x_ = param1;
      this.y_ = param2;
      this.scale_ = param3;
      this.bitmap_ = param4;
      this.w_ = this.bitmap_.width * this.scale_;
      this.h_ = this.bitmap_.height * this.scale_;
   }
   
   public function draw(param1:Vector.<IGraphicsData>, param2:Camera, param3:int) : void {
      var _loc5_:Number = this.x_ * Math.cos(-param2.angleRad_) - this.y_ * Math.sin(-param2.angleRad_);
      var _loc8_:Number = this.x_ * Math.sin(-param2.angleRad_) + this.y_ * Math.cos(-param2.angleRad_);
      var _loc7_:Matrix = this.bitmapFill_.matrix;
      _loc7_.identity();
      _loc7_.translate(-this.bitmap_.width / 2,-this.bitmap_.height / 2);
      _loc7_.scale(this.scale_,this.scale_);
      _loc7_.translate(_loc5_,_loc8_);
      this.bitmapFill_.bitmapData = this.bitmap_;
      this.path_.data.length = 0;
      var _loc4_:Number = _loc5_ - this.w_ / 2;
      var _loc6_:Number = _loc8_ - this.h_ / 2;
      this.path_.data.push(_loc4_,_loc6_,_loc4_ + this.w_,_loc6_,_loc4_ + this.w_,_loc6_ + this.h_,_loc4_,_loc6_ + this.h_);
      param1.push(this.bitmapFill_);
      param1.push(this.path_);
      param1.push(END_FILL);
   }
}
