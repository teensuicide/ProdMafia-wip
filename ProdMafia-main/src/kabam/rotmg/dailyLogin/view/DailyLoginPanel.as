package kabam.rotmg.dailyLogin.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.Bitmap;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class DailyLoginPanel extends Panel {
       
      
      private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777215,18,true);
      
      public var calendarButton:DeprecatedTextButtonStatic;
      
      private var icon:Bitmap;
      
      private var title:String = "Login Seer";
      
      private var showCalendarText:String = "See rewards";
      
      private var noCalendarText:String = "Check Back Later";
      
      private var objectType:int;
      
      public function DailyLoginPanel(param1:GameSprite) {
         super(param1);
         this.icon = PetsViewAssetFactory.returnBitmap(5978);
         this.icon.x = -4;
         this.icon.y = -8;
         addChild(this.icon);
         this.objectType = 5972;
         this.titleText.setStringBuilder(new StaticStringBuilder(this.title));
         this.titleText.x = 58;
         this.titleText.y = 28;
         addChild(this.titleText);
      }
      
      public function showCalendarButton() : void {
         this.calendarButton = new DeprecatedTextButtonStatic(16,this.showCalendarText);
         this.calendarButton.textChanged.addOnce(this.alignButton);
         addChild(this.calendarButton);
      }
      
      public function showNoCalendarButton() : void {
         this.calendarButton = new DeprecatedTextButtonStatic(16,this.noCalendarText);
         this.calendarButton.textChanged.addOnce(this.alignButton);
         addChild(this.calendarButton);
      }
      
      public function init() : void {
      }
      
      private function alignButton() : void {
         this.calendarButton.x = 94 - this.calendarButton.width / 2;
         this.calendarButton.y = 84 - this.calendarButton.height - 4;
      }
   }
}
