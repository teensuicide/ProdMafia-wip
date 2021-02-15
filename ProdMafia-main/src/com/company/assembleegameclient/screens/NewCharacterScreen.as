package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.rotmg.graphics.ScreenGraphic;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.view.CreditDisplay;
   import kabam.rotmg.ui.view.components.ScreenBase;
   import org.osflash.signals.Signal;
   
   public class NewCharacterScreen extends Sprite {
       
      
      public var tooltip:Signal;
      
      public var close:Signal;
      
      public var selected:Signal;
      
      private var backButton_:TitleMenuOption;
      
      private var creditDisplay_:CreditDisplay;
      
      private var boxes_:Object;
      
      private var isInitialized:Boolean = false;
      
      public function NewCharacterScreen() {
         boxes_ = {};
         super();
         this.tooltip = new Signal(Sprite);
         this.selected = new Signal(int);
         this.close = new Signal();
         addChild(new ScreenBase());
         addChild(new AccountScreen());
         addChild(new ScreenGraphic());
      }
      
      public function initialize(param1:PlayerModel) : void {
         var _loc6_:int = 0;
         var _loc2_:XML = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc4_:Boolean = false;
         var _loc3_:CharacterBox = null;
         if(this.isInitialized) {
            return;
         }
         this.isInitialized = true;
         this.backButton_ = new TitleMenuOption("Screens.back",36,false);
         this.backButton_.addEventListener("click",this.onBackClick);
         this.backButton_.setVerticalAlign("middle");
         addChild(this.backButton_);
         this.creditDisplay_ = new CreditDisplay();
         this.creditDisplay_.draw(param1.getCredits(),param1.getFame(), param1.getForgefire());
         addChild(this.creditDisplay_);
         _loc6_ = 0;
         while(_loc6_ < ObjectLibrary.playerChars_.length) {
            _loc2_ = ObjectLibrary.playerChars_[_loc6_];
            _loc5_ = _loc2_.@type;
            _loc7_ = _loc2_.@id;
            if(!param1.isClassAvailability(_loc7_,"unavailable")) {
               _loc4_ = param1.isClassAvailability(_loc7_,"unrestricted");
               _loc3_ = new CharacterBox(_loc2_,param1.getCharStats()[_loc5_],param1,_loc4_);
               _loc3_.x = 158 + 115 * (int(_loc6_ % 4)) + 70 - _loc3_.width / 2;
               _loc3_.y = 52 + 115 * (int(_loc6_ / 4));
               this.boxes_[_loc5_] = _loc3_;
               _loc3_.addEventListener("rollOver",this.onCharBoxOver);
               _loc3_.addEventListener("rollOut",this.onCharBoxOut);
               _loc3_.characterSelectClicked_.add(this.onCharBoxClick);
               addChild(_loc3_);
            }
            _loc6_++;
         }
         this.backButton_.x = stage.stageWidth / 2 - this.backButton_.width / 2;
         this.backButton_.y = 550;
         this.creditDisplay_.x = stage.stageWidth;
         this.creditDisplay_.y = 20;
      }
      
      public function updateCreditDisplay(credits:int, fame:int, forgefire:int) : void {
         this.creditDisplay_.draw(credits, fame, forgefire);
      }
      
      public function update(param1:PlayerModel) : void {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc7_:Boolean = false;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < ObjectLibrary.playerChars_.length) {
            _loc4_ = ObjectLibrary.playerChars_[_loc2_];
            _loc3_ = _loc4_.@type;
            _loc5_ = String(_loc4_.@id);
            if(!param1.isClassAvailability(_loc5_,"unavailable")) {
               _loc7_ = param1.isClassAvailability(_loc5_,"unrestricted");
               _loc6_ = this.boxes_[_loc3_];
               if(_loc6_) {
                  if(_loc7_ || param1.isLevelRequirementsMet(_loc3_)) {
                     _loc6_.unlock();
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function onBackClick(param1:Event) : void {
         this.close.dispatch();
      }
      
      private function onCharBoxOver(param1:MouseEvent) : void {
         var _loc2_:CharacterBox = param1.currentTarget as CharacterBox;
         _loc2_.setOver(true);
         this.tooltip.dispatch(_loc2_.getTooltip());
      }
      
      private function onCharBoxOut(param1:MouseEvent) : void {
         var _loc2_:CharacterBox = param1.currentTarget as CharacterBox;
         _loc2_.setOver(false);
         this.tooltip.dispatch(null);
      }
      
      private function onCharBoxClick(param1:MouseEvent) : void {
         this.tooltip.dispatch(null);
         var _loc2_:CharacterBox = param1.currentTarget.parent as CharacterBox;
         if(!_loc2_.available_) {
            return;
         }
         var _loc4_:int = _loc2_.objectType();
         var _loc3_:String = ObjectLibrary.typeToDisplayId_[_loc4_];
         this.selected.dispatch(_loc4_);
      }
   }
}
