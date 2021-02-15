package com.company.assembleegameclient.account.ui {
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class NewChooseNameFrame extends Frame {
       
      
      public const choose:Signal = new Signal();
      
      public const cancel:Signal = new Signal();
      
      private var name_:TextInputField;
      
      public function NewChooseNameFrame() {
         super("Choose a unique player name","Cancel","NewChooseNameFrame.rightButton","/newChooseName");
         this.name_ = new TextInputField("Player Name",false);
         this.name_.inputText_.restrict = "A-Za-z";
         this.name_.inputText_.maxChars = 10;
         addTextInputField(this.name_);
         addPlainText("Frame.maxChar",{"maxChars":10});
         addPlainText("Frame.restrictChar");
         addPlainText("NewChooseNameFrame.warning");
         leftButton_.addEventListener("click",this.onCancel);
         rightButton_.addEventListener("click",this.onChoose);
      }
      
      public function setError(param1:String) : void {
         this.name_.setError(param1);
      }
      
      private function onChoose(param1:MouseEvent) : void {
         this.choose.dispatch(this.name_.text());
      }
      
      private function onCancel(param1:MouseEvent) : void {
         this.cancel.dispatch();
      }
   }
}
