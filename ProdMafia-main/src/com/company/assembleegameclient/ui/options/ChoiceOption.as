package com.company.assembleegameclient.ui.options {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.MoreColorUtil;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   
   public class ChoiceOption extends BaseOption {
       
      
      private var callback_:Function;
      
      private var choiceBox_:ChoiceBox;
      
      public function ChoiceOption(param1:String, param2:Vector.<StringBuilder>, param3:Array, param4:String, param5:String, param6:Function, param7:uint = 16777215) {
         super(param1,param4,param5);
         desc_.setColor(param7);
         tooltip_.tipText_.setColor(param7);
         this.callback_ = param6;
         this.choiceBox_ = new ChoiceBox(param2,param3,Parameters.data[paramName_],param7);
         this.choiceBox_.addEventListener("change",this.onChange);
         addChild(this.choiceBox_);
      }
      
      override public function refresh() : void {
         this.choiceBox_.setValue(Parameters.data[paramName_]);
      }
      
      public function refreshNoCallback() : void {
         this.choiceBox_.setValue(Parameters.data[paramName_],false);
      }
      
      public function enable(param1:Boolean) : void {
         transform.colorTransform = !!param1?MoreColorUtil.darkCT:MoreColorUtil.identity;
         mouseEnabled = !param1;
         mouseChildren = !param1;
      }
      
      private function onChange(param1:Event) : void {
         Parameters.data[paramName_] = this.choiceBox_.value();
         if(this.callback_ != null) {
            this.callback_();
         }
         Parameters.save();
      }
   }
}
