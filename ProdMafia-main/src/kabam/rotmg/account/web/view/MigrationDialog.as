package kabam.rotmg.account.web.view {
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.view.EmptyFrame;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.appengine.impl.SimpleAppEngineClient;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.util.components.SimpleButton;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class MigrationDialog extends EmptyFrame {
       
      
      public var done:Signal;
      
      protected var leftButton_:SimpleButton;
      
      protected var rightButton_:SimpleButton;
      
      private var okButton:Signal;
      
      private var account:Account;
      
      private var client:AppEngineClient;
      
      private var progressCheckClient:AppEngineClient;
      
      private var lastPercent:Number = 0;
      
      private var total:Number = 100;
      
      private var progBar:ProgressBar;
      
      private var timerProgressCheck:Timer;
      
      private var status:Number = 0;
      
      private var isClosed:Boolean;
      
      public function MigrationDialog(param1:Account, param2:Number) {
         timerProgressCheck = new Timer(2000,0);
         super(500,220,"Maintenance Needed");
         this.isClosed = false;
         setDesc("Press OK to begin maintenance on \n\n" + param1.getUserName() + "\n\nor cancel to login with a different account",true);
         this.makeAndAddLeftButton("Cancel");
         this.makeAndAddRightButton("OK");
         this.account = param1;
         this.status = param2;
         this.client = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
         this.okButton = new NativeMappedSignal(this.rightButton_,"click");
         cancel = new NativeMappedSignal(this.leftButton_,"click");
         this.done = new Signal();
         this.okButton.addOnce(this.okButton_doMigrate);
         this.done.addOnce(this.closeMyself);
         cancel.addOnce(this.removeMigrateCallback);
         cancel.addOnce(this.closeMyself);
      }
      
      private function okButton_doMigrate() : void {
         var _loc1_:* = null;
         this.rightButton_.setEnabled(false);
         if(this.status == 1) {
            _loc1_ = this.account.getCredentials();
            this.client.complete.addOnce(this.onMigrateStartComplete);
            this.client.sendRequest("/migrate/doMigration",_loc1_);
         }
      }
      
      private function startPercentLoop() : void {
         this.timerProgressCheck.addEventListener("timer",this.percentLoop);
         if(this.progressCheckClient == null) {
            this.progressCheckClient = StaticInjectorContext.getInjector().getInstance(SimpleAppEngineClient);
         }
         this.timerProgressCheck.start();
         this.updatePercent(0);
      }
      
      private function stopPercentLoop() : void {
         this.updatePercent(100);
         this.timerProgressCheck.stop();
         this.timerProgressCheck.removeEventListener("timer",this.percentLoop);
      }
      
      private function onUpdateStatusComplete(param1:Boolean, param2:*) : void {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param1) {
            if(this.isClosed == true) {
               return;
            }
            _loc4_ = new XML(param2);
            if("Percent" in _loc4_) {
               _loc5_ = _loc4_.Percent;
               _loc3_ = parseFloat(_loc5_);
               if(_loc3_ == 100) {
                  if(this.isClosed == false) {
                     this.stopPercentLoop();
                     this.updatePercent(_loc3_);
                     this.done.dispatch();
                  }
               } else if(_loc3_ != this.lastPercent) {
                  this.updatePercent(_loc3_);
               }
            } else if("MigrateStatus" in _loc4_) {
               _loc6_ = _loc4_.MigrateStatus;
               if(_loc6_ == 44) {
                  this.stopPercentLoop();
                  this.reset();
               }
            }
         }
      }
      
      private function updatePercent(param1:Number) : void {
         this.progBar.update(param1);
         this.lastPercent = param1;
         setDesc("" + param1 + "%",true);
      }
      
      private function onMigrateStartComplete(param1:Boolean, param2:*) : void {
         var _loc4_:* = null;
         var _loc3_:Number = NaN;
         if(this.isClosed) {
            return;
         }
         if(param1) {
            _loc4_ = new XML(param2);
            if("MigrateStatus" in _loc4_) {
               _loc3_ = _loc4_.MigrateStatus;
               if(_loc3_ == 44) {
                  this.stopPercentLoop();
                  this.reset();
               } else if(_loc3_ == 4) {
                  this.addProgressBar();
                  setTitle("Migration In Progress",true);
                  this.startPercentLoop();
               } else {
                  this.stopPercentLoop();
                  this.reset();
               }
            }
         } else {
            this.stopPercentLoop();
            this.reset();
         }
      }
      
      private function reset() : void {
         setTitle("Error, please try again. Maintenance needed",true);
         setDesc("Press OK to begin maintenance on \n\n" + this.account.getUserName() + "\n\nor cancel to login with a different account",true);
         this.removeProgressBar();
         this.okButton.addOnce(this.okButton_doMigrate);
         this.rightButton_.setEnabled(true);
      }
      
      private function addProgressBar() : void {
         var _loc1_:Number = NaN;
         this.removeProgressBar();
         _loc1_ = modalHeight / 3;
         var _loc2_:Number = modalWidth - 40;
         this.progBar = new ProgressBar(_loc2_,40);
         addChild(this.progBar);
         this.progBar.x = 20;
         this.progBar.y = _loc1_;
      }
      
      private function removeProgressBar() : void {
         if(this.progBar != null && this.progBar.parent != null) {
            removeChild(this.progBar);
         }
      }
      
      private function removeMigrateCallback() : void {
         this.done.removeAll();
      }
      
      private function closeMyself() : void {
         this.isClosed = true;
         var _loc1_:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
         _loc1_.dispatch();
      }
      
      private function makeAndAddLeftButton(param1:String) : void {
         this.leftButton_ = new SimpleButton(param1);
         if(param1 != "") {
            this.leftButton_.buttonMode = true;
            addChild(this.leftButton_);
            this.leftButton_.x = modalWidth / 2 - 100 - this.leftButton_.width;
            this.leftButton_.y = modalHeight - 50;
         }
      }
      
      private function makeAndAddRightButton(param1:String) : void {
         this.rightButton_ = new SimpleButton(this.leftButton_.text.text);
         this.rightButton_.freezeSize();
         this.rightButton_.setText(param1);
         if(param1 != "") {
            this.rightButton_.buttonMode = true;
            addChild(this.rightButton_);
            this.rightButton_.x = modalWidth / 2 + 100;
            this.rightButton_.y = modalHeight - 50;
         }
      }
      
      private function percentLoop(param1:TimerEvent) : void {
         var _loc2_:Object = this.account.getCredentials();
         this.progressCheckClient.complete.addOnce(this.onUpdateStatusComplete);
         this.progressCheckClient.sendRequest("/migrate/progress",_loc2_);
      }
   }
}
