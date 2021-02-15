package kabam.rotmg.friends.view {
   import com.company.assembleegameclient.account.ui.TextInputField;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.dialogs.DialogCloser;
   import com.company.ui.BaseSimpleText;
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import io.decagames.rotmg.social.model.FriendVO;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   
   public class FriendListView extends Sprite implements DialogCloser {
      
      public static const TEXT_WIDTH:int = 500;
      
      public static const TEXT_HEIGHT:int = 500;
      
      public static const LIST_ITEM_WIDTH:int = 490;
      
      public static const LIST_ITEM_HEIGHT:int = 40;
       
      
      private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(500);
      
      public var closeDialogSignal:Signal;
      
      public var actionSignal:Signal;
      
      public var tabSignal:Signal;
      
      public var _tabView:FriendTabView;
      
      public var _w:int;
      
      public var _h:int;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      private var _friendTotalText:TextFieldDisplayConcrete;
      
      private var _friendDefaultText:TextFieldDisplayConcrete;
      
      private var _inviteDefaultText:TextFieldDisplayConcrete;
      
      private var _addButton:DeprecatedTextButton;
      
      private var _findButton:DeprecatedTextButton;
      
      private var _nameInput:TextInputField;
      
      private var _friendsContainer:FriendListContainer;
      
      private var _invitationsContainer:FriendListContainer;
      
      private var _currentServerName:String;
      
      private var backgroundFill_:GraphicsSolidFill;
      
      private var outlineFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      public function FriendListView() {
         closeDialogSignal = new Signal();
         actionSignal = new Signal(String,String);
         tabSignal = new Signal(String);
         backgroundFill_ = new GraphicsSolidFill(3355443,1);
         outlineFill_ = new GraphicsSolidFill(16777215,1);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,outlineFill_);
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.graphicsData_ = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
      }
      
      public function init(param1:Vector.<FriendVO>, param2:Vector.<FriendVO>, param3:String) : void {
         this._w = 500;
         addEventListener("removedFromStage",this.onRemovedFromStage);
         this._tabView = new FriendTabView(500,500);
         this._tabView.tabSelected.add(this.onTabClicked);
         addChild(this._tabView);
         this.createFriendTab();
         this.createInvitationsTab();
         addChild(this.closeButton);
         this.drawBackground();
         this._currentServerName = param3;
         this.seedData(param1,param2);
         this._tabView.setSelectedTab(0);
      }
      
      public function destroy() : void {
         while(numChildren > 0) {
            this.removeChildAt(numChildren - 1);
         }
         this._addButton.removeEventListener("click",this.onAddFriendClicked);
         this._addButton = null;
         this._tabView.destroy();
         this._tabView = null;
         this._nameInput.removeEventListener("focusIn",this.onFocusIn);
         this._nameInput = null;
         this._friendsContainer = null;
         this._invitationsContainer = null;
      }
      
      public function updateFriendTab(param1:Vector.<FriendVO>, param2:String) : void {
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         this._friendDefaultText.visible = param1.length <= 0;
         _loc3_ = this._friendsContainer.getTotal() - param1.length;
         while(_loc3_ > 0) {
            this._friendsContainer.removeChildAt(this._friendsContainer.getTotal() - 1);
            _loc3_--;
         }
         _loc3_ = 0;
         while(_loc3_ < this._friendsContainer.getTotal()) {
            _loc7_ = param1.pop();
            if(_loc7_ != null) {
               _loc6_ = this._friendsContainer.getChildAt(_loc3_) as FListItem;
               _loc6_.update(_loc7_,param2);
            }
            _loc3_++;
         }
         var _loc4_:* = param1;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(_loc7_ in param1) {
            _loc6_ = new FriendListItem(_loc7_,490,40,param2);
            _loc6_.actionSignal.add(this.onListItemAction);
            _loc6_.x = 2;
            this._friendsContainer.addListItem(_loc6_);
         }
         param1.length = 0;
         param1 = null;
      }
      
      public function updateInvitationTab(param1:Vector.<FriendVO>) : void {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         this._tabView.showTabBadget(1,param1.length);
         this._inviteDefaultText.visible = param1.length == 0;
         _loc3_ = this._invitationsContainer.getTotal() - param1.length;
         while(_loc3_ > 0) {
            this._invitationsContainer.removeChildAt(this._invitationsContainer.getTotal() - 1);
            _loc3_--;
         }
         _loc3_ = 0;
         while(_loc3_ < this._invitationsContainer.getTotal()) {
            _loc2_ = param1.pop();
            if(_loc2_ != null) {
               _loc5_ = this._invitationsContainer.getChildAt(_loc3_) as FListItem;
               _loc5_.update(_loc2_,"");
            }
            _loc3_++;
         }
         var _loc6_:* = param1;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc2_ in param1) {
            _loc5_ = new InvitationListItem(_loc2_,490,40);
            _loc5_.actionSignal.add(this.onListItemAction);
            this._invitationsContainer.addListItem(_loc5_);
         }
         param1.length = 0;
         param1 = null;
      }
      
      public function getCloseSignal() : Signal {
         return this.closeDialogSignal;
      }
      
      public function updateInput(param1:String, param2:Object = null) : void {
         this._nameInput.setError(param1,param2);
      }
      
      private function createFriendTab() : void {
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = "Friends";
         this._nameInput = new TextInputField("Friend.AddTitle",false);
         this._nameInput.x = 3;
         this._nameInput.y = 0;
         this._nameInput.addEventListener("focusIn",this.onFocusIn);
         _loc2_.addChild(this._nameInput);
         this._addButton = new DeprecatedTextButton(14,"Friend.AddButton",110);
         this._addButton.y = 30;
         this._addButton.x = 253;
         this._addButton.addEventListener("click",this.onAddFriendClicked);
         _loc2_.addChild(this._addButton);
         this._findButton = new DeprecatedTextButton(14,"Editor.Search",110);
         this._findButton.y = 30;
         this._findButton.x = 380;
         this._findButton.addEventListener("click",this.onSearchFriendClicked);
         _loc2_.addChild(this._findButton);
         this._friendDefaultText = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true).setAutoSize("center");
         this._friendDefaultText.setStringBuilder(new LineBuilder().setParams("Friend.FriendDefaultText"));
         this._friendDefaultText.x = 250;
         this._friendDefaultText.y = 200;
         _loc2_.addChild(this._friendDefaultText);
         this._friendTotalText = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setBold(true).setAutoSize("center");
         this._friendTotalText.x = 400;
         this._friendTotalText.y = 0;
         _loc2_.addChild(this._friendTotalText);
         this._friendsContainer = new FriendListContainer(500,390);
         this._friendsContainer.x = 3;
         this._friendsContainer.y = 80;
         _loc2_.addChild(this._friendsContainer);
         var _loc1_:BaseSimpleText = new BaseSimpleText(18,16777215,false,100,26);
         _loc1_.setAlignment("center");
         _loc1_.text = "Friends";
         this._tabView.addTab(_loc1_,_loc2_);
      }
      
      private function createInvitationsTab() : void {
         var _loc2_:* = null;
         _loc2_ = new Sprite();
         _loc2_.name = "Invitations";
         this._invitationsContainer = new FriendListContainer(500,470);
         this._invitationsContainer.x = 3;
         _loc2_.addChild(this._invitationsContainer);
         this._inviteDefaultText = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true).setAutoSize("center");
         this._inviteDefaultText.setStringBuilder(new LineBuilder().setParams("Friend.FriendInvitationDefaultText"));
         this._inviteDefaultText.x = 250;
         this._inviteDefaultText.y = 200;
         _loc2_.addChild(this._inviteDefaultText);
         var _loc1_:BaseSimpleText = new BaseSimpleText(18,16777215,false,100,26);
         _loc1_.text = "Invitations";
         _loc1_.setAlignment("center");
         this._tabView.addTab(_loc1_,_loc2_);
      }
      
      private function seedData(param1:Vector.<FriendVO>, param2:Vector.<FriendVO>) : void {
         this._friendTotalText.setStringBuilder(new LineBuilder().setParams("Friend.TotalFriend",{"total":param1.length}));
         this.updateFriendTab(param1,this._currentServerName);
         this.updateInvitationTab(param2);
      }
      
      private function onTabClicked(param1:String) : void {
         this.tabSignal.dispatch(param1);
      }
      
      private function onListItemAction(param1:String, param2:String) : void {
         this.actionSignal.dispatch(param1,param2);
      }
      
      private function drawBackground() : void {
         this._h = 508;
         x = 400 - this._w / 2;
         y = 300 - this._h / 2;
         graphics.clear();
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,this._w + 12,this._h + 12,4,[1,1,1,1],this.path_);
         graphics.drawGraphicsData(this.graphicsData_);
      }
      
      private function onFocusIn(param1:FocusEvent) : void {
         this._nameInput.clearText();
         this._nameInput.clearError();
         this.actionSignal.dispatch("searchFriend",this._nameInput.text());
      }
      
      private function onAddFriendClicked(param1:MouseEvent) : void {
         this.actionSignal.dispatch("/requestFriend",this._nameInput.text());
      }
      
      private function onSearchFriendClicked(param1:MouseEvent) : void {
         this.actionSignal.dispatch("searchFriend",this._nameInput.text());
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemovedFromStage);
         this.destroy();
      }
   }
}
