package com.company.assembleegameclient.screens {
   public class LeagueData {
       
      
      private var _leagueType:int;
      
      private var _title:String;
      
      private var _endDate:Date;
      
      private var _description:String;
      
      private var _quote:String;
      
      private var _characterId:String;
      
      private var _panelBackgroundId:String;
      
      private var _maxCharacters:int;
      
      public function LeagueData() {
         super();
      }
      
      public function get leagueType() : int {
         return this._leagueType;
      }
      
      public function set leagueType(param1:int) : void {
         this._leagueType = param1;
      }
      
      public function get title() : String {
         return this._title;
      }
      
      public function set title(param1:String) : void {
         this._title = param1;
      }
      
      public function get endDate() : Date {
         return this._endDate;
      }
      
      public function set endDate(param1:Date) : void {
         this._endDate = param1;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function set description(param1:String) : void {
         this._description = param1;
      }
      
      public function get quote() : String {
         return this._quote;
      }
      
      public function set quote(param1:String) : void {
         this._quote = param1;
      }
      
      public function get characterId() : String {
         return this._characterId;
      }
      
      public function set characterId(param1:String) : void {
         this._characterId = param1;
      }
      
      public function get panelBackgroundId() : String {
         return this._panelBackgroundId;
      }
      
      public function set panelBackgroundId(param1:String) : void {
         this._panelBackgroundId = param1;
      }
      
      public function get maxCharacters() : int {
         return this._maxCharacters;
      }
      
      public function set maxCharacters(param1:int) : void {
         this._maxCharacters = param1;
      }
   }
}
