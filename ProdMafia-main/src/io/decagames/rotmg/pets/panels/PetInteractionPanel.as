package io.decagames.rotmg.pets.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.Bitmap;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class PetInteractionPanel extends Panel {
       
      
      private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777215,16,true);
      
      var wardrobeButton:DeprecatedTextButton;
      
      private var icon:Bitmap;
      
      private var title:String = "Console";
      
      private var wardrobeButtonString:String = "Wardrobe";
      
      private var objectType:int;
      
      public function PetInteractionPanel(param1:GameSprite, param2:int) {
         super(param1);
         this.objectType = param2;
         this.titleText.setStringBuilder(new LineBuilder().setParams(this.title));
         this.titleText.x = 48;
         this.titleText.y = 28;
         addChild(this.titleText);
         this.wardrobeButton = new DeprecatedTextButton(16,this.wardrobeButtonString);
         this.wardrobeButton.textChanged.addOnce(this.alignButton);
         addChild(this.wardrobeButton);
      }
      
      public function init() : void {
         this.icon = PetsViewAssetFactory.returnBitmap(this.objectType);
         this.icon.x = -4;
         this.icon.y = -8;
         addChild(this.icon);
      }
      
      private function alignButton() : void {
         this.wardrobeButton.x = 94 - this.wardrobeButton.width / 2;
         this.wardrobeButton.y = 84 - this.wardrobeButton.height - 4;
      }
   }
}
