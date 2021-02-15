package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.ui.GuildText;
   import com.company.assembleegameclient.ui.RankText;
   import com.company.assembleegameclient.ui.tooltip.RankToolTip;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kabam.rotmg.account.core.view.AccountInfoView;
   import org.osflash.signals.Signal;
   
   public class AccountScreen extends Sprite {
       
      
      public var tooltip:Signal;
      
      private var rankLayer:Sprite;
      
      private var guildLayer:Sprite;
      
      private var accountInfoLayer:Sprite;
      
      private var guildName:String;
      
      private var guildRank:int;
      
      private var stars:int;
      
      private var starBg:int;
      
      private var rankText:RankText;
      
      private var guildText:GuildText;
      
      private var accountInfo:AccountInfoView;
      
      public function AccountScreen() {
         super();
         this.tooltip = new Signal();
         this.makeLayers();
      }
      
      public function setGuild(param1:String, param2:int) : void {
         this.guildName = param1;
         this.guildRank = param2;
         this.makeGuildText();
      }
      
      public function setRank(param1:int, param2:int = 0) : void {
         this.stars = param1;
         this.starBg = param2;
         this.makeRankText();
      }
      
      public function setAccountInfo(param1:AccountInfoView) : void {
         this.accountInfo = param1;
         var _loc2_:DisplayObject = param1 as DisplayObject;
         _loc2_.x = stage.stageWidth - 10;
         _loc2_.y = 2;
         while(this.accountInfoLayer.numChildren > 0) {
            this.accountInfoLayer.removeChildAt(0);
         }
         this.accountInfoLayer.addChild(_loc2_);
      }
      
      private function makeLayers() : void {
         var _loc1_:* = new Sprite();
         this.rankLayer = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.guildLayer = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.accountInfoLayer = _loc1_;
         addChild(_loc1_);
      }
      
      private function makeGuildText() : void {
         this.guildText = new GuildText(this.guildName,this.guildRank);
         this.guildText.x = 92;
         this.guildText.y = 6;
         while(this.guildLayer.numChildren > 0) {
            this.guildLayer.removeChildAt(0);
         }
         this.guildLayer.addChild(this.guildText);
      }
      
      private function makeRankText() : void {
         this.rankText = new RankText(this.stars,true,false,this.starBg);
         this.rankText.x = 36;
         this.rankText.y = 4;
         this.rankText.mouseEnabled = true;
         this.rankText.addEventListener("mouseOver",this.onMouseOver);
         this.rankText.addEventListener("rollOut",this.onRollOut);
         while(this.rankLayer.numChildren > 0) {
            this.rankLayer.removeChildAt(0);
         }
         this.rankLayer.addChild(this.rankText);
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         this.tooltip.dispatch(new RankToolTip(this.stars));
      }
      
      protected function onRollOut(param1:MouseEvent) : void {
         this.tooltip.dispatch(null);
      }
   }
}
