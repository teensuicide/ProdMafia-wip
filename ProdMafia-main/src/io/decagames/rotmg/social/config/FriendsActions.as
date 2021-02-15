package io.decagames.rotmg.social.config {
   public class FriendsActions {
      
      public static const FRIEND_LIST:String = "/getList";
      
      public static const INVITE_LIST:String = "/getRequests";
      
      public static const INVITE:String = "/requestFriend";
      
      public static const ACCEPT:String = "/acceptRequest";
      
      public static const REJECT:String = "/rejectRequest";
      
      public static const REMOVE:String = "/removeFriend";
      
      public static const BLOCK:String = "/blockRequest";
      
      public static const SEARCH:String = "searchFriend";
      
      public static const FRIEND_TAB:String = "Friends";
      
      public static const INVITE_TAB:String = "Invitations";
      
      public static const WHISPER:String = "Whisper";
      
      public static const JUMP:String = "JumpServer";
       
      
      public function FriendsActions() {
         super();
      }
      
      public static function getURL(param1:String) : String {
         return "/friends" + param1;
      }
   }
}
