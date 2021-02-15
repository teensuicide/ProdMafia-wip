package io.decagames.rotmg.social.config {
   public class GuildActions {
      
      public static const BASE_DIRECTORY:String = "/guild";
      
      public static const GUILD_LIST:String = "/listMembers";
       
      
      public function GuildActions() {
         super();
      }
      
      public static function getURL(param1:String) : String {
         return "/guild" + param1;
      }
   }
}
