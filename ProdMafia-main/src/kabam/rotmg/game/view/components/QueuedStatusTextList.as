package kabam.rotmg.game.view.components {
   import flash.display.DisplayObjectContainer;
   
   public class QueuedStatusTextList {
       
      
      public var target:DisplayObjectContainer;
      
      private var head:QueuedStatusText;
      
      private var tail:QueuedStatusText;
      
      public function QueuedStatusTextList() {
         super();
      }
      
      public function shift() : void {
         this.target.removeChild(this.head);
         this.head = this.head.next;
         if(this.head) {
            this.target.addChild(this.head);
         } else {
            this.tail = null;
         }
      }
      
      public function append(param1:QueuedStatusText) : void {
         var _loc2_:* = undefined;
         param1.list = this;
         if(this.tail) {
            this.tail.next = param1;
            this.tail = param1;
         } else {
            _loc2_ = param1;
            this.tail = _loc2_;
            this.head = _loc2_;
            this.target.addChild(param1);
         }
      }
   }
}
