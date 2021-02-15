package kabam.rotmg.arena.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.Bitmap;
   import kabam.rotmg.arena.util.ArenaViewAssetFactory;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   
   public class ArenaQueryPanel extends Panel {
       
      
      private const titleText:TextFieldDisplayConcrete = ArenaViewAssetFactory.returnTextfield(16777215,16,true);
      
      var infoButton:DeprecatedTextButton;
      
      var enterButton:DeprecatedTextButton;
      
      var queryType:uint;
      
      private var icon:Bitmap;
      
      private var title:String = "ArenaQueryPanel.title";
      
      private var infoButtonString:String = "Pets.caretakerPanelButtonInfo";
      
      private var upgradeYardButtonString:String = "ArenaQueryPanel.leaderboard";
      
      private var waiter:SignalWaiter;
      
      public function ArenaQueryPanel(param1:GameSprite, param2:uint) {
         waiter = new SignalWaiter();
         this.queryType = param2;
         super(param1);
         this.waiter.complete.addOnce(this.alignButton);
         this.handleIcon();
         this.handleTitleText();
         this.handleInfoButton();
         this.handleEnterButton();
      }
      
      private function handleInfoButton() : void {
         this.infoButton = new DeprecatedTextButton(16,this.infoButtonString);
         this.waiter.push(this.infoButton.textChanged);
         addChild(this.infoButton);
      }
      
      private function handleTitleText() : void {
         this.titleText.setStringBuilder(new LineBuilder().setParams(this.title));
         this.titleText.x = 65;
         this.titleText.y = 28;
         addChild(this.titleText);
      }
      
      private function handleEnterButton() : void {
         this.enterButton = new DeprecatedTextButton(16,this.upgradeYardButtonString);
         this.waiter.push(this.enterButton.textChanged);
         addChild(this.enterButton);
      }
      
      private function handleIcon() : void {
         this.icon = ArenaViewAssetFactory.returnHostBitmap(this.queryType);
         addChild(this.icon);
         this.icon.x = 5;
      }
      
      private function alignButton() : void {
         var _loc1_:int = this.infoButton.width + 15 + this.enterButton.width;
         this.infoButton.x = 94 - _loc1_ / 2;
         this.enterButton.x = this.infoButton.x + this.infoButton.width + 15;
         this.enterButton.y = 84 - this.enterButton.height - 4;
         this.infoButton.y = 84 - this.infoButton.height - 4;
      }
   }
}
