package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.GameObjectListItem;
   import com.company.assembleegameclient.ui.GuildText;
   import com.company.assembleegameclient.ui.RankText;
   import com.company.assembleegameclient.ui.StatusBar;
   import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
   import flash.events.Event;

import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.game.view.components.StatsView;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   
   public class PlayerToolTip extends ToolTip {
       
      
      public var player_:Player;
      
      private var playerPanel_:GameObjectListItem;
      
      private var rankText_:RankText;
      
      private var guildText_:GuildText;
      
      private var fameBar_:StatusBar;
      
      private var expBar_:StatusBar;
      
      private var hpBar_:StatusBar;
      
      private var mpBar_:StatusBar;

      private var clickMessage_:TextFieldDisplayConcrete;
      
      private var eGrid:EquippedGrid;

      private var inv1:InventoryGrid;

      public function PlayerToolTip(param1:Player) {
         var _loc2_:int = 0;
         super(3552822,0.5,16777215,1);
         this.player_ = param1;
         this.playerPanel_ = new GameObjectListItem(11776947,true,this.player_);
         addChild(this.playerPanel_);
         _loc2_ = 34;
         this.rankText_ = new RankText(this.player_.numStars_,false,true);
         this.rankText_.x = 6;
         this.rankText_.y = _loc2_;
         addChild(this.rankText_);
         _loc2_ = _loc2_ + 30;
         if(param1.guildName_ != null && param1.guildName_ != "") {
            this.guildText_ = new GuildText(this.player_.guildName_,this.player_.guildRank_,136);
            this.guildText_.x = 6;
            this.guildText_.y = _loc2_ - 2;
            addChild(this.guildText_);
            _loc2_ = _loc2_ + 30;
         }
         if(this.player_.level_ != 20) {
            this.expBar_ = new StatusBar(176,16,5931045,5526612,"ExpBar.level");
            this.expBar_.x = 6;
            this.expBar_.y = _loc2_;
            addChild(this.expBar_);
         } else {
            this.fameBar_ = new StatusBar(176,16,14835456,5526612,"Currency.fame");
            this.fameBar_.x = 6;
            this.fameBar_.y = _loc2_;
            addChild(this.fameBar_);
         }
         _loc2_ = _loc2_ + 24;
         this.hpBar_ = new StatusBar(176,16,14693428,5526612,"StatusBar.HealthPoints");
         this.hpBar_.x = 6;
         this.hpBar_.y = _loc2_;
         addChild(this.hpBar_);
         _loc2_ = _loc2_ + 24;
         this.mpBar_ = new StatusBar(176,16,6325472,5526612,"StatusBar.ManaPoints");
         this.mpBar_.x = 6;
         this.mpBar_.y = _loc2_;
         addChild(this.mpBar_);
         _loc2_ = _loc2_ + 24;
         this.eGrid = new EquippedGrid(null,this.player_.slotTypes_,this.player_);
         this.eGrid.x = 8;
         this.eGrid.y = _loc2_;
         addChild(this.eGrid);
         if(Parameters.data.showInventoryTooltip) {
            _loc2_ = _loc2_ + this.eGrid.height + 5;
            this.inv1 = new InventoryGrid(this.player_,this.player_,4);
            this.inv1.x = 8;
            this.inv1.y = _loc2_ - 1;
            addChild(this.inv1);
         }
         addEventListener("removedFromStage",this.dispose,false,0,true);
      }
      
      override public function draw() : void {
         if(this.player_.level_ != 20) {
            if(this.expBar_) {
               this.expBar_.setLabelText("ExpBar.level",{"level":this.player_.level_});
               this.expBar_.draw(this.player_.exp_,this.player_.nextLevelExp_,0);
            }
         } else if(this.fameBar_) {
            this.fameBar_.draw(this.player_.currFame_,this.player_.nextClassQuestFame_,0);
         }
         this.hpBar_.draw(this.player_.hp_,this.player_.maxHP_,this.player_.maxHPBoost_,this.player_.maxHPMax_,this.player_.level_,this.player_.exaltedHealth);
         this.mpBar_.draw(this.player_.mp_,this.player_.maxMP_,this.player_.maxMPBoost_,this.player_.maxMPMax_,this.player_.level_,this.player_.exaltedMana);
         this.eGrid.setItems(this.player_.equipment_);
         this.rankText_.draw(this.player_.numStars_,this.player_.starsBg_);
         super.draw();
      }
      
      public function dispose(param1:Event) : void {
         removeEventListener("removedFromStage",dispose);
         player_ = null;
         playerPanel_ = null;
         rankText_ = null;
         guildText_ = null;
         fameBar_ = null;
         expBar_ = null;
         hpBar_ = null;
         mpBar_ = null;
         clickMessage_ = null;
         eGrid.dispose();
         inv1 = null;
         while(this.numChildren > 0) {
            removeChildAt(0);
         }
      }
   }
}
