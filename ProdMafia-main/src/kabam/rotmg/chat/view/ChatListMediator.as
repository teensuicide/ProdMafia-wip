package kabam.rotmg.chat.view {
   import kabam.rotmg.application.api.ApplicationSetup;
   import kabam.rotmg.chat.control.AddChatSignal;
   import kabam.rotmg.chat.control.ScrollListSignal;
   import kabam.rotmg.chat.control.ShowChatInputSignal;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.chat.model.ChatModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ChatListMediator extends Mediator {
       
      
      [Inject]
      public var view:ChatList;
      
      [Inject]
      public var model:ChatModel;
      
      [Inject]
      public var showChatInput:ShowChatInputSignal;
      
      [Inject]
      public var scrollList:ScrollListSignal;
      
      [Inject]
      public var addChat:AddChatSignal;
      
      [Inject]
      public var itemFactory:ChatListItemFactory;
      
      [Inject]
      public var setup:ApplicationSetup;
      
      public function ChatListMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc3_:* = null;
         this.view.setup(this.model);
         var _loc1_:* = this.model.chatMessages;
         var _loc5_:int = 0;
         var _loc4_:* = this.model.chatMessages;
         for each(_loc3_ in this.model.chatMessages) {
            this.view.addMessage(this.itemFactory.make(_loc3_,true));
         }
         this.view.scrollToCurrent();
         this.showChatInput.add(this.onShowChatInput);
         this.scrollList.add(this.onScrollList);
         this.addChat.add(this.onAddChat);
         this.onAddChat(ChatMessage.make("*Client*",this.getChatLabel()));
      }
      
      override public function destroy() : void {
         this.showChatInput.remove(this.onShowChatInput);
         this.scrollList.remove(this.onScrollList);
         this.addChat.remove(this.onAddChat);
         this.view.dispose();
         this.itemFactory.dispose();
      }
      
      private function onShowChatInput(param1:Boolean, param2:String) : void {
         this.view.y = this.model.bounds.height - (!!param1?this.model.lineHeight:0);
      }
      
      private function onScrollList(param1:int) : void {
         if(param1 > 0) {
            this.view.pageDown();
         } else if(param1 < 0) {
            this.view.pageUp();
         }
      }
      
      private function onAddChat(param1:ChatMessage) : void {
         this.view.addMessage(this.itemFactory.make(param1));
      }
      
      private function getChatLabel() : String {
         var _loc1_:String = this.setup.getBuildLabel();
         return _loc1_.replace(/<font .+>(.+)<\/font>/g,"$1");
      }
   }
}
