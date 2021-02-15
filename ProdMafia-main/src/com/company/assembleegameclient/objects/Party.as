package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.PointUtil;
   import flash.utils.Dictionary;
   import kabam.rotmg.messaging.impl.incoming.AccountList;
   
   public class Party {
      
      public static const NUM_MEMBERS:int = 6;
      
      private static const SORT_ON_FIELDS:Array = ["starred_","distSqFromThisPlayer_","objectId_"];
      
      private static const SORT_ON_PARAMS:Array = [18,16,16];
      
      private static const PARTY_DISTANCE_SQ:int = 2500;
       
      
      public var map_:Map;
      
      public var members_:Array;
      
      private var starred_:Dictionary;
      
      private var ignored_:Dictionary;
      
      private var lastUpdate_:int = -2147483648;
      
      public function Party(param1:Map) {
         members_ = [];
         starred_ = new Dictionary(true);
         ignored_ = new Dictionary(true);
         super();
         this.map_ = param1;
      }

      public function update(_arg_1:int, _arg_2:int):void {
         var _local5:Player = null;
         if (_arg_1 < this.lastUpdate_ + (Parameters.lowCPUMode ? 2500 : Number(500))) {
            return;
         }
         this.lastUpdate_ = _arg_1;
         this.members_.length = 0;
         var _local3:Player = this.map_.player_;
         if (_local3 == null) {
            return;
         }
         for each(var _local4:GameObject in this.map_.goDict_) {
            if (_local4 is Player && _local4 != _local3) {
               _local5 = _local4 as Player;
               _local5.starred_ = this.starred_[_local5.accountId_] != undefined;
               _local5.ignored_ = this.ignored_[_local5.accountId_] != undefined;
               _local5.distSqFromThisPlayer_ = PointUtil.distanceSquaredXY(_local3.x_, _local3.y_, _local5.x_, _local5.y_);
               if (_local5.distSqFromThisPlayer_ < 2500 || _local5.starred_) {
                  this.members_.push(_local5);
               }
            }
         }
         this.members_.sortOn(SORT_ON_FIELDS, SORT_ON_PARAMS);
         if (this.members_.length > 6) {
            this.members_.length = 6;
         }
      }
      
      public function lockPlayer(param1:Player) : void {
         var _loc2_:int = 0;
         this.starred_[param1.accountId_] = 1;
         this.lastUpdate_ = -2147483648;
         this.map_.gs_.gsc_.editAccountList(0,true,param1.objectId_);
         _loc2_ = this.map_.gs_.model.lockList.indexOf(param1.accountId_);
         if(_loc2_ == -1) {
            this.map_.gs_.model.lockList.push(param1.accountId_);
         }
      }
      
      public function unlockPlayer(param1:Player) : void {
         var _loc2_:int = 0;
         delete this.starred_[param1.accountId_];
         param1.starred_ = false;
         this.lastUpdate_ = -2147483648;
         this.map_.gs_.gsc_.editAccountList(0,false,param1.objectId_);
         _loc2_ = this.map_.gs_.model.lockList.indexOf(param1.accountId_);
         if(_loc2_ != -1) {
            this.map_.gs_.model.lockList.removeAt(_loc2_);
         }
      }
      
      public function setStars(param1:AccountList) : void {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:uint = param1.accountIds_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_) {
            _loc3_ = param1.accountIds_[_loc4_];
            this.starred_[_loc3_] = 1;
            this.lastUpdate_ = -2147483648;
            _loc4_++;
         }
      }
      
      public function removeStars(param1:AccountList) : void {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:uint = param1.accountIds_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_) {
            _loc3_ = param1.accountIds_[_loc4_];
            delete this.starred_[_loc3_];
            this.lastUpdate_ = -2147483648;
            _loc4_++;
         }
      }
      
      public function ignorePlayer(param1:Player) : void {
         var _loc2_:int = 0;
         this.ignored_[param1.accountId_] = 1;
         this.lastUpdate_ = -2147483648;
         this.map_.gs_.gsc_.editAccountList(1,true,param1.objectId_);
         _loc2_ = this.map_.gs_.model.ignoreList.indexOf(param1.accountId_);
         if(_loc2_ == -1) {
            this.map_.gs_.model.ignoreList.push(param1.accountId_);
         }
      }
      
      public function unignorePlayer(param1:Player) : void {
         var _loc2_:int = 0;
         delete this.ignored_[param1.accountId_];
         param1.ignored_ = false;
         this.lastUpdate_ = -2147483648;
         this.map_.gs_.gsc_.editAccountList(1,false,param1.objectId_);
         _loc2_ = this.map_.gs_.model.ignoreList.indexOf(param1.accountId_);
         if(_loc2_ != -1) {
            this.map_.gs_.model.ignoreList.removeAt(_loc2_);
         }
      }
      
      public function setIgnores(param1:AccountList) : void {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         this.ignored_ = new Dictionary(true);
         var _loc2_:uint = param1.accountIds_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_) {
            _loc3_ = param1.accountIds_[_loc4_];
            this.ignored_[_loc3_] = 1;
            this.lastUpdate_ = -2147483648;
            _loc4_++;
         }
      }
      
      public function setExaltLists() : void {
         var _loc3_:* = null;
         this.starred_ = new Dictionary(true);
         this.ignored_ = new Dictionary(true);
         for each(_loc3_ in this.map_.gs_.model.lockList) {
            this.starred_[_loc3_] = 1;
         }
         for each(_loc3_ in this.map_.gs_.model.ignoreList) {
            this.ignored_[_loc3_] = 1;
         }
         this.lastUpdate_ = -2147483648;
      }
   }
}
