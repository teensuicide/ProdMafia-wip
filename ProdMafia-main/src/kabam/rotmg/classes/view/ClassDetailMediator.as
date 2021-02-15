package kabam.rotmg.classes.view {
   import com.company.assembleegameclient.util.FameUtil;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.rotmg.assets.model.Animation;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.control.FocusCharacterSkinSignal;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.model.PlayerModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ClassDetailMediator extends Mediator {
       
      
      private const skins:Object = {};
      
      private const nextSkinTimer:Timer = new Timer(250,1);
      
      [Inject]
      public var view:ClassDetailView;
      
      [Inject]
      public var classesModel:ClassesModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var focusSet:FocusCharacterSkinSignal;
      
      [Inject]
      public var factory:CharacterFactory;
      
      private var character:CharacterClass;
      
      private var nextSkin:CharacterSkin;
      
      public function ClassDetailMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.character = this.classesModel.getSelected();
         this.nextSkinTimer.addEventListener("timer",this.delayedFocusSet);
         this.focusSet.add(this.onFocusSet);
         this.setCharacterData();
         this.onFocusSet();
      }
      
      override public function destroy() : void {
         this.focusSet.remove(this.onFocusSet);
         this.nextSkinTimer.removeEventListener("timer",this.delayedFocusSet);
         this.view.setWalkingAnimation(null);
         this.disposeAnimations();
      }
      
      private function setCharacterData() : void {
         var _loc2_:int = this.playerModel.charList.bestFame(this.character.id);
         var _loc1_:int = FameUtil.numStars(_loc2_);
         this.view.setData(this.character.name,this.character.description,_loc1_,this.playerModel.charList.bestLevel(this.character.id),_loc2_);
         var _loc3_:int = FameUtil.nextStarFame(_loc2_,0);
         this.view.setNextGoal(this.character.name,_loc3_);
      }
      
      private function onFocusSet(param1:CharacterSkin = null) : void {
         param1 = param1 || this.character.skins.getSelectedSkin();
         this.nextSkin = param1;
         this.nextSkinTimer.start();
      }
      
      private function disposeAnimations() : void {
         var _loc3_:* = undefined;
         var _loc1_:* = null;
         var _loc2_:* = this.skins;
         var _loc6_:int = 0;
         var _loc5_:* = this.skins;
         for(_loc3_ in this.skins) {
            _loc1_ = this.skins[_loc3_];
            _loc1_.dispose();
            delete this.skins[_loc3_];
         }
      }
      
      private function delayedFocusSet(param1:TimerEvent) : void {
         var _loc3_:* = this.skins[this.nextSkin.id] || this.factory.makeWalkingIcon(this.nextSkin.template,!!this.nextSkin.is16x16?100:Number(200));
         this.skins[this.nextSkin.id] = _loc3_;
         var _loc2_:Animation = _loc3_;
         this.view.setWalkingAnimation(_loc2_);
      }
   }
}
