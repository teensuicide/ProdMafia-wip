package com.company.assembleegameclient.tutorial {
   public class Step {
       
      
      public var text_:String;
      
      public var action_:String;
      
      public var uiDrawBoxes_:Vector.<UIDrawBox>;
      
      public var uiDrawArrows_:Vector.<UIDrawArrow>;
      
      public var reqs_:Vector.<Requirement>;
      
      public var satisfiedSince_:int = 0;
      
      public var trackingSent:Boolean;
      
      public function Step(param1:XML) {
         uiDrawBoxes_ = new Vector.<UIDrawBox>();
         uiDrawArrows_ = new Vector.<UIDrawArrow>();
         reqs_ = new Vector.<Requirement>();
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         super();
         var _loc10_:* = param1.UIDrawBox;
         var _loc12_:int = 0;
         var _loc11_:* = param1.UIDrawBox;
         for each(_loc2_ in param1.UIDrawBox) {
            this.uiDrawBoxes_.push(new UIDrawBox(_loc2_));
         }
         var _loc8_:* = param1.UIDrawArrow;
         var _loc14_:int = 0;
         var _loc13_:* = param1.UIDrawArrow;
         for each(_loc9_ in param1.UIDrawArrow) {
            this.uiDrawArrows_.push(new UIDrawArrow(_loc9_));
         }
         var _loc6_:* = param1.Requirement;
         var _loc16_:int = 0;
         var _loc15_:* = param1.Requirement;
         for each(_loc4_ in param1.Requirement) {
            this.reqs_.push(new Requirement(_loc4_));
         }
      }
      
      public function toString() : String {
         return "[" + this.text_ + "]";
      }
   }
}
