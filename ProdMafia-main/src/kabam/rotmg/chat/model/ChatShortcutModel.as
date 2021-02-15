package kabam.rotmg.chat.model {
   import com.company.assembleegameclient.parameters.Parameters;
   
   public class ChatShortcutModel {
       
      
      private var commandShortcut:int = 191;
      
      private var chatShortcut:int = 13;
      
      private var tellShortcut:int = 9;
      
      private var guildShortcut:int = 71;
      
      private var scrollUp:uint = 33;
      
      private var scrollDown:uint = 34;
      
      public function ChatShortcutModel() {
         super();
      }
      
      public function getCommandShortcut() : int {
         return Parameters.data["chatCommand"];
      }
      
      public function getChatShortcut() : int {
         return Parameters.data["chat"];
      }
      
      public function getTellShortcut() : int {
         return Parameters.data["tell"];
      }
      
      public function getGuildShortcut() : int {
         return Parameters.data["guildChat"];
      }
      
      public function getScrollUp() : uint {
         return Parameters.data["scrollChatUp"];
      }
      
      public function getScrollDown() : uint {
         return Parameters.data["scrollChatDown"];
      }
   }
}
