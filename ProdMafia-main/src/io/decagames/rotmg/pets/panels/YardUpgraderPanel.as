package io.decagames.rotmg.pets.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.Bitmap;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class YardUpgraderPanel extends Panel {
       
      
      private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777215,16,true);
      
      var infoButton:DeprecatedTextButton;
      
      var upgradeYardButton:DeprecatedTextButton;
      
      var petsButton:DeprecatedTextButton;
      
      var upgradeType:uint;
      
      private var icon:Bitmap;
      
      private var title:String = "Pets.caretakerPanelTitle";
      
      private var infoButtonString:String = "Pets.caretakerPanelButtonInfo";
      
      private var upgradeYardButtonString:String = "Pets.caretakerPanelButtonUpgrade";
      
      private var petsButtonString:String = "Pets";
      
      public function YardUpgraderPanel(param1:GameSprite, param2:uint) {
         this.upgradeType = param2;
         super(param1);
      }
      
      public function init(param1:Boolean) : void {
         this.handleIcon();
         this.handleTitleText();
         this.handleInfoButton();
         this.handlePetsButton();
         if(param1) {
            this.handleUpgradeYardButton();
         }
      }
      
      private function handleInfoButton() : void {
         this.infoButton = new DeprecatedTextButton(16,this.infoButtonString);
         this.infoButton.textChanged.addOnce(this.alignButton);
         addChild(this.infoButton);
      }
      
      private function handlePetsButton() : void {
         this.petsButton = new DeprecatedTextButton(16,this.petsButtonString);
         this.petsButton.textChanged.addOnce(this.alignButton);
         addChild(this.petsButton);
      }
      
      private function handleTitleText() : void {
         this.icon.x = -25;
         this.icon.y = -36;
         this.titleText.setStringBuilder(new LineBuilder().setParams(this.title));
         this.titleText.x = 48;
         this.titleText.y = 28;
         addChild(this.titleText);
      }
      
      private function handleUpgradeYardButton() : void {
         this.upgradeYardButton = new DeprecatedTextButton(16,this.upgradeYardButtonString);
         this.upgradeYardButton.textChanged.addOnce(this.alignButton);
         addChild(this.upgradeYardButton);
      }
      
      private function handleIcon() : void {
         this.icon = PetsViewAssetFactory.returnCaretakerBitmap(this.upgradeType);
         addChild(this.icon);
         this.icon.x = 5;
      }
      
      private function alignButton() : void {
         if(this.upgradeYardButton && contains(this.upgradeYardButton)) {
            this.upgradeYardButton.x = 141 - this.upgradeYardButton.width / 2;
            this.upgradeYardButton.y = 84 - this.upgradeYardButton.height - 4;
            this.infoButton.x = 47 - this.infoButton.width / 2;
            this.infoButton.y = 84 - this.infoButton.height - 4;
         } else {
            this.infoButton.x = 58.75 - this.infoButton.width / 2;
            this.infoButton.y = 84 - this.infoButton.height - 4;
            if(this.petsButton) {
               this.petsButton.x = 129.25 - this.petsButton.width / 2;
               this.petsButton.y = 84 - this.petsButton.height - 4;
            }
         }
      }
   }
}
