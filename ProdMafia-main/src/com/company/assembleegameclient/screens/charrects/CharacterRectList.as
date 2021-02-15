package com.company.assembleegameclient.screens.charrects {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.PlayerModel;
   import org.osflash.signals.Signal;
   import org.swiftsuspenders.Injector;
   
   public class CharacterRectList extends Sprite {
       
      
      public var newCharacter:Signal;
      
      public var buyCharacterSlot:Signal;
      
      private var classes:ClassesModel;
      
      private var model:PlayerModel;
      
      private var seasonalEventModel:SeasonalEventModel;
      
      private var assetFactory:CharacterFactory;
      
      private var yOffset:int;
      
      private var accountName:String;
      
      private var numberOfSavedCharacters:int;
      
      private var numberOfAvailableCharSlots:int;
      
      private var charactersAvailable:UILabel;
      
      private var isSeasonalEvent:Boolean;
      
      public function CharacterRectList() {
         super();
         this.init();
      }
      
      private function init() : void {
         var _loc1_:* = null;
         this.createInjections();
         this.createSignals();
         this.accountName = this.model.getName();
         this.yOffset = 4;
         this.createSavedCharacters();
         this.createAvailableCharSlots();
         if(this.canBuyCharSlot()) {
            this.createBuyRect();
         }
         if(this.isSeasonalEvent) {
            this.charactersAvailable = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.charactersAvailable,18,16776960,"center",true);
            this.charactersAvailable.width = this.width;
            this.charactersAvailable.multiline = true;
            this.charactersAvailable.wordWrap = true;
            if(!this.canBuyCharSlot() && this.numberOfAvailableCharSlots == 0 && this.numberOfSavedCharacters == 0) {
               _loc1_ = "You have no more Characters left to play\n ...maybe one day you can buy some :-)";
            } else {
               _loc1_ = "You can create " + this.seasonalEventModel.remainingCharacters + " more characters";
            }
            this.charactersAvailable.text = _loc1_;
            this.charactersAvailable.y = this.yOffset + 120;
            addChild(this.charactersAvailable);
         }
      }
      
      private function canBuyCharSlot() : Boolean {
         var _loc1_:* = true;
         return _loc1_;
      }
      
      private function createAvailableCharSlots() : void {
         var _loc1_:int = 0;
         var _loc3_:* = null;
         if(this.model.hasAvailableCharSlot()) {
            this.numberOfAvailableCharSlots = this.model.getAvailableCharSlots();
            _loc1_ = 0;
            while(_loc1_ < this.numberOfAvailableCharSlots) {
               _loc3_ = new CreateNewCharacterRect(this.model);
               _loc3_.addEventListener("mouseDown",this.onNewChar);
               _loc3_.y = this.yOffset;
               addChild(_loc3_);
               this.yOffset = this.yOffset + 63;
               _loc1_++;
            }
         }
      }
      
      private function createSavedCharacters() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc2_:CurrentCharacterRect = null;
         var _loc7_:Vector.<SavedCharacter> = this.model.getSavedCharacters();
         this.numberOfSavedCharacters = _loc7_.length;
         var _loc4_:* = _loc7_;
         var _loc9_:int = 0;
         var _loc8_:* = _loc7_;
         for each(_loc1_ in _loc7_) {
            _loc3_ = this.classes.getCharacterClass(_loc1_.objectType());
            _loc6_ = this.model.getCharStats()[_loc1_.objectType()];
            _loc2_ = new CurrentCharacterRect(this.accountName,_loc3_,_loc1_,_loc6_);
            if(Parameters.skinTypes16.indexOf(_loc1_.skinType()) != -1) {
               _loc2_.setIcon(this.getIcon(_loc1_,50));
            } else {
               _loc2_.setIcon(this.getIcon(_loc1_,100));
            }
            _loc2_.y = this.yOffset;
            addChild(_loc2_);
            this.yOffset = this.yOffset + 63;
         }
      }
      
      private function createSignals() : void {
         this.newCharacter = new Signal();
         this.buyCharacterSlot = new Signal();
      }
      
      private function createInjections() : void {
         var _loc1_:Injector = StaticInjectorContext.getInjector();
         this.classes = _loc1_.getInstance(ClassesModel);
         this.model = _loc1_.getInstance(PlayerModel);
         this.assetFactory = _loc1_.getInstance(CharacterFactory);
         this.seasonalEventModel = _loc1_.getInstance(SeasonalEventModel);
      }
      
      private function createBuyRect() : void {
         var _loc1_:BuyCharacterRect = new BuyCharacterRect(this.model);
         _loc1_.addEventListener("mouseDown",this.onBuyCharSlot);
         _loc1_.y = this.yOffset;
         addChild(_loc1_);
      }
      
      private function getIcon(param1:SavedCharacter, param2:int = 100) : DisplayObject {
         var _loc5_:CharacterClass = this.classes.getCharacterClass(param1.objectType());
         var _loc4_:CharacterSkin = _loc5_.skins.getSkin(param1.skinType()) || _loc5_.skins.getDefaultSkin();
         var _loc3_:BitmapData = this.assetFactory.makeIcon(_loc4_.template,param2,param1.tex1(),param1.tex2());
         return new Bitmap(_loc3_);
      }
      
      private function onNewChar(param1:Event) : void {
         this.newCharacter.dispatch();
      }
      
      private function onBuyCharSlot(param1:Event) : void {
         this.buyCharacterSlot.dispatch(this.model.getNextCharSlotPrice());
      }
   }
}
