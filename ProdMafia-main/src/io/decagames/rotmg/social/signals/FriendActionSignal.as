package io.decagames.rotmg.social.signals {
   import io.decagames.rotmg.social.model.FriendRequestVO;
   import org.osflash.signals.Signal;
   
   public class FriendActionSignal extends Signal {
       
      
      public function FriendActionSignal() {
         super(FriendRequestVO);
      }
   }
}
