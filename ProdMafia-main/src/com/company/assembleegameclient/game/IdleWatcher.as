package com.company.assembleegameclient.game {
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   
   public class IdleWatcher {
      
      private static const MINUTE_IN_MS:int = 60000;
      
      private static const FIRST_WARNING_MINUTES:int = 10;
      
      private static const SECOND_WARNING_MINUTES:int = 15;
      
      private static const KICK_MINUTES:int = 20;
       
      
      public var gs_:GameSprite = null;
      
      public var idleTime_:int = 0;
      
      private var addTextLine:AddTextLineSignal;
      
      public function IdleWatcher() {
         super();
         this.addTextLine = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
      }
      
      public function start(param1:GameSprite) : void {
         this.gs_ = param1;
         this.idleTime_ = 0;
         this.gs_.stage.addEventListener("mouseMove",this.onMouseMove);
         this.gs_.stage.addEventListener("keyDown",this.onKeyDown);
      }
      
      public function update(param1:int) : Boolean {
         var _loc2_:int = this.idleTime_;
         this.idleTime_ = this.idleTime_ + param1;
         if(this.idleTime_ < 600000) {
            return false;
         }
         if(this.idleTime_ >= 600000 && _loc2_ < 600000) {
            this.addTextLine.dispatch(this.makeFirstWarning());
            return false;
         }
         if(this.idleTime_ >= 900000 && _loc2_ < 900000) {
            this.addTextLine.dispatch(this.makeSecondWarning());
            return false;
         }
         if(this.idleTime_ >= 1200000 && _loc2_ < 1200000) {
            this.addTextLine.dispatch(this.makeThirdWarning());
            return true;
         }
         return false;
      }
      
      public function stop() : void {
         this.gs_.stage.removeEventListener("mouseMove",this.onMouseMove);
         this.gs_.stage.removeEventListener("keyDown",this.onKeyDown);
         this.gs_ = null;
      }
      
      private function makeFirstWarning() : ChatMessage {
         var _loc1_:ChatMessage = new ChatMessage();
         _loc1_.name = "*Error*";
         _loc1_.text = "You have been idle for 10 minutes, you will be disconnected if you are idle for more than 20 minutes.";
         return _loc1_;
      }
      
      private function makeSecondWarning() : ChatMessage {
         var _loc1_:ChatMessage = new ChatMessage();
         _loc1_.name = "*Error*";
         _loc1_.text = "You have been idle for 15 minutes, you will be disconnected if you are idle for more than 20 minutes.";
         return _loc1_;
      }
      
      private function makeThirdWarning() : ChatMessage {
         var _loc1_:ChatMessage = new ChatMessage();
         _loc1_.name = "*Error*";
         _loc1_.text = "You have been idle for 20 minutes, disconnecting.";
         return _loc1_;
      }
      
      private function onMouseMove(param1:MouseEvent) : void {
         this.idleTime_ = 0;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         this.idleTime_ = 0;
      }
   }
}
