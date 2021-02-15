package com.company.assembleegameclient.screens.charrects {
   import com.company.assembleegameclient.appengine.CharacterStats;
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.screens.events.DeleteCharacterEvent;
   import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.rotmg.graphics.DeleteXGraphic;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.fame.FameContentPopup;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.assets.services.IconFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   import org.swiftsuspenders.Injector;
   
   public class CurrentCharacterRect extends CharacterRect {
      
      private static var toolTip_:MyPlayerToolTip = null;
      
      private static var fameToolTip:TextToolTip = null;
       
      
      public const selected:Signal = new Signal();
      
      public const deleteCharacter:Signal = new Signal();
      
      public const showToolTip:Signal = new Signal(Sprite);
      
      public const hideTooltip:Signal = new Signal();
      
      public var charName:String;
      
      public var charStats:CharacterStats;
      
      public var char_:SavedCharacter;
      
      public var myPlayerToolTipFactory:MyPlayerToolTipFactory;
      
      protected var statsMaxedText:TextFieldDisplayConcrete;
      
      private var charType:CharacterClass;
      
      private var deleteButton:Sprite;
      
      private var icon:DisplayObject;
      
      private var petIcon:Bitmap;
      
      private var fameBitmap:Bitmap;
      
      private var fameBitmapContainer:Sprite;
      
      public function CurrentCharacterRect(param1:String, param2:CharacterClass, param3:SavedCharacter, param4:CharacterStats) {
         myPlayerToolTipFactory = new MyPlayerToolTipFactory();
         super();
         this.charName = param1;
         this.charType = param2;
         this.char_ = param3;
         this.charStats = param4;
         var _loc5_:String = param2.name;
         var _loc8_:int = param3.charXML_.Level;
         var _loc7_:int = param3.charXML_.IsChallenger;
         var _loc6_:Number = _loc7_ == 1?15597823:16777215;
         super.className = new LineBuilder().setParams("CurrentCharacter.description",{
            "className":_loc5_,
            "level":_loc8_
         });
         this.setCharCon(_loc5_.toLowerCase(),this.char_.charId());
         super.color = 6052956;
         super.overColor = 8355711;
         super.init();
         super.classNameText.setColor(_loc6_);
         this.setSeasonalOverlay(_loc7_ == 1);
         this.makeTagline();
         this.makeDeleteButton();
         this.makePetIcon();
         this.makeStatsMaxedText();
         this.makeFameUIIcon();
         this.addEventListeners();
      }
      
      public function addEventListeners() : void {
         addEventListener("removedFromStage",this.onRemovedFromStage);
         selectContainer.addEventListener("click",this.onSelect);
         this.fameBitmapContainer.addEventListener("click",this.onFameClick);
         this.deleteButton.addEventListener("click",this.onDelete);
      }
      
      public function setIcon(param1:DisplayObject) : void {
         this.icon && selectContainer.removeChild(this.icon);
         this.icon = param1;
         this.icon.x = 8;
         this.icon.y = 4;
         addChild(this.icon);
      }
      
      private function setCharCon(param1:String, param2:int) : void {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < Parameters.charNames.length) {
            if(Parameters.charNames[_loc3_] == param1) {
               if(Parameters.charIds[_loc3_] < param2) {
                  param1 = param1 + "2";
                  Parameters.charNames.push(param1);
                  Parameters.charIds.push(param2);
               } else {
                  param1 = param1 + "2";
                  Parameters.charNames.push(param1);
                  Parameters.charIds.push(Parameters.charIds[_loc3_]);
                  Parameters.charIds[_loc3_] = param2;
               }
               return;
            }
            _loc3_++;
         }
         Parameters.charNames.push(param1);
         Parameters.charIds.push(param2);
      }
      
      private function makePetIcon() : void {
         var _loc1_:PetVO = this.char_.getPetVO();
         if(_loc1_) {
            this.petIcon = _loc1_.getSkinBitmap();
            if(this.petIcon == null) {
               return;
            }
            this.petIcon.x = 275;
            this.petIcon.y = 1;
            selectContainer.addChild(this.petIcon);
         }
      }
      
      private function makeTagline() : void {
         var _loc1_:int = this.getNextStarFame();
         if(_loc1_ > 0) {
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams("CurrentCharacter.tagline",{
               "fame":this.char_.fame(),
               "nextStarFame":_loc1_
            }));
            taglineText.x = taglineText.x + taglineIcon.width;
         } else {
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams("CurrentCharacter.tagline_noquest",{"fame":this.char_.fame()}));
            taglineText.x = taglineText.x + taglineIcon.width;
         }
      }
      
      private function getNextStarFame() : int {
         return FameUtil.nextStarFame(this.charStats == null?0:this.charStats.bestFame(),this.char_.fame());
      }
      
      private function makeDeleteButton() : void {
         this.deleteButton = new DeleteXGraphic();
         this.deleteButton.addEventListener("mouseDown",this.onDeleteDown);
         this.deleteButton.x = 389;
         this.deleteButton.y = 19;
         addChild(this.deleteButton);
      }
      
      private function makeStatsMaxedText() : void {
         var _loc2_:int = this.getMaxedStats();
         var _loc1_:int = 11776947;
         if(_loc2_ >= 8) {
            _loc1_ = 16572160;
         }
         this.statsMaxedText = new TextFieldDisplayConcrete().setSize(18).setColor(16777215);
         this.statsMaxedText.setBold(true);
         this.statsMaxedText.setColor(_loc1_);
         this.statsMaxedText.setStringBuilder(new StaticStringBuilder(_loc2_ + "/8"));
         this.statsMaxedText.filters = makeDropShadowFilter();
         this.statsMaxedText.x = 353;
         this.statsMaxedText.y = 19;
         selectContainer.addChild(this.statsMaxedText);
      }
      
      private function makeFameUIIcon() : void {
         var _loc1_:BitmapData = IconFactory.makeFame();
         this.fameBitmap = new Bitmap(_loc1_);
         this.fameBitmapContainer = new Sprite();
         this.fameBitmapContainer.name = "fame_ui";
         this.fameBitmapContainer.addChild(this.fameBitmap);
         this.fameBitmapContainer.x = 328;
         this.fameBitmapContainer.y = 19;
         addChild(this.fameBitmapContainer);
      }
      
      private function getMaxedStats() : int {
         var _loc1_:int = 0;
         if(this.char_.hp() == this.charType.hp.max) {
            _loc1_++;
         }
         if(this.char_.mp() == this.charType.mp.max) {
            _loc1_++;
         }
         if(this.char_.att() == this.charType.attack.max) {
            _loc1_++;
         }
         if(this.char_.def() == this.charType.defense.max) {
            _loc1_++;
         }
         if(this.char_.spd() == this.charType.speed.max) {
            _loc1_++;
         }
         if(this.char_.dex() == this.charType.dexterity.max) {
            _loc1_++;
         }
         if(this.char_.vit() == this.charType.hpRegeneration.max) {
            _loc1_++;
         }
         if(this.char_.wis() == this.charType.mpRegeneration.max) {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function removeToolTip() : void {
         this.hideTooltip.dispatch();
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void {
         super.onMouseOver(param1);
         this.removeToolTip();
         if(param1.target.name == "fame_ui") {
            fameToolTip = new TextToolTip(3552822,10197915,"Fame","Click to get an Overview!",225);
            this.showToolTip.dispatch(fameToolTip);
         } else {
            toolTip_ = this.myPlayerToolTipFactory.create(this.char_.charXML_.Account.Name,this.char_.charXML_,this.charStats);
            toolTip_.createUI();
            this.showToolTip.dispatch(toolTip_);
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void {
         super.onRollOut(param1);
         this.removeToolTip();
      }
      
      private function onSelect(param1:MouseEvent) : void {
         this.selected.dispatch(this.char_);
      }
      
      private function onFameClick(param1:MouseEvent) : void {
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc3_:ShowPopupSignal = _loc2_.getInstance(ShowPopupSignal);
         _loc3_.dispatch(new FameContentPopup(this.char_.charId()));
      }
      
      private function onDelete(param1:MouseEvent) : void {
         this.deleteCharacter.dispatch(this.char_);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         this.removeToolTip();
         selectContainer.removeEventListener("click",this.onSelect);
         this.fameBitmapContainer.removeEventListener("click",this.onFameClick);
         this.deleteButton.removeEventListener("click",this.onDelete);
      }
      
      private function onDeleteDown(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         dispatchEvent(new DeleteCharacterEvent(this.char_));
      }
   }
}
