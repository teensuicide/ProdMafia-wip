package com.company.util {
   import flash.external.ExternalInterface;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   
   public class HTMLUtil {
       
      
      public function HTMLUtil() {
         super();
      }
      
      public static function unescape(param1:String) : String {
         return new XMLDocument(param1).firstChild.nodeValue;
      }
      
      public static function escape(param1:String) : String {
         return XML(new XMLNode(3,param1)).toXMLString();
      }
      
      public static function refreshPageNoParams() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(ExternalInterface.available) {
            _loc2_ = ExternalInterface.call("window.location.toString");
            _loc1_ = _loc2_.split("?");
            if(_loc1_.length > 0) {
               _loc3_ = _loc1_[0];
               if(_loc3_.indexOf("www.kabam") != -1) {
                  _loc3_ = "http://www.realmofthemadgod.com";
               }
               ExternalInterface.call("window.location.assign",_loc3_);
            }
         }
      }
   }
}
