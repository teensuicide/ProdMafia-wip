package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.Merchant;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.SellableObject;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.ConfirmBuyModal;
   import com.company.assembleegameclient.ui.RankText;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.util.GuildUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.nexusShop.NexusShopPopupView;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import org.osflash.signals.Signal;
   
   public class SellableObjectPanel extends Panel implements TooltipAble {
       
      
      private const BUTTON_OFFSET:int = 17;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var closePopupByClassSignal:ClosePopupByClassSignal;
      
      public var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public var buyItem:Signal;
      
      private var owner_:SellableObject;
      
      private var nameText_:TextFieldDisplayConcrete;
      
      private var buyButton_:LegacyBuyButton;
      
      private var rankReqText_:Sprite;
      
      private var guildRankReqText_:TextFieldDisplayConcrete;
      
      private var icon_:Sprite;
      
      private var bitmap_:Bitmap;
      
      private var confirmBuyModal:ConfirmBuyModal;
      
      private var availableInventoryNumber:int;
      
      public function SellableObjectPanel(param1:GameSprite, param2:SellableObject) {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         buyItem = new Signal(SellableObject);
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
         this.buyButton_ = new LegacyBuyButton("SellableObjectPanel.buy",16,0,-1);
         this.buyButton_.addEventListener("click",this.onBuyButtonClick);
         addChild(this.buyButton_);
         this.setOwner(param2);
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
         this.hoverTooltipDelegate.setDisplayObject(this);
         this.hoverTooltipDelegate.tooltip = param2.getTooltip();
      }
      
      private static function createRankReqText(param1:int) : Sprite {
         _arg_1 = param1;
         var _arg_1:int = _arg_1;
         var param1:int = _arg_1;
         var rankReq:int = param1;
         var rankReqText:Sprite = new Sprite();
         var requiredText:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setBold(true).setAutoSize("center");
         requiredText.filters = [new DropShadowFilter(0,0,0)];
         rankReqText.addChild(requiredText);
         var rankText:Sprite = new RankText(rankReq,false,false);
         rankReqText.addChild(rankText);
         requiredText.textChanged.addOnce(function():void {
            rankText.x = requiredText.width * 0.5 + 4;
            rankText.y = -rankText.height / 2;
         });
         requiredText.setStringBuilder(new LineBuilder().setParams("SellableObjectPanel.requireRankSprite"));
         return rankReqText;
      }
      
      private static function createGuildRankReqText(param1:int) : TextFieldDisplayConcrete {
         var _loc2_:* = null;
         _loc2_ = new TextFieldDisplayConcrete().setSize(16).setColor(16711680).setBold(true).setAutoSize("center");
         var _loc3_:String = GuildUtil.rankToString(param1);
         _loc2_.setStringBuilder(new LineBuilder().setParams("SellableObjectPanel.requireRank",{"amount":_loc3_}));
         _loc2_.filters = [new DropShadowFilter(0,0,0)];
         return _loc2_;
      }
      
      override public function draw() : void {
         var _loc2_:Player = gs_.map.player_;
         this.nameText_.y = this.nameText_.height > 30?0:12;
         var _loc1_:int = this.owner_.rankReq_;
         if(_loc2_.numStars_ < _loc1_) {
            if(contains(this.buyButton_)) {
               removeChild(this.buyButton_);
            }
            if(this.rankReqText_ == null || !contains(this.rankReqText_)) {
               this.rankReqText_ = createRankReqText(_loc1_);
               this.rankReqText_.x = 94 - this.rankReqText_.width / 2;
               this.rankReqText_.y = 84 - this.rankReqText_.height / 2 - 20;
               addChild(this.rankReqText_);
            }
         } else if(_loc2_.guildRank_ < this.owner_.guildRankReq_) {
            if(contains(this.buyButton_)) {
               removeChild(this.buyButton_);
            }
            if(this.guildRankReqText_ == null || !contains(this.guildRankReqText_)) {
               this.guildRankReqText_ = createGuildRankReqText(this.owner_.guildRankReq_);
               this.guildRankReqText_.x = 94 - this.guildRankReqText_.width / 2;
               this.guildRankReqText_.y = 84 - this.guildRankReqText_.height / 2 - 20;
               addChild(this.guildRankReqText_);
            }
         } else {
            this.buyButton_.setPrice(this.owner_.price_,this.owner_.currency_);
            this.buyButton_.setEnabled(gs_.gsc_.outstandingBuy_ == null);
            this.buyButton_.x = int(94 - this.buyButton_.width / 2);
            this.buyButton_.y = 84 - this.buyButton_.height / 2 - 17;
            if(!contains(this.buyButton_)) {
               addChild(this.buyButton_);
            }
            if(this.rankReqText_ != null && contains(this.rankReqText_)) {
               removeChild(this.rankReqText_);
            }
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
      
      public function setInventorySpaceAmount(param1:int) : void {
         this.availableInventoryNumber = param1;
      }
      
      public function setShowToolTipSignal(param1:ShowTooltipSignal) : void {
         this.hoverTooltipDelegate.setShowToolTipSignal(param1);
      }
      
      public function getShowToolTip() : ShowTooltipSignal {
         return this.hoverTooltipDelegate.getShowToolTip();
      }
      
      public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void {
         this.hoverTooltipDelegate.setHideToolTipsSignal(param1);
      }
      
      public function getHideToolTips() : HideTooltipsSignal {
         return this.hoverTooltipDelegate.getHideToolTips();
      }
      
      private function buyEvent() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:Account = StaticInjectorContext.getInjector().getInstance(Account);
         if(parent != null && _loc2_.isRegistered() && this.owner_ is Merchant) {
            _loc1_ = StaticInjectorContext.getInjector();
            _loc3_ = _loc1_.getInstance(ShowPopupSignal);
            _loc3_.dispatch(new NexusShopPopupView(this.buyItem,this.owner_,this.buyButton_.width,this.availableInventoryNumber));
         } else {
            this.buyItem.dispatch(this.owner_);
         }
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("keyDown",this.onKeyDown);
         this.icon_.x = -4;
         this.icon_.y = -8;
         this.nameText_.x = 44;
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         stage.removeEventListener("keyDown",this.onKeyDown);
         if(NexusShopPopupView != null) {
            _loc2_ = StaticInjectorContext.getInjector();
            _loc3_ = _loc2_.getInstance(ClosePopupByClassSignal);
            _loc3_.dispatch(NexusShopPopupView);
         }
         if(parent != null && this.confirmBuyModal != null && this.confirmBuyModal.open) {
            parent.removeChild(this.confirmBuyModal);
         }
      }
      
      private function onBuyButtonClick(param1:MouseEvent) : void {
         if(ConfirmBuyModal.free) {
            this.buyEvent();
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null && ConfirmBuyModal.free) {
            this.buyEvent();
         }
      }
   }
}
