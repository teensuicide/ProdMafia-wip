package kabam.rotmg.promotions.view {
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.packages.view.BasePackageButton;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.UIUtils;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class BeginnersPackageButton extends BasePackageButton {
      
      private static const FONT_SIZE:int = 16;
      
      public static const NOTIFICATION_BACKGROUND_WIDTH:Number = 50;
      
      public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
       
      
      public var clicked:Signal;
      
      private var timeLeftText:TextFieldDisplayConcrete;
      
      private var lootIcon:DisplayObject;
      
      private var daysRemaining:int = -1;
      
      private var clickArea:Sprite;
      
      public function BeginnersPackageButton() {
         super();
         this.clickArea = UIUtils.makeHUDBackground(50,25);
         this.clicked = new NativeMappedSignal(this,"click");
         tabChildren = false;
         tabEnabled = false;
         this.makeUI();
      }
      
      public function setDaysRemaining(param1:int) : void {
         if(this.daysRemaining != param1) {
            this.daysRemaining = param1;
            this.updateTimeLeftPosition();
         }
      }
      
      public function destroy() : void {
         parent.removeChild(this);
      }
      
      private function makeUI() : void {
         addChild(this.clickArea);
         this.lootIcon = makeIcon();
         addChild(this.lootIcon);
         this.makeTimeLeftText();
         this.setDaysRemaining(0);
      }
      
      private function makeTimeLeftText() : void {
         this.timeLeftText = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         this.timeLeftText.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         this.updateTimeLeftPosition();
         addChild(this.timeLeftText);
      }
      
      private function updateTimeLeftPosition() : void {
         this.timeLeftText.textChanged.addOnce(this.onTextChanged);
         this.timeLeftText.setStringBuilder(new StaticStringBuilder(this.daysRemaining.toString() + "d"));
      }
      
      private function onTextChanged() : void {
         positionText(this.lootIcon,this.timeLeftText);
      }
   }
}
