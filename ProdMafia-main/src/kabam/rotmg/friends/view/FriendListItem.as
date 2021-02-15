package kabam.rotmg.friends.view {
   import com.company.assembleegameclient.ui.icons.IconButton;
   import com.company.assembleegameclient.ui.icons.IconButtonFactory;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.social.model.FriendVO;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class FriendListItem extends FListItem {
       
      
      private const ONLINE_COLOR:uint = 3407650;
      
      private const NORMAL_COLOR:uint = 11776947;
      
      private var _senderName:String;
      
      private var _serverName:String;
      
      private var _isOnline:Boolean;
      
      private var _portrait:Bitmap;
      
      private var _nameText:TextFieldDisplayConcrete;
      
      private var _serverText:TextFieldDisplayConcrete;
      
      private var _whisperButton:IconButton;
      
      private var _jumpButton:IconButton;
      
      private var _removeButton:FriendRemoveButton;
      
      public function FriendListItem(param1:FriendVO, param2:Number, param3:Number, param4:String) {
         super();
         this.init(param2,param3);
         this.update(param1,param4);
      }
      
      override protected function init(param1:Number, param2:Number) : void {
         this.graphics.beginFill(6710886);
         this.graphics.drawRoundRect(0,0,param1,param2,10,10);
         this.graphics.endFill();
         this._portrait = new Bitmap();
         this._portrait.x = 2;
         this._portrait.y = -8;
         this._portrait.scaleY = 1.2;
         this._portrait.scaleX = 1.2;
         addChild(this._portrait);
         this._nameText = new TextFieldDisplayConcrete().setSize(18).setColor(!!this._isOnline?3407650:11776947);
         this._nameText.setStringBuilder(new StaticStringBuilder(this._senderName));
         this._nameText.y = 4;
         addChild(this._nameText);
         this._serverText = new TextFieldDisplayConcrete().setSize(16).setColor(11776947);
         this._serverText.x = this.width - 250;
         this._serverText.setStringBuilder(new StaticStringBuilder(this._serverName));
         addChild(this._serverText);
         var _loc3_:IconButtonFactory = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
         this._jumpButton = _loc3_.create(AssetLibrary.getImageFromSet("lofiInterface2",3),"Friend.TeleportTitle","","");
         this._jumpButton.setToolTipTitle("Friend.TeleportTitle");
         this._jumpButton.x = this.width - 270;
         this._jumpButton.y = 4;
         this._jumpButton.addEventListener("click",this.onJumpClicked);
         addChild(this._jumpButton);
         this._whisperButton = _loc3_.create(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),"PlayerMenu.PM","","");
         this._whisperButton.x = this.width - 130;
         this._whisperButton.y = 4;
         this._whisperButton.addEventListener("click",this.onWhisperClicked);
         addChild(this._whisperButton);
         this._removeButton = new FriendRemoveButton("Friend.RemoveRight","Friend.RemoveRightDesc");
         this._removeButton.addEventListener("click",this.onRemoveClicked);
         this._removeButton.x = this.width - 30;
         this._removeButton.y = 11;
         addChild(this._removeButton);
         this.addEventListener("removedFromStage",this.onRemovedFromState);
      }
      
      override public function update(param1:FriendVO, param2:String) : void {
         this._portrait.bitmapData = param1.getPortrait();
         if(param1.getName() != this._senderName) {
            this._senderName = param1.getName();
            this._nameText.x = this._portrait.width + 8;
            this._nameText.setStringBuilder(new StaticStringBuilder(this._senderName));
            this._serverText.y = this._nameText.y + 16;
         }
         if(param1.getServerName() != this._serverName) {
            this._serverName = param1.getServerName();
            this._serverText.setStringBuilder(new StaticStringBuilder(this._serverName));
         }
         this._isOnline = param1.isOnline;
         this._nameText.setColor(!!this._isOnline?3407650:11776947);
         this._whisperButton.visible = this._isOnline;
         this._jumpButton.visible = this._isOnline;
         this._jumpButton.setToolTipText("Friend.TeleportDesc",{"name":this._serverName});
         this._jumpButton.enabled = this._serverName != param2;
      }
      
      override public function destroy() : void {
         while(numChildren > 0) {
            this.removeChildAt(numChildren - 1);
         }
         this._portrait = null;
         this._nameText = null;
         this._serverText = null;
         this._whisperButton.removeEventListener("click",this.onWhisperClicked);
         this._whisperButton = null;
         this._jumpButton.removeEventListener("click",this.onJumpClicked);
         this._jumpButton = null;
         this._removeButton.removeEventListener("click",this.onRemoveClicked);
         this._removeButton.destroy();
         this._removeButton = null;
      }
      
      private function onRemovedFromState(param1:Event) : void {
         this.removeEventListener("removedFromStage",this.onRemovedFromState);
         this.destroy();
      }
      
      private function onRemoveClicked(param1:MouseEvent) : void {
         actionSignal.dispatch("/removeFriend",this._senderName);
      }
      
      private function onWhisperClicked(param1:MouseEvent) : void {
         actionSignal.dispatch("Whisper",this._senderName);
      }
      
      private function onJumpClicked(param1:MouseEvent) : void {
         actionSignal.dispatch("JumpServer",this._serverName);
      }
   }
}
