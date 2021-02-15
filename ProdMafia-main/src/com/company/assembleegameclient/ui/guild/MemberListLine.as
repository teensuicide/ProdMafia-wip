package com.company.assembleegameclient.ui.guild {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.assembleegameclient.util.GuildUtil;
   import com.company.rotmg.graphics.DeleteXGraphic;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   class MemberListLine extends Sprite {
      
      public static const WIDTH:int = 756;
      
      public static const HEIGHT:int = 32;
      
      protected static const mouseOverCT:ColorTransform = new ColorTransform(1,0.862745098039216,0.52156862745098);
       
      
      private var name_:String;
      
      private var rank_:int;
      
      private var placeText_:TextFieldDisplayConcrete;
      
      private var nameText_:TextFieldDisplayConcrete;
      
      private var guildFameText_:TextFieldDisplayConcrete;
      
      private var guildFameIcon_:Bitmap;
      
      private var rankIcon_:Bitmap;
      
      private var rankText_:TextFieldDisplayConcrete;
      
      private var promoteButton_:Sprite;
      
      private var demoteButton_:Sprite;
      
      private var removeButton_:Sprite;
      
      function MemberListLine(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:int) {
         var _loc7_:int = 0;
         super();
         this.name_ = param2;
         this.rank_ = param3;
         _loc7_ = 11776947;
         if(param5) {
            _loc7_ = 16564761;
         }
         this.placeText_ = new TextFieldDisplayConcrete().setSize(22).setColor(_loc7_);
         this.placeText_.setStringBuilder(new StaticStringBuilder(param1.toString() + "."));
         this.placeText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.placeText_.x = 60 - this.placeText_.width;
         this.placeText_.y = 4;
         addChild(this.placeText_);
         this.nameText_ = new TextFieldDisplayConcrete().setSize(22).setColor(_loc7_);
         this.nameText_.setStringBuilder(new StaticStringBuilder(param2));
         this.nameText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.nameText_.x = 100;
         this.nameText_.y = 4;
         addChild(this.nameText_);
         this.guildFameText_ = new TextFieldDisplayConcrete().setSize(22).setColor(_loc7_);
         this.guildFameText_.setAutoSize("right");
         this.guildFameText_.setStringBuilder(new StaticStringBuilder(param4.toString()));
         this.guildFameText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.guildFameText_.x = 408;
         this.guildFameText_.y = 4;
         addChild(this.guildFameText_);
         this.guildFameIcon_ = new Bitmap(GuildUtil.guildFameIcon(40));
         this.guildFameIcon_.x = 400;
         this.guildFameIcon_.y = 16 - this.guildFameIcon_.height / 2;
         addChild(this.guildFameIcon_);
         this.rankIcon_ = new Bitmap(GuildUtil.rankToIcon(param3,20));
         this.rankIcon_.x = 548;
         this.rankIcon_.y = 16 - this.rankIcon_.height / 2;
         addChild(this.rankIcon_);
         this.rankText_ = new TextFieldDisplayConcrete().setSize(22).setColor(_loc7_);
         this.rankText_.setStringBuilder(new LineBuilder().setParams(GuildUtil.rankToString(param3)));
         this.rankText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.rankText_.setVerticalAlign("middle");
         this.rankText_.x = 580;
         this.rankText_.y = 16;
         addChild(this.rankText_);
         if(GuildUtil.canPromote(param6,param3)) {
            this.promoteButton_ = this.createArrow(true);
            this.addHighlighting(this.promoteButton_);
            this.promoteButton_.addEventListener("click",this.onPromote,false,0,true);
            this.promoteButton_.x = 676;
            this.promoteButton_.y = 16;
            addChild(this.promoteButton_);
         }
         if(GuildUtil.canDemote(param6,param3)) {
            this.demoteButton_ = this.createArrow(false);
            this.addHighlighting(this.demoteButton_);
            this.demoteButton_.addEventListener("click",this.onDemote,false,0,true);
            this.demoteButton_.x = 706;
            this.demoteButton_.y = 16;
            addChild(this.demoteButton_);
         }
         if(GuildUtil.canRemove(param6,param3)) {
            this.removeButton_ = new DeleteXGraphic();
            this.addHighlighting(this.removeButton_);
            this.removeButton_.addEventListener("click",this.onRemove,false,0,true);
            this.removeButton_.x = 730;
            this.removeButton_.y = 16 - this.removeButton_.height / 2;
            addChild(this.removeButton_);
         }
      }
      
      private function createArrow(param1:Boolean) : Sprite {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Graphics = _loc2_.graphics;
         _loc3_.beginFill(16777215);
         _loc3_.moveTo(-8,-6);
         _loc3_.lineTo(8,-6);
         _loc3_.lineTo(0,6);
         _loc3_.lineTo(-8,-6);
         if(param1) {
            _loc2_.rotation = 180;
         }
         return _loc2_;
      }
      
      private function addHighlighting(param1:Sprite) : void {
         param1.addEventListener("mouseOver",this.onHighlightOver,false,0,true);
         param1.addEventListener("rollOut",this.onHighlightOut,false,0,true);
      }
      
      private function onHighlightOver(param1:MouseEvent) : void {
         var _loc2_:Sprite = param1.currentTarget as Sprite;
         _loc2_.transform.colorTransform = mouseOverCT;
      }
      
      private function onHighlightOut(param1:MouseEvent) : void {
         var _loc2_:Sprite = param1.currentTarget as Sprite;
         _loc2_.transform.colorTransform = MoreColorUtil.identity;
      }
      
      private function onPromote(param1:MouseEvent) : void {
         var _loc2_:String = GuildUtil.rankToString(GuildUtil.promotedRank(this.rank_));
         var _loc3_:Dialog = new Dialog("","","Guild.PromoteLeftButton","Guild.PromoteRightButton","/promote");
         _loc3_.setTextParams("Guild.PromoteText",{
            "name":this.name_,
            "rank":_loc2_
         });
         _loc3_.setTitleStringBuilder(new LineBuilder().setParams("Guild.PromoteTitle",{"name":this.name_}));
         _loc3_.addEventListener("dialogLeftButton",this.onCancelDialog,false,0,true);
         _loc3_.addEventListener("dialogRightButton",this.onVerifiedPromote,false,0,true);
         StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(_loc3_);
      }
      
      private function onVerifiedPromote(param1:Event) : void {
         dispatchEvent(new GuildPlayerListEvent("SET_RANK",this.name_,GuildUtil.promotedRank(this.rank_)));
         StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
      }
      
      private function onDemote(param1:MouseEvent) : void {
         var _loc2_:String = GuildUtil.rankToString(GuildUtil.demotedRank(this.rank_));
         var _loc3_:Dialog = new Dialog("","","Guild.DemoteLeft","Guild.DemoteRight","/demote");
         _loc3_.setTextParams("Guild.DemoteText",{
            "name":this.name_,
            "rank":_loc2_
         });
         _loc3_.setTitleStringBuilder(new LineBuilder().setParams("Guild.DemoteTitle",{"name":this.name_}));
         _loc3_.addEventListener("dialogLeftButton",this.onCancelDialog,false,0,true);
         _loc3_.addEventListener("dialogRightButton",this.onVerifiedDemote,false,0,true);
         StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(_loc3_);
      }
      
      private function onVerifiedDemote(param1:Event) : void {
         dispatchEvent(new GuildPlayerListEvent("SET_RANK",this.name_,GuildUtil.demotedRank(this.rank_)));
         StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
      }
      
      private function onRemove(param1:MouseEvent) : void {
         var _loc2_:Dialog = new Dialog("","","Guild.RemoveLeft","Guild.RemoveRight","/removeFromGuild");
         _loc2_.setTextParams("Guild.RemoveText",{"name":this.name_});
         _loc2_.setTitleStringBuilder(new LineBuilder().setParams("Guild.RemoveTitle",{"name":this.name_}));
         _loc2_.addEventListener("dialogLeftButton",this.onCancelDialog,false,0,true);
         _loc2_.addEventListener("dialogRightButton",this.onVerifiedRemove,false,0,true);
         StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(_loc2_);
      }
      
      private function onVerifiedRemove(param1:Event) : void {
         StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
         dispatchEvent(new GuildPlayerListEvent("REMOVE_MEMBER",this.name_));
      }
      
      private function onCancelDialog(param1:Event) : void {
         StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
      }
   }
}
