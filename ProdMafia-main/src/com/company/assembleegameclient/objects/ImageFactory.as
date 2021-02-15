package com.company.assembleegameclient.objects {
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   
   public class ImageFactory {
       
      
      public function ImageFactory() {
         super();
      }
      
      public function getImageFromSet(param1:String, param2:int) : BitmapData {
         return AssetLibrary.getImageFromSet(param1,param2);
      }
      
      public function getTexture(param1:int, param2:int) : BitmapData {
         var _loc4_:Number = NaN;
         var _loc3_:* = null;
         var _loc5_:BitmapData = ObjectLibrary.getBitmapData(param1);
         if(_loc5_) {
            _loc4_ = (param2 - 24) / _loc5_.width;
            _loc3_ = ObjectLibrary.getRedrawnTextureFromType(param1,100,true,false,_loc4_);
            return _loc3_;
         }
         return new BitmapData(param2,param2,true,0);
      }
   }
}
