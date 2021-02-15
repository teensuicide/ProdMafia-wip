package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.appengine.CharacterStats;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.ui.LineBreakDesign;
   import com.company.assembleegameclient.util.AnimatedChar;
   import com.company.assembleegameclient.util.AnimatedChars;
   import com.company.assembleegameclient.util.EquipmentUtil;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.assembleegameclient.util.FilterUtil;
   import com.company.assembleegameclient.util.MaskedImage;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.rotmg.graphics.StarGraphic;
   import com.company.util.AssetLibrary;
   import com.company.util.CachingColorTransformer;
   import com.company.util.ConversionUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class ClassToolTip extends ToolTip {
      
      public static const CLASS_TOOL_TIP_WIDTH:int = 210;
      
      public static const FULL_STAR:ColorTransform = new ColorTransform(0.8,0.8,0.8);
      
      public static const EMPTY_STAR:ColorTransform = new ColorTransform(0.1,0.1,0.1);
       
      
      private var portrait_:Bitmap;
      
      private var nameText_:TextFieldDisplayConcrete;
      
      private var classQuestText_:TextFieldDisplayConcrete;
      
      private var classUnlockText_:TextFieldDisplayConcrete;
      
      private var descriptionText_:TextFieldDisplayConcrete;
      
      private var lineBreakOne:LineBreakDesign;
      
      private var lineBreakTwo:LineBreakDesign;
      
      private var toUnlockText_:TextFieldDisplayConcrete;
      
      private var unlockText_:TextFieldDisplayConcrete;
      
      private var nextClassQuest_:TextFieldDisplayConcrete;
      
      private var showUnlockRequirements:Boolean;
      
      private var _playerXML:XML;
      
      private var _playerModel:PlayerModel;
      
      private var _charStats:CharacterStats;
      
      private var _equipmentContainer:Sprite;
      
      private var _progressContainer:Sprite;
      
      private var _bestContainer:Sprite;
      
      private var _classUnlockContainer:Sprite;
      
      private var _numberOfStars:int;
      
      private var _backgroundColor:Number;
      
      private var _borderColor:Number;
      
      private var _lineColor:Number;
      
      private var _nextStarFame:int;
      
      public function ClassToolTip(param1:XML, param2:PlayerModel, param3:CharacterStats) {
         var _loc4_:* = undefined;
         this._playerXML = param1;
         this._playerModel = param2;
         this._charStats = param3;
         this.showUnlockRequirements = this.shouldShowUnlockRequirements(this._playerModel,this._playerXML);
         if(this.showUnlockRequirements) {
            this._backgroundColor = 1842204;
            _loc4_ = 3552822;
            this._borderColor = _loc4_;
            this._lineColor = _loc4_;
         } else {
            this._backgroundColor = 3552822;
            this._borderColor = 16777215;
            this._lineColor = 1842204;
         }
         super(this._backgroundColor,1,this._borderColor,1);
         this.init();
      }
      
      public static function getDisplayId(param1:XML) : String {
         return param1.DisplayId == undefined?param1.@id:param1.DisplayId;
      }
      
      override protected function alignUI() : void {
         this.nameText_.x = 32;
         this.nameText_.y = 6;
         this.descriptionText_.x = 8;
         this.descriptionText_.y = 40;
         height;
         this.lineBreakOne.x = 6;
         this.lineBreakOne.y = height;
         if(this.showUnlockRequirements) {
            this.toUnlockText_.x = 8;
            this.toUnlockText_.y = height - 2;
            this.unlockText_.x = 12;
            this.unlockText_.y = height - 4;
         } else {
            this.classQuestText_.x = 6;
            this.classQuestText_.y = height - 2;
            if(this._nextStarFame > 0) {
               this.nextClassQuest_.x = 8;
               this.nextClassQuest_.y = height - 4;
            }
            this._progressContainer.x = 10;
            this._progressContainer.y = height - 2;
            this._bestContainer.x = 6;
            this._bestContainer.y = height;
            if(this.lineBreakTwo) {
               this.lineBreakTwo.x = 6;
               this.lineBreakTwo.y = height - 10;
               this.classUnlockText_.visible = true;
               this.classUnlockText_.x = 6;
               this.classUnlockText_.y = height;
               this._classUnlockContainer.x = 6;
               this._classUnlockContainer.y = height - 6;
            }
         }
         this.draw();
         position();
      }
      
      override public function draw() : void {
         this.lineBreakOne.setWidthColor(210,this._lineColor);
         this.lineBreakTwo && this.lineBreakTwo.setWidthColor(210,this._lineColor);
         this._equipmentContainer.x = 210 - this._equipmentContainer.width + 10;
         this._equipmentContainer.y = 6;
         super.draw();
      }
      
      private function init() : void {
         var _loc1_:Boolean = StaticInjectorContext.injector.getInstance(SeasonalEventModel).isChallenger;
         this._numberOfStars = this._charStats == null?0:this._charStats.numStars();
         this.createCharacter();
         this.createEquipmentTypes();
         this.createCharacterName();
         this.lineBreakOne = new LineBreakDesign(204,this._lineColor);
         addChild(this.lineBreakOne);
         if(this.showUnlockRequirements && !_loc1_) {
            this.createUnlockRequirements();
         } else {
            this.createClassQuest();
            this.createQuestText();
            this.createStarProgress();
            this.createBestLevelAndFame();
            if(!_loc1_) {
               this.createClassUnlockTitle();
               this.createClassUnlocks();
               if(this._classUnlockContainer.numChildren > 0) {
                  this.lineBreakTwo = new LineBreakDesign(204,this._lineColor);
                  addChild(this.lineBreakTwo);
               }
            }
         }
      }
      
      private function createCharacter() : void {
         var _loc4_:AnimatedChar = AnimatedChars.getAnimatedChar(this._playerXML.AnimatedTexture.File,this._playerXML.AnimatedTexture.Index);
         var _loc1_:MaskedImage = _loc4_.imageFromDir(0,0,0);
         var _loc3_:int = 4 / _loc1_.width() * 100;
         var _loc2_:BitmapData = TextureRedrawer.redraw(_loc1_.image_,_loc3_,true,0);
         if(this.showUnlockRequirements) {
            _loc2_ = CachingColorTransformer.transformBitmapData(_loc2_,new ColorTransform(0,0,0,0.5,0,0,0,0));
         }
         this.portrait_ = new Bitmap();
         this.portrait_.bitmapData = _loc2_;
         this.portrait_.x = -4;
         this.portrait_.y = -4;
         addChild(this.portrait_);
      }
      
      private function createEquipmentTypes() : void {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         this._equipmentContainer = new Sprite();
         addChild(this._equipmentContainer);
         var _loc4_:Vector.<int> = ConversionUtil.toIntVector(this._playerXML.SlotTypes);
         var _loc1_:Vector.<int> = ConversionUtil.toIntVector(this._playerXML.Equipment);
         while(_loc3_ < 4) {
            _loc2_ = _loc1_[_loc3_];
            if(_loc2_ > -1) {
               _loc5_ = ObjectLibrary.getRedrawnTextureFromType(_loc2_,40,true);
               _loc7_ = new Bitmap(_loc5_);
               _loc7_.x = _loc3_ * 22;
               _loc7_.y = -12;
               this._equipmentContainer.addChild(_loc7_);
            } else {
               _loc6_ = EquipmentUtil.getEquipmentBackground(_loc4_[_loc3_],2);
               if(_loc6_) {
                  _loc6_.x = 12 + _loc3_ * 22;
                  _loc6_.filters = FilterUtil.getDarkGreyColorFilter();
                  this._equipmentContainer.addChild(_loc6_);
               }
            }
            _loc3_++;
         }
      }
      
      private function createCharacterName() : void {
         this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16777215);
         this.nameText_.setBold(true);
         this.nameText_.setStringBuilder(new LineBuilder().setParams(getDisplayId(this._playerXML)));
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.nameText_.textChanged);
         addChild(this.nameText_);
         this.descriptionText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947).setWordWrap(true).setMultiLine(true).setTextWidth(174);
         this.descriptionText_.setStringBuilder(new LineBuilder().setParams(this._playerXML.Description));
         this.descriptionText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.descriptionText_.textChanged);
         addChild(this.descriptionText_);
      }
      
      private function createClassQuest() : void {
         this.classQuestText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16777215);
         this.classQuestText_.setBold(true);
         this.classQuestText_.setStringBuilder(new LineBuilder().setParams("Class Quest"));
         this.classQuestText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.classQuestText_.textChanged);
         addChild(this.classQuestText_);
      }
      
      private function createQuestText() : void {
         this._nextStarFame = FameUtil.nextStarFame(this._charStats == null?0:this._charStats.bestFame(),0);
         if(this._nextStarFame > 0) {
            this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(160).setMultiLine(true).setWordWrap(true);
            if(this._numberOfStars > 0) {
               this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams("Earn {nextStarFame} Fame with {typeToDisplay} to unlock the next Star",{
                  "nextStarFame":this._nextStarFame,
                  "typeToDisplay":getDisplayId(this._playerXML)
               }));
            } else {
               this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams("Earn 20 Fame with {typeToDisplay} to unlock the first star",{"typeToDisplay":getDisplayId(this._playerXML)}));
            }
            this.nextClassQuest_.filters = [new DropShadowFilter(0,0,0)];
            waiter.push(this.nextClassQuest_.textChanged);
            addChild(this.nextClassQuest_);
         }
      }
      
      private function createStarProgress() : void {
         var _loc10_:* = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Number = NaN;
         var _loc9_:* = false;
         var _loc2_:int = 0;
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc13_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         this._progressContainer = new Sprite();
         _loc10_ = this._progressContainer.graphics;
         addChild(this._progressContainer);
         var _loc8_:Vector.<int> = FameUtil.STARS;
         var _loc12_:int = _loc8_.length;
         while(_loc1_ < _loc12_) {
            _loc5_ = _loc8_[_loc1_];
            _loc7_ = this._charStats != null?this._charStats.bestFame():0;
            _loc3_ = _loc7_ >= _loc5_?65280:16549442;
            _loc9_ = _loc1_ < this._numberOfStars;
            _loc2_ = 20 + _loc1_ * 10;
            _loc11_ = new StarGraphic();
            _loc11_.x = _loc6_ + (_loc2_ - _loc11_.width) / 2;
            _loc11_.transform.colorTransform = !_loc9_?EMPTY_STAR:FULL_STAR;
            this._progressContainer.addChild(_loc11_);
            _loc4_ = new UILabel();
            _loc4_.text = _loc5_.toString();
            DefaultLabelFormat.characterToolTipLabel(_loc4_,_loc3_);
            _loc4_.x = _loc6_ + (_loc2_ - _loc4_.width) / 2;
            _loc4_.y = 14;
            this._progressContainer.addChild(_loc4_);
            _loc10_.beginFill(1842204);
            _loc10_.drawRect(_loc6_,31,_loc2_,4);
            if(_loc7_ > 0) {
               _loc10_.beginFill(_loc3_);
               if(_loc7_ >= _loc5_) {
                  _loc10_.drawRect(_loc6_,31,_loc2_,4);
               } else if(_loc1_ == 0) {
                  _loc13_ = _loc7_ / _loc5_ * _loc2_;
                  _loc10_.drawRect(_loc6_,31,_loc13_,4);
               } else if(_loc7_ > _loc8_[_loc1_ - 1]) {
                  _loc13_ = (_loc7_ - _loc8_[_loc1_ - 1]) / (_loc5_ - _loc8_[_loc1_ - 1]) * _loc2_;
                  _loc10_.drawRect(_loc6_,31,_loc13_,4);
               }
            }
            _loc6_ = _loc6_ + (1 + _loc2_);
            _loc1_++;
         }
      }
      
      private function createBestLevelAndFame() : void {
         this._bestContainer = new Sprite();
         addChild(this._bestContainer);
         var _loc4_:UILabel = new UILabel();
         _loc4_.text = "Best Level";
         DefaultLabelFormat.characterToolTipLabel(_loc4_,16777215);
         this._bestContainer.addChild(_loc4_);
         var _loc1_:UILabel = new UILabel();
         _loc1_.text = (this._charStats != null?this._charStats.bestLevel():0).toString();
         DefaultLabelFormat.characterToolTipLabel(_loc1_,16777215);
         _loc1_.x = 186;
         this._bestContainer.addChild(_loc1_);
         var _loc3_:UILabel = new UILabel();
         _loc3_.text = "Best Fame";
         DefaultLabelFormat.characterToolTipLabel(_loc3_,16777215);
         _loc3_.y = 18;
         this._bestContainer.addChild(_loc3_);
         var _loc5_:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",224);
         _loc5_ = TextureRedrawer.redraw(_loc5_,40,true,0);
         var _loc2_:Bitmap = new Bitmap(_loc5_);
         _loc2_.x = 174;
         _loc2_.y = _loc3_.y - 10;
         this._bestContainer.addChild(_loc2_);
         var _loc6_:UILabel = new UILabel();
         _loc6_.text = (this._charStats != null?this._charStats.bestFame():0).toString();
         DefaultLabelFormat.characterToolTipLabel(_loc6_,16777215);
         _loc6_.x = _loc2_.x - _loc6_.width;
         _loc6_.y = _loc3_.y;
         this._bestContainer.addChild(_loc6_);
      }
      
      private function createClassUnlockTitle() : void {
         this.classUnlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16777215);
         this.classUnlockText_.setBold(true);
         this.classUnlockText_.setStringBuilder(new LineBuilder().setParams("Class Unlocks"));
         this.classUnlockText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.classUnlockText_.textChanged);
         this.classUnlockText_.visible = false;
         addChild(this.classUnlockText_);
      }
      
      private function createClassUnlocks() : void {
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc8_:* = null;
         var _loc3_:int = 0;
         var _loc13_:Number = NaN;
         var _loc4_:* = null;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         this._classUnlockContainer = new Sprite();
         var _loc5_:int = ObjectLibrary.playerChars_.length;
         var _loc9_:Vector.<XML> = ObjectLibrary.playerChars_;
         var _loc2_:String = this._playerXML.@id;
         var _loc14_:int = this._charStats != null?this._charStats.bestLevel():0;
         while(_loc7_ < _loc5_) {
            _loc6_ = _loc9_[_loc7_];
            _loc1_ = _loc6_.@id;
            if(_loc2_ != _loc1_ && _loc6_.UnlockLevel) {
               _loc11_ = 0;
               _loc12_ = _loc6_.UnlockLevel;
               var _loc16_:int = 0;
               var _loc15_:* = _loc6_.UnlockLevel;
               for each(_loc8_ in _loc6_.UnlockLevel) {
                  if(_loc2_ == _loc8_.toString()) {
                     _loc3_ = _loc8_.@level;
                     _loc13_ = _loc14_ >= _loc3_?65280:16711680;
                     _loc4_ = new UILabel();
                     _loc4_.text = "Reach level " + _loc3_.toString() + " to unlock " + _loc1_;
                     DefaultLabelFormat.characterToolTipLabel(_loc4_,_loc13_);
                     _loc4_.y = _loc10_;
                     this._classUnlockContainer.addChild(_loc4_);
                     _loc10_ = _loc10_ + 14;
                  }
               }
            }
            _loc7_++;
         }
         addChild(this._classUnlockContainer);
      }
      
      private function createUnlockRequirements() : void {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         this.toUnlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947).setTextWidth(174).setBold(true);
         this.toUnlockText_.setStringBuilder(new LineBuilder().setParams("unlockText_.toUnlock"));
         this.toUnlockText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.toUnlockText_.textChanged);
         addChild(this.toUnlockText_);
         this.unlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174).setWordWrap(false).setMultiLine(true);
         var _loc5_:AppendingLineBuilder = new AppendingLineBuilder();
         var _loc6_:* = this._playerXML.UnlockLevel;
         var _loc8_:int = 0;
         var _loc7_:* = this._playerXML.UnlockLevel;
         for each(_loc1_ in this._playerXML.UnlockLevel) {
            _loc3_ = ObjectLibrary.idToType_[_loc1_.toString()];
            _loc2_ = _loc1_.@level;
            if(this._playerModel.getBestLevel(_loc3_) < int(_loc1_.@level)) {
               _loc5_.pushParams("unlockText_.reachLevel",{
                  "unlockLevel":_loc2_,
                  "typeToDisplay":ObjectLibrary.typeToDisplayId_[_loc3_]
               });
            }
         }
         this.unlockText_.setStringBuilder(_loc5_);
         this.unlockText_.filters = [new DropShadowFilter(0,0,0)];
         waiter.push(this.unlockText_.textChanged);
         addChild(this.unlockText_);
      }
      
      private function shouldShowUnlockRequirements(param1:PlayerModel, param2:XML) : Boolean {
         var _loc4_:Boolean = param1.isClassAvailability(String(param2.@id),"unrestricted");
         var _loc3_:Boolean = param1.isLevelRequirementsMet(int(param2.@type));
         return !_loc4_ && !_loc3_;
      }
   }
}
