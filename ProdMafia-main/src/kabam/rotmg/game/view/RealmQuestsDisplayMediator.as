package kabam.rotmg.game.view {
   import kabam.rotmg.game.model.QuestModel;
   import kabam.rotmg.ui.signals.RealmHeroesSignal;
   import kabam.rotmg.ui.signals.RealmOryxSignal;
   import kabam.rotmg.ui.signals.RealmQuestLevelSignal;
   import kabam.rotmg.ui.signals.RealmServerNameSignal;
   import kabam.rotmg.ui.signals.ToggleRealmQuestsDisplaySignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class RealmQuestsDisplayMediator extends Mediator {
       
      
      [Inject]
      public var view:RealmQuestsDisplay;
      
      [Inject]
      public var realmHeroesSignal:RealmHeroesSignal;
      
      [Inject]
      public var realmQuestLevelSignal:RealmQuestLevelSignal;
      
      [Inject]
      public var realmOryxSignal:RealmOryxSignal;
      
      [Inject]
      public var toggleRealmQuestsDisplay:ToggleRealmQuestsDisplaySignal;
      
      [Inject]
      public var questModel:QuestModel;
      
      [Inject]
      public var realmServerNameSignal:RealmServerNameSignal;
      
      public function RealmQuestsDisplayMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.realmHeroesSignal.add(this.onRealmHeroes);
         this.realmQuestLevelSignal.add(this.onRealmQuestLevel);
         this.realmOryxSignal.add(this.onOryxKill);
         this.realmServerNameSignal.add(this.onServerName);
         this.toggleRealmQuestsDisplay.add(this.onToggleDisplay);
         this.initView();
      }
      
      private function onServerName(param1:String) : void {
         this.view.realmName = param1;
      }
      
      private function initView() : void {
         this.view.requirementsStates = this.questModel.requirementsStates;
         this.view.init();
         if(this.questModel.previousRealm == "Realm of the Mad God" && this.view.requirementsStates[1]) {
            this.view.remainingHeroes = 0;
         }
      }
      
      private function onToggleDisplay() : void {
         this.view.toggleOpenState();
      }
      
      private function onOryxKill() : void {
         this.view.setOryxCompleted();
         this.questModel.requirementsStates = this.view.requirementsStates;
         this.questModel.hasOryxBeenKilled = true;
      }
      
      private function onRealmQuestLevel(param1:int) : void {
         this.view.level = param1;
         this.questModel.requirementsStates = this.view.requirementsStates;
      }
      
      private function onRealmHeroes(param1:int) : void {
         if(!this.view.requirementsStates[1]) {
            this.questModel.remainingHeroes = param1;
            this.view.remainingHeroes = param1;
            this.questModel.requirementsStates = this.view.requirementsStates;
         }
      }
   }
}
