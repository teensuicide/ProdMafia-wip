package com.company.assembleegameclient.ui.options {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.MoreColorUtil;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   
   public class KeyMapper extends BaseOption {
       
      
      private var keyCodeBox_:KeyCodeBox;
      
      private var disabled_:Boolean;
      
      public function KeyMapper(param1:String, param2:String, param3:String, param4:Boolean = false, param5:uint = 16777215) {
         super(param1,param2,param3);
         desc_.setColor(param5);
         tooltip_.tipText_.setColor(param5);
         this.keyCodeBox_ = new KeyCodeBox(Parameters.data[paramName_],param5);
         this.keyCodeBox_.addEventListener("change",this.onChange);
         addChild(this.keyCodeBox_);
         this.setDisabled(param4);
      }
      
      override public function refresh() : void {
         this.keyCodeBox_.setKeyCode(Parameters.data[paramName_]);
      }
      
      public function setDisabled(param1:Boolean) : void {
         this.disabled_ = param1;
         transform.colorTransform = !!this.disabled_?MoreColorUtil.darkCT:MoreColorUtil.identity;
         mouseEnabled = !this.disabled_;
         mouseChildren = !this.disabled_;
      }
      
      private function onChange(param1:Event) : void {
         Parameters.setKey(paramName_,this.keyCodeBox_.value());
         Parameters.save();
      }
   }
}
