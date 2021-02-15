package com.company.assembleegameclient.account.ui {
   import com.company.assembleegameclient.game.AGameSprite;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class ChooseNameFrame extends Frame {
       
      
      public const cancel:Signal = new Signal();
      
      public const choose:Signal = new Signal(String);
      
      public var gameSprite:AGameSprite;
      
      public var isPurchase:Boolean;
      
      private var nameInput:TextInputField;
      
      public function ChooseNameFrame(param1:AGameSprite, param2:Boolean) {
         super("NewChooseNameFrame.title","Frame.cancel","NewChooseNameFrame.rightButton","/chooseName");
         this.gameSprite = param1;
         this.isPurchase = param2;
         this.nameInput = new TextInputField("NewChooseNameFrame.name",false);
         this.nameInput.inputText_.restrict = "A-Za-z";
         this.nameInput.inputText_.maxChars = 10;
         addTextInputField(this.nameInput);
         addPlainText("Frame.maxChar",{"maxChars":10});
         addPlainText("Frame.restrictChar");
         addPlainText("NewChooseNameFrame.warning");
         leftButton_.addEventListener("click",this.onCancel);
         rightButton_.addEventListener("click",this.onChoose);
      }
      
      public function setError(param1:String) : void {
         this.nameInput.setError(param1);
      }
      
      private function onCancel(param1:MouseEvent) : void {
         this.cancel.dispatch();
      }
      
      private function onChoose(param1:MouseEvent) : void {
         this.choose.dispatch(this.nameInput.text());
         disable();
      }
   }
}
