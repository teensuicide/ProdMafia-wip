package com.company.assembleegameclient.ui.guild {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.game.events.GuildResultEvent;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.rotmg.graphics.ScreenGraphic;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class GuildChronicleScreen extends Sprite {
       
      
      private var gs_:AGameSprite;
      
      private var container:Sprite;
      
      private var guildPlayerList_:GuildPlayerList;
      
      private var continueButton_:TitleMenuOption;
      
      public function GuildChronicleScreen(param1:AGameSprite) {
         super();
         this.gs_ = param1;
         graphics.clear();
         graphics.beginFill(2829099,0.8);
         graphics.drawRect(0,0,800,600);
         graphics.endFill();
         var _loc2_:* = new Sprite();
         this.container = _loc2_;
         addChild(_loc2_);
         this.addList();
         addChild(new ScreenGraphic());
         this.continueButton_ = new TitleMenuOption("Options.continueButton",36,false);
         this.continueButton_.setAutoSize("center");
         this.continueButton_.setVerticalAlign("middle");
         this.continueButton_.addEventListener("click",this.onContinueClick,false,0,true);
         addChild(this.continueButton_);
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      }
      
      private function addList() : void {
         if(this.guildPlayerList_ && this.guildPlayerList_.parent) {
            this.container.removeChild(this.guildPlayerList_);
         }
         var _loc1_:Player = this.gs_.map.player_;
         this.guildPlayerList_ = new GuildPlayerList(500,0,_loc1_ == null?"":_loc1_.name_,_loc1_.guildRank_);
         this.guildPlayerList_.addEventListener("SET_RANK",this.onSetRank,false,0,true);
         this.guildPlayerList_.addEventListener("REMOVE_MEMBER",this.onRemoveMember,false,0,true);
         this.container.addChild(this.guildPlayerList_);
      }
      
      private function removeList() : void {
         this.guildPlayerList_.removeEventListener("SET_RANK",this.onSetRank);
         this.guildPlayerList_.removeEventListener("REMOVE_MEMBER",this.onRemoveMember);
         this.container.removeChild(this.guildPlayerList_);
         this.guildPlayerList_ = null;
      }
      
      private function showError(param1:String) : void {
         var _loc2_:Dialog = new Dialog("GuildChronicle.left",param1,"GuildChronicle.right",null,"/guildError");
         _loc2_.addEventListener("dialogLeftButton",this.onErrorTextDone,false,0,true);
         stage.addChild(_loc2_);
      }
      
      private function close() : void {
         stage.focus = null;
         parent.removeChild(this);
      }
      
      private function onSetRank(param1:GuildPlayerListEvent) : void {
         this.removeList();
         this.gs_.addEventListener("GUILDRESULTEVENT",this.onSetRankResult,false,0,true);
         this.gs_.gsc_.changeGuildRank(param1.name_,param1.rank_);
      }
      
      private function onSetRankResult(param1:GuildResultEvent) : void {
         this.gs_.removeEventListener("GUILDRESULTEVENT",this.onSetRankResult);
         if(!param1.success_) {
            this.showError(param1.errorKey);
         } else {
            this.addList();
         }
      }
      
      private function onRemoveMember(param1:GuildPlayerListEvent) : void {
         this.removeList();
         this.gs_.addEventListener("GUILDRESULTEVENT",this.onRemoveResult,false,0,true);
         this.gs_.gsc_.guildRemove(param1.name_);
      }
      
      private function onRemoveResult(param1:GuildResultEvent) : void {
         this.gs_.removeEventListener("GUILDRESULTEVENT",this.onRemoveResult);
         if(!param1.success_) {
            this.showError(param1.errorKey);
         } else {
            this.addList();
         }
      }
      
      private function onErrorTextDone(param1:Event) : void {
         var _loc2_:Dialog = param1.currentTarget as Dialog;
         stage.removeChild(_loc2_);
         this.addList();
      }
      
      private function onContinueClick(param1:MouseEvent) : void {
         this.close();
      }
      
      private function onAddedToStage(param1:Event) : void {
         this.continueButton_.x = 400 - this.continueButton_.width;
         this.continueButton_.y = 550;
         stage.addEventListener("keyDown",this.onKeyDown,false,1);
         stage.addEventListener("keyUp",this.onKeyUp,false,1);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown,false);
         stage.removeEventListener("keyUp",this.onKeyUp,false);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         param1.stopImmediatePropagation();
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void {
         param1.stopImmediatePropagation();
      }
   }
}
