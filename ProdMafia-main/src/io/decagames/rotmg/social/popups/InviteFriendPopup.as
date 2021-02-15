package io.decagames.rotmg.social.popups {
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.textField.InputTextField;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class InviteFriendPopup extends ModalPopup {
       
      
      public var sendButton:SliceScalingButton;
      
      public var search:InputTextField;
      
      public function InviteFriendPopup() {
         var _loc1_:* = null;
         super(400,85,"Send invitation");
         _loc1_ = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",300);
         addChild(_loc1_);
         _loc1_.height = 30;
         _loc1_.x = 50;
         _loc1_.y = 10;
         this.search = new InputTextField("Account name");
         DefaultLabelFormat.defaultSmallPopupTitle(this.search,"center");
         addChild(this.search);
         this.search.width = 290;
         this.search.x = _loc1_.x + 5;
         this.search.y = _loc1_.y + 7;
         this.sendButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this.sendButton.width = 100;
         this.sendButton.setLabel("Send",DefaultLabelFormat.defaultButtonLabel);
         this.sendButton.y = 50;
         this.sendButton.x = Math.round(_contentWidth - this.sendButton.width) / 2;
         addChild(this.sendButton);
      }
   }
}
