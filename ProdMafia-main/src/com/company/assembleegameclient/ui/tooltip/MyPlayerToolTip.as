package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.appengine.CharacterStats;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.GameObjectListItem;
   import com.company.assembleegameclient.ui.LineBreakDesign;
   import com.company.assembleegameclient.ui.StatusBar;
   import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
   import com.company.assembleegameclient.util.FameUtil;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.game.view.components.StatsView;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class MyPlayerToolTip extends ToolTip {
       
      
      public var player_:Player;
      
      private var factory:CharacterFactory;
      
      private var classes:ClassesModel;
      
      private var playerPanel_:GameObjectListItem;
      
      private var hpBar_:StatusBar;
      
      private var mpBar_:StatusBar;
      
      private var lineBreak_:LineBreakDesign;
      
      private var bestLevel_:TextFieldDisplayConcrete;
      
      private var nextClassQuest_:TextFieldDisplayConcrete;
      
      private var eGrid:EquippedGrid;
      
      private var iGrid:InventoryGrid;
      
      private var bGrid:InventoryGrid;
      
      private var accountName:String;
      
      private var charXML:XML;
      
      private var charStats:CharacterStats;
      
      private var stats_:StatsView;
      
      public function MyPlayerToolTip(param1:String, param2:XML, param3:CharacterStats) {
         super(3552822,1,16777215,1);
         this.accountName = param1;
         this.charXML = param2;
         this.charStats = param3;
      }
      
      override protected function alignUI() : void {
         if(this.nextClassQuest_) {
            this.nextClassQuest_.x = 8;
            this.nextClassQuest_.y = this.bestLevel_.getBounds(this).bottom - 2;
         }
      }
      
      override public function draw() : void {
         this.hpBar_.draw(this.player_.hp_,this.player_.maxHP_,this.player_.maxHPBoost_,this.player_.maxHPMax_,this.player_.level_,this.player_.exaltedHealth);
         this.mpBar_.draw(this.player_.mp_,this.player_.maxMP_,this.player_.maxMPBoost_,this.player_.maxMPMax_,this.player_.level_,this.player_.exaltedMana);
         this.lineBreak_.setWidthColor(width - 10,1842204);
         super.draw();
      }
      
      public function createUI() : void {
         var _loc4_:* = NaN;
         this.factory = StaticInjectorContext.getInjector().getInstance(CharacterFactory);
         this.classes = StaticInjectorContext.getInjector().getInstance(ClassesModel);
         var _loc6_:int = this.charXML.ObjectType;
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[_loc6_];
         this.player_ = Player.fromPlayerXML(this.accountName,this.charXML);
         var _loc3_:CharacterClass = this.classes.getCharacterClass(this.player_.objectType_);
         var _loc2_:CharacterSkin = _loc3_.skins.getSkin(this.charXML.Texture);
         this.player_.animatedChar_ = this.factory.makeCharacter(_loc2_.template);
         this.playerPanel_ = new GameObjectListItem(11776947,true,this.player_);
         addChild(this.playerPanel_);
         _loc4_ = 36;
         this.hpBar_ = new StatusBar(176,16,14693428,5526612,"StatusBar.HealthPoints",true);
         this.hpBar_.x = 6;
         this.hpBar_.y = _loc4_;
         addChild(this.hpBar_);
         _loc4_ = Number(_loc4_ + 22);
         this.mpBar_ = new StatusBar(176,16,6325472,5526612,"StatusBar.ManaPoints",true);
         this.mpBar_.x = 6;
         this.mpBar_.y = _loc4_;
         addChild(this.mpBar_);
         _loc4_ = Number(_loc4_ + 22);
         this.stats_ = new StatsView();
         this.stats_.draw(this.player_,false);
         this.stats_.x = 6;
         this.stats_.y = _loc4_ - 3;
         addChild(this.stats_);
         _loc4_ = Number(_loc4_ + 44);
         this.eGrid = new EquippedGrid(null,this.player_.slotTypes_,this.player_);
         this.eGrid.x = 8;
         this.eGrid.y = _loc4_;
         addChild(this.eGrid);
         this.eGrid.setItems(this.player_.equipment_);
         _loc4_ = Number(_loc4_ + 44);
         this.iGrid = new InventoryGrid(null,this.player_,4);
         this.iGrid.x = 8;
         this.iGrid.y = _loc4_;
         addChild(this.iGrid);
         this.iGrid.setItems(this.player_.equipment_);
         _loc4_ = Number(_loc4_ + 88);
         if(this.player_.hasBackpack_) {
            this.bGrid = new InventoryGrid(null,this.player_,12);
            this.bGrid.x = 8;
            this.bGrid.y = _loc4_;
            addChild(this.bGrid);
            this.bGrid.setItems(this.player_.equipment_);
            _loc4_ = Number(_loc4_ + 88);
         }
         _loc4_ = Number(_loc4_ + 8);
         this.lineBreak_ = new LineBreakDesign(100,1842204);
         this.lineBreak_.x = 6;
         this.lineBreak_.y = _loc4_;
         addChild(this.lineBreak_);
         this.makeBestLevelText();
         this.bestLevel_.x = 8;
         this.bestLevel_.y = height - 2;
         var _loc5_:int = FameUtil.nextStarFame(this.charStats == null?0:this.charStats.bestFame(),0);
         if(_loc5_ > 0) {
            this.makeNextClassQuestText(_loc5_,_loc1_);
         }
      }
      
      public function makeNextClassQuestText(param1:int, param2:XML) : void {
         this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174);
         this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams("MyPlayerToolTip.NextClassQuest",{
            "nextStarFame":param1,
            "character":ClassToolTip.getDisplayId(param2)
         }));
         this.nextClassQuest_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nextClassQuest_);
         waiter.push(this.nextClassQuest_.textChanged);
      }
      
      public function makeBestLevelText() : void {
         this.bestLevel_ = new TextFieldDisplayConcrete().setSize(14).setColor(6206769);
         var _loc2_:int = this.charStats == null?0:this.charStats.numStars();
         var _loc1_:String = (this.charStats != null?this.charStats.bestLevel():0).toString();
         var _loc3_:String = (this.charStats != null?this.charStats.bestFame():0).toString();
         this.bestLevel_.setStringBuilder(new LineBuilder().setParams("bestLevel_.stats",{
            "numStars":_loc2_,
            "bestLevel":_loc1_,
            "fame":_loc3_
         }));
         this.bestLevel_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.bestLevel_);
         waiter.push(this.bestLevel_.textChanged);
      }
   }
}
