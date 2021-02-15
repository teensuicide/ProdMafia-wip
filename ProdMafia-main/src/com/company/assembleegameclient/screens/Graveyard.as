package com.company.assembleegameclient.screens {
   import flash.display.Sprite;
   import kabam.rotmg.core.model.PlayerModel;
   
   public class Graveyard extends Sprite {
       
      
      private var lines_:Vector.<GraveyardLine>;
      
      private var hasCharacters_:Boolean = false;
      
      public function Graveyard(param1:PlayerModel) {
         lines_ = new Vector.<GraveyardLine>();
         var _loc2_:* = null;
         super();
         var _loc3_:* = param1.getNews();
         var _loc6_:int = 0;
         var _loc5_:* = param1.getNews();
         for each(_loc2_ in param1.getNews()) {
            if(_loc2_.isCharDeath()) {
               this.addLine(new GraveyardLine(_loc2_.getIcon(),_loc2_.title_,_loc2_.tagline_,_loc2_.link_,_loc2_.date_,param1.getAccountId()));
               this.hasCharacters_ = true;
            }
         }
      }
      
      public function hasCharacters() : Boolean {
         return this.hasCharacters_;
      }
      
      public function addLine(param1:GraveyardLine) : void {
         param1.y = 4 + this.lines_.length * 56;
         this.lines_.push(param1);
         addChild(param1);
      }
   }
}
