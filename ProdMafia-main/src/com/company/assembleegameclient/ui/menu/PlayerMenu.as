package com.company.assembleegameclient.ui.menu {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.GameObjectListItem;
   import com.company.util.AssetLibrary;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.social.model.FriendRequestVO;
   import io.decagames.rotmg.social.signals.FriendActionSignal;
   import kabam.rotmg.chat.control.ShowChatInputSignal;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class PlayerMenu extends Menu {
       
      
      public var gs_:AGameSprite;
      
      public var playerName_:String;
      
      public var player_:Player;
      
      public var playerPanel_:GameObjectListItem;
      
      public var namePlate_:TextFieldDisplayConcrete;
      
      public function PlayerMenu() {
         super(3552822,16777215);
      }
      
      public function initDifferentServer(param1:AGameSprite, param2:String, param3:Boolean = false, param4:Boolean = false) : void {
         var _loc5_:* = null;
         this.gs_ = param1;
         this.playerName_ = param2;
         this.player_ = null;
         this.namePlate_ = new TextFieldDisplayConcrete().setSize(13).setColor(16572160).setHTML(true);
         this.namePlate_.setStringBuilder(new LineBuilder().setParams(this.playerName_));
         this.namePlate_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.namePlate_);
         this.yOffset = this.yOffset - 13;
         _loc5_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,"PlayerMenu.PM");
         _loc5_.addEventListener("click",this.onPrivateMessage,false,0,true);
         addOption(_loc5_);
         _loc5_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",8),16777215,"Friend.BlockRight");
         _loc5_.addEventListener("click",this.onIgnoreDifferentServer,false,0,true);
         addOption(_loc5_);
         _loc5_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",18),16777215,"Add Friend");
         _loc5_.addEventListener("click",this.onAddFriend,false,0,true);
         addOption(_loc5_);
      }
      
      public function init(param1:AGameSprite, param2:Player) : void {
         var _loc3_:* = null;
         this.gs_ = param1;
         this.playerName_ = !!param2.name_?param2.name_:param2.className;
         this.player_ = param2;
         this.playerPanel_ = new GameObjectListItem(11776947,true,this.player_,true);
         this.yOffset = this.yOffset + 7;
         addChild(this.playerPanel_);
         if(this.gs_.map.allowPlayerTeleport() && this.player_.isTeleportEligible(this.player_)) {
            _loc3_ = new TeleportMenuOption(this.gs_.map.player_);
            _loc3_.addEventListener("click",this.onTeleport,false,0,true);
            addOption(_loc3_);
         }
         if(this.gs_.map.player_.guildRank_ >= 20 && (param2.guildName_ == null || param2.guildName_.length == 0)) {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",10),16777215,"PlayerMenu.Invite");
            _loc3_.addEventListener("click",this.onInvite,false,0,true);
            addOption(_loc3_);
         }
         if(!this.player_.starred_) {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2",5),16777215,"PlayerMenu.Lock");
            _loc3_.addEventListener("click",this.onLock,false,0,true);
            addOption(_loc3_);
         } else {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2",6),16777215,"PlayerMenu.UnLock");
            _loc3_.addEventListener("click",this.onUnlock,false,0,true);
            addOption(_loc3_);
         }
         _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",7),16777215,"PlayerMenu.Trade");
         _loc3_.addEventListener("click",this.onTrade,false,0,true);
         addOption(_loc3_);
         _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,"PlayerMenu.PM");
         _loc3_.addEventListener("click",this.onPrivateMessage,false,0,true);
         addOption(_loc3_);
         if(this.player_.isFellowGuild_) {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,"PlayerMenu.GuildChat");
            _loc3_.addEventListener("click",this.onGuildMessage,false,0,true);
            addOption(_loc3_);
         }
         if(!this.player_.ignored_) {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",8),16777215,"PlayerMenu.Ignore");
            _loc3_.addEventListener("click",this.onIgnore,false,0,true);
            addOption(_loc3_);
         } else {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",9),16777215,"PlayerMenu.Unignore");
            _loc3_.addEventListener("click",this.onUnignore,false,0,true);
            addOption(_loc3_);
         }
         if(Parameters.data.extraPlayerMenu) {
            _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",5),16777215,"Anchor");
            _loc3_.addEventListener("click",this.onSetAnchor,false,0,true);
            addOption(_loc3_);
            if(Parameters.followName == this.playerName_.toUpperCase()) {
               _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",19),16711680,"Stop Follow");
            } else {
               _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",19),16777215,"Follow");
            }
            _loc3_.addEventListener("click",this.onSetFollow,false,0,true);
            addOption(_loc3_);
         }
         _loc3_ = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",18),16777215,"Add Friend");
         _loc3_.addEventListener("click",this.onAddFriend,false,0,true);
         addOption(_loc3_);
      }
      
      private function onIgnoreDifferentServer(param1:Event) : void {
         this.gs_.gsc_.playerText("/ignore " + this.playerName_);
         remove();
      }
      
      private function onSetAnchor(param1:Event) : void {
         Parameters.data.anchorName = this.player_.name_;
         remove();
      }
      
      private function onSetFollow(param1:Event) : void {
         if(Parameters.followName == this.player_.name_.toUpperCase()) {
            Parameters.followName = "";
            Parameters.followingName = false;
            Parameters.followPlayer = null;
         } else {
            Parameters.followName = this.player_.name_.toUpperCase();
            Parameters.followingName = true;
            Parameters.followPlayer = this.player_;
         }
         remove();
      }
      
      private function onPrivateMessage(param1:Event) : void {
         var _loc2_:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
         _loc2_.dispatch(true,"/tell " + this.playerName_ + " ");
         remove();
      }
      
      private function onAddFriend(param1:Event) : void {
         var _loc2_:FriendActionSignal = StaticInjectorContext.getInjector().getInstance(FriendActionSignal);
         _loc2_.dispatch(new FriendRequestVO("/requestFriend",this.playerName_));
         remove();
      }
      
      private function onGuildMessage(param1:Event) : void {
         var _loc2_:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
         _loc2_.dispatch(true,"/g ");
         remove();
      }
      
      private function onTeleport(param1:Event) : void {
         this.gs_.map.player_.teleportTo(this.player_);
         remove();
      }
      
      private function onInvite(param1:Event) : void {
         this.gs_.gsc_.guildInvite(this.playerName_);
         remove();
      }
      
      private function onLock(param1:Event) : void {
         this.gs_.map.party_.lockPlayer(this.player_);
         remove();
      }
      
      private function onUnlock(param1:Event) : void {
         this.gs_.map.party_.unlockPlayer(this.player_);
         remove();
      }
      
      private function onTrade(param1:Event) : void {
         this.gs_.gsc_.requestTrade(this.playerName_);
         remove();
      }
      
      private function onIgnore(param1:Event) : void {
         this.gs_.map.party_.ignorePlayer(this.player_);
         remove();
      }
      
      private function onUnignore(param1:Event) : void {
         this.gs_.map.party_.unignorePlayer(this.player_);
         remove();
      }
   }
}
