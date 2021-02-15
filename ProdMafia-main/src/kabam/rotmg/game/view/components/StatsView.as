package kabam.rotmg.game.view.components {
   import com.company.assembleegameclient.objects.Player;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import kabam.rotmg.game.model.StatModel;
   import org.osflash.signals.natives.NativeSignal;
   
   public class StatsView extends Sprite {
      
      private static const statsModel:Array = [new StatModel("StatModel.attack.short","StatModel.attack.long","StatModel.attack.description",true),new StatModel("StatModel.defense.short","StatModel.defense.long","StatModel.defense.description",false),new StatModel("StatModel.speed.short","StatModel.speed.long","StatModel.speed.description",true),new StatModel("StatModel.dexterity.short","StatModel.dexterity.long","StatModel.dexterity.description",true),new StatModel("StatModel.vitality.short","StatModel.vitality.long","StatModel.vitality.description",true),new StatModel("StatModel.wisdom.short","StatModel.wisdom.long","StatModel.wisdom.description",true)];
      
      private static const statsModelLength:uint = statsModel.length;
      
      public static const ATTACK:int = 0;
      
      public static const DEFENSE:int = 1;
      
      public static const SPEED:int = 2;
      
      public static const DEXTERITY:int = 3;
      
      public static const VITALITY:int = 4;
      
      public static const WISDOM:int = 5;
      
      public static const LIFE:int = 6;
      
      public static const MANA:int = 7;
      
      public static const STATE_UNDOCKED:String = "state_undocked";
      
      public static const STATE_DOCKED:String = "state_docked";
      
      public static const STATE_DEFAULT:String = "state_docked";
       
      
      private const DEFAULT_FILTER:GlowFilter = new GlowFilter(0,1,10,10,1,3);
      
      private const WIDTH:int = 188;
      
      private const HEIGHT:int = 45;
      
      public var myPlayer:Boolean = true;
      
      public var altPlayer:Player;
      
      public var stats_:Vector.<StatView>;
      
      public var containerSprite:Sprite;
      
      public var mouseDown:NativeSignal;
      
      public var currentState:String = "state_docked";
      
      private var background:Sprite;
      
      public function StatsView() {
         this.background = this.createBackground();
         this.stats_ = new Vector.<StatView>();
         this.containerSprite = new Sprite();
         super();
         addChild(this.background);
         addChild(this.containerSprite);
         this.createStats();
         mouseChildren = false;
         this.mouseDown = new NativeSignal(this,"mouseDown",MouseEvent);
      }
      
      public function draw(param1:Player, param2:Boolean = true) : void {
         if(param1) {
            this.setBackgroundVisibility();
            this.drawStats(param1);
         }
         if(param2) {
            this.containerSprite.x = (188 - this.containerSprite.width) / 2;
         }
      }
      
      public function dock() : void {
         this.currentState = "state_docked";
      }
      
      public function undock() : void {
         this.currentState = "state_undocked";
      }
      
      private function createStats() : void {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < statsModelLength) {
            _loc1_ = this.createStat(_loc3_,_loc2_);
            this.stats_.push(_loc1_);
            this.containerSprite.addChild(_loc1_);
            _loc2_ = _loc2_ + _loc3_ % 2;
            _loc3_++;
         }
      }
      
      private function createStat(param1:int, param2:int) : StatView {
         var _loc3_:* = null;
         var _loc4_:StatModel = statsModel[param1];
         _loc3_ = new StatView(_loc4_.name,_loc4_.abbreviation,_loc4_.description,_loc4_.redOnZero);
         _loc3_.x = param1 % 2 * 188 * 0.5;
         _loc3_.y = param2 * 15;
         return _loc3_;
      }
      
      private function drawStats(param1:Player) : void {
         this.stats_[0].draw(param1.attack_,param1.attackBoost_,param1.attackMax_,param1.exaltedAttack,param1.level_);
         this.stats_[1].draw(param1.defense_,param1.defenseBoost_,param1.defenseMax_,param1.exaltedDefense,param1.level_);
         this.stats_[2].draw(param1.speed_,param1.speedBoost_,param1.speedMax_,param1.exaltedSpeed,param1.level_);
         this.stats_[3].draw(param1.dexterity_,param1.dexterityBoost_,param1.dexterityMax_,param1.exaltedDexterity,param1.level_);
         this.stats_[4].draw(param1.vitality_,param1.vitalityBoost_,param1.vitalityMax_,param1.exaltedVitality,param1.level_);
         this.stats_[5].draw(param1.wisdom,param1.wisdomBoost_,param1.wisdomMax_,param1.exaltedWisdom,param1.level_);
      }
      
      private function createBackground() : Sprite {
         this.background = new Sprite();
         this.background.graphics.clear();
         this.background.graphics.beginFill(3552822);
         this.background.graphics.lineStyle(2,16777215);
         this.background.graphics.drawRoundRect(-5,-5,198,58,10);
         this.background.filters = [DEFAULT_FILTER];
         return this.background;
      }
      
      private function setBackgroundVisibility() : void {
         if(this.currentState == "state_undocked") {
            this.background.alpha = 1;
         } else if(this.currentState == "state_docked") {
            this.background.alpha = 0;
         }
      }
   }
}
