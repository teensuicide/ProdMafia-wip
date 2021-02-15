package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class TextPanel extends Panel {
       
      
      private var textField:TextFieldDisplayConcrete;
      
      private var virtualWidth:Number;
      
      private var virtualHeight:Number;
      
      public function TextPanel(param1:GameSprite) {
         super(param1);
         this.initTextfield();
      }
      
      public function init(param1:String) : void {
         this.textField.setStringBuilder(new LineBuilder().setParams(param1));
         this.textField.setAutoSize("center").setVerticalAlign("middle");
         this.textField.x = 94;
         this.textField.y = 42;
      }
      
      private function initTextfield() : void {
         this.textField = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         this.textField.setBold(true);
         this.textField.setStringBuilder(new LineBuilder().setParams("TextPanel.giftChestIsEmpty"));
         this.textField.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.textField);
      }
   }
}
