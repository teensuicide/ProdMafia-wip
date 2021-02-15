package kabam.rotmg.game.view.components {
   import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
   import com.company.assembleegameclient.objects.GameObject;
   
   public class QueuedStatusText extends CharacterStatusText {
       
      
      public var list:QueuedStatusTextList;
      
      public var next:QueuedStatusText;
      
      public function QueuedStatusText(param1:GameObject, param2:String, param3:uint, param4:int, param5:int = 0) {
         super(param1,param3,param4,param5);
         setText(param2);
      }
      
      override public function dispose() : void {
         this.list.shift();
      }
   }
}
