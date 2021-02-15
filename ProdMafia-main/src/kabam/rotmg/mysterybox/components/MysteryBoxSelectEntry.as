package kabam.rotmg.mysterybox.components {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import kabam.rotmg.util.components.UIAssetsHelper;
   
   public class MysteryBoxSelectEntry extends Sprite {
      
      public static var redBarEmbed:Class = MysteryBoxSelectEntry_redBarEmbed;
       
      
      private const newString:String = "MysteryBoxSelectEntry.newString";
      
      private const onSaleString:String = "MysteryBoxSelectEntry.onSaleString";
      
      private const saleEndString:String = "MysteryBoxSelectEntry.saleEndString";
      
      public var mbi:MysteryBoxInfo;
      
      private var buyButton:LegacyBuyButton;
      
      private var leftNavSprite:Sprite;
      
      private var rightNavSprite:Sprite;
      
      private var iconImage:DisplayObject;
      
      private var infoImageBorder:PopupWindowBackground;
      
      private var infoImage:DisplayObject;
      
      private var newText:TextFieldDisplayConcrete;
      
      private var sale:TextFieldDisplayConcrete;
      
      private var left:TextFieldDisplayConcrete;
      
      private var hoverState:Boolean = false;
      
      private var descriptionShowing:Boolean = false;
      
      private var redbar:DisplayObject;
      
      private var soldOut:Boolean;
      
      private var _quantity:int;
      
      private var title:TextFieldDisplayConcrete;
      
      public function MysteryBoxSelectEntry(param1:MysteryBoxInfo) {
         var _loc2_:* = null;
         super();
         this.redbar = new redBarEmbed();
         this.redbar.y = -5;
         this.redbar.width = MysteryBoxSelectModal.modalWidth - 5;
         this.redbar.height = MysteryBoxSelectModal.aMysteryBoxHeight - 8;
         addChild(this.redbar);
         _loc2_ = new redBarEmbed();
         _loc2_.y = 0;
         _loc2_.width = MysteryBoxSelectModal.modalWidth - 5;
         _loc2_.height = MysteryBoxSelectModal.aMysteryBoxHeight - 8 + 5;
         _loc2_.alpha = 0;
         addChild(_loc2_);
         this.mbi = param1;
         this._quantity = 1;
         this.title = this.getText(this.mbi.title,74,20,18,true);
         this.title.textChanged.addOnce(this.updateTextPosition);
         addChild(this.title);
         this.addNewText();
         this.buyButton = new LegacyBuyButton("",16,0,-1,false,this.mbi.isOnSale());
         if(this.mbi.unitsLeft == 0) {
            this.buyButton.setText(LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutButton"));
         } else if(this.mbi.isOnSale()) {
            this.buyButton.setPrice(this.mbi.saleAmount,this.mbi.saleCurrency);
         } else {
            this.buyButton.setPrice(this.mbi.priceAmount,this.mbi.priceCurrency);
         }
         this.buyButton.x = MysteryBoxSelectModal.modalWidth - 120;
         this.buyButton.y = 16;
         this.buyButton._width = 70;
         this.addSaleText();
         if(this.mbi.unitsLeft > 0 || this.mbi.unitsLeft == -1) {
            this.buyButton.addEventListener("click",this.onBoxBuy);
         }
         addChild(this.buyButton);
         this.iconImage = this.mbi.iconImage;
         this.infoImage = this.mbi.infoImage;
         if(this.iconImage == null) {
            this.mbi.loader.contentLoaderInfo.addEventListener("complete",this.onImageLoadComplete);
         } else {
            this.addIconImageChild();
         }
         if(this.infoImage == null) {
            this.mbi.infoImageLoader.contentLoaderInfo.addEventListener("complete",this.onInfoLoadComplete);
         } else {
            this.addInfoImageChild();
         }
         this.mbi.quantity = this._quantity;
         if(this.mbi.unitsLeft > 0 || this.mbi.unitsLeft == -1) {
            this.leftNavSprite = UIAssetsHelper.createLeftNevigatorIcon("left",3);
            this.leftNavSprite.x = this.buyButton.x + this.buyButton.width + 45;
            this.leftNavSprite.y = this.buyButton.y + this.buyButton.height / 2 - 2;
            this.leftNavSprite.addEventListener("click",this.onClick);
            addChild(this.leftNavSprite);
            this.rightNavSprite = UIAssetsHelper.createLeftNevigatorIcon("right",3);
            this.rightNavSprite.x = this.buyButton.x + this.buyButton.width + 45;
            this.rightNavSprite.y = this.buyButton.y + this.buyButton.height / 2 - 16;
            this.rightNavSprite.addEventListener("click",this.onClick);
            addChild(this.rightNavSprite);
         }
         this.addUnitsLeftText();
         addEventListener("rollOver",this.onHover);
         addEventListener("rollOut",this.onRemoveHover);
         addEventListener("enterFrame",this.onEnterFrame);
      }
      
      public function updateContent() : void {
         if(this.left) {
            this.left.setStringBuilder(new LineBuilder().setParams(this.mbi.unitsLeft + " " + LineBuilder.getLocalizedStringFromKey("MysteryBoxSelectEntry.left")));
         }
      }
      
      public function getText(param1:String, param2:int, param3:int, param4:int = 12, param5:Boolean = false) : TextFieldDisplayConcrete {
         var _loc6_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(param4).setColor(16777215).setTextWidth(MysteryBoxSelectModal.modalWidth - 185);
         _loc6_.setBold(true);
         if(param5) {
            _loc6_.setStringBuilder(new StaticStringBuilder(param1));
         } else {
            _loc6_.setStringBuilder(new LineBuilder().setParams(param1));
         }
         _loc6_.setWordWrap(true);
         _loc6_.setMultiLine(true);
         _loc6_.setAutoSize("left");
         _loc6_.setHorizontalAlign("left");
         _loc6_.filters = [new DropShadowFilter(0,0,0)];
         _loc6_.x = param2;
         _loc6_.y = param3;
         return _loc6_;
      }
      
      private function updateTextPosition() : void {
         this.title.y = Math.round((this.redbar.height - (this.title.getTextHeight() + (this.title.textField.numLines == 1?8:10))) / 2);
         if((this.mbi.isNew() || this.mbi.isOnSale()) && this.title.textField.numLines == 2) {
            this.title.y = this.title.y + 6;
         }
      }
      
      private function addUnitsLeftText() : void {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(this.mbi.unitsLeft >= 0) {
            _loc1_ = this.mbi.unitsLeft / this.mbi.totalUnits;
            if(_loc1_ <= 0.1) {
               _loc2_ = 16711680;
            } else if(_loc1_ <= 0.5) {
               _loc2_ = 16754944;
            } else {
               _loc2_ = 65280;
            }
            this.left = this.getText(this.mbi.unitsLeft + " left",20,46,11).setColor(_loc2_);
            addChild(this.left);
         }
      }
      
      private function markAsSold() : void {
         this.buyButton.setPrice(0,-1);
         this.buyButton.setText(LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutButton"));
         if(this.leftNavSprite && this.leftNavSprite.parent == this) {
            removeChild(this.leftNavSprite);
            this.leftNavSprite.removeEventListener("click",this.onClick);
         }
         if(this.rightNavSprite && this.rightNavSprite.parent == this) {
            removeChild(this.rightNavSprite);
            this.rightNavSprite.removeEventListener("click",this.onClick);
         }
      }
      
      private function addNewText() : void {
         if(this.mbi.isNew() && !this.mbi.isOnSale()) {
            this.newText = this.getText("MysteryBoxSelectEntry.newString",74,0).setColor(16768512);
            addChild(this.newText);
         }
      }
      
      private function addSaleText() : void {
         var _loc1_:* = null;
         if(this.mbi.isOnSale()) {
            this.sale = this.getText("MysteryBoxSelectEntry.onSaleString",74,0).setColor(65280);
            addChild(this.sale);
            _loc1_ = this.getText(LineBuilder.getLocalizedStringFromKey("MysteryBoxSelectEntry.was") + " " + this.mbi.priceAmount + " " + this.mbi.currencyName,this.buyButton.x,this.buyButton.y - 14,10).setColor(16711680);
            addChild(_loc1_);
         }
      }
      
      private function addIconImageChild() : void {
         if(this.iconImage == null) {
            return;
         }
         this.iconImage.width = 58;
         this.iconImage.height = 58;
         this.iconImage.x = 14;
         if(this.mbi.unitsLeft != -1) {
            this.iconImage.y = -6;
         } else {
            this.iconImage.y = 1;
         }
         addChild(this.iconImage);
      }
      
      private function addInfoImageChild() : void {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(this.infoImage == null) {
            return;
         }
         this.infoImage.width = 283;
         this.infoImage.height = 580;
         var _loc1_:Point = this.globalToLocal(new Point(MysteryBoxSelectModal.getRightBorderX() + 1 + 14,10));
         this.infoImage.x = _loc1_.x;
         this.infoImage.y = _loc1_.y;
         if(this.hoverState && !this.descriptionShowing) {
            this.descriptionShowing = true;
            addChild(this.infoImage);
            this.infoImageBorder = new PopupWindowBackground();
            this.infoImageBorder.draw(this.infoImage.width,this.infoImage.height + 2,2);
            this.infoImageBorder.x = this.infoImage.x;
            this.infoImageBorder.y = this.infoImage.y - 1;
            addChild(this.infoImageBorder);
            _loc3_ = [3.0742,-1.8282,-0.246,0,50,-0.9258,2.1718,-0.246,0,50,-0.9258,-1.8282,3.754,0,50,0,0,0,1,0];
            _loc2_ = new ColorMatrixFilter(_loc3_);
            this.redbar.filters = [_loc2_];
         }
      }
      
      private function removeInfoImageChild() : void {
         if(this.descriptionShowing) {
            removeChild(this.infoImageBorder);
            removeChild(this.infoImage);
            this.descriptionShowing = false;
            this.redbar.filters = [];
         }
      }
      
      private function onHover(param1:MouseEvent) : void {
         this.hoverState = true;
         this.addInfoImageChild();
      }
      
      private function onRemoveHover(param1:MouseEvent) : void {
         this.hoverState = false;
         this.removeInfoImageChild();
      }
      
      private function onClick(param1:MouseEvent) : void {
         var _loc2_:* = param1.currentTarget;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case this.rightNavSprite:
               if(this._quantity == 1) {
                  this._quantity = this._quantity + 4;
                  break;
               }
               if(this._quantity < 10) {
                  this._quantity = this._quantity + 5;
                  break;
               }
               break;
            case this.leftNavSprite:
               if(this._quantity == 10) {
                  this._quantity = this._quantity - 5;
                  break;
               }
               if(this._quantity > 1) {
                  this._quantity = this._quantity - 4;
                  break;
               }
               break;
         }
         this.mbi.quantity = this._quantity;
         if(this.mbi.isOnSale()) {
            this.buyButton.setPrice(this.mbi.saleAmount * this._quantity,this.mbi.saleCurrency);
         } else {
            this.buyButton.setPrice(this.mbi.priceAmount * this._quantity,this.mbi.priceCurrency);
         }
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc2_:Number = 1.05 + 0.05 * Math.sin(TimeUtil.getTrueTime() / 200);
         if(this.sale) {
            this.sale.scaleX = _loc2_;
            this.sale.scaleY = _loc2_;
         }
         if(this.newText) {
            this.newText.scaleX = _loc2_;
            this.newText.scaleY = _loc2_;
         }
         if(this.mbi.unitsLeft == 0 && !this.soldOut) {
            this.soldOut = true;
            this.markAsSold();
         }
      }
      
      private function onImageLoadComplete(param1:Event) : void {
         this.mbi.loader.contentLoaderInfo.removeEventListener("complete",this.onImageLoadComplete);
         this.iconImage = DisplayObject(this.mbi.loader);
         this.addIconImageChild();
      }
      
      private function onInfoLoadComplete(param1:Event) : void {
         this.mbi.infoImageLoader.contentLoaderInfo.removeEventListener("complete",this.onInfoLoadComplete);
         this.infoImage = DisplayObject(this.mbi.infoImageLoader);
         this.addInfoImageChild();
      }
      
      private function onBoxBuy(param1:MouseEvent) : void {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc6_:Boolean = false;
         if(this.mbi.unitsLeft != -1 && this._quantity > this.mbi.unitsLeft) {
            _loc2_ = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _loc4_ = "";
            if(this.mbi.unitsLeft == 0) {
               _loc4_ = "MysteryBoxError.soldOutAll";
            } else {
               _loc4_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft",{
                  "left":this.mbi.unitsLeft,
                  "box":(this.mbi.unitsLeft == 1?LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box"):LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
               });
            }
            _loc5_ = new Dialog("MysteryBoxRollModal.purchaseFailedString",_loc4_,"MysteryBoxRollModal.okString",null,null);
            _loc5_.addEventListener("dialogLeftButton",this.onErrorOk);
            _loc2_.dispatch(_loc5_);
         } else {
            _loc3_ = new MysteryBoxRollModal(this.mbi,this._quantity);
            _loc6_ = _loc3_.moneyCheckPass();
            if(_loc6_) {
               _loc3_.parentSelectModal = MysteryBoxSelectModal(parent.parent);
               _loc2_ = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
               _loc2_.dispatch(_loc3_);
            }
         }
      }
      
      private function onErrorOk(param1:Event) : void {
         var _loc2_:* = null;
         _loc2_ = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
         _loc2_.dispatch(new MysteryBoxSelectModal());
      }
   }
}
