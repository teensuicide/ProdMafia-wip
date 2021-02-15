package com.company.assembleegameclient.util {
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import kabam.rotmg.constants.ItemConstants;
   
   public class EquipmentUtil {
      
      public static const NUM_SLOTS:uint = 4;
       
      
      public function EquipmentUtil() {
         super();
      }
      
      public static function getEquipmentBackground(param1:int, param2:Number = 1) : Bitmap {
         var _loc4_:* = null;
         var _loc3_:BitmapData = ItemConstants.itemTypeToBaseSprite(param1);
         if(_loc3_ != null) {
            _loc4_ = new Bitmap(_loc3_);
            _loc4_.scaleX = param2;
            _loc4_.scaleY = param2;
         }
         return _loc4_;
      }
   }
}
