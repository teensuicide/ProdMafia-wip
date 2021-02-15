package com.company.assembleegameclient.map {
   public class AnimateProperties {
      
      public static const NO_ANIMATE:int = 0;
      
      public static const WAVE_ANIMATE:int = 1;
      
      public static const FLOW_ANIMATE:int = 2;
       
      
      public var type_:int = 0;
      
      public var dx_:Number = 0;
      
      public var dy_:Number = 0;
      
      public function AnimateProperties() {
         super();
      }
      
      public function parseXML(param1:XML) : void {
         var _loc2_:String = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "Wave":
               this.type_ = 1;
               break;
            case "Flow":
               this.type_ = 2;
         }
         this.dx_ = param1.@dx;
         this.dy_ = param1.@dy;
      }
   }
}
