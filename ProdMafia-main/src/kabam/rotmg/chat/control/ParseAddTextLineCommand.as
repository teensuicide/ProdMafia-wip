package kabam.rotmg.chat.control {
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.chat.model.ChatModel;
   import kabam.rotmg.text.model.TextAndMapProvider;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class ParseAddTextLineCommand extends Command {
       
      
      [Inject]
      public var chatMessage:ChatMessage;
      
      [Inject]
      public var textStringMap:TextAndMapProvider;
      
      [Inject]
      public var addChat:AddChatSignal;
      
      [Inject]
      public var model:ChatModel;
      
      public function ParseAddTextLineCommand() {
         super();
      }
      
      override public function execute() : void {
         this.translateMessage();
         this.translateName();
         this.model.pushMessage(this.chatMessage);
         this.addChat.dispatch(this.chatMessage);
      }
      
      public function translateChatMessage() : void {
         var _loc2_:LineBuilder = new LineBuilder().setParams(this.chatMessage.text,this.chatMessage.tokens);
         _loc2_.setStringMap(this.textStringMap.getStringMap());
         var _loc1_:String = _loc2_.getString();
         this.chatMessage.text = !!_loc1_?_loc1_:this.chatMessage.text;
      }
      
      private function translateName() : void {
         var _loc2_:LineBuilder = null;
         var _loc1_:String = null;
         if(this.chatMessage.name.length > 0 && this.chatMessage.name.charAt(0) == "#") {
            _loc2_ = new LineBuilder().setParams(this.chatMessage.name.substr(1,this.chatMessage.name.length - 1),this.chatMessage.tokens);
            _loc2_.setStringMap(this.textStringMap.getStringMap());
            _loc1_ = _loc2_.getString();
            this.chatMessage.name = !!_loc1_?"#" + _loc1_:this.chatMessage.name;
         }
      }
      
      private function translateMessage() : void {
         if(this.chatMessage.name == "*Client*" || this.chatMessage.name == "" || this.chatMessage.name == "*Error*" || this.chatMessage.name == "*Help*" || this.chatMessage.name.charAt(0) == "#") {
            this.translateChatMessage();
         }
      }
   }
}
