package kabam.rotmg.chat.view {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import kabam.rotmg.chat.model.ChatModel;
   import org.osflash.signals.Signal;
   
   public class ChatInput extends Sprite {
       
      
      public const message:Signal = new Signal(String);
      
      public const close:Signal = new Signal();
      
      public var input:TextField;
      
      private var enteredText:Boolean;
      
      private var lastInput:String = "";
      
      public function ChatInput() {
         super();
         visible = false;
         tabEnabled = false;
         this.enteredText = false;
      }
      
      public function setup(param1:ChatModel, param2:TextField) : void {
         var _loc3_:* = param2;
         this.input = _loc3_;
         addChild(_loc3_);
         param2.width = param1.bounds.width - 2;
         param2.height = param1.lineHeight;
         param2.y = param1.bounds.height - param1.lineHeight;
      }
      
      public function activate(param1:String, param2:Boolean) : void {
         this.enteredText = false;
         if(param1 != null) {
            this.input.text = param1;
         }
         var _loc3_:int = !!param1?param1.length:0;
         this.input.setSelection(_loc3_,_loc3_);
         if(param2) {
            this.activateEnabled();
         } else {
            this.activateDisabled();
         }
         visible = true;
      }
      
      public function deactivate() : void {
         this.enteredText = false;
         removeEventListener("keyUp",this.onKeyUp);
         stage.removeEventListener("keyUp",this.onTextChange);
         visible = false;
      }
      
      public function hasEnteredText() : Boolean {
         return this.enteredText;
      }
      
      private function activateEnabled() : void {
         this.input.type = "input";
         this.input.border = true;
         this.input.selectable = true;
         this.input.maxChars = 128;
         this.input.borderColor = 16777215;
         this.input.height = 18;
         this.input.filters = [new GlowFilter(0,1,3,3,2,1)];
         addEventListener("keyUp",this.onKeyUp);
         stage.addEventListener("keyUp",this.onTextChange);
      }
      
      private function activateDisabled() : void {
         this.input.type = "dynamic";
         this.input.border = false;
         this.input.selectable = false;
         this.input.filters = [new GlowFilter(0,1,3,3,2,1)];
         this.input.height = 18;
         removeEventListener("keyUp",this.onKeyUp);
         stage.removeEventListener("keyUp",this.onTextChange);
      }
      
      private function onTextChange(param1:Event) : void {
         this.enteredText = true;
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void {
         var _loc2_:int = 0;
         if(param1.keyCode == Parameters.data.chat) {
            if(this.input.text != "") {
               this.message.dispatch(this.input.text);
            } else {
               this.close.dispatch();
            }
            this.lastInput = this.input.text;
            param1.stopImmediatePropagation();
         }
         if(param1.keyCode == Parameters.data.chatCommand) {
            if(this.input.text != "") {
               return;
            }
            this.input.text = this.lastInput;
            _loc2_ = this.lastInput.length;
            this.input.setSelection(_loc2_,_loc2_);
            param1.stopImmediatePropagation();
         }
      }
   }
}
