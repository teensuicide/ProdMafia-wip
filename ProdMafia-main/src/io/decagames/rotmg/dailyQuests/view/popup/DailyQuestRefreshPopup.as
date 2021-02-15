package io.decagames.rotmg.dailyQuests.view.popup {
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   
   public class DailyQuestRefreshPopup extends ModalPopup {
       
      
      private const TITLE:String = "Refresh Daily Quests";
      
      private const TEXT:String = "Do you want to refresh your Daily Quests? All Daily Quests will be refreshed!";
      
      private const WIDTH:int = 300;
      
      private const HEIGHT:int = 100;
      
      private var _refreshPrice:int;
      
      private var _buyQuestRefreshButton:BuyQuestRefreshButton;
      
      public function DailyQuestRefreshPopup(param1:int) {
         super(300,100,"Refresh Daily Quests");
         this._refreshPrice = param1;
         this.init();
      }
      
      public function get buyQuestRefreshButton() : BuyQuestRefreshButton {
         return this._buyQuestRefreshButton;
      }
      
      private function init() : void {
         var _loc1_:UILabel = new UILabel();
         _loc1_.width = 280;
         _loc1_.multiline = true;
         _loc1_.wordWrap = true;
         _loc1_.text = "Do you want to refresh your Daily Quests? All Daily Quests will be refreshed!";
         DefaultLabelFormat.defaultSmallPopupTitle(_loc1_,"center");
         _loc1_.x = (300 - _loc1_.width) / 2;
         _loc1_.y = 10;
         addChild(_loc1_);
         this._buyQuestRefreshButton = new BuyQuestRefreshButton(this._refreshPrice);
         this._buyQuestRefreshButton.x = (300 - this._buyQuestRefreshButton.width) / 2;
         this._buyQuestRefreshButton.y = 60;
         addChild(this._buyQuestRefreshButton);
      }
   }
}
