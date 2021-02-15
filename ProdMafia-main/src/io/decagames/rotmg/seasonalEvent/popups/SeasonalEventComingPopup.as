package io.decagames.rotmg.seasonalEvent.popups {
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.date.TimeLeft;
   
   public class SeasonalEventComingPopup extends ModalPopup {
       
      
      private const WIDTH:int = 330;
      
      private const HEIGHT:int = 100;
      
      private var _scheduledDate:Date;
      
      private var _okButton:SliceScalingButton;
      
      public function SeasonalEventComingPopup(param1:Date) {
         var _loc2_:* = null;
         super(330,100,"Seasonal Event coming!",DefaultLabelFormat.defaultSmallPopupTitle);
         this._scheduledDate = param1;
         _loc2_ = new TextureParser().getSliceScalingBitmap("UI","main_button_decoration",186);
         addChild(_loc2_);
         _loc2_.y = 40;
         _loc2_.x = Math.round((330 - _loc2_.width) / 2);
         this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this._okButton.setLabel("OK",DefaultLabelFormat.questButtonCompleteLabel);
         this._okButton.width = 130;
         this._okButton.x = Math.round(100);
         this._okButton.y = 46;
         addChild(this._okButton);
         var _loc4_:String = TimeLeft.getStartTimeString(param1);
         var _loc3_:UILabel = new UILabel();
         DefaultLabelFormat.defaultSmallPopupTitle(_loc3_);
         _loc3_.width = 330;
         _loc3_.autoSize = "center";
         _loc3_.text = "Seasonal Event starting in: " + _loc4_;
         _loc3_.y = 10;
         addChild(_loc3_);
      }
      
      public function get okButton() : SliceScalingButton {
         return this._okButton;
      }
   }
}
