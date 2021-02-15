package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
   import com.company.assembleegameclient.ui.StatusBar;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class StatMetersView extends Sprite {
       
      
      public var expBar_:StatusBar;
      
      public var fameBar_:StatusBar;
      
      public var hpBar_:StatusBar;
      
      public var clientHpBar_:StatusBar;
      
      public var mpBar_:StatusBar;
      
      private var areTempXpListenersAdded:Boolean;
      
      private var curXPBoost:int;
      
      private var expTimer:ExperienceBoostTimerPopup;
      
      private var lastLevel:int;
      
      public function StatMetersView() {
         super();
         init();
      }
      
      public function init() : void {
         lastLevel = -2;
         this.expBar_ = new StatusBar(176,15,5931045,5526612,"ExpBar.level",false,null,false,true);
         this.fameBar_ = new StatusBar(176,15,14835456,5526612,"Currency.fame",false,null,false,true);
         this.hpBar_ = new StatusBar(176,15,14693428,5526612,"StatusBar.HealthPoints");
         this.clientHpBar_ = new StatusBar(176,15,14693428,5526612,"CH");
         this.mpBar_ = new StatusBar(176,15,6325472,5526612,"StatusBar.ManaPoints");
         this.hpBar_.y = 16;
         this.clientHpBar_.y = 32;
         this.mpBar_.y = 48;
         this.fameBar_.visible = false;
         addChild(this.expBar_);
         addChild(this.fameBar_);
         addChild(this.hpBar_);
         addChild(this.clientHpBar_);
         addChild(this.mpBar_);
      }
      
      public function dispose() : void {
         while(this.numChildren > 0) {
            this.removeChildAt(0);
         }
      }
      
      public function update(param1:Player) : void {
         if(param1.level_ != this.lastLevel) {
            this.expBar_.setLabelText("ExpBar.level",{"level":param1.level_});
            this.lastLevel = param1.level_;
         }
         if(param1.level_ != 20) {
            if(this.expTimer) {
               this.expTimer.update(param1.xpTimer);
            }
            if(!this.expBar_.visible) {
               this.expBar_.visible = true;
               this.fameBar_.visible = false;
            }
            this.expBar_.draw(param1.exp_,param1.nextLevelExp_,0);
            if(this.curXPBoost != param1.xpBoost_) {
               this.curXPBoost = param1.xpBoost_;
               if(this.curXPBoost) {
                  this.expBar_.showMultiplierText();
               } else {
                  this.expBar_.hideMultiplierText();
               }
            }
            if(param1.xpTimer) {
               if(!this.areTempXpListenersAdded) {
                  this.expBar_.addEventListener("MULTIPLIER_OVER",this.onExpBarOver);
                  this.expBar_.addEventListener("MULTIPLIER_OUT",this.onExpBarOut);
                  this.areTempXpListenersAdded = true;
               }
            } else {
               if(this.areTempXpListenersAdded) {
                  this.expBar_.removeEventListener("MULTIPLIER_OVER",this.onExpBarOver);
                  this.expBar_.removeEventListener("MULTIPLIER_OUT",this.onExpBarOut);
                  this.areTempXpListenersAdded = false;
               }
               if(this.expTimer && this.expTimer.parent) {
                  removeChild(this.expTimer);
                  this.expTimer = null;
               }
            }
         } else {
            if(!this.fameBar_.visible) {
               this.fameBar_.visible = true;
               this.expBar_.visible = false;
            }
            this.fameBar_.draw(param1.currFame_,param1.nextClassQuestFame_,0);
         }
         this.clientHpBar_.draw(param1.clientHp,param1.maxHP_,param1.maxHPBoost_,param1.maxHPMax_,param1.level_,param1.exaltedHealth);
         this.hpBar_.draw(param1.hp_,param1.maxHP_,param1.maxHPBoost_,param1.maxHPMax_,param1.level_,param1.exaltedHealth);
         this.mpBar_.draw(param1.mp_,param1.maxMP_,param1.maxMPBoost_,param1.maxMPMax_,param1.level_,param1.exaltedMana);
      }
      
      private function onExpBarOver(param1:Event) : void {
         var _loc2_:* = new ExperienceBoostTimerPopup();
         this.expTimer = _loc2_;
         addChild(_loc2_);
      }
      
      private function onExpBarOut(param1:Event) : void {
         if(this.expTimer && this.expTimer.parent) {
            removeChild(this.expTimer);
            this.expTimer = null;
         }
      }
   }
}
