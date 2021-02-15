package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.objects.SellableObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldConcreteBuilder;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.util.components.ItemWithTooltip;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import kabam.rotmg.util.components.UIAssetsHelper;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;
   
   public class ConfirmBuyModal extends Sprite {
      
      public static const WIDTH:int = 280;
      
      public static const HEIGHT:int = 240;
      
      public static const TEXT_MARGIN:int = 20;
      
      public static var free:Boolean = true;
       
      
      private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(280);
      
      private const buyButton:LegacyBuyButton = new LegacyBuyButton("SellableObjectPanel.buy",16,0,-1);
      
      public var buyItem:Signal;
      
      public var open:Boolean;
      
      public var buttonWidth:int;
      
      private var buyButtonClicked:NativeSignal;
      
      private var quantityInputText:TextFieldDisplayConcrete;
      
      private var leftNavSprite:Sprite;
      
      private var rightNavSprite:Sprite;
      
      private var quantity_:int = 1;
      
      private var availableInventoryNumber:int;
      
      private var owner_:SellableObject;
      
      public function ConfirmBuyModal(param1:Signal, param2:SellableObject, param3:Number, param4:int) {
         var _loc7_:* = null;
         var _loc6_:* = null;
         super();
         ConfirmBuyModal.free = false;
         this.buyItem = param1;
         this.owner_ = param2;
         this.buttonWidth = param3;
         this.availableInventoryNumber = param4;
         this.events();
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
         this.positionAndStuff();
         this.addChildren();
         this.buyButton.setPrice(this.owner_.price_,this.owner_.currency_);
         var _loc5_:String = this.owner_.soldObjectName();
         _loc6_ = new TextFieldConcreteBuilder();
         _loc6_.containerMargin = 20;
         _loc6_.containerWidth = 280;
         addChild(_loc6_.getLocalizedTextObject("ConfirmBuyModal.title",20,5));
         addChild(_loc6_.getLocalizedTextObject("ConfirmBuyModal.desc",20,40));
         addChild(_loc6_.getLocalizedTextObject(_loc5_,20,90));
         var _loc8_:TextFieldDisplayConcrete = _loc6_.getLocalizedTextObject("ConfirmBuyModal.amount",20,140);
         addChild(_loc8_);
         this.quantityInputText = _loc6_.getLiteralTextObject("1",20,160);
         if(this.owner_.getSellableType() != -1) {
            _loc7_ = new ItemWithTooltip(this.owner_.getSellableType(),64);
         }
         _loc7_.x = 140 - _loc7_.width / 2;
         _loc7_.y = 100;
         addChild(_loc7_);
         this.quantityInputText = _loc6_.getLiteralTextObject("1",20,160);
         this.quantityInputText.setMultiLine(false);
         addChild(this.quantityInputText);
         this.leftNavSprite = this.makeNavigator("left");
         this.rightNavSprite = this.makeNavigator("right");
         this.leftNavSprite.x = 101.818181818182 - this.rightNavSprite.width / 2;
         this.leftNavSprite.y = 150;
         addChild(this.leftNavSprite);
         this.rightNavSprite.x = 178.181818181818 - this.rightNavSprite.width / 2;
         this.rightNavSprite.y = 150;
         addChild(this.rightNavSprite);
         this.refreshNavDisable();
         this.open = true;
      }
      
      private static function makeModalBackground(param1:int, param2:int) : PopupWindowBackground {
         var _loc3_:PopupWindowBackground = new PopupWindowBackground();
         _loc3_.draw(param1,param2);
         _loc3_.divide("HORIZONTAL_DIVISION",30);
         return _loc3_;
      }
      
      public function onCloseClick() : void {
         this.close();
      }
      
      private function refreshNavDisable() : void {
         this.leftNavSprite.alpha = this.quantity_ == 1?0.5:1;
         this.rightNavSprite.alpha = this.quantity_ == this.availableInventoryNumber?0.5:1;
      }
      
      private function positionAndStuff() : void {
         this.x = -440;
         this.y = -320;
         this.buyButton.x = this.buyButton.x + 35;
         this.buyButton.y = this.buyButton.y + 195;
         this.buyButton.x = 140 - this.buttonWidth / 2;
      }
      
      private function events() : void {
         this.closeButton.clicked.add(this.onCloseClick);
         this.buyButtonClicked = new NativeSignal(this.buyButton,"click",MouseEvent);
         this.buyButtonClicked.add(this.onBuyClick);
      }
      
      private function addChildren() : void {
         addChild(makeModalBackground(280,240));
         addChild(this.closeButton);
         addChild(this.buyButton);
      }
      
      private function close() : void {
         parent.removeChild(this);
         ConfirmBuyModal.free = true;
         this.open = false;
      }
      
      private function makeNavigator(param1:String) : Sprite {
         var _loc2_:Sprite = UIAssetsHelper.createLeftNevigatorIcon(param1);
         _loc2_.addEventListener("click",this.onClick,false,0,true);
         return _loc2_;
      }
      
      public function onBuyClick(param1:MouseEvent) : void {
         this.owner_.quantity_ = this.quantity_;
         this.buyItem.dispatch(this.owner_);
         this.close();
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         ConfirmBuyModal.free = true;
         this.open = false;
         this.leftNavSprite.removeEventListener("click",this.onClick);
         this.rightNavSprite.removeEventListener("click",this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void {
         var _loc3_:* = param1.currentTarget;
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case this.rightNavSprite:
               if(this.quantity_ < this.availableInventoryNumber) {
                  this.quantity_ = this.quantity_ + 1;
                  break;
               }
               break;
            case this.leftNavSprite:
               if(this.quantity_ > 1) {
                  this.quantity_ = this.quantity_ - 1;
                  break;
               }
         }
         this.refreshNavDisable();
         var _loc2_:int = this.owner_.price_ * this.quantity_;
         this.buyButton.setPrice(_loc2_,this.owner_.currency_);
         this.quantityInputText.setText(this.quantity_.toString());
      }
   }
}
