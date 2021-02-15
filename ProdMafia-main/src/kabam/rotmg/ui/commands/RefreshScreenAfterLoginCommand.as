package kabam.rotmg.ui.commands {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
   import flash.display.Sprite;
   import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
   import kabam.rotmg.core.model.ScreenModel;
   import kabam.rotmg.core.signals.InvalidateDataSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   
   public class RefreshScreenAfterLoginCommand {
       
      
      [Inject]
      public var screenModel:ScreenModel;
      
      [Inject]
      public var update:UpdateAccountInfoSignal;
      
      [Inject]
      public var invalidate:InvalidateDataSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      public function RefreshScreenAfterLoginCommand() {
         super();
      }
      
      public function execute() : void {
         this.update.dispatch();
         this.invalidate.dispatch();
         this.setScreenWithValidData.dispatch(this.getTargetScreen());
      }
      
      private function getTargetScreen() : Sprite {
         var _loc1_:Class = this.screenModel.getCurrentScreenType();
         if(_loc1_ == null || _loc1_ == GameSprite) {
            _loc1_ = CharacterSelectionAndNewsScreen;
         }
         return new _loc1_();
      }
   }
}
