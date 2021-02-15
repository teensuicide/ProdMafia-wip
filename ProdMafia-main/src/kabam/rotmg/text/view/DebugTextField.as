package kabam.rotmg.text.view {
   import flash.text.TextField;
   import kabam.rotmg.language.model.DebugStringMap;
   
   public class DebugTextField extends TextField {
      
      public static const WRONG_LANGUAGE_COLOR:uint = 977663;
      
      public static const INVALID_KEY_COLOR:uint = 15874138;
       
      
      public var debugStringMap:DebugStringMap;
      
      public function DebugTextField() {
         super();
      }
      
      override public function set text(param1:String) : void {
         super.text = this.getText(param1);
      }
      
      override public function set htmlText(param1:String) : void {
         super.htmlText = this.getText(param1);
      }
      
      public function getText(param1:String) : String {
         var _loc2_:* = null;
         if(this.debugStringMap.debugTextInfos.length) {
            _loc2_ = this.debugStringMap.debugTextInfos[0];
            if(_loc2_.hasKey) {
               this.setBackground(977663);
            } else {
               this.setBackground(15874138);
            }
            return _loc2_.key;
         }
         return param1;
      }
      
      private function setBackground(param1:uint) : void {
         background = true;
         backgroundColor = param1;
      }
   }
}
