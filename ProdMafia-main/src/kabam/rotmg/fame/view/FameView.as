package kabam.rotmg.fame.view {
   import com.company.assembleegameclient.map.GroundLibrary;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.screens.ScoreTextLine;
   import com.company.assembleegameclient.screens.ScoringBox;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.rotmg.graphics.FameIconBackgroundDesign;
   import com.company.rotmg.graphics.ScreenGraphic;
   import com.company.util.BitmapUtil;
   import com.gskinner.motion.GTween;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.components.ScreenBase;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class FameView extends Sprite {
      
      private static const FameIconBackgroundDesign_:Class = FameIconBackgroundDesign;
       
      
      private const DEFAULT_FILTER:DropShadowFilter = new DropShadowFilter(0,0,0,0.5,12,12);
      
      public var closed:Signal;
      
      private var infoContainer:DisplayObjectContainer;
      
      private var overlayContainer:Bitmap;
      
      private var title:TextFieldDisplayConcrete;
      
      private var date:TextFieldDisplayConcrete;
      
      private var scoringBox:ScoringBox;
      
      private var finalLine:ScoreTextLine;
      
      private var continueBtn:TitleMenuOption;
      
      private var isAnimation:Boolean;
      
      private var isFadeComplete:Boolean;
      
      private var isDataPopulated:Boolean;
      
      private var _remainingChallengerCharacters:UILabel;
      
      public function FameView() {
         super();
         this.init();
      }
      
      public function get remainingChallengerCharacters() : UILabel {
         return this._remainingChallengerCharacters;
      }
      
      public function set remainingChallengerCharacters(param1:UILabel) : void {
         this._remainingChallengerCharacters = param1;
      }
      
      public function setIsAnimation(param1:Boolean) : void {
         this.isAnimation = param1;
      }
      
      public function setBackground(param1:BitmapData) : void {
         this.overlayContainer.bitmapData = param1;
         var _loc2_:GTween = new GTween(this.overlayContainer,2,{"alpha":0});
         _loc2_.onComplete = this.onFadeComplete;
         SoundEffectLibrary.play("death_screen");
      }
      
      public function clearBackground() : void {
         this.overlayContainer.bitmapData = null;
      }
      
      public function setCharacterInfo(param1:String, param2:int, param3:int) : void {
         this.title = new TextFieldDisplayConcrete().setSize(38).setColor(13421772);
         this.title.setBold(true).setAutoSize("center");
         this.title.filters = [DEFAULT_FILTER];
         var _loc4_:String = ObjectLibrary.typeToDisplayId_[param3];
         this.title.setStringBuilder(new LineBuilder().setParams("FameView.CharacterInfo",{
            "name":param1,
            "level":param2,
            "type":_loc4_
         }));
         this.title.x = stage.stageWidth * 0.5;
         this.title.y = 225;
         this.infoContainer.addChild(this.title);
      }
      
      public function setDeathInfo(param1:String, param2:String) : void {
         this.date = new TextFieldDisplayConcrete().setSize(24).setColor(13421772);
         this.date.setBold(true).setAutoSize("center");
         this.date.filters = [DEFAULT_FILTER];
         var _loc3_:LineBuilder = new LineBuilder();
         if(param2) {
            _loc3_.setParams("FameView.deathInfoLong",{
               "date":param1,
               "killer":this.convertKillerString(param2)
            });
         } else {
            _loc3_.setParams("FameView.deathInfoShort",{"date":param1});
         }
         this.date.setStringBuilder(_loc3_);
         this.date.x = stage.stageWidth * 0.5;
         this.date.y = 272;
         this.infoContainer.addChild(this.date);
      }
      
      public function setIcon(param1:BitmapData) : void {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Sprite = new FameIconBackgroundDesign_();
         _loc3_.filters = [DEFAULT_FILTER];
         _loc2_.addChild(_loc3_);
         var _loc4_:Bitmap = new Bitmap(param1);
         _loc4_.x = _loc2_.width * 0.5 - _loc4_.width * 0.5;
         _loc4_.y = _loc2_.height * 0.5 - _loc4_.height * 0.5;
         _loc2_.addChild(_loc4_);
         _loc2_.y = 20;
         _loc2_.x = stage.stageWidth * 0.5 - _loc2_.width * 0.5;
         this.infoContainer.addChild(_loc2_);
      }
      
      public function setScore(param1:int, param2:XML) : void {
         this.scoringBox = new ScoringBox(new Rectangle(0,0,784,150),param2);
         this.scoringBox.x = 8;
         this.scoringBox.y = 316;
         addChild(this.scoringBox);
         this.infoContainer.addChild(this.scoringBox);
         var _loc3_:BitmapData = FameUtil.getFameIcon();
         _loc3_ = BitmapUtil.cropToBitmapData(_loc3_,6,6,_loc3_.width - 12,_loc3_.height - 12);
         this.finalLine = new ScoreTextLine(24,13421772,16762880,"FameView.totalFameEarned",null,0,param1,"","",new Bitmap(_loc3_));
         this.finalLine.x = 10;
         this.finalLine.y = 470;
         this.infoContainer.addChild(this.finalLine);
         this.isDataPopulated = true;
         if(!this.isAnimation || this.isFadeComplete) {
            this.makeContinueButton();
         }
      }
      
      public function addRemainingChallengerCharacters(param1:int) : void {
         this._remainingChallengerCharacters = new UILabel();
         DefaultLabelFormat.createLabelFormat(this._remainingChallengerCharacters,18,16711680,"left",true);
         this._remainingChallengerCharacters.autoSize = "left";
         this._remainingChallengerCharacters.text = "You can create " + param1 + " more characters";
         this._remainingChallengerCharacters.x = (this.width - this._remainingChallengerCharacters.width) / 2;
         this._remainingChallengerCharacters.y = this.finalLine.y + this.finalLine.height - 10;
         this.infoContainer.addChild(this._remainingChallengerCharacters);
      }
      
      private function init() : void {
         addChild(new ScreenBase());
         var _loc1_:* = new Sprite();
         this.infoContainer = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Bitmap();
         this.overlayContainer = _loc1_;
         addChild(_loc1_);
         this.continueBtn = new TitleMenuOption("Options.continueButton",36,false);
         this.continueBtn.setAutoSize("center");
         this.continueBtn.setVerticalAlign("middle");
         this.closed = new NativeMappedSignal(this.continueBtn,"click");
      }
      
      private function onFadeComplete(param1:GTween) : void {
         removeChild(this.overlayContainer);
         this.isFadeComplete = true;
         if(this.isDataPopulated) {
            this.makeContinueButton();
         }
      }
      
      private function convertKillerString(param1:String) : String {
         var _loc5_:* = undefined;
         var _loc2_:Array = param1.split(".");
         var _loc4_:String = _loc2_[0];
         var _loc3_:* = _loc2_[1];
         if(_loc3_ == null) {
            _loc3_ = _loc4_;
            _loc5_ = _loc3_;
            var _loc6_:* = _loc5_;
            switch(_loc6_) {
               case "lava":
                  _loc3_ = "Lava";
                  break;
               case "lava blend":
                  _loc3_ = "Lava Blend";
                  break;
               case "liquid evil":
                  _loc3_ = "Liquid Evil";
                  break;
               case "evil water":
                  _loc3_ = "Evil Water";
                  break;
               case "puke water":
                  _loc3_ = "Puke Water";
                  break;
               case "hot lava":
                  _loc3_ = "Hot Lava";
                  break;
               case "pure evil":
                  _loc3_ = "Pure Evil";
                  break;
               case "lod red tile":
                  _loc3_ = "lod Red Tile";
                  break;
               case "lod purple tile":
                  _loc3_ = "lod Purple Tile";
                  break;
               case "lod blue tile":
                  _loc3_ = "lod Blue Tile";
                  break;
               case "lod green tile":
                  _loc3_ = "lod Green Tile";
                  break;
               case "lod cream tile":
                  _loc3_ = "lod Cream Tile";
            }
         } else {
            _loc3_ = _loc3_.substr(0,_loc3_.length - 1);
            _loc3_ = _loc3_.replace(/_/g," ");
            _loc3_ = _loc3_.replace(/APOS/g,"\'");
            _loc3_ = _loc3_.replace(/BANG/g,"!");
         }
         if(ObjectLibrary.getPropsFromId(_loc3_)) {
            _loc3_ = ObjectLibrary.getPropsFromId(_loc3_).displayId_;
         } else if(GroundLibrary.getPropsFromId(_loc3_) != null) {
            _loc3_ = GroundLibrary.getPropsFromId(_loc3_).displayId_;
         }
         return _loc3_;
      }
      
      private function makeContinueButton() : void {
         this.infoContainer.addChild(new ScreenGraphic());
         this.continueBtn.x = stage.stageWidth * 0.5;
         this.continueBtn.y = 550;
         this.infoContainer.addChild(this.continueBtn);
         if(this.isAnimation) {
            this.scoringBox.animateScore();
         } else {
            this.scoringBox.showScore();
         }
      }
   }
}
