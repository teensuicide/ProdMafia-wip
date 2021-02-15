package io.decagames.rotmg.social {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import io.decagames.rotmg.social.widgets.FriendListItem;
   import io.decagames.rotmg.social.widgets.GuildInfoItem;
   import io.decagames.rotmg.social.widgets.GuildListItem;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.scroll.UIScrollbar;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.tabs.TabButton;
   import io.decagames.rotmg.ui.tabs.UITab;
   import io.decagames.rotmg.ui.tabs.UITabs;
   import io.decagames.rotmg.ui.textField.InputTextField;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class SocialPopupView extends ModalPopup {
      
      public static const SOCIAL_LABEL:String = "Social";
      
      public static const FRIEND_TAB_LABEL:String = "Friends";
      
      public static const GUILD_TAB_LABEL:String = "Guild";
      
      public static const MAX_VISIBLE_INVITATIONS:int = 3;
      
      public static const DEFAULT_NO_GUILD_MESSAGE:String = "You have not yet joined a Guild,\njoin a Guild to find Players to play with or\n create your own Guild.";
       
      
      public var search:InputTextField;
      
      public var addButton:SliceScalingButton;
      
      private var contentInset:SliceScalingBitmap;
      
      private var friendsGrid:UIGrid;
      
      private var guildsGrid:UIGrid;
      
      private var _tabContent:Sprite;
      
      private var _tabs:UITabs;
      
      public function SocialPopupView() {
         super(350,505,"Social",DefaultLabelFormat.defaultSmallPopupTitle,new Rectangle(0,0,350,565));
         this.init();
      }
      
      public function get tabs() : UITabs {
         return this._tabs;
      }
      
      public function addFriendCategory(param1:String) : void {
         var _loc3_:* = null;
         var _loc2_:UIGridElement = new UIGridElement();
         _loc3_ = new UILabel();
         _loc3_.text = param1;
         DefaultLabelFormat.defaultSmallPopupTitle(_loc3_);
         _loc2_.addChild(_loc3_);
         this.friendsGrid.addGridElement(_loc2_);
      }
      
      public function addFriend(param1:FriendListItem) : void {
         var _loc2_:UIGridElement = new UIGridElement();
         _loc2_.addChild(param1);
         this.friendsGrid.addGridElement(_loc2_);
      }
      
      public function addGuildInfo(param1:GuildInfoItem) : void {
         var _loc2_:* = null;
         _loc2_ = new UIGridElement();
         _loc2_.addChild(param1);
         _loc2_.x = (_contentWidth - _loc2_.width) / 2;
         _loc2_.y = 10;
         this._tabContent.addChild(_loc2_);
      }
      
      public function addGuildCategory(param1:String) : void {
         var _loc2_:UIGridElement = new UIGridElement();
         var _loc3_:UILabel = new UILabel();
         _loc3_.text = param1;
         DefaultLabelFormat.defaultSmallPopupTitle(_loc3_);
         _loc2_.addChild(_loc3_);
         this.guildsGrid.addGridElement(_loc2_);
      }
      
      public function addGuildDefaultMessage(param1:String) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _loc2_ = new UIGridElement();
         _loc3_ = new UILabel();
         _loc3_.width = 300;
         _loc3_.multiline = true;
         _loc3_.wordWrap = true;
         _loc3_.text = param1;
         _loc3_.x = 5;
         DefaultLabelFormat.guildInfoLabel(_loc3_,14,11776947,"center");
         _loc2_.addChild(_loc3_);
         this.guildsGrid.addGridElement(_loc2_);
      }
      
      public function addGuildMember(param1:GuildListItem) : void {
         var _loc2_:UIGridElement = new UIGridElement();
         _loc2_.addChild(param1);
         this.guildsGrid.addGridElement(_loc2_);
      }
      
      public function addInvites(param1:FriendListItem) : void {
         var _loc2_:UIGridElement = new UIGridElement();
         _loc2_.addChild(param1);
         this.friendsGrid.addGridElement(_loc2_);
      }
      
      public function showInviteIndicator(param1:Boolean, param2:String) : void {
         var _loc3_:TabButton = this._tabs.getTabButtonByLabel(param2);
         if(_loc3_) {
            _loc3_.showIndicator = param1;
         }
      }
      
      public function clearFriendsList() : void {
         this.friendsGrid.clearGrid();
         this.showInviteIndicator(false,"Friends");
      }
      
      public function clearGuildList() : void {
         this.guildsGrid.clearGrid();
         this.showInviteIndicator(false,"Guild");
      }
      
      private function init() : void {
         this.friendsGrid = new UIGrid(350,1,3);
         this.friendsGrid.x = 9;
         this.friendsGrid.y = 15;
         this.guildsGrid = new UIGrid(350,1,3);
         this.guildsGrid.x = 9;
         this.createContentInset();
         this.createContentTabs();
         this.addTabs();
      }
      
      private function addTabs() : void {
         this._tabs = new UITabs(350,true);
         var _loc2_:Sprite = new Sprite();
         this._tabs.addTab(this.createTab("Friends",_loc2_,this.friendsGrid,true),true);
         var _loc1_:Sprite = new Sprite();
         this._tabs.addTab(this.createTab("Guild",_loc1_,this.guildsGrid),false);
         this._tabs.y = 6;
         this._tabs.x = 0;
         addChild(this._tabs);
      }
      
      private function createContentTabs() : void {
         var _loc1_:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","tab_inset_content_background",350);
         _loc1_.height = 45;
         _loc1_.x = 0;
         _loc1_.y = 5;
         addChild(_loc1_);
      }
      
      private function createContentInset() : void {
         this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",350);
         this.contentInset.height = 465;
         this.contentInset.x = 0;
         this.contentInset.y = 40;
         addChild(this.contentInset);
      }
      
      private function createSearchInputField(param1:int) : InputTextField {
         var _loc2_:InputTextField = new InputTextField("Filter");
         DefaultLabelFormat.defaultSmallPopupTitle(_loc2_);
         _loc2_.width = param1;
         return _loc2_;
      }
      
      private function createSearchIcon() : Bitmap {
         var _loc1_:BitmapData = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiInterfaceBig",40),20,true,0);
         return new Bitmap(_loc1_);
      }
      
      private function createAddButton() : SliceScalingButton {
         return new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","add_button"));
      }
      
      private function createSearchInset(param1:int) : SliceScalingBitmap {
         var _loc2_:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",param1);
         _loc2_.height = 30;
         return _loc2_;
      }
      
      private function createTab(param1:String, param2:Sprite, param3:UIGrid, param4:Boolean = false) : UITab {
         var _loc7_:* = null;
         var _loc5_:UITab = new UITab(param1,true);
         this._tabContent = new Sprite();
         param2.x = this.contentInset.x;
         this._tabContent.addChild(param2);
         if(param4) {
            this.createSearchAndAdd();
         }
         param2.y = !!param4?50:85;
         param2.addChild(param3);
         var _loc6_:int = !!param4?410:Number(375);
         var _loc8_:UIScrollbar = new UIScrollbar(_loc6_);
         _loc8_.mouseRollSpeedFactor = 1;
         _loc8_.scrollObject = _loc5_;
         _loc8_.content = param2;
         _loc8_.x = this.contentInset.x + this.contentInset.width - 25;
         _loc8_.y = param2.y;
         this._tabContent.addChild(_loc8_);
         _loc7_ = new Sprite();
         _loc7_.graphics.beginFill(0);
         _loc7_.graphics.drawRect(0,0,350,_loc6_ - 5);
         _loc7_.x = param2.x;
         _loc7_.y = param2.y;
         param2.mask = _loc7_;
         this._tabContent.addChild(_loc7_);
         _loc5_.addContent(this._tabContent);
         return _loc5_;
      }
      
      private function createSearchAndAdd() : void {
         var _loc1_:* = null;
         this.addButton = this.createAddButton();
         this.addButton.x = 7;
         this.addButton.y = 6;
         this._tabContent.addChild(this.addButton);
         var _loc2_:SliceScalingBitmap = this.createSearchInset(296);
         _loc2_.x = this.addButton.x + this.addButton.width;
         _loc2_.y = 10;
         this._tabContent.addChild(_loc2_);
         _loc1_ = this.createSearchIcon();
         _loc1_.x = _loc2_.x;
         _loc1_.y = 5;
         this._tabContent.addChild(_loc1_);
         this.search = this.createSearchInputField(250);
         this.search.autoSize = "none";
         this.search.multiline = false;
         this.search.wordWrap = false;
         this.search.x = _loc1_.x + _loc1_.width - 5;
         this.search.y = _loc2_.y + 7;
         this._tabContent.addChild(this.search);
      }
   }
}
