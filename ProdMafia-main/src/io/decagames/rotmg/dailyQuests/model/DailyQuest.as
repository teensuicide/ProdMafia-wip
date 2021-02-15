package io.decagames.rotmg.dailyQuests.model {
   public class DailyQuest {
       
      
      public var completed:Boolean;
      
      public var id:String;
      
      public var name:String;
      
      public var description:String;
      
      public var expiration:String;
      
      public var rewards:Vector.<int>;
      
      public var requirements:Vector.<int>;
      
      public var category:int;
      
      public var itemOfChoice:Boolean;
      
      public var repeatable:Boolean;
      
      public var weight:int;
      
      public function DailyQuest() {
         super();
      }
      
      public function toString() : String {
         return "Quest: id=" + this.id + ", name=" + this.name + ", description=" + this.description + ", expiration=" + this.expiration + ", weight=" + this.weight + ", category=" + this.category + ", rewards=" + this.rewards + ", requirements=" + this.requirements + ", is itemOfChoice? " + (!this.itemOfChoice?"false":"true") + ", is completed? " + (!this.completed?"false":"true") + ", repeatable? " + (!this.repeatable?"false":"true");
      }
   }
}
