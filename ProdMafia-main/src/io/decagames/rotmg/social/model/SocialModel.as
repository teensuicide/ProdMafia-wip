package io.decagames.rotmg.social.model {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.utils.Dictionary;
   import io.decagames.rotmg.social.config.FriendsActions;
   import io.decagames.rotmg.social.config.GuildActions;
   import io.decagames.rotmg.social.signals.SocialDataSignal;
   import io.decagames.rotmg.social.tasks.FriendDataRequestTask;
   import io.decagames.rotmg.social.tasks.GuildDataRequestTask;
   import io.decagames.rotmg.social.tasks.ISocialTask;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   import kabam.rotmg.ui.model.HUDModel;
   import org.osflash.signals.Signal;
   
   public class SocialModel {
       
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var serverModel:ServerModel;
      
      [Inject]
      public var friendsDataRequest:FriendDataRequestTask;
      
      [Inject]
      public var guildDataRequest:GuildDataRequestTask;
      
      public var socialDataSignal:SocialDataSignal;
      
      public var noInvitationSignal:Signal;
      
      private var _onlineFriends:Vector.<FriendVO>;
      
      private var _offlineFriends:Vector.<FriendVO>;
      
      private var _onlineFilteredFriends:Vector.<FriendVO>;
      
      private var _offlineFilteredFriends:Vector.<FriendVO>;
      
      private var _onlineGuildMembers:Vector.<GuildMemberVO>;
      
      private var _offlineGuildMembers:Vector.<GuildMemberVO>;
      
      private var _guildMembers:Vector.<GuildMemberVO>;
      
      private var _friends:Dictionary;
      
      private var _invitations:Dictionary;
      
      private var _friendsLoadInProcess:Boolean;
      
      private var _invitationsLoadInProgress:Boolean;
      
      private var _guildLoadInProgress:Boolean;
      
      private var _numberOfInvitation:int;
      
      private var _isFriDataOK:Boolean;
      
      private var _serverDict:Dictionary;
      
      private var _currentServer:Server;
      
      private var _friendsList:Vector.<FriendVO>;
      
      private var _numberOfFriends:int;
      
      private var _numberOfGuildMembers:int;
      
      private var _guildVO:GuildVO;
      
      public function SocialModel() {
         socialDataSignal = new SocialDataSignal();
         noInvitationSignal = new Signal();
         super();
         this._initSocialModel();
      }
      
      public function get friendsList() : Vector.<FriendVO> {
         return this._friendsList;
      }
      
      public function get numberOfFriends() : int {
         return this._numberOfFriends;
      }
      
      public function get numberOfGuildMembers() : int {
         return this._numberOfGuildMembers;
      }
      
      public function get guildVO() : GuildVO {
         return this._guildVO;
      }
      
      public function get hasInvitations() : Boolean {
         return this._numberOfInvitation > 0;
      }
      
      public function setCurrentServer(param1:Server) : void {
         this._currentServer = param1;
      }
      
      public function getCurrentServerName() : String {
         return !this._currentServer?"":this._currentServer.name;
      }
      
      public function loadFriendsData() : void {
         if(this._friendsLoadInProcess || this._invitationsLoadInProgress) {
            return;
         }
         this._friendsLoadInProcess = true;
         this._invitationsLoadInProgress = true;
         this.loadList(this.friendsDataRequest,FriendsActions.getURL("/getList"),this.onFriendListResponse);
      }
      
      public function loadInvitations() : void {
         if(this._friendsLoadInProcess || this._invitationsLoadInProgress) {
            return;
         }
         this._invitationsLoadInProgress = true;
         this.loadList(this.friendsDataRequest,FriendsActions.getURL("/getRequests"),this.onInvitationListResponse);
      }
      
      public function loadGuildData() : void {
         if(this._guildLoadInProgress) {
            return;
         }
         this._guildLoadInProgress = true;
         this.loadList(this.guildDataRequest,GuildActions.getURL("/listMembers"),this.onGuildListResponse);
      }
      
      public function seedFriends(param1:XML) : void {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         this._onlineFriends.length = 0;
         this._offlineFriends.length = 0;
         var _loc5_:* = param1.Account;
         var _loc12_:int = 0;
         var _loc11_:* = param1.Account;
         for each(_loc8_ in param1.Account) {
            try {
               _loc2_ = _loc8_.Name;
               _loc4_ = this._friends[_loc2_] != null?this._friends[_loc2_].vo as FriendVO:new FriendVO(Player.fromPlayerXML(_loc2_,_loc8_.Character[0]));
               if(_loc8_.hasOwnProperty("Online")) {
                  _loc7_ = String(_loc8_.Online);
                  _loc6_ = this.serverNameDictionary()[_loc7_];
                  _loc4_.online(_loc6_,_loc7_);
                  this._onlineFriends.push(_loc4_);
                  this._friends[_loc4_.getName()] = {
                     "vo":_loc4_,
                     "list":this._onlineFriends
                  };
                  continue;
               }
               _loc4_.offline();
               _loc4_.lastLogin = this.getLastLoginInSeconds(_loc8_.LastLogin);
               this._offlineFriends.push(_loc4_);
               this._friends[_loc4_.getName()] = {
                  "vo":_loc4_,
                  "list":this._offlineFriends
               };
            }
            catch(error:Error) {
               trace(error.toString());
               continue;
            }
         }
         this._onlineFriends.sort(this.sortFriend);
         this._offlineFriends.sort(this.sortFriend);
         this.updateFriendsList();
      }
      
      public function isMyFriend(param1:String) : Boolean {
         return this._friends[param1] != null;
      }
      
      public function updateFriendVO(param1:String, param2:Player) : void {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(this.isMyFriend(param1)) {
            _loc4_ = this._friends[param1];
            _loc3_ = _loc4_.vo as FriendVO;
            _loc3_.updatePlayer(param2);
         }
      }
      
      public function getFilterFriends(param1:String) : Vector.<FriendVO> {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:RegExp = new RegExp(param1,"gix");
         this._onlineFilteredFriends.length = 0;
         this._offlineFilteredFriends.length = 0;
         while(_loc3_ < this._onlineFriends.length) {
            _loc4_ = this._onlineFriends[_loc3_];
            if(_loc4_.getName().search(_loc2_) >= 0) {
               this._onlineFilteredFriends.push(_loc4_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._offlineFriends.length) {
            _loc4_ = this._offlineFriends[_loc3_];
            if(_loc4_.getName().search(_loc2_) >= 0) {
               this._offlineFilteredFriends.push(_loc4_);
            }
            _loc3_++;
         }
         this._onlineFilteredFriends.sort(this.sortFriend);
         this._offlineFilteredFriends.sort(this.sortFriend);
         return this._onlineFilteredFriends.concat(this._offlineFilteredFriends);
      }
      
      public function ifReachMax() : Boolean {
         return this._numberOfFriends >= 100;
      }
      
      public function getAllInvitations() : Vector.<FriendVO> {
         var _loc1_:* = null;
         var _loc3_:Vector.<FriendVO> = new Vector.<FriendVO>();
         var _loc2_:* = this._invitations;
         var _loc6_:int = 0;
         var _loc5_:* = this._invitations;
         for each(_loc1_ in this._invitations) {
            _loc3_.push(_loc1_);
         }
         _loc3_.sort(this.sortFriend);
         return _loc3_;
      }
      
      public function removeFriend(param1:String) : Boolean {
         var _loc2_:Object = this._friends[param1];
         if(_loc2_) {
            this.removeFriendFromList(param1);
            this.removeFromList(_loc2_.list,param1);
            this._friends[param1] = null;
            delete this._friends[param1];
            return true;
         }
         return false;
      }
      
      public function removeInvitation(param1:String) : Boolean {
         if(this._invitations[param1] != null) {
            this._invitations[param1] = null;
            delete this._invitations[param1];
            this._numberOfInvitation--;
            if(this._numberOfInvitation == 0) {
               this.noInvitationSignal.dispatch();
            }
            return true;
         }
         return false;
      }
      
      public function removeGuildMember(param1:String) : void {
         var _loc2_:* = null;
         var _loc3_:* = this._onlineGuildMembers;
         var _loc8_:int = 0;
         var _loc7_:* = this._onlineGuildMembers;
         for each(_loc2_ in this._onlineGuildMembers) {
            if(_loc2_.name == param1) {
               this._onlineGuildMembers.splice(this._onlineGuildMembers.indexOf(_loc2_),1);
               break;
            }
         }
         var _loc4_:int = 0;
         var _loc6_:* = this._offlineGuildMembers;
         var _loc10_:int = 0;
         var _loc9_:* = this._offlineGuildMembers;
         for each(_loc2_ in this._offlineGuildMembers) {
            if(_loc2_.name == param1) {
               this._offlineGuildMembers.splice(this._offlineGuildMembers.indexOf(_loc2_),1);
               break;
            }
         }
         this.updateGuildData();
      }
      
      private function _initSocialModel() : void {
         this._numberOfFriends = 0;
         this._numberOfInvitation = 0;
         this._friends = new Dictionary(true);
         this._onlineFriends = new Vector.<FriendVO>(0);
         this._offlineFriends = new Vector.<FriendVO>(0);
         this._onlineFilteredFriends = new Vector.<FriendVO>(0);
         this._offlineFilteredFriends = new Vector.<FriendVO>(0);
         this._onlineGuildMembers = new Vector.<GuildMemberVO>(0);
         this._offlineGuildMembers = new Vector.<GuildMemberVO>(0);
         this._friendsLoadInProcess = false;
         this._invitationsLoadInProgress = false;
         this._guildLoadInProgress = false;
      }
      
      private function loadList(param1:ISocialTask, param2:String, param3:Function) : void {
         param1.requestURL = param2;
         (param1 as BaseTask).finished.addOnce(param3);
         (param1 as BaseTask).start();
      }
      
      private function onFriendListResponse(param1:FriendDataRequestTask, param2:Boolean, param3:String = "") : void {
         this._isFriDataOK = param2;
         if(this._isFriDataOK) {
            this.seedFriends(param1.xml);
            param1.reset();
            this._friendsLoadInProcess = false;
            this.loadList(this.friendsDataRequest,FriendsActions.getURL("/getRequests"),this.onInvitationListResponse);
         } else {
            this.socialDataSignal.dispatch("SocialDataSignal.FRIENDS_DATA_LOADED",this._isFriDataOK,param3);
         }
      }
      
      private function onInvitationListResponse(param1:FriendDataRequestTask, param2:Boolean, param3:String = "") : void {
         if(param2) {
            this.seedInvitations(param1.xml);
            this.socialDataSignal.dispatch("SocialDataSignal.FRIENDS_DATA_LOADED",this._isFriDataOK,param3);
         } else {
            this.socialDataSignal.dispatch("SocialDataSignal.FRIEND_INVITATIONS_LOADED",param2,param3);
         }
         param1.reset();
         this._invitationsLoadInProgress = false;
      }
      
      private function onGuildListResponse(param1:GuildDataRequestTask, param2:Boolean, param3:String = "") : void {
         if(param2) {
            this.seedGuild(param1.xml);
         } else {
            this.clearGuildData();
         }
         param1.reset();
         this._guildLoadInProgress = false;
         this.socialDataSignal.dispatch("SocialDataSignal.GUILD_DATA_LOADED",param2,param3);
      }
      
      private function seedInvitations(param1:XML) : void {
         var _loc2_:String = null;
         var _loc3_:Player = null;
         var _loc6_:XML = null;
         this._invitations = new Dictionary(true);
         this._numberOfInvitation = 0;
         var _loc5_:* = param1.Account;
         var _loc10_:int = 0;
         var _loc9_:* = param1.Account;
         for each(_loc6_ in param1.Account) {
            try {
               if(_loc6_.Character[0] && _loc6_.Character[0].ObjectType != 0) {
                  if(this.starFilter(_loc6_.Character[0].ObjectType,_loc6_.Character[0].CurrentFame,_loc6_.Stats[0])) {
                     _loc2_ = _loc6_.Name;
                     _loc3_ = Player.fromPlayerXML(_loc2_,_loc6_.Character[0]);
                     this._invitations[_loc2_] = new FriendVO(_loc3_);
                     this._numberOfInvitation++;
                  } else {
                     continue;
                  }
               } else {
                  continue;
               }
            }
            catch(error:Error) {
               trace(error.toString());
               continue;
            }
         }
      }
      
      private function seedGuild(param1:XML) : void {
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         this.clearGuildData();
         this._guildVO = new GuildVO();
         this._guildVO.guildName = param1.@name;
         this._guildVO.guildId = param1.@id;
         this._guildVO.guildTotalFame = param1.TotalFame;
         this._guildVO.guildCurrentFame = param1.CurrentFame.value;
         this._guildVO.guildHallType = param1.HallType;
         var _loc2_:XMLList = param1.child("Member");
         if(_loc2_.length() > 0) {
            _loc4_ = 0;
            _loc6_ = _loc2_;
            var _loc10_:int = 0;
            var _loc9_:* = _loc2_;
            for each(_loc5_ in _loc2_) {
               _loc7_ = new GuildMemberVO();
               _loc3_ = _loc5_.Name;
               if(_loc3_ == this.hudModel.getPlayerName()) {
                  _loc7_.isMe = true;
                  this._guildVO.myRank = _loc5_.Rank;
               }
               _loc7_.name = _loc3_;
               _loc7_.rank = _loc5_.Rank;
               _loc7_.fame = _loc5_.Fame;
               _loc7_.player = this.getPlayerObject(_loc3_,_loc5_);
               if(_loc5_.hasOwnProperty("Online")) {
                  _loc7_.isOnline = true;
                  _loc8_ = String(_loc5_.Online);
                  _loc7_.serverAddress = _loc8_;
                  _loc7_.serverName = this.serverNameDictionary()[_loc8_];
                  this._onlineGuildMembers.push(_loc7_);
               } else {
                  _loc7_.lastLogin = this.getLastLoginInSeconds(_loc5_.LastLogin);
                  this._offlineGuildMembers.push(_loc7_);
               }
            }
         }
         this.updateGuildData();
      }
      
      private function getPlayerObject(param1:String, param2:XML) : Player {
         var _loc3_:XML = param2.Character[0];
         if(_loc3_.ObjectType == 0) {
            _loc3_.ObjectType = "782";
         }
         return Player.fromPlayerXML(param1,_loc3_);
      }
      
      private function getLastLoginInSeconds(param1:String) : Number {
         var _loc2_:Date = new Date();
         return (_loc2_.getTime() - TimeUtil.parseUTCDate(param1).getTime()) / 1000;
      }
      
      private function updateGuildData() : void {
         this._onlineGuildMembers.sort(this.sortGuildMemberByRank);
         this._offlineGuildMembers.sort(this.sortGuildMemberByRank);
         this._onlineGuildMembers.sort(this.sortGuildMemberByAlphabet);
         this._offlineGuildMembers.sort(this.sortGuildMemberByAlphabet);
         this._guildMembers = this._onlineGuildMembers.concat(this._offlineGuildMembers);
         this._numberOfGuildMembers = this._guildMembers.length;
         this._guildVO.guildMembers = this._guildMembers;
      }
      
      private function clearGuildData() : void {
         this._onlineGuildMembers.length = 0;
         this._offlineGuildMembers.length = 0;
         this._guildVO = null;
      }
      
      private function removeFriendFromList(param1:String) : void {
         var _loc2_:* = null;
         var _loc3_:* = this._onlineFriends;
         var _loc8_:int = 0;
         var _loc7_:* = this._onlineFriends;
         for each(_loc2_ in this._onlineFriends) {
            if(_loc2_.getName() == param1) {
               this._onlineFriends.splice(this._onlineFriends.indexOf(_loc2_),1);
               break;
            }
         }
         var _loc4_:int = 0;
         var _loc6_:* = this._offlineFriends;
         var _loc10_:int = 0;
         var _loc9_:* = this._offlineFriends;
         for each(_loc2_ in this._offlineFriends) {
            if(_loc2_.getName() == param1) {
               this._offlineFriends.splice(this._offlineFriends.indexOf(_loc2_),1);
               break;
            }
         }
         this.updateFriendsList();
      }
      
      private function removeFromList(param1:Vector.<FriendVO>, param2:String) : void {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length) {
            _loc4_ = param1[_loc3_];
            if(_loc4_.getName() == param2) {
               param1.slice(_loc3_,1);
               return;
            }
            _loc3_++;
         }
      }
      
      private function sortFriend(param1:FriendVO, param2:FriendVO) : Number {
         if(param1.getName() < param2.getName()) {
            return -1;
         }
         if(param1.getName() > param2.getName()) {
            return 1;
         }
         return 0;
      }
      
      private function sortGuildMemberByRank(param1:GuildMemberVO, param2:GuildMemberVO) : Number {
         if(param1.rank > param2.rank) {
            return -1;
         }
         if(param1.rank < param2.rank) {
            return 1;
         }
         return 0;
      }
      
      private function sortGuildMemberByAlphabet(param1:GuildMemberVO, param2:GuildMemberVO) : Number {
         if(param1.rank == param2.rank) {
            if(param1.name < param2.name) {
               return -1;
            }
            if(param1.name > param2.name) {
               return 1;
            }
            return 0;
         }
         return 0;
      }
      
      private function serverNameDictionary() : Dictionary {
         var _loc1_:* = null;
         if(this._serverDict) {
            return this._serverDict;
         }
         var _loc3_:Vector.<Server> = this.serverModel.getServers();
         this._serverDict = new Dictionary(true);
         var _loc2_:* = _loc3_;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc1_ in _loc3_) {
            this._serverDict[_loc1_.address] = _loc1_.name;
         }
         return this._serverDict;
      }
      
      private function starFilter(param1:int, param2:int, param3:XML) : Boolean {
         return FameUtil.numAllTimeStars(param1,param2,param3) >= Parameters.data.friendStarRequirement;
      }
      
      private function updateFriendsList() : void {
         this._friendsList = this._onlineFriends.concat(this._offlineFriends);
         this._numberOfFriends = this._friendsList.length;
      }
   }
}
