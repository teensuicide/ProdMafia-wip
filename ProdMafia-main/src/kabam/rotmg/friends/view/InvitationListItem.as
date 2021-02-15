package kabam.rotmg.friends.view {
   import com.company.assembleegameclient.ui.icons.IconButton;
   import com.company.assembleegameclient.ui.icons.IconButtonFactory;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import io.decagames.rotmg.social.model.FriendVO;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class InvitationListItem extends FListItem {
       
      
      private var _senderName:String;
      
      private var _portrait:Bitmap;
      
      private var _nameText:TextFieldDisplayConcrete;
      
      private var _rejectButton:IconButton;
      
      private var _acceptButton:IconButton;
      
      private var _blockButton:IconButton;
      
      public function InvitationListItem(param1:FriendVO, param2:Number, param3:Number) {
         super();
         this.init(param2,param3);
         this.update(param1,"");
      }
      
      override protected function init(param1:Number, param2:Number) : void {
         var _loc4_:* = null;
         this.graphics.beginFill(6710886);
         this.graphics.drawRoundRect(0,0,param1,param2,10,10);
         this.graphics.endFill();
         this._portrait = new Bitmap();
         this._portrait.x = 2;
         addChild(this._portrait);
         this._nameText = new TextFieldDisplayConcrete().setSize(18).setBold(true).setColor(11776947);
         this._nameText.y = 11;
         addChild(this._nameText);
         _loc4_ = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
         var _loc3_:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig",11);
         _loc3_.colorTransform(_loc3_.rect,new ColorTransform(0,1,0,1,182,255,160,0));
         this._acceptButton = _loc4_.create(_loc3_,"Guild.accept","","");
         this._acceptButton.x = this.width - 200;
         this._acceptButton.y = 11;
         this._acceptButton.addEventListener("click",this.onAcceptClicked);
         addChild(this._acceptButton);
         _loc3_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",12);
         _loc3_.colorTransform(_loc3_.rect,new ColorTransform(1,0,0,1,255,188,188,0));
         this._rejectButton = _loc4_.create(_loc3_,"Guild.rejection","","");
         this._rejectButton.x = this.width - 110;
         this._rejectButton.y = 11;
         this._rejectButton.addEventListener("click",this.onRejectClicked);
         addChild(this._rejectButton);
         this._blockButton = _loc4_.create(AssetLibrary.getImageFromSet("lofiInterfaceBig",8),"","Friend.BlockRight","");
         this._blockButton.setToolTipText("Friend.BlockRightDesc");
         this._blockButton.addEventListener("click",this.onBlockClicked);
         this._blockButton.x = this.width - 25;
         this._blockButton.y = 12;
         addChild(this._blockButton);
         this.addEventListener("removedFromStage",this.onRemovedFromState);
      }
      
      override public function update(param1:FriendVO, param2:String) : void {
         if(param1.getName() != this._senderName) {
            this._senderName = param1.getName();
            this._portrait.bitmapData = param1.getPortrait();
            this._nameText.setStringBuilder(new StaticStringBuilder(this._senderName));
            this._nameText.x = this._portrait.width + 12;
         }
      }
      
      override public function destroy() : void {
         while(numChildren > 0) {
            this.removeChildAt(numChildren - 1);
         }
         this._portrait = null;
         this._nameText = null;
         this._acceptButton.removeEventListener("click",this.onAcceptClicked);
         this._acceptButton = null;
         this._rejectButton.removeEventListener("click",this.onRejectClicked);
         this._rejectButton = null;
         this._blockButton.removeEventListener("click",this.onBlockClicked);
         this._blockButton = null;
      }
      
      private function onRemovedFromState(param1:Event) : void {
         this.removeEventListener("removedFromStage",this.onRemovedFromState);
         this.destroy();
      }
      
      private function onAcceptClicked(param1:MouseEvent) : void {
         actionSignal.dispatch("/acceptRequest",this._senderName);
      }
      
      private function onRejectClicked(param1:MouseEvent) : void {
         actionSignal.dispatch("/rejectRequest",this._senderName);
      }
      
      private function onBlockClicked(param1:MouseEvent) : void {
         actionSignal.dispatch("/blockRequest",this._senderName);
      }
   }
}
