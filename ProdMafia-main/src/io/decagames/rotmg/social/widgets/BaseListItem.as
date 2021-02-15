package io.decagames.rotmg.social.widgets {
   import com.company.assembleegameclient.ui.icons.IconButton;
   import com.company.assembleegameclient.ui.icons.IconButtonFactory;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   
   public class BaseListItem extends Sprite implements TooltipAble {
       
      
      protected const LIST_ITEM_WIDTH:int = 310;
      
      protected const LIST_ITEM_HEIGHT:int = 40;
      
      protected const ONLINE_COLOR:uint = 3407650;
      
      protected const OFFLINE_COLOR:uint = 11776947;
      
      protected var _characterContainer:Sprite;
      
      protected var hoverTooltipDelegate:HoverTooltipDelegate;
      
      protected var _state:int;
      
      protected var _iconButtonFactory:IconButtonFactory;
      
      protected var listBackground:SliceScalingBitmap;
      
      protected var listLabel:UILabel;
      
      protected var listPortrait:Bitmap;
      
      private var toolTip_:TextToolTip;
      
      public function BaseListItem(param1:int) {
         super();
         this._state = param1;
      }
      
      public function getLabelText() : String {
         return this.listLabel.text;
      }
      
      public function setToolTipTitle(param1:String, param2:Object = null) : void {
         if(param1 != "") {
            if(this.toolTip_ == null) {
               this.toolTip_ = new TextToolTip(3552822,10197915,"","",200);
               this.hoverTooltipDelegate.setDisplayObject(this._characterContainer);
               this.hoverTooltipDelegate.tooltip = this.toolTip_;
            }
            this.toolTip_.setTitle(new LineBuilder().setParams(param1,param2));
         }
      }
      
      public function setToolTipText(param1:String, param2:Object = null) : void {
         if(param1 != "") {
            if(this.toolTip_ == null) {
               this.toolTip_ = new TextToolTip(3552822,10197915,"","",200);
               this.hoverTooltipDelegate.setDisplayObject(this._characterContainer);
               this.hoverTooltipDelegate.tooltip = this.toolTip_;
            }
            this.toolTip_.setText(new LineBuilder().setParams(param1,param2));
         }
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
      
      protected function init() : void {
         this._iconButtonFactory = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
         this.hoverTooltipDelegate = new HoverTooltipDelegate();
         this.setBaseItemState();
         this._characterContainer = new Sprite();
         addChild(this._characterContainer);
      }
      
      protected function createListLabel(param1:String) : void {
         this.listLabel = new UILabel();
         this.listLabel.x = 40;
         this.listLabel.y = 12;
         this.listLabel.text = param1;
         this.setLabelColorByState(this.listLabel);
         this._characterContainer.addChild(this.listLabel);
      }
      
      protected function createListPortrait(param1:BitmapData) : void {
         this.listPortrait = new Bitmap(param1);
         this.listPortrait.x = -Math.round(this.listPortrait.width / 2) + 22;
         this.listPortrait.y = -Math.round(this.listPortrait.height / 2) + 20;
         if(this.listPortrait) {
            this._characterContainer.addChild(this.listPortrait);
         }
      }
      
      protected function setLabelColorByState(param1:UILabel) : void {
         var _loc2_:* = int(this._state) - 1;
         switch(_loc2_) {
            case 0:
               DefaultLabelFormat.friendsItemLabel(param1,3407650);
               return;
            case 1:
               DefaultLabelFormat.friendsItemLabel(param1,11776947);
               return;
            default:
               DefaultLabelFormat.defaultSmallPopupTitle(param1);
               return;
         }
      }
      
      protected function addButton(param1:String, param2:int, param3:int, param4:int, param5:String, param6:String = "") : IconButton {
         var _loc7_:* = null;
         _loc7_ = this._iconButtonFactory.create(AssetLibrary.getImageFromSet(param1,param2),"","","");
         _loc7_.setToolTipTitle(param5);
         _loc7_.setToolTipText(param6);
         _loc7_.x = param3;
         _loc7_.y = param4;
         addChild(_loc7_);
         return _loc7_;
      }
      
      private function setBaseItemState() : void {
         var _loc1_:* = int(this._state) - 1;
         switch(_loc1_) {
            case 0:
               this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI","listitem_content_background");
               addChild(this.listBackground);
               break;
            case 1:
               this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI","listitem_content_background_inactive");
               addChild(this.listBackground);
               break;
            case 2:
               this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI","listitem_content_background_indicator");
               addChild(this.listBackground);
         }
         this.listBackground.height = 40;
         this.listBackground.width = 310;
      }
   }
}
