package com.company.assembleegameclient.ui.tooltip {
   public class TooltipHelper {
      
      public static const BETTER_COLOR:uint = 65280;
      
      public static const WORSE_COLOR:uint = 16711680;
      
      public static const NO_DIFF_COLOR:uint = 16777103;
      
      public static const NO_DIFF_COLOR_INACTIVE:uint = 6842444;
      
      public static const WIS_BONUS_COLOR:uint = 4219875;
      
      public static const UNTIERED_COLOR:uint = 9055202;
      
      public static const SET_COLOR:uint = 16750848;
      
      public static const SET_COLOR_INACTIVE:uint = 6835752;
       
      
      public function TooltipHelper() {
         super();
      }
      
      public static function wrapInFontTag(param1:String, param2:String) : String {
         return "<font color=\"" + param2 + "\">" + param1 + "</font>";
      }
      
      public static function getOpenTag(param1:uint) : String {
         return "<font color=\"#" + param1.toString(16) + "\">";
      }
      
      public static function getCloseTag() : String {
         return "</font>";
      }
      
      public static function compareAndGetPlural(param1:Number, param2:Number, param3:String, param4:Boolean = true, param5:Boolean = true) : String {
         return wrapInFontTag(getPlural(param1,param3),"#" + getTextColor((!!param4?param1 - param2:Number(param2 - param1)) * int(param5)).toString(16));
      }
      
      public static function compare(param1:Number, param2:Number, param3:Boolean = true, param4:String = "", param5:Boolean = false, param6:Boolean = true) : String {
         return wrapInFontTag((!!param5?Math.abs(param1):Number(param1)) + param4,"#" + getTextColor((!!param3?param1 - param2:Number(param2 - param1)) * int(param6)).toString(16));
      }
      
      public static function getPlural(param1:Number, param2:String) : String {
         var _loc3_:String = param1 + " " + param2;
         if(param1 != 1) {
            return _loc3_ + "s";
         }
         return _loc3_;
      }
      
      public static function getTextColor(param1:Number) : uint {
         return param1 < 0?16711680:Number(param1 > 0?65280:16777103);
      }
   }
}
