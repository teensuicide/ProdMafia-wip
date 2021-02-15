package com.company.assembleegameclient.ui.dialogs {
   import flash.events.Event;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   
   public class ConfirmDialog extends StaticDialog {
       
      
      private var _callback:Function;
      
      public function ConfirmDialog(param1:String, param2:String, param3:Function) {
         this._callback = param3;
         super(param1,param2,"Cancel","OK",null);
         addEventListener("dialogLeftButton",this.onCancel);
         addEventListener("dialogRightButton",this.onConfirm);
      }
      
      private function onConfirm(param1:Event) : void {
         this._callback();
         var _loc2_:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
         _loc2_.dispatch();
      }
      
      private function onCancel(param1:Event) : void {
         var _loc2_:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
         _loc2_.dispatch();
      }
   }
}
