package io.decagames.rotmg.social.model {
   public class GuildVO {
       
      
      private var _guildName:String;
      
      private var _guildId:String;
      
      private var _guildTotalFame:int;
      
      private var _guildCurrentFame:int;
      
      private var _guildHallType:String;
      
      private var _guildMembers:Vector.<GuildMemberVO>;
      
      private var _myRank:int;
      
      public function GuildVO() {
         super();
      }
      
      public function get guildName() : String {
         return this._guildName;
      }
      
      public function set guildName(param1:String) : void {
         this._guildName = param1;
      }
      
      public function get guildId() : String {
         return this._guildId;
      }
      
      public function set guildId(param1:String) : void {
         this._guildId = param1;
      }
      
      public function get guildTotalFame() : int {
         return this._guildTotalFame;
      }
      
      public function set guildTotalFame(param1:int) : void {
         this._guildTotalFame = param1;
      }
      
      public function get guildCurrentFame() : int {
         return this._guildCurrentFame;
      }
      
      public function set guildCurrentFame(param1:int) : void {
         this._guildCurrentFame = param1;
      }
      
      public function get guildHallType() : String {
         return this._guildHallType;
      }
      
      public function set guildHallType(param1:String) : void {
         this._guildHallType = param1;
      }
      
      public function get guildMembers() : Vector.<GuildMemberVO> {
         return this._guildMembers;
      }
      
      public function set guildMembers(param1:Vector.<GuildMemberVO>) : void {
         this._guildMembers = param1;
      }
      
      public function get myRank() : int {
         return this._myRank;
      }
      
      public function set myRank(param1:int) : void {
         this._myRank = param1;
      }
   }
}
