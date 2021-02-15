package com.company.util {
   import flash.display.BitmapData;
   
   public class ImageSet {
       
      
      public var images:Vector.<BitmapData>;
      
      public var imagesLength:int;
      
      public function ImageSet() {
         super();
         this.images = new Vector.<BitmapData>();
         this.imagesLength = this.images.length;
      }
      
      public function add(param1:BitmapData) : void {
         this.images.push(param1);
         this.imagesLength = this.images.length;
      }
      
      public function random() : BitmapData {
         return this.images[int(Math.random() * this.imagesLength)];
      }
      
      public function addFromBitmapData(param1:BitmapData, param2:int, param3:int) : void {
         var _loc7_:int = 0;
         var _loc4_:int = param1.width / param2;
         var _loc5_:int = param1.height / param3;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_) {
            _loc7_ = 0;
            while(_loc7_ < _loc4_) {
               this.images.push(BitmapUtil.cropToBitmapData(param1,_loc7_ * param2,_loc6_ * param3,param2,param3));
               _loc7_++;
            }
            _loc6_++;
         }
         this.imagesLength = this.images.length;
      }
   }
}
