package kabam.rotmg.fame.service {
   import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
   import com.company.util.DateFormatterReplacement;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.assets.model.CharacterTemplate;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   
   public class RequestCharacterFameTask extends BaseTask {
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var classes:ClassesModel;
      
      public var accountId:String;
      
      public var charId:int;
      
      public var xml:XML;
      
      public var name:String;
      
      public var level:int;
      
      public var type:int;
      
      public var deathDate:String;
      
      public var killer:String;
      
      public var totalFame:int;
      
      public var template:CharacterTemplate;
      
      public var texture1:int;
      
      public var texture2:int;
      
      public var size:int;
      
      public var timer:Timer;
      
      private var errorRetry:Boolean = false;
      
      public function RequestCharacterFameTask() {
         timer = new Timer(150);
         super();
      }
      
      override protected function startTask() : void {
         this.timer.addEventListener("timer",this.sendFameRequest);
         this.timer.start();
      }
      
      private function getDataPacket() : Object {
         var _loc1_:* = {};
         _loc1_.accountId = this.accountId;
         _loc1_.charId = this.accountId == ""?-1:this.charId;
         return _loc1_;
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.parseFameData(param2);
         } else {
            this.onFameError(param2);
         }
      }
      
      private function parseFameData(param1:String) : void {
         this.xml = new XML(param1);
         this.parseXML();
         completeTask(true);
      }
      
      private function parseXML() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = this.xml.Char;
         var _loc4_:* = new XMLList("");
         var _loc7_:* = this.xml.Char;
         var _loc8_:int = 0;
         var _loc10_:* = new XMLList("");
         _loc2_ = this.xml.Char.(@id == charId)[0];
         this.name = _loc2_.Account.Name;
         this.level = _loc2_.Level;
         this.type = _loc2_.ObjectType;
         this.deathDate = this.getDeathDate();
         this.killer = this.xml.KilledBy || "";
         this.totalFame = this.xml.TotalFame;
         _loc1_ = this.classes.getCharacterClass(_loc2_.ObjectType);
         _loc3_ = "Texture" in _loc2_?_loc1_.skins.getSkin(_loc2_.Texture):_loc1_.skins.getDefaultSkin();
         this.template = _loc3_.template;
         this.texture1 = "Tex1" in _loc2_?_loc2_.Tex1:0;
         this.texture2 = "Tex2" in _loc2_?_loc2_.Tex2:0;
         this.size = !!_loc3_.is16x16?140:Number(250);
      }
      
      private function getDeathDate() : String {
         var _loc2_:Number = this.xml.CreatedOn * 1000;
         var _loc1_:Date = new Date(_loc2_);
         var _loc3_:DateFormatterReplacement = new DateFormatterReplacement();
         _loc3_.formatString = "MMMM D, YYYY";
         return _loc3_.format(_loc1_);
      }
      
      private function onFameError(param1:String) : void {
         if(this.errorRetry == false) {
            this.errorRetry = true;
            this.timer = new Timer(600);
            this.timer.addEventListener("timer",this.sendFameRequest);
            this.timer.start();
         } else {
            this.errorRetry = false;
            this.openDialog.dispatch(new ErrorDialog(param1));
         }
      }
      
      private function sendFameRequest(param1:TimerEvent) : void {
         this.client.setMaxRetries(8);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("char/fame",this.getDataPacket());
         this.timer.removeEventListener("timer",this.sendFameRequest);
         this.timer.stop();
         this.timer = null;
      }
   }
}
