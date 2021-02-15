package com.company.assembleegameclient.account.ui {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.game.events.NameResultEvent;
   import kabam.rotmg.core.service.TrackingData;
   import kabam.rotmg.core.signals.TrackEventSignal;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.ui.signals.NameChangedSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ChooseNameFrameMediator extends Mediator {
       
      
      [Inject]
      public var view:ChooseNameFrame;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      [Inject]
      public var trackEvent:TrackEventSignal;
      
      [Inject]
      public var nameChanged:NameChangedSignal;
      
      private var gameSprite:AGameSprite;
      
      private var name:String;
      
      public function ChooseNameFrameMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.gameSprite = this.view.gameSprite;
         this.view.choose.add(this.onChoose);
         this.view.cancel.add(this.onCancel);
      }
      
      override public function destroy() : void {
         this.view.choose.remove(this.onChoose);
         this.view.cancel.remove(this.onCancel);
      }
      
      private function onChoose(param1:String) : void {
         this.name = param1;
         this.gameSprite.addEventListener("NAMERESULTEVENT",this.onNameResult);
         this.gameSprite.gsc_.chooseName(param1);
         this.view.disable();
      }
      
      private function handleSuccessfulNameChange() : void {
         if(this.view.isPurchase) {
            this.trackPurchase();
         }
         this.gameSprite.model.setName(this.name);
         this.gameSprite.map.player_.name_ = this.name;
         this.closeDialogs.dispatch();
         this.nameChanged.dispatch(this.name);
      }
      
      private function trackPurchase() : void {
         var _loc1_:TrackingData = new TrackingData();
         _loc1_.category = "credits";
         _loc1_.action = !!this.gameSprite.model.getConverted()?"buyConverted":"buy";
         _loc1_.label = "Name Change";
         _loc1_.value = 1000;
         this.trackEvent.dispatch(_loc1_);
      }
      
      private function handleFailedNameChange(param1:String) : void {
         this.view.setError(param1);
         this.view.enable();
      }
      
      private function onCancel() : void {
         this.closeDialogs.dispatch();
      }
      
      public function onNameResult(param1:NameResultEvent) : void {
         this.gameSprite.removeEventListener("NAMERESULTEVENT",this.onNameResult);
         var _loc2_:Boolean = param1.m_.success_;
         if(_loc2_) {
            this.handleSuccessfulNameChange();
         } else {
            this.handleFailedNameChange(param1.m_.errorText_);
         }
      }
   }
}
