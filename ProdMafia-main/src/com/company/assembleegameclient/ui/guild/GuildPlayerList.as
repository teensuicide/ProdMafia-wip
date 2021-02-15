package com.company.assembleegameclient.ui.guild {
   import com.company.assembleegameclient.ui.Scrollbar;
   import com.company.assembleegameclient.util.GuildUtil;
   import com.company.ui.BaseSimpleText;
   import com.company.util.MoreObjectUtil;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class GuildPlayerList extends Sprite {
       
      
      private var num_:int;
      
      private var offset_:int;
      
      private var myName_:String;
      
      private var myRank_:int;
      
      private var listClient_:AppEngineClient;
      
      private var loadingText_:TextFieldDisplayConcrete;
      
      private var titleText_:BaseSimpleText;
      
      private var guildFameText_:BaseSimpleText;
      
      private var guildFameIcon_:Bitmap;
      
      private var lines_:Shape;
      
      private var mainSprite_:Sprite;
      
      private var listSprite_:Sprite;
      
      private var openSlotsText_:TextFieldDisplayConcrete;
      
      private var scrollBar_:Scrollbar;
      
      public function GuildPlayerList(param1:int, param2:int, param3:String = "", param4:int = 0) {
         super();
         this.num_ = param1;
         this.offset_ = param2;
         this.myName_ = param3;
         this.myRank_ = param4;
         this.loadingText_ = new TextFieldDisplayConcrete().setSize(22).setColor(11776947);
         this.loadingText_.setBold(true);
         this.loadingText_.setStringBuilder(new LineBuilder().setParams("Loading.text"));
         this.loadingText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.loadingText_.setAutoSize("center").setVerticalAlign("middle");
         this.loadingText_.x = 400;
         this.loadingText_.y = 550;
         addChild(this.loadingText_);
         var _loc6_:Account = StaticInjectorContext.getInjector().getInstance(Account);
         var _loc5_:Object = {
            "num":param1,
            "offset":param2
         };
         MoreObjectUtil.addToObject(_loc5_,_loc6_.getCredentials());
         this.listClient_ = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
         this.listClient_.setMaxRetries(2);
         this.listClient_.complete.addOnce(this.onComplete);
         this.listClient_.sendRequest("/guild/listMembers",_loc5_);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onGenericData(param2);
         } else {
            this.onTextError(param2);
         }
      }
      
      private function onGenericData(param1:String) : void {
         this.build(XML(param1));
      }
      
      private function onTextError(param1:String) : void {
      }
      
      private function build(param1:XML) : void {
         var _loc11_:int = 0;
         var _loc10_:* = false;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         removeChild(this.loadingText_);
         this.titleText_ = new BaseSimpleText(32,11776947,false,0,0);
         this.titleText_.setBold(true);
         this.titleText_.text = param1.@name;
         this.titleText_.useTextDimensions();
         this.titleText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.titleText_.y = 24;
         this.titleText_.x = 400 - this.titleText_.width * 0.5;
         addChild(this.titleText_);
         this.guildFameText_ = new BaseSimpleText(22,16777215,false,0,0);
         this.guildFameText_.text = param1.CurrentFame;
         this.guildFameText_.useTextDimensions();
         this.guildFameText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.guildFameText_.x = 768 - this.guildFameText_.width;
         this.guildFameText_.y = 16 - this.guildFameText_.height * 0.5;
         addChild(this.guildFameText_);
         this.guildFameIcon_ = new Bitmap(GuildUtil.guildFameIcon(40));
         this.guildFameIcon_.x = 760;
         this.guildFameIcon_.y = 16 - this.guildFameIcon_.height * 0.5;
         addChild(this.guildFameIcon_);
         this.lines_ = new Shape();
         _loc2_ = this.lines_.graphics;
         _loc2_.clear();
         _loc2_.lineStyle(2,5526612);
         _loc2_.moveTo(0,100);
         _loc2_.lineTo(stage.stageWidth,100);
         _loc2_.lineStyle();
         addChild(this.lines_);
         this.mainSprite_ = new Sprite();
         this.mainSprite_.x = 10;
         this.mainSprite_.y = 110;
         var _loc8_:Shape = new Shape();
         _loc2_ = _loc8_.graphics;
         _loc2_.beginFill(0);
         _loc2_.drawRect(0,0,756,430);
         _loc2_.endFill();
         this.mainSprite_.addChild(_loc8_);
         this.mainSprite_.mask = _loc8_;
         addChild(this.mainSprite_);
         this.listSprite_ = new Sprite();
         var _loc3_:* = param1.Member;
         var _loc13_:int = 0;
         var _loc12_:* = param1.Member;
         for each(_loc4_ in param1.Member) {
            _loc10_ = this.myName_ == _loc4_.Name;
            _loc7_ = _loc4_.Rank;
            _loc6_ = new MemberListLine(this.offset_ + _loc9_ + 1,_loc4_.Name,_loc4_.Rank,_loc4_.Fame,_loc10_,this.myRank_);
            _loc6_.y = _loc9_ * 32;
            this.listSprite_.addChild(_loc6_);
            _loc9_++;
         }
         _loc11_ = 50 - (this.offset_ + _loc9_);
         this.openSlotsText_ = new TextFieldDisplayConcrete().setSize(22).setColor(11776947);
         this.openSlotsText_.setStringBuilder(new LineBuilder().setParams("GuildPlayerList.openSlots",{"openSlots":_loc11_}));
         this.openSlotsText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.openSlotsText_.setAutoSize("center");
         this.openSlotsText_.x = 378;
         this.openSlotsText_.y = _loc9_ * 32;
         this.listSprite_.addChild(this.openSlotsText_);
         this.mainSprite_.addChild(this.listSprite_);
         if(this.listSprite_.height > 400) {
            this.scrollBar_ = new Scrollbar(16,400);
            this.scrollBar_.x = 800 - this.scrollBar_.width - 4;
            this.scrollBar_.y = 104;
            this.scrollBar_.setIndicatorSize(400,this.listSprite_.height);
            this.scrollBar_.addEventListener("change",this.onScrollBarChange,false,0,true);
            addChild(this.scrollBar_);
         }
      }
      
      private function onScrollBarChange(param1:Event) : void {
         this.listSprite_.y = -this.scrollBar_.pos() * (this.listSprite_.height - 400);
      }
   }
}
