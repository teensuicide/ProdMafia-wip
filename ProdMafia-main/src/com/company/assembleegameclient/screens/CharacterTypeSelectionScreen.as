package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.util.FilterUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import io.decagames.rotmg.ui.buttons.InfoButton;
   import kabam.rotmg.core.signals.LeagueItemSignal;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.view.ButtonFactory;
   import kabam.rotmg.ui.view.components.MenuOptionsBar;
   import kabam.rotmg.ui.view.components.ScreenBase;
   import org.osflash.signals.Signal;
   
   public class CharacterTypeSelectionScreen extends Sprite {
       
      
      private const DROP_SHADOW:DropShadowFilter = new DropShadowFilter(0,0,0,1,8,8);
      
      public var close:Signal;
      
      public var leagueItemSignal:LeagueItemSignal;
      
      private var nameText:TextFieldDisplayConcrete;
      
      private var backButton:TitleMenuOption;
      
      private var _leagueItems:Vector.<LeagueItem>;
      
      private var _leagueContainer:Sprite;
      
      private var _buttonFactory:ButtonFactory;
      
      private var _leagueDatas:Vector.<LeagueData>;
      
      private var _infoButton:InfoButton;
      
      public function CharacterTypeSelectionScreen() {
         leagueItemSignal = new LeagueItemSignal();
         super();
         this.init();
      }
      
      public function set leagueDatas(param1:Vector.<LeagueData>) : void {
         this._leagueDatas = param1;
         this.createLeagues();
         this.createInfoButton();
      }
      
      public function get infoButton() : InfoButton {
         return this._infoButton;
      }
      
      public function setName(param1:String) : void {
         this.nameText.setStringBuilder(new StaticStringBuilder(param1));
         this.nameText.x = (this.getReferenceRectangle().width - this.nameText.width) * 0.5;
      }
      
      function getReferenceRectangle() : Rectangle {
         var _loc1_:Rectangle = new Rectangle();
         if(stage) {
            _loc1_ = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
         }
         return _loc1_;
      }
      
      private function init() : void {
         this._buttonFactory = new ButtonFactory();
         addChild(new ScreenBase());
         addChild(new AccountScreen());
         this.createDisplayAssets();
      }
      
      private function createDisplayAssets() : void {
         this.createNameText();
         this.makeMenuOptionsBar();
         this._leagueContainer = new Sprite();
         addChild(this._leagueContainer);
      }
      
      private function makeMenuOptionsBar() : void {
         this.backButton = this._buttonFactory.getBackButton();
         this.close = this.backButton.clicked;
         var _loc1_:MenuOptionsBar = new MenuOptionsBar();
         _loc1_.addButton(this.backButton,"CENTER");
         addChild(_loc1_);
      }
      
      private function createNameText() : void {
         this.nameText = new TextFieldDisplayConcrete().setSize(22).setColor(11776947);
         this.nameText.setBold(true).setAutoSize("center");
         this.nameText.filters = [this.DROP_SHADOW];
         this.nameText.y = 24;
         this.nameText.x = (this.getReferenceRectangle().width - this.nameText.width) / 2;
         addChild(this.nameText);
      }
      
      private function createInfoButton() : void {
         this._infoButton = new InfoButton(10);
         this._infoButton.x = this._leagueContainer.width - this._infoButton.width - 18;
         this._infoButton.y = this._infoButton.height + 16;
         this._leagueContainer.addChild(this._infoButton);
      }
      
      private function createLeagues() : void {
         var _loc3_:* = null;
         var _loc1_:int = 0;
         if(!this._leagueItems) {
            this._leagueItems = new Vector.<LeagueItem>(0);
         } else {
            this._leagueItems.length = 0;
         }
         var _loc2_:int = this._leagueDatas.length;
         while(_loc1_ < _loc2_) {
            _loc3_ = new LeagueItem(this._leagueDatas[_loc1_]);
            _loc3_.x = _loc1_ * (_loc3_.width + 20);
            _loc3_.buttonMode = true;
            _loc3_.addEventListener("click",this.onLeagueItemClick);
            _loc3_.addEventListener("rollOver",this.onOver);
            _loc3_.addEventListener("rollOut",this.onOut);
            this._leagueItems.push(_loc3_);
            this._leagueContainer.addChild(_loc3_);
            _loc1_++;
         }
         this._leagueContainer.x = (this.width - this._leagueContainer.width) / 2;
         this._leagueContainer.y = (this.height - this._leagueContainer.height) / 2;
      }
      
      private function removeLeagueItemListeners() : void {
         var _loc1_:int = 0;
         var _loc2_:int = this._leagueItems.length;
         while(_loc1_ < _loc2_) {
            this._leagueItems[_loc1_].removeEventListener("click",this.onLeagueItemClick);
            this._leagueItems[_loc1_].removeEventListener("rollOut",this.onOut);
            this._leagueItems[_loc1_].removeEventListener("rollOver",this.onOver);
            _loc1_++;
         }
      }
      
      private function onOut(param1:MouseEvent) : void {
         var _loc2_:* = null;
         _loc2_ = param1.currentTarget as LeagueItem;
         if(_loc2_) {
            _loc2_.filters = [];
            _loc2_.characterDance(false);
         } else {
            param1.currentTarget.filters = [];
         }
      }
      
      private function onOver(param1:MouseEvent) : void {
         var _loc2_:LeagueItem = param1.currentTarget as LeagueItem;
         if(_loc2_) {
            _loc2_.characterDance(true);
         } else {
            param1.currentTarget.filters = FilterUtil.getLargeGlowFilter();
         }
      }
      
      private function onLeagueItemClick(param1:MouseEvent) : void {
         this.removeLeagueItemListeners();
         this.leagueItemSignal.dispatch((param1.currentTarget as LeagueItem).leagueType);
      }
   }
}
