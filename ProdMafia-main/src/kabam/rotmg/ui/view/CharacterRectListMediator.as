package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.screens.NewCharacterScreen;
   import com.company.assembleegameclient.screens.charrects.CharacterRectList;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   import kabam.rotmg.ui.signals.BuyCharacterSlotSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CharacterRectListMediator extends Mediator {
       
      
      [Inject]
      public var view:CharacterRectList;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var buyCharacterSlotSignal:BuyCharacterSlotSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      private var seasonalEventErrorPopUp:SeasonalEventErrorPopup;
      
      public function CharacterRectListMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.newCharacter.add(this.onNewCharacter);
         this.view.buyCharacterSlot.add(this.onBuyCharacterSlot);
      }
      
      override public function destroy() : void {
         this.view.newCharacter.remove(this.onNewCharacter);
         this.view.buyCharacterSlot.remove(this.onBuyCharacterSlot);
      }
      
      private function onNewCharacter() : void {
            this.setScreenWithValidData.dispatch(new NewCharacterScreen());
         }
      
      private function showSeasonalErrorPopUp(param1:String) : void {
         this.seasonalEventErrorPopUp = new SeasonalEventErrorPopup(param1);
         this.seasonalEventErrorPopUp.okButton.addEventListener("click",this.onSeasonalErrorPopUpClose);
         this.showPopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
      
      private function onBuyCharacterSlot(param1:int) : void {
         this.buyCharacterSlotSignal.dispatch(param1);
      }
      
      private function onSeasonalErrorPopUpClose(param1:MouseEvent) : void {
         this.seasonalEventErrorPopUp.okButton.removeEventListener("click",this.onSeasonalErrorPopUpClose);
         this.closePopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
   }
}
