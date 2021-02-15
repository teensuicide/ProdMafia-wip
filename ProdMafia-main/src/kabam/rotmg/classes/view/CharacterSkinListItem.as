package kabam.rotmg.classes.view {
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.CharacterSkinState;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   import kabam.rotmg.util.components.RadioButton;
   import kabam.rotmg.util.components.api.BuyButton;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class CharacterSkinListItem extends Sprite {
      
      public static const WIDTH:int = 420;
      
      public static const PADDING:int = 16;
      
      public static const HEIGHT:int = 60;
      
      private static const HIGHLIGHTED_COLOR:uint = 8092539;
      
      private static const AVAILABLE_COLOR:uint = 5921370;
      
      private static const LOCKED_COLOR:uint = 2631720;
       
      
      private const grayscaleMatrix:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
      
      private const background:Shape = makeBackground();
      
      private const skinContainer:Sprite = makeSkinContainer();
      
      private const nameText:TextFieldDisplayConcrete = makeNameText();
      
      private const selectionButton:RadioButton = makeSelectionButton();
      
      private const lock:Bitmap = makeLock();
      
      private const lockText:TextFieldDisplayConcrete = makeLockText();
      
      private const buyButtonContainer:Sprite = makeBuyButtonContainer();
      
      private const limitedBanner:CharacterSkinLimitedBanner = makeLimitedBanner();
      
      public const buy:Signal = new NativeMappedSignal(buyButtonContainer,"click");
      
      public const over:Signal = new Signal();
      
      public const out:Signal = new Signal();
      
      public const selected:Signal = selectionButton.changed;
      
      private var model:CharacterSkin;
      
      private var state:CharacterSkinState;
      
      private var isSelected:Boolean = false;
      
      private var skinIcon:Bitmap;
      
      private var buyButton:BuyButton;
      
      private var isOver:Boolean;
      
      public function CharacterSkinListItem() {
         state = CharacterSkinState.NULL;
         super();
      }
      
      public function setLockIcon(param1:BitmapData) : void {
         this.lock.bitmapData = param1;
         this.lock.x = this.lockText.x - this.lock.width - 5;
         this.lock.y = 30 - this.lock.height * 0.5;
         addChild(this.lock);
      }
      
      public function setBuyButton(param1:BuyButton) : void {
         this.buyButton = param1;
         param1.readyForPlacement.add(this.onReadyForPlacement);
         this.model && this.setCost();
         this.buyButtonContainer.addChild(param1);
         param1.x = -param1.width;
         param1.y = -param1.height * 0.5;
         this.buyButtonContainer.visible = this.state == CharacterSkinState.PURCHASABLE;
         this.setLimitedBannerVisibility();
      }
      
      public function setSkin(param1:Bitmap) : void {
         this.skinIcon && this.skinContainer.removeChild(this.skinIcon);
         this.skinIcon = param1;
         addChild(this.skinIcon);
      }
      
      public function getModel() : CharacterSkin {
         return this.model;
      }
      
      public function setModel(param1:CharacterSkin) : void {
         this.model && this.model.changed.remove(this.onModelChanged);
         this.model = param1;
         this.model && this.model.changed.add(this.onModelChanged);
         this.onModelChanged(this.model);
         addEventListener("mouseOver",this.onOver);
         addEventListener("mouseOut",this.onOut);
      }
      
      public function getState() : CharacterSkinState {
         return this.state;
      }
      
      public function getIsSelected() : Boolean {
         return this.isSelected;
      }
      
      public function setIsSelected(param1:Boolean) : void {
         this.isSelected = param1 && this.state == CharacterSkinState.OWNED;
         this.selectionButton.setSelected(param1);
         this.updateBackground();
      }
      
      public function setWidth(param1:int) : void {
         this.buyButtonContainer.x = param1 - 16;
         this.lockText.x = param1 - this.lockText.width - 15;
         this.lock.x = this.lockText.x - this.lock.width - 5;
         this.selectionButton.x = param1 - this.selectionButton.width - 15;
         this.setLimitedBannerVisibility();
         this.drawBackground(this.background.graphics,param1);
      }
      
      function removeEventListeners() : void {
         removeEventListener("click",this.onClick);
      }
      
      private function makeBackground() : Shape {
         var _loc1_:Shape = new Shape();
         this.drawBackground(_loc1_.graphics,420);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeSkinContainer() : Sprite {
         var _loc1_:* = null;
         _loc1_ = new Sprite();
         _loc1_.x = 8;
         _loc1_.y = 4;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeNameText() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true);
         _loc1_.x = 75;
         _loc1_.y = 15;
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeSelectionButton() : RadioButton {
         var _loc1_:* = null;
         _loc1_ = new RadioButton();
         _loc1_.setSelected(false);
         _loc1_.x = 420 - _loc1_.width - 15;
         _loc1_.y = 30 - _loc1_.height / 2;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeLock() : Bitmap {
         var _loc1_:Bitmap = new Bitmap();
         _loc1_.scaleX = 2;
         _loc1_.scaleY = 2;
         _loc1_.visible = false;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeLockText() : TextFieldDisplayConcrete {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(14).setColor(16777215);
         _loc1_.setVerticalAlign("middle");
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeBuyButtonContainer() : Sprite {
         var _loc1_:Sprite = new Sprite();
         _loc1_.x = 404;
         _loc1_.y = 30;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeLimitedBanner() : CharacterSkinLimitedBanner {
         var _loc1_:* = null;
         _loc1_ = new CharacterSkinLimitedBanner();
         _loc1_.readyForPositioning.addOnce(this.setLimitedBannerVisibility);
         _loc1_.y = -1;
         _loc1_.visible = false;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function onReadyForPlacement() : void {
         this.buyButton.x = -this.buyButton.width;
      }
      
      private function onModelChanged(param1:CharacterSkin) : void {
         this.state = !!this.model?this.model.getState():CharacterSkinState.NULL;
         this.updateName();
         this.updateState();
         this.buyButton && this.setCost();
         this.updateUnlockText();
         this.setLimitedBannerVisibility();
         this.setIsSelected(this.model && this.model.getIsSelected());
      }
      
      private function updateName() : void {
         this.nameText.setStringBuilder(new LineBuilder().setParams(!!this.model?this.model.name:""));
      }
      
      private function updateState() : void {
         this.setButtonVisibilities();
         this.updateBackground();
         this.setEventListeners();
         this.updateGrayFilter();
      }
      
      private function setLimitedBannerVisibility() : void {
         this.limitedBanner.visible = false;
         this.limitedBanner.x = (this.state == CharacterSkinState.LOCKED || !this.buyButton?this.lock.x - 5:Number(this.buyButtonContainer.x + this.buyButton.x - 15)) - this.limitedBanner.width;
      }
      
      private function setButtonVisibilities() : void {
         var _loc4_:* = this.state == CharacterSkinState.OWNED;
         var _loc1_:* = this.state == CharacterSkinState.PURCHASABLE;
         var _loc3_:* = this.state == CharacterSkinState.PURCHASING;
         var _loc2_:* = this.state == CharacterSkinState.LOCKED;
         this.selectionButton.visible = _loc4_;
         this.lock.visible = _loc2_;
         this.lockText.visible = _loc2_ || _loc3_;
      }
      
      private function setEventListeners() : void {
         if(this.state == CharacterSkinState.OWNED) {
            this.addEventListeners();
         } else {
            this.removeEventListeners();
         }
      }
      
      private function setCost() : void {
         var _loc1_:int = !!this.model?this.model.cost:0;
         this.buyButton.setPrice(_loc1_,0);
      }
      
      private function updateUnlockText() : void {
         if(this.model != null && this.model.unlockSpecial != null) {
            this.lockText.setStringBuilder(new StaticStringBuilder(this.model.unlockSpecial));
            this.lockText.setTextWidth(110);
            this.lockText.setWordWrap(true);
            this.lockText.setMultiLine(true);
            this.lockText.setAutoSize("left");
            this.lockText.setHorizontalAlign("left");
            this.lockText.setVerticalAlign("center");
            this.lockText.y = 8.57142857142858;
         } else {
            this.lockText.setStringBuilder(this.state == CharacterSkinState.PURCHASING?new LineBuilder().setParams("CharacterSkinListItem.purchasing"):this.makeUnlockTextStringBuilder());
            this.lockText.y = 30;
         }
         this.lockText.x = 420 - this.lockText.width - 15;
         this.lock.x = this.lockText.x - this.lock.width - 5;
      }
      
      private function makeUnlockTextStringBuilder() : StringBuilder {
         var _loc2_:LineBuilder = new LineBuilder();
         var _loc1_:String = !!this.model?this.model.unlockLevel.toString():"";
         return _loc2_.setParams("CharacterSkinListItem.unlock",{"level":_loc1_});
      }
      
      private function addEventListeners() : void {
         addEventListener("click",this.onClick);
      }
      
      private function updateBackground() : void {
         var _loc1_:ColorTransform = this.background.transform.colorTransform;
         _loc1_.color = this.getColor();
         this.background.transform.colorTransform = _loc1_;
      }
      
      private function getColor() : uint {
         if(this.state.isDisabled()) {
            return 2631720;
         }
         if(this.isSelected || this.isOver) {
            return 8092539;
         }
         return 5921370;
      }
      
      private function updateGrayFilter() : void {
         filters = this.state == CharacterSkinState.PURCHASING?[this.grayscaleMatrix]:[];
      }
      
      private function drawBackground(param1:Graphics, param2:int) : void {
         param1.clear();
         param1.beginFill(5921370);
         param1.drawRect(0,0,param2,60);
         param1.endFill();
      }
      
      private function onClick(param1:MouseEvent) : void {
         this.setIsSelected(true);
      }
      
      private function onOver(param1:MouseEvent) : void {
         this.isOver = true;
         this.updateBackground();
         this.over.dispatch();
      }
      
      private function onOut(param1:MouseEvent) : void {
         this.isOver = false;
         this.updateBackground();
         this.out.dispatch();
      }
   }
}
