package com.company.assembleegameclient.ui.dialogs {
   import flash.events.Event;
   
   public class NotEnoughFameDialog extends Dialog {
       
      
      public function NotEnoughFameDialog() {
         super("NotEnoughFameDialog.title","NotEnoughFameDialog.text","NotEnoughFameDialog.leftButton",null,"/notEnoughFame");
         addEventListener("dialogLeftButton",this.onOk);
      }
      
      public function onOk(param1:Event) : void {
         parent.removeChild(this);
      }
   }
}
