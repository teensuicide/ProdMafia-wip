package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.ui.Scrollbar;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.BitmapUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class ScoringBox extends Sprite {
       
      
      private var rect_:Rectangle;
      
      private var mask_:Shape;
      
      private var linesSprite_:Sprite;
      
      private var scoreTextLines_:Vector.<ScoreTextLine>;
      
      private var scrollbar_:Scrollbar;
      
      private var startTime_:int;
      
      public function ScoringBox(param1:Rectangle, param2:XML) {
         mask_ = new Shape();
         linesSprite_ = new Sprite();
         scoreTextLines_ = new Vector.<ScoreTextLine>();
         var _loc3_:* = null;
         super();
         this.rect_ = param1;
         graphics.lineStyle(1,4802889,2);
         graphics.drawRect(this.rect_.x + 1,this.rect_.y + 1,this.rect_.width - 2,this.rect_.height - 2);
         graphics.lineStyle();
         this.scrollbar_ = new Scrollbar(16,this.rect_.height);
         this.scrollbar_.addEventListener("change",this.onScroll);
         this.mask_.graphics.beginFill(16777215,1);
         this.mask_.graphics.drawRect(this.rect_.x,this.rect_.y,this.rect_.width,this.rect_.height);
         this.mask_.graphics.endFill();
         addChild(this.mask_);
         mask = this.mask_;
         addChild(this.linesSprite_);
         this.addLine("FameView.Shots",null,0,param2.Shots,false,5746018);
         if(param2.Shots != 0) {
            this.addLine("FameView.Accuracy",null,0,100 * param2.ShotsThatDamage / param2.Shots,true,5746018,"","%");
         }
         this.addLine("FameView.TilesSeen",null,0,param2.TilesUncovered,false,5746018);
         this.addLine("FameView.MonsterKills",null,0,param2.MonsterKills,false,5746018);
         this.addLine("FameView.GodKills",null,0,param2.GodKills,false,5746018);
         this.addLine("FameView.OryxKills",null,0,param2.OryxKills,false,5746018);
         this.addLine("FameView.QuestsCompleted",null,0,param2.QuestsCompleted,false,5746018);
         this.addLine("FameView.DungeonsCompleted",null,0,param2.PirateCavesCompleted + param2.UndeadLairsCompleted + param2.AbyssOfDemonsCompleted + param2.SnakePitsCompleted + param2.SpiderDensCompleted + param2.SpriteWorldsCompleted + param2.TombsCompleted + param2.TrenchesCompleted + param2.JunglesCompleted + param2.ManorsCompleted + param2.ForestMazeCompleted + param2.LairOfDraconisCompleted + param2.CandyLandCompleted + param2.HauntedCemeteryCompleted + param2.CaveOfAThousandTreasuresCompleted + param2.MadLabCompleted + param2.DavyJonesCompleted + param2.TombHeroicCompleted + param2.DreamscapeCompleted + param2.IceCaveCompleted + param2.DeadWaterDocksCompleted + param2.CrawlingDepthCompleted + param2.WoodLandCompleted + param2.BattleNexusCompleted + param2.TheShattersCompleted + param2.BelladonnaCompleted + param2.PuppetMasterCompleted + param2.ToxicSewersCompleted + param2.TheHiveCompleted + param2.MountainTempleCompleted + param2.TheNestCompleted + param2.LairOfDraconisHmCompleted + param2.LostHallsCompleted + param2.CultistHideoutCompleted + param2.TheVoidCompleted + param2.PuppetEncoreCompleted + param2.LairOfShaitanCompleted + param2.ParasiteChambersCompleted,false,5746018);
         this.addLine("FameView.PartyMemberLevelUps",null,0,param2.LevelUpAssists,false,5746018);
         var _loc5_:BitmapData = FameUtil.getFameIcon();
         _loc5_ = BitmapUtil.cropToBitmapData(_loc5_,6,6,_loc5_.width - 12,_loc5_.height - 12);
         this.addLine("FameView.BaseFameEarned",null,0,param2.BaseFame,true,16762880,"","",new Bitmap(_loc5_));
         var _loc6_:* = param2.Bonus;
         var _loc8_:int = 0;
         var _loc7_:* = param2.Bonus;
         for each(_loc3_ in param2.Bonus) {
            this.addLine(_loc3_.@id,_loc3_.@desc,_loc3_.@level,_loc3_,true,16762880,"+","",new Bitmap(_loc5_));
         }
      }
      
      public function showScore() : void {
         var _loc3_:* = null;
         this.animateScore();
         this.startTime_ = -2147483647;
         var _loc1_:* = this.scoreTextLines_;
         var _loc5_:int = 0;
         var _loc4_:* = this.scoreTextLines_;
         for each(_loc3_ in this.scoreTextLines_) {
            _loc3_.skip();
         }
      }
      
      public function animateScore() : void {
         this.startTime_ = TimeUtil.getTrueTime();
         addEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function addLine(param1:String, param2:String, param3:int, param4:int, param5:Boolean, param6:uint, param7:String = "", param8:String = "", param9:DisplayObject = null) : void {
         if(param4 == 0 && !param5) {
            return;
         }
         this.scoreTextLines_.push(new ScoreTextLine(20,11776947,param6,param1,param2,param3,param4,param7,param8,param9));
      }
      
      private function addScrollbar() : void {
         graphics.clear();
         graphics.lineStyle(1,4802889,2);
         graphics.drawRect(this.rect_.x + 1,this.rect_.y + 1,this.rect_.width - 26,this.rect_.height - 2);
         graphics.lineStyle();
         this.scrollbar_.x = this.rect_.width - 16;
         this.scrollbar_.setIndicatorSize(this.mask_.height,this.linesSprite_.height);
         this.scrollbar_.setPos(1);
         addChild(this.scrollbar_);
      }
      
      private function onScroll(param1:Event) : void {
         var _loc2_:Number = this.scrollbar_.pos();
         this.linesSprite_.y = _loc2_ * (this.rect_.height - this.linesSprite_.height - 15) + 5;
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc4_:Number = NaN;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc2_:Number = this.startTime_ + 2000 * (this.scoreTextLines_.length - 1) / 2;
         _loc4_ = TimeUtil.getTrueTime();
         var _loc5_:int = Math.min(this.scoreTextLines_.length,2 * (TimeUtil.getTrueTime() - this.startTime_) / 2000 + 1);
         while(_loc3_ < _loc5_) {
            _loc6_ = this.scoreTextLines_[_loc3_];
            _loc6_.y = 28 * _loc3_;
            this.linesSprite_.addChild(_loc6_);
            _loc3_++;
         }
         this.linesSprite_.y = this.rect_.height - this.linesSprite_.height - 10;
         if(_loc4_ > _loc2_ + 1000) {
            this.addScrollbar();
            dispatchEvent(new Event("complete"));
            removeEventListener("enterFrame",this.onEnterFrame);
         }
      }
   }
}
