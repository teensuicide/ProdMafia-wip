package io.decagames.rotmg.social.tasks {
   public interface ISocialTask {
       
      
      function get requestURL() : String;
      
      function set requestURL(param1:String) : void;
      
      function get xml() : XML;
      
      function set xml(param1:XML) : void;
   }
}
