package kabam.rotmg.game.model {
   public class ChatFilter {
       
      
      public function ChatFilter() {
         super();
      }
      
      public function guestChatFilter(param1:String) : Boolean {
         var _loc2_:Boolean = false;
         if(param1 == null) {
            return true;
         }
         if(param1 == "" || param1 == "*Help*" || param1 == "*Error*" || param1 == "*Client*") {
            _loc2_ = true;
         }
         if(param1.charAt(0) == "#") {
            _loc2_ = true;
         }
         if(param1.charAt(0) == "@") {
            _loc2_ = true;
         }
         return _loc2_;
      }
   }
}
