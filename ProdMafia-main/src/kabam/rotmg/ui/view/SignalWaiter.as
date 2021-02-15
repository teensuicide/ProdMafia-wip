package kabam.rotmg.ui.view {
   import com.adobe.utils.DictionaryUtil;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   
   public class SignalWaiter {
       
      
      public var complete:Signal;
      
      private var texts:Dictionary;
      
      public function SignalWaiter() {
         complete = new Signal();
         texts = new Dictionary();
         super();
      }
      
      public function push(param1:Signal) : SignalWaiter {
         this.texts[param1] = true;
         this.listenTo(param1);
         return this;
      }
      
      public function pushArgs(... rest) : SignalWaiter {
         var _loc2_:* = null;
         var _loc3_:* = rest;
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(_loc2_ in rest) {
            this.push(_loc2_);
         }
         return this;
      }
      
      public function isEmpty() : Boolean {
         return DictionaryUtil.getKeys(this.texts).length == 0;
      }
      
      private function listenTo(param1:Signal) : void {
         _arg_1 = param1;
         var _arg_1:Signal = _arg_1;
         var param1:Signal = _arg_1;
         var value:Signal = param1;
         var onTextChanged:Function = function():void {
            delete texts[value];
            checkEmpty();
         };
         value.addOnce(onTextChanged);
      }
      
      private function checkEmpty() : void {
         if(this.isEmpty()) {
            this.complete.dispatch();
         }
      }
   }
}
