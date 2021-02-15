package com.company.assembleegameclient.account.ui {
   import com.company.assembleegameclient.account.ui.components.Selectable;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.util.components.RadioButton;
   import org.osflash.signals.Signal;
   
   public class PaymentMethodRadioButton extends Sprite implements Selectable {
      
      public static const HEIGHT:int = 28;
       
      
      public const textSet:Signal = new Signal();
      
      private var label:String;
      
      private var text:TextFieldDisplayConcrete;
      
      private var button:RadioButton;
      
      public function PaymentMethodRadioButton(param1:String) {
         super();
         this.label = param1;
         this.makeRadioButton();
         this.makeLabelText();
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
         this.text.textChanged.add(this.onTextChanged);
      }
      
      public function getValue() : String {
         return this.label;
      }
      
      public function setSelected(param1:Boolean) : void {
         this.button.setSelected(param1);
      }
      
      private function onTextChanged() : void {
         this.text.y = this.button.height / 2 - this.text.height / 2;
         this.textSet.dispatch();
      }
      
      private function makeRadioButton() : void {
         this.button = new RadioButton();
         addChild(this.button);
      }
      
      private function makeLabelText() : void {
         this.text = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true);
         this.text.setStringBuilder(new LineBuilder().setParams(this.label));
         this.text.filters = [new DropShadowFilter(0,0,0)];
         this.text.x = 36;
         addChild(this.text);
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.text.setColor(16768133);
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.text.setColor(16777215);
      }
   }
}
