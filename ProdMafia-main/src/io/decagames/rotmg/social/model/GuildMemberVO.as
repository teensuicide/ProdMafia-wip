package io.decagames.rotmg.social.model {
   import com.company.assembleegameclient.objects.Player;
   
   public class GuildMemberVO {
       
      
      private var _name:String;
      
      private var _rank:int;
      
      private var _fame:int;
      
      private var _player:Player;
      
      private var _serverName:String;
      
      private var _serverAddress:String;
      
      private var _isOnline:Boolean;
      
      private var _isMe:Boolean;
      
      private var _lastLogin:Number;
      
      public function GuildMemberVO() {
         super();
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function set name(param1:String) : void {
         this._name = param1;
      }
      
      public function get rank() : int {
         return this._rank;
      }
      
      public function set rank(param1:int) : void {
         this._rank = param1;
      }
      
      public function get fame() : int {
         return this._fame;
      }
      
      public function set fame(param1:int) : void {
         this._fame = param1;
      }
      
      public function get player() : Player {
         return this._player;
      }
      
      public function set player(param1:Player) : void {
         this._player = param1;
      }
      
      public function get serverName() : String {
         return this._serverName;
      }
      
      public function set serverName(param1:String) : void {
         this._serverName = param1;
      }
      
      public function get serverAddress() : String {
         return this._serverAddress;
      }
      
      public function set serverAddress(param1:String) : void {
         this._serverAddress = param1;
      }
      
      public function get isOnline() : Boolean {
         return this._isOnline;
      }
      
      public function set isOnline(param1:Boolean) : void {
         this._isOnline = param1;
      }
      
      public function get isMe() : Boolean {
         return this._isMe;
      }
      
      public function set isMe(param1:Boolean) : void {
         this._isMe = param1;
      }
      
      public function get lastLogin() : Number {
         return this._lastLogin;
      }
      
      public function set lastLogin(param1:Number) : void {
         this._lastLogin = param1;
      }
   }
}
