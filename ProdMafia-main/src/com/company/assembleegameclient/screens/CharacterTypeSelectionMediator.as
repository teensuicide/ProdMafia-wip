package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.tasks.GetOwnedPetSkinsTask;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventInfoPopup;
   import io.decagames.rotmg.seasonalEvent.signals.ShowSeasonHasEndedPopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.services.GetCharListTask;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.CharListLoadedSignal;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   import kabam.rotmg.news.model.NewsModel;
   import kabam.rotmg.news.services.GetInGameNewsTask;
   import kabam.rotmg.ui.view.TitleView;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CharacterTypeSelectionMediator extends Mediator {
       
      
      [Inject]
      public var view:CharacterTypeSelectionScreen;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var petsModel:PetsModel;
      
      [Inject]
      public var newsModel:NewsModel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var charListLoadedSignal:CharListLoadedSignal;
      
      [Inject]
      public var getCharListTask:GetCharListTask;
      
      [Inject]
      public var getOwnedPetSkinsTask:GetOwnedPetSkinsTask;
      
      [Inject]
      public var getInGameNewsTask:GetInGameNewsTask;
      
      [Inject]
      public var showSeasonHasEndedPopupSignal:ShowSeasonHasEndedPopupSignal;
      
      private var seasonalEventErrorPopUp:SeasonalEventErrorPopup;
      
      private var seasonEndedPopUp:SeasonalEventErrorPopup;
      
      public function CharacterTypeSelectionMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.charListLoadedSignal.add(this.onListComplete);
         this.showSeasonHasEndedPopupSignal.add(this.onSeasonEnded);
         this.view.setName(this.playerModel.getName());
         this.view.leagueDatas = this.seasonalEventModel.leagueDatas;
         this.view.leagueItemSignal.add(this.onLeagueChosen);
         this.view.close.add(this.onClose);
         this.view.infoButton.addEventListener("click",this.onInfoClicked);
      }
      
      override public function destroy() : void {
         this.view.close.remove(this.onClose);
         this.view.leagueItemSignal.remove(this.onLeagueChosen);
      }
      
      private function onSeasonEnded() : void {
         this.showSeasonEndedPopUp("Season has ended!");
      }
      
      private function showInfo() : void {
         this.showPopupSignal.dispatch(new SeasonalEventInfoPopup(this.seasonalEventModel.rulesAndDescription));
      }
      
      private function resetCharacterSkins() : void {
         var _loc1_:ClassesModel = StaticInjectorContext.getInjector().getInstance(ClassesModel);
         _loc1_.resetCharacterSkinsSelection();
      }
      
      private function onLeagueChosen(param1:int) : void {
         this.resetCharacterSkins();
         if(param1 == 0) {
            this.seasonalEventModel.isChallenger = 0;
            this.runTasks();
         } else if(param1 == 1) {
            if(this.isAccountCreationDateValid()) {
               this.seasonalEventModel.isChallenger = 1;
               this.runTasks();
            } else {
               this.showSeasonalErrorPopUp("Your account must be created before: " + this.seasonalEventModel.accountCreatedBefore.toString() + " to play a Seasonal Event!");
            }
         }
      }
      
      private function runTasks() : void {
         this.getCharListTask.start();
         this.petsModel.clearPets();
         this.getOwnedPetSkinsTask.start();
         this.newsModel.clearNews();
         this.getInGameNewsTask.start();
      }
      
      private function isAccountCreationDateValid() : Boolean {
         var _loc1_:Boolean = false;
         if(this.seasonalEventModel.accountCreatedBefore.getTime() - this.account.creationDate.getTime() > 0) {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function onListComplete() : void {
         this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
      }
      
      private function onClose() : void {
         this.setScreen.dispatch(new TitleView());
      }
      
      private function showSeasonalErrorPopUp(param1:String) : void {
         this.seasonalEventErrorPopUp = new SeasonalEventErrorPopup(param1);
         this.seasonalEventErrorPopUp.okButton.addEventListener("click",this.onSeasonalErrorPopUpClose);
         this.showPopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
      
      private function showSeasonEndedPopUp(param1:String) : void {
         this.seasonEndedPopUp = new SeasonalEventErrorPopup(param1);
         this.seasonEndedPopUp.okButton.addEventListener("click",this.onSeasonEndedPopUpClose);
         this.showPopupSignal.dispatch(this.seasonEndedPopUp);
      }
      
      private function onInfoClicked(param1:MouseEvent) : void {
         this.showInfo();
      }
      
      private function onSeasonalErrorPopUpClose(param1:MouseEvent) : void {
         this.seasonalEventModel.isChallenger = 0;
         this.seasonalEventErrorPopUp.okButton.removeEventListener("click",this.onSeasonalErrorPopUpClose);
         this.closePopupSignal.dispatch(this.seasonalEventErrorPopUp);
         this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
      }
      
      private function onSeasonEndedPopUpClose(param1:MouseEvent) : void {
         this.view.leagueItemSignal.remove(this.onLeagueChosen);
         this.seasonalEventModel.isSeasonalMode = false;
         this.onLeagueChosen(0);
         this.seasonEndedPopUp.okButton.removeEventListener("click",this.onSeasonalErrorPopUpClose);
         this.closePopupSignal.dispatch(this.seasonEndedPopUp);
      }
   }
}
