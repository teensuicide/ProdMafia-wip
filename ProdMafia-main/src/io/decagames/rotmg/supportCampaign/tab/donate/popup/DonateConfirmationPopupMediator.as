package io.decagames.rotmg.supportCampaign.tab.donate.popup {
   import com.company.assembleegameclient.objects.Player;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class DonateConfirmationPopupMediator extends Mediator {
       
      
      [Inject]
      public var view:DonateConfirmationPopup;
      
      [Inject]
      public var showFade:ShowLockFade;
      
      [Inject]
      public var removeFade:RemoveLockFade;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var model:SupporterCampaignModel;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      private var closeButton:SliceScalingButton;
      
      public function DonateConfirmationPopupMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.donateButton.clickSignal.add(this.donateClick);
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
      }
      
      override public function destroy() : void {
         this.view.donateButton.clickSignal.remove(this.donateClick);
         this.closeButton.clickSignal.remove(this.onClose);
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function donateClick(param1:BaseButton) : void {
         this.showFade.dispatch();
         var _loc2_:Object = this.account.getCredentials();
         _loc2_.amount = this.view.gold;
         this.client.sendRequest("/supportCampaign/donate",_loc2_);
         this.client.complete.addOnce(this.onDonateComplete);
      }
      
      private function onDonateComplete(param1:Boolean, param2:*) : void {
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = param1;
         var _loc4_:* = param2;
         this.removeFade.dispatch();
         this.closePopupSignal.dispatch(this.view);
         if(_loc6_) {
            try {
               _loc7_ = new XML(_loc4_);
               if(_loc7_.hasOwnProperty("Gold")) {
                  this.updateUserGold(_loc7_.Gold);
               }
               this.model.parseUpdateData(_loc7_);
               return;
            }
            catch(e:Error) {
               showPopupSignal.dispatch(new ErrorModal(300,"Campaign Error","General campaign error."));
               return;
            }
            return;
         }
         try {
            _loc3_ = new XML(_loc4_);
            _loc5_ = LineBuilder.getLocalizedStringFromKey(_loc3_.toString(),{});
            this.showPopupSignal.dispatch(new ErrorModal(300,"Campaign Error",_loc5_ == ""?_loc3_.toString():_loc5_));
            return;
         }
         catch(e:Error) {
            showPopupSignal.dispatch(new ErrorModal(300,"Campaign Error","General campaign error."));
            return;
         }
      }
      
      private function updateUserGold(param1:int) : void {
         var _loc2_:Player = this.gameModel.player;
         if(_loc2_ != null) {
            _loc2_.setCredits(param1);
         } else {
            this.playerModel.setCredits(param1);
         }
      }
   }
}
