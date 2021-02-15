package kabam.rotmg.chat.model {
   public class ChatMessage {
       
      
      public var name:String;
      
      public var text:String;
      
      public var objectId:int = -1;
      
      public var numStars:int = -1;
      
      public var recipient:String = "";
      
      public var isToMe:Boolean;
      
      public var isWhisper:Boolean;
      
      public var tokens:Object;
      
      public var isFromSupporter:Boolean;

      public function ChatMessage() {
         super();
      }
      
      public static function make(param1:String, param2:String, param3:int = -1, param4:int = -1, param5:String = "", param6:Boolean = false, param7:Object = null, param8:Boolean = false, param9:Boolean = false) : ChatMessage {
         var _loc11_:ChatMessage = new ChatMessage();
         _loc11_.name = param1;
         _loc11_.text = param2;
         _loc11_.objectId = param3;
         _loc11_.numStars = param4;
         _loc11_.recipient = param5;
         _loc11_.isToMe = param6;
         _loc11_.isWhisper = param8;
         _loc11_.isFromSupporter = param9;
         _loc11_.tokens = param7 == null?{}:param7;
         return _loc11_;
      }
   }
}
