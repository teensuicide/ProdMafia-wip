package io.decagames.rotmg.seasonalEvent.data {
   public class LegacySeasonData {
       
      
      private var _seasonId:String;
      
      private var _title:String;
      
      private var _active:Boolean;
      
      private var _timeValid:Boolean;
      
      private var _hasLeaderBoard:Boolean;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      public function LegacySeasonData() {
         super();
      }
      
      public function get seasonId() : String {
         return this._seasonId;
      }
      
      public function set seasonId(param1:String) : void {
         this._seasonId = param1;
      }
      
      public function get title() : String {
         return this._title;
      }
      
      public function set title(param1:String) : void {
         this._title = param1;
      }
      
      public function get active() : Boolean {
         return this._active;
      }
      
      public function set active(param1:Boolean) : void {
         this._active = param1;
      }
      
      public function get timeValid() : Boolean {
         return this._timeValid;
      }
      
      public function set timeValid(param1:Boolean) : void {
         this._timeValid = param1;
      }
      
      public function get hasLeaderBoard() : Boolean {
         return this._hasLeaderBoard;
      }
      
      public function set hasLeaderBoard(param1:Boolean) : void {
         this._hasLeaderBoard = param1;
      }
      
      public function get startTime() : Date {
         return this._startTime;
      }
      
      public function set startTime(param1:Date) : void {
         this._startTime = param1;
      }
      
      public function get endTime() : Date {
         return this._endTime;
      }
      
      public function set endTime(param1:Date) : void {
         this._endTime = param1;
      }
   }
}
