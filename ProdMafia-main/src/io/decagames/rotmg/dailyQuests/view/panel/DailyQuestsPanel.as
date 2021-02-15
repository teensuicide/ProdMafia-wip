package io.decagames.rotmg.dailyQuests.view.panel {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.Bitmap;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class DailyQuestsPanel extends Panel {
       
      
      private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777215,18,true);
      
      var feedButton:DeprecatedTextButtonStatic;
      
      private var icon:Bitmap;
      
      private var title:String = "The Tinkerer";
      
      private var feedPetText:String = "See Quests";
      
      private var objectType:int;
      
      public function DailyQuestsPanel(param1:GameSprite) {
         super(param1);
         this.icon = PetsViewAssetFactory.returnBitmap(5972);
         this.icon.x = -4;
         this.icon.y = -8;
         addChild(this.icon);
         this.objectType = 5972;
         this.titleText.setStringBuilder(new StaticStringBuilder(this.title));
         this.titleText.x = 58;
         this.titleText.y = 28;
         addChild(this.titleText);
      }
      
      public function addSeeOffersButton() : void {
         this.feedButton = new DeprecatedTextButtonStatic(16,this.feedPetText);
         this.feedButton.textChanged.addOnce(this.alignButton);
         addChild(this.feedButton);
      }
      
      private function alignButton() : void {
         this.feedButton.x = 94 - this.feedButton.width / 2;
         this.feedButton.y = 84 - this.feedButton.height - 4;
      }
   }
}
