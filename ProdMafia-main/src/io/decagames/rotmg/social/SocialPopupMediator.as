package io.decagames.rotmg.social {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.events.KeyboardEvent;
   import io.decagames.rotmg.social.model.FriendVO;
   import io.decagames.rotmg.social.model.GuildVO;
   import io.decagames.rotmg.social.model.SocialModel;
   import io.decagames.rotmg.social.popups.InviteFriendPopup;
   import io.decagames.rotmg.social.signals.RefreshListSignal;
   import io.decagames.rotmg.social.widgets.FriendListItem;
   import io.decagames.rotmg.social.widgets.GuildInfoItem;
   import io.decagames.rotmg.social.widgets.GuildListItem;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class SocialPopupMediator extends Mediator {
       
      
      [Inject]
      public var view:SocialPopupView;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var socialModel:SocialModel;
      
      [Inject]
      public var refreshSignal:RefreshListSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      private var _isFriendsListLoaded:Boolean;
      
      private var _isGuildListLoaded:Boolean;
      
      private var closeButton:SliceScalingButton;
      
      private var addFriendToolTip:TextToolTip;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public function SocialPopupMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.socialModel.socialDataSignal.add(this.onDataLoaded);
         this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
         this.refreshSignal.add(this.refreshListHandler);
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.view.addButton.clickSignal.add(this.addButtonHandler);
         this.createAddButtonTooltip();
         this.view.search.addEventListener("keyUp",this.onSearchHandler);
      }
      
      override public function destroy() : void {
         this.closeButton.dispose();
         this.refreshSignal.remove(this.refreshListHandler);
         this.view.addButton.clickSignal.remove(this.addButtonHandler);
         this.view.search.removeEventListener("keyUp",this.onSearchHandler);
         this.addFriendToolTip = null;
         this.hoverTooltipDelegate.removeDisplayObject();
         this.hoverTooltipDelegate = null;
      }
      
      private function onTabSelected(param1:String) : void {
         if(param1 == "Friends") {
            if(!this._isFriendsListLoaded) {
               this.socialModel.loadFriendsData();
            }
         } else if(param1 == "Guild") {
            if(!this._isGuildListLoaded) {
               this.socialModel.loadGuildData();
            }
         }
      }
      
      private function onDataLoaded(param1:String, param2:Boolean, param3:String) : void {
         var _loc4_:* = param1;
         var _loc5_:* = _loc4_;
         switch(_loc5_) {
            case "SocialDataSignal.FRIENDS_DATA_LOADED":
               this.view.clearFriendsList();
               if(param2) {
                  this.showFriends();
                  this._isFriendsListLoaded = true;
               } else {
                  this._isFriendsListLoaded = false;
                  this.showError(param1,param3);
               }
               return;
            case "SocialDataSignal.GUILD_DATA_LOADED":
               this.view.clearGuildList();
               this.showGuild();
               this._isGuildListLoaded = true;
               return;
            default:
               return;
         }
      }
      
      private function createAddButtonTooltip() : void {
         this.addFriendToolTip = new TextToolTip(3552822,10197915,"Add a friend","Click to add a friend",200);
         this.hoverTooltipDelegate = new HoverTooltipDelegate();
         this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
         this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
         this.hoverTooltipDelegate.setDisplayObject(this.view.addButton);
         this.hoverTooltipDelegate.tooltip = this.addFriendToolTip;
      }
      
      private function addButtonHandler(param1:BaseButton) : void {
         this.showPopupSignal.dispatch(new InviteFriendPopup());
      }
      
      private function refreshListHandler(param1:String, param2:Boolean) : void {
         if(param1 == "RefreshListSignal.CONTEXT_FRIENDS_LIST") {
            this.view.search.reset();
            this.view.clearFriendsList();
            this.showFriends();
         } else if(param1 == "RefreshListSignal.CONTEXT_GUILD_LIST") {
            this.view.clearGuildList();
            this.showGuild();
         }
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function showFriends(param1:String = "") : void {
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc5_:* = undefined;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = param1 != "";
         if(this.socialModel.hasInvitations) {
            _loc5_ = this.socialModel.getAllInvitations();
            this.view.addFriendCategory("Invitations (" + _loc5_.length + ")");
            _loc10_ = _loc5_.length > 3?3:_loc5_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc10_) {
               this.view.addInvites(new FriendListItem(_loc5_[_loc9_],3));
               _loc9_++;
            }
            this.view.showInviteIndicator(true,"Friends");
         } else {
            this.view.showInviteIndicator(false,"Friends");
         }
         _loc7_ = !_loc2_?this.socialModel.friendsList:this.socialModel.getFilterFriends(param1);
         this.view.addFriendCategory("Friends (" + this.socialModel.numberOfFriends + "/" + 100 + ")");
         var _loc6_:* = _loc7_;
         var _loc12_:int = 0;
         var _loc11_:* = _loc7_;
         for each(_loc4_ in _loc7_) {
            _loc8_ = !!_loc4_.isOnline?1:2;
            this.view.addFriend(new FriendListItem(_loc4_,_loc8_));
         }
         this.view.addFriendCategory("");
      }
      
      private function showError(param1:String, param2:String) : void {
         var _loc3_:* = param1;
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case "SocialDataSignal.FRIENDS_DATA_LOADED":
               this.view.addFriendCategory("Error: " + param2);
               return;
            case "SocialDataSignal.FRIEND_INVITATIONS_LOADED":
               this.view.addFriendCategory("Invitation Error: " + param2);
               return;
            default:
               return;
         }
      }
      
      private function showGuild() : void {
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc5_:GuildVO = this.socialModel.guildVO;
         var _loc1_:String = !_loc5_?"No Guild":_loc5_.guildName;
         var _loc3_:int = !_loc5_?0:_loc5_.guildTotalFame;
         this.view.addGuildInfo(new GuildInfoItem(_loc1_,_loc3_));
         if(_loc5_ && this.socialModel.numberOfGuildMembers > 0) {
            this.view.addGuildCategory("Guild Members (" + this.socialModel.numberOfGuildMembers + "/" + 50 + ")");
            _loc2_ = _loc5_.guildMembers;
            _loc4_ = _loc2_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc4_) {
               _loc7_ = _loc2_[_loc8_];
               _loc6_ = !!_loc7_.isOnline?1:2;
               this.view.addGuildMember(new GuildListItem(_loc7_,_loc6_,_loc5_.myRank));
               _loc8_++;
            }
            this.view.addGuildCategory("");
         } else {
            this.view.addGuildDefaultMessage("You have not yet joined a Guild,\njoin a Guild to find Players to play with or\n create your own Guild.");
         }
      }
      
      private function onSearchHandler(param1:KeyboardEvent) : void {
         this.view.clearFriendsList();
         this.showFriends(this.view.search.text);
      }
   }
}
