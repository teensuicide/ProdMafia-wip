package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.thrown.BitmapParticle;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class ParticleField extends BitmapParticle {
       
      
      private const SMALL:String = "SMALL";
      
      private const LARGE:String = "LARGE";
      
      public var lifetime_:int;
      
      public var timeLeft_:int;
      
      private var bitmapSize:String;
      
      private var width:int;
      
      private var height:int;
      
      private var spriteSource:Sprite;
      
      private var squares:Array;
      
      private var visibleHeight:Number;
      
      private var offset:Number;
      
      private var timer:Timer;
      
      private var doDestroy:Boolean;
      
      public function ParticleField(param1:Number, param2:Number) {
         this.spriteSource = new Sprite();
         this.squares = [];
         this.setDimensions(param2,param1);
         this.setBitmapSize();
         this.createTimer();
         var _loc3_:BitmapData = new BitmapData(this.width,this.height,true,0);
         _loc3_.draw(this.spriteSource);
         super(_loc3_,0);
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc4_:int = 0;
         if(this.doDestroy) {
            return false;
         }
         var _loc3_:uint = this.squares.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_) {
            if(this.squares[_loc4_]) {
               this.squares[_loc4_].move();
            }
            _loc4_++;
         }
         if(_bitmapData) {
            _bitmapData.dispose();
         }
         _bitmapData = new BitmapData(this.width,this.height,true,0);
         _bitmapData.draw(this.spriteSource);
         return true;
      }
      
      public function destroy() : void {
         if(this.timer) {
            this.timer.removeEventListener("timer",this.onTimer);
            this.timer.stop();
            this.timer = null;
         }
         if(this._bitmapData) {
            this._bitmapData.dispose();
            this._bitmapData = null;
         }
         this.spriteSource = null;
         this.squares = [];
         this.doDestroy = true;
      }
      
      private function createTimer() : void {
         this.timer = new Timer(this.getInterval());
         this.timer.addEventListener("timer",this.onTimer);
         this.timer.start();
      }
      
      private function setDimensions(param1:Number, param2:Number) : void {
         this.visibleHeight = param1 * 5 + 40;
         this.offset = this.visibleHeight * 0.5;
         this.width = param2 * 5 + 40;
         this.height = this.visibleHeight + this.offset;
      }
      
      private function setBitmapSize() : void {
         this.bitmapSize = this.width == 8?"SMALL":"LARGE";
      }
      
      private function getLifespan() : uint {
         return this.bitmapSize == "SMALL"?15:30;
      }
      
      private function getInterval() : uint {
         return this.bitmapSize == "SMALL"?100:50;
      }
      
      private function onSquareComplete(param1:ParticleSquare) : void {
         param1.complete.removeAll();
         this.spriteSource.removeChild(param1);
         this.squares.splice(this.squares.indexOf(param1),1);
      }
      
      private function getStartPoint() : Point {
         var _loc1_:Array = Math.random() < 0.5?["x","y","width","visibleHeight"]:["y","x","visibleHeight","width"];
         var _loc2_:Point = new Point(0,0);
         _loc2_[_loc1_[0]] = Math.random() * this[_loc1_[2]];
         _loc2_[_loc1_[1]] = Math.random() < 0.5?0:this[_loc1_[3]];
         return _loc2_;
      }
      
      private function getEndPoint() : Point {
         return new Point(this.width / 2,this.visibleHeight / 2);
      }
      
      private function onTimer(param1:TimerEvent) : void {
         var _loc2_:ParticleSquare = new ParticleSquare(this.getStartPoint(),this.getEndPoint(),this.getLifespan());
         _loc2_.complete.add(this.onSquareComplete);
         this.squares.push(_loc2_);
         this.spriteSource.addChild(_loc2_);
      }
   }
}

import flash.display.Shape;
import flash.geom.Point;
import org.osflash.signals.Signal;

class ParticleSquare extends Shape {
    
   
   public var start:Point;
   
   public var end:Point;
   
   public var complete:Signal;
   
   private var lifespan:uint;
   
   private var moveX:Number;
   
   private var moveY:Number;
   
   private var angle:Number;
   
   function ParticleSquare(param1:Point, param2:Point, param3:uint) {
      this.complete = new Signal();
      super();
      this.start = param1;
      this.end = param2;
      this.lifespan = param3;
      this.moveX = (param2.x - param1.x) / param3;
      this.moveY = (param2.y - param1.y) / param3;
      graphics.beginFill(16777215);
      graphics.drawRect(-2,-2,4,4);
      this.position();
   }
   
   public function move() : void {
      this.x = this.x + this.moveX;
      this.y = this.y + this.moveY;
      this.lifespan--;
      if(!this.lifespan) {
         this.complete.dispatch(this);
      }
   }
   
   private function position() : void {
      this.x = this.start.x;
      this.y = this.start.y;
   }
}
