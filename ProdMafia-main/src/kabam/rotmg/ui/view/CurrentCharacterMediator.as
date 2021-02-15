package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.account.ui.NewChooseNameFrame;
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
   import com.company.assembleegameclient.screens.NewCharacterScreen;
   import com.company.assembleegameclient.screens.ServersScreen;
   import com.company.util.MoreDateUtil;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventComingPopup;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup;
   import io.decagames.rotmg.seasonalEvent.signals.ShowSeasonComingPopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
   import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.service.TrackingData;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   import kabam.rotmg.core.signals.TrackEventSignal;
   import kabam.rotmg.core.signals.TrackPageViewSignal;
   import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
   import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.game.signals.PlayGameSignal;
   import kabam.rotmg.packages.control.InitPackagesSignal;
   import kabam.rotmg.ui.signals.NameChangedSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CurrentCharacterMediator extends Mediator {
       
      
      private const DAY_IN_MILLISECONDS:int = 86400000;
      
      private const MINUTES_IN_MILLISECONDS:int = 60000;
      
      [Inject]
      public var view:CharacterSelectionAndNewsScreen;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var classesModel:ClassesModel;
      
      [Inject]
      public var track:TrackEventSignal;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var playGame:PlayGameSignal;
      
      [Inject]
      public var nameChanged:NameChangedSignal;
      
      [Inject]
      public var trackPage:TrackPageViewSignal;
      
      [Inject]
      public var initPackages:InitPackagesSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var securityQuestionsModel:SecurityQuestionsModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var addToQueueSignal:AddPopupToStartupQueueSignal;
      
      [Inject]
      public var flushQueueSignal:FlushPopupStartupQueueSignal;
      
      [Inject]
      public var showSeasonComingPopupSignal:ShowSeasonComingPopupSignal;
      
      private var seasonalEventErrorPopUp:SeasonalEventErrorPopup;
      
      public function CurrentCharacterMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         this.trackSomething();
         this.view.initialize(this.playerModel);
         this.view.close.add(this.onClose);
         this.view.newCharacter.add(this.onNewCharacter);
         this.view.showClasses.add(this.onNewCharacter);
         this.view.playGame.add(this.onPlayGame);
         this.view.serversClicked.add(this.showServersScreen);
         this.view.chooseName.add(this.onChooseName);
         this.trackPage.dispatch("/currentCharScreen");
         this.nameChanged.add(this.onNameChanged);
         this.initPackages.dispatch();
         if(this.securityQuestionsModel.showSecurityQuestionsOnStartup) {
            this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
         }
         if(this.seasonalEventModel.scheduledSeasonalEvent) {
            if(Parameters.data["challenger_info_popup"]) {
               _loc2_ = Parameters.data["challenger_info_popup"];
               _loc1_ = new Date().time;
               if(_loc1_ - (_loc2_ + 86400000) > 0) {
                  this.showSeasonsComingPopup();
                  Parameters.data["challenger_info_popup"] = _loc1_;
               }
            } else {
               this.showSeasonsComingPopup();
               Parameters.data["challenger_info_popup"] = new Date().time;
            }
         }
      }
      
      override public function destroy() : void {
         this.nameChanged.remove(this.onNameChanged);
         this.view.close.remove(this.onClose);
         this.view.newCharacter.remove(this.onNewCharacter);
         this.view.showClasses.remove(this.onNewCharacter);
         this.view.playGame.remove(this.onPlayGame);
         this.view.chooseName.remove(this.onChooseName);
      }
      
      private function onChooseName() : void {
         this.openDialog.dispatch(new NewChooseNameFrame());
      }
      
      private function onNameChanged(param1:String) : void {
         this.view.setName(param1);
      }
      
      private function showSeasonsComingPopup() : void {
         this.showPopupSignal.dispatch(new SeasonalEventComingPopup(this.seasonalEventModel.scheduledSeasonalEvent));
      }
      
      private function showServersScreen() : void {
         this.setScreen.dispatch(new ServersScreen);
      }
      
      private function trackSomething() : void {
         var _loc1_:* = null;
         var _loc2_:String = MoreDateUtil.getDayStringInPT();
         if(Parameters.data.lastDailyAnalytics != _loc2_) {
            _loc1_ = new TrackingData();
            _loc1_.category = "joinDate";
            _loc1_.action = Parameters.data.joinDate;
            this.track.dispatch(_loc1_);
            Parameters.data.lastDailyAnalytics = _loc2_;
            Parameters.save();
         }
      }
      
      private function onNewCharacter() : void {
            this.setScreen.dispatch(new NewCharacterScreen());
      }
      
      private function showSeasonalErrorPopUp(param1:String) : void {
         this.seasonalEventErrorPopUp = new SeasonalEventErrorPopup(param1);
         this.seasonalEventErrorPopUp.okButton.addEventListener("click",this.onSeasonalErrorPopUpClose);
         this.showPopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
      
      private function onClose() : void {
         this.playerModel.isInvalidated = true;
         this.playerModel.isLogOutLogIn = true;
         this.setScreenWithValidData.dispatch(new TitleView());
      }
      
      private function onPlayGame() : void {
         var _loc4_:SavedCharacter = this.playerModel.getCharacterByIndex(0);
         this.playerModel.currentCharId = _loc4_.charId();
         var _loc1_:CharacterClass = this.classesModel.getCharacterClass(_loc4_.objectType());
         _loc1_.setIsSelected(true);
         _loc1_.skins.getSkin(_loc4_.skinType()).setIsSelected(true);
         var _loc3_:TrackingData = new TrackingData();
         _loc3_.category = "character";
         _loc3_.action = "select";
         _loc3_.label = _loc4_.displayId();
         _loc3_.value = _loc4_.level();
         this.track.dispatch(_loc3_);
         var _loc2_:GameInitData = new GameInitData();
         _loc2_.createCharacter = false;
         _loc2_.charId = _loc4_.charId();
         _loc2_.isNewGame = true;
         this.playGame.dispatch(_loc2_);
      }
      
      private function onSeasonalErrorPopUpClose(param1:MouseEvent) : void {
         this.seasonalEventErrorPopUp.okButton.removeEventListener("click",this.onSeasonalErrorPopUpClose);
         this.closePopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
   }
}
