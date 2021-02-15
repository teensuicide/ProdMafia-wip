package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import flash.display.BitmapData;
   
   public class SeasonalLeaderBoardItemData {
       
      
      private var _accountId:String;
      
      private var _charId:int;
      
      private var _name:String;
      
      private var _isOwn:Boolean;
      
      private var _rank:int;
      
      private var _totalFame:int;
      
      private var _character:BitmapData;
      
      private var _equipmentSlots:Vector.<int>;
      
      private var _equipment:Vector.<int>;
      
      public function SeasonalLeaderBoardItemData() {
         super();
      }
      
      public function get accountId() : String {
         return this._accountId;
      }
      
      public function set accountId(param1:String) : void {
         this._accountId = param1;
      }
      
      public function get charId() : int {
         return this._charId;
      }
      
      public function set charId(param1:int) : void {
         this._charId = param1;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function set name(param1:String) : void {
         this._name = param1;
      }
      
      public function get isOwn() : Boolean {
         return this._isOwn;
      }
      
      public function set isOwn(param1:Boolean) : void {
         this._isOwn = param1;
      }
      
      public function get rank() : int {
         return this._rank;
      }
      
      public function set rank(param1:int) : void {
         this._rank = param1;
      }
      
      public function get totalFame() : int {
         return this._totalFame;
      }
      
      public function set totalFame(param1:int) : void {
         this._totalFame = param1;
      }
      
      public function get character() : BitmapData {
         return this._character;
      }
      
      public function set character(param1:BitmapData) : void {
         this._character = param1;
      }
      
      public function get equipmentSlots() : Vector.<int> {
         return this._equipmentSlots;
      }
      
      public function set equipmentSlots(param1:Vector.<int>) : void {
         this._equipmentSlots = param1;
      }
      
      public function get equipment() : Vector.<int> {
         return this._equipment;
      }
      
      public function set equipment(param1:Vector.<int>) : void {
         this._equipment = param1;
      }
   }
}
