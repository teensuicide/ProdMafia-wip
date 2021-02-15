package io.decagames.rotmg.social.model {
   import com.company.assembleegameclient.objects.Player;
   import flash.display.BitmapData;
   
   public class FriendVO {
       
      
      public var playerName:String;
      
      protected var _player:Player;
      
      protected var _serverName:String;
      
      protected var _serverAddr:String;
      
      protected var _isOnline:Boolean;
      
      private var _lastLogin:Number;
      
      public function FriendVO(param1:Player, param2:Boolean = false, param3:String = "", param4:String = "") {
         super();
         this._player = param1;
         this._isOnline = param2;
         this._serverName = param3;
         this._serverAddr = param4;
         this.playerName = this._player.getName();
      }
      
      public function get isOnline() : Boolean {
         return this._isOnline;
      }
      
      public function get lastLogin() : Number {
         return this._lastLogin;
      }
      
      public function set lastLogin(param1:Number) : void {
         this._lastLogin = param1;
      }
      
      public function updatePlayer(param1:Player) : void {
         this._player = param1;
         this.playerName = this._player.getName();
      }
      
      public function getServerName() : String {
         return this._serverName;
      }
      
      public function getName() : String {
         return this._player.getName();
      }
      
      public function getPortrait() : BitmapData {
         return this._player.getPortrait();
      }
      
      public function online(param1:String, param2:String) : void {
         this._isOnline = true;
         this._serverName = param1;
         this._serverAddr = param2;
      }
      
      public function offline() : void {
         this._isOnline = false;
         this._serverName = "";
         this._serverAddr = "";
      }
   }
}
