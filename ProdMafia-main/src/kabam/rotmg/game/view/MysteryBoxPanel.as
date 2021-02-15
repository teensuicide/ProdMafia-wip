package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.SellableObject;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.util.Currency;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.shop.ShopPopupView;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.view.RegisterPromptDialog;
   import kabam.rotmg.arena.util.ArenaViewAssetFactory;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
   import kabam.rotmg.mysterybox.services.MysteryBoxModel;
   import kabam.rotmg.packages.services.GetPackagesTask;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import org.osflash.signals.Signal;
   import org.swiftsuspenders.Injector;
   
   public class MysteryBoxPanel extends Panel {
       
      
      private const BUTTON_OFFSET:int = 17;
      
      public var buyItem:Signal;
      
      private var owner_:SellableObject;
      
      private var nameText_:TextFieldDisplayConcrete;
      
      private var buyButton_:LegacyBuyButton;
      
      private var infoButton_:DeprecatedTextButton;
      
      private var icon_:Sprite;
      
      private var bitmap_:Bitmap;
      
      public function MysteryBoxPanel(param1:GameSprite, param2:uint) {
         buyItem = new Signal(SellableObject);
         var _loc5_:Injector = StaticInjectorContext.getInjector();
         var _loc7_:GetMysteryBoxesTask = _loc5_.getInstance(GetMysteryBoxesTask);
         _loc7_.start();
         var _loc3_:GetPackagesTask = _loc5_.getInstance(GetPackagesTask);
         _loc3_.start();
         super(param1);
         this.nameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(144);
         this.nameText_.setBold(true);
         this.nameText_.setStringBuilder(new LineBuilder().setParams("SellableObjectPanel.text"));
         this.nameText_.setWordWrap(true);
         this.nameText_.setMultiLine(true);
         this.nameText_.setAutoSize("center");
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText_);
         this.icon_ = new Sprite();
         addChild(this.icon_);
         this.bitmap_ = new Bitmap(null);
         this.icon_.addChild(this.bitmap_);
         var _loc4_:MysteryBoxModel = _loc5_.getInstance(MysteryBoxModel);
         var _loc6_:Account = _loc5_.getInstance(Account);
         if(_loc4_.isInitialized() || !_loc6_.isRegistered()) {
            this.infoButton_ = new DeprecatedTextButton(16,"MysteryBoxPanel.open");
            this.infoButton_.addEventListener("click",this.onInfoButtonClick);
            addChild(this.infoButton_);
         } else {
            this.infoButton_ = new DeprecatedTextButton(16,"MysteryBoxPanel.checkBackLater");
            addChild(this.infoButton_);
         }
         this.nameText_.setStringBuilder(new LineBuilder().setParams("Shop"));
         this.bitmap_.bitmapData = ArenaViewAssetFactory.returnHostBitmap(param2).bitmapData;
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      override public function draw() : void {
         this.nameText_.y = this.nameText_.height > 30?0:12;
         this.infoButton_.x = 94 - this.infoButton_.width / 2;
         this.infoButton_.y = 84 - this.infoButton_.height / 2 - 17;
         if(!contains(this.infoButton_)) {
            addChild(this.infoButton_);
         }
      }
      
      public function setOwner(param1:SellableObject) : void {
         if(param1 == this.owner_) {
            return;
         }
         this.owner_ = param1;
         this.buyButton_.setPrice(this.owner_.price_,this.owner_.currency_);
         var _loc2_:String = this.owner_.soldObjectName();
         this.nameText_.setStringBuilder(new LineBuilder().setParams(_loc2_));
         this.bitmap_.bitmapData = this.owner_.getIcon();
      }
      
      private function onInfoButton() : void {
         var _loc2_:* = null;
         var _loc5_:Injector = StaticInjectorContext.getInjector();
         var _loc1_:MysteryBoxModel = _loc5_.getInstance(MysteryBoxModel);
         var _loc3_:Account = _loc5_.getInstance(Account);
         var _loc4_:OpenDialogSignal = _loc5_.getInstance(OpenDialogSignal);
         if(_loc1_.isInitialized() && _loc3_.isRegistered()) {
            _loc2_ = _loc5_.getInstance(ShowPopupSignal);
            _loc2_.dispatch(new ShopPopupView());
         } else if(!_loc3_.isRegistered()) {
            _loc4_.dispatch(new RegisterPromptDialog("SellableObjectPanelMediator.text",{"type":Currency.typeToName(0)}));
         }
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("keyDown",this.onKeyDown);
         this.icon_.x = -4;
         this.icon_.y = -8;
         this.nameText_.x = 44;
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown);
         this.infoButton_.removeEventListener("click",this.onInfoButtonClick);
      }
      
      private function onInfoButtonClick(param1:MouseEvent) : void {
         this.onInfoButton();
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            this.onInfoButton();
         }
      }
   }
}
