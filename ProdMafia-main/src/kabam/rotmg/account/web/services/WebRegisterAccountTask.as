package kabam.rotmg.account.web.services {
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.services.RegisterAccountTask;
   import kabam.rotmg.account.web.model.AccountData;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.model.PlayerModel;
   
   public class WebRegisterAccountTask extends BaseTask implements RegisterAccountTask {
       
      
      [Inject]
      public var data:AccountData;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var client:AppEngineClient;
      
      public function WebRegisterAccountTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/register",this.makeDataPacket());
      }
      
      private function makeDataPacket() : Object {
         var _loc1_:* = {};
         _loc1_.guid = this.account.getUserId();
         _loc1_.newGUID = this.data.username;
         _loc1_.newPassword = this.data.password;
         _loc1_.name = this.data.name;
         _loc1_.entrytag = this.account.getEntryTag();
         _loc1_.signedUpKabamEmail = this.data.signedUpKabamEmail;
         _loc1_.isAgeVerified = 1;
         return _loc1_;
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         param1 && this.onRegisterDone(param2);
         completeTask(param1,param2);
      }
      
      private function onRegisterDone(param1:String) : void {
         this.model.setIsAgeVerified(true);
         if(this.data.name) {
            this.model.setName(this.data.name);
            this.model.isNameChosen = true;
         }
         var _loc2_:XML = new XML(param1);
         if("token" in _loc2_) {
            this.data.token = _loc2_.token;
            this.account.updateUser(this.data.username,this.data.password,_loc2_.token,"");
         } else {
            this.account.updateUser(this.data.username,this.data.password,"","");
         }
      }
   }
}
