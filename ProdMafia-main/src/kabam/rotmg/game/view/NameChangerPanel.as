package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.RankText;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import org.osflash.signals.Signal;
   
   public class NameChangerPanel extends Panel {
       
      
      public var chooseName:Signal;
      
      public var buy_:Boolean;
      
      private var title_:TextFieldDisplayConcrete;
      
      private var button_:Sprite;
      
      public function NameChangerPanel(param1:GameSprite, param2:int) {
         var _loc4_:* = null;
         var _loc3_:* = null;
         chooseName = new Signal();
         super(param1);
         if(this.hasMapAndPlayer()) {
            _loc4_ = gs_.map.player_;
            this.buy_ = _loc4_.nameChosen_;
            _loc3_ = this.createNameText();
            if(this.buy_) {
               this.handleAlreadyHasName(_loc3_);
            } else if(_loc4_.numStars_ < param2) {
               this.handleInsufficientRank(param2);
            } else {
               this.handleNoName();
            }
         }
         addEventListener("addedToStage",this.onAddedToStage);
      }
      
      public function updateName(param1:String) : void {
         this.title_.setStringBuilder(this.makeNameText(param1));
         this.title_.y = 0;
      }
      
      private function hasMapAndPlayer() : Boolean {
         return gs_.map && gs_.map.player_;
      }
      
      private function createNameText() : String {
         var _loc1_:* = null;
         _loc1_ = gs_.model.getName();
         this.title_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setTextWidth(188);
         this.title_.setBold(true).setWordWrap(true).setMultiLine(true).setHorizontalAlign("center");
         this.title_.filters = [new DropShadowFilter(0,0,0)];
         return _loc1_;
      }
      
      private function handleAlreadyHasName(param1:String) : void {
         this.title_.setStringBuilder(this.makeNameText(param1));
         this.title_.y = 0;
         addChild(this.title_);
         var _loc2_:LegacyBuyButton = new LegacyBuyButton("NameChangerPanel.change",16,1000,0);
         _loc2_.readyForPlacement.addOnce(this.positionButton);
         this.button_ = _loc2_;
         var _loc3_:* = 1000 <= gs_.map.player_.credits_;
         if(!_loc3_) {
            (this.button_ as LegacyBuyButton).setEnabled(_loc3_);
         } else {
            this.addListeners();
         }
         addChild(this.button_);
      }
      
      private function positionButton() : void {
         this.button_.x = 94 - this.button_.width / 2;
         this.button_.y = 84 - this.button_.height / 2 - 17;
      }
      
      private function handleNoName() : void {
         this.title_.setStringBuilder(new LineBuilder().setParams("NameChangerPanel.text"));
         this.title_.y = 6;
         addChild(this.title_);
         var _loc1_:DeprecatedTextButton = new DeprecatedTextButton(16,"NameChangerPanel.choose");
         _loc1_.textChanged.addOnce(this.positionTextButton);
         this.button_ = _loc1_;
         addChild(this.button_);
         this.addListeners();
      }
      
      private function positionTextButton() : void {
         this.button_.x = 94 - this.button_.width / 2;
         this.button_.y = 84 - this.button_.height - 4;
      }
      
      private function addListeners() : void {
         this.button_.addEventListener("click",this.onButtonClick);
      }
      
      private function handleInsufficientRank(param1:int) : void {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         this.title_.setStringBuilder(new LineBuilder().setParams("NameChangerPanel.text"));
         addChild(this.title_);
         _loc2_ = new Sprite();
         _loc4_ = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         _loc4_.setBold(true);
         _loc4_.setStringBuilder(new LineBuilder().setParams("NameChangerPanel.requireRank"));
         _loc4_.filters = [new DropShadowFilter(0,0,0)];
         _loc2_.addChild(_loc4_);
         _loc3_ = new RankText(param1,false,false);
         _loc3_.x = _loc4_.width + 4;
         _loc3_.y = _loc4_.height / 2 - _loc3_.height / 2;
         _loc2_.addChild(_loc3_);
         _loc2_.x = 94 - _loc2_.width / 2;
         _loc2_.y = 84 - _loc2_.height / 2 - 20;
         addChild(_loc2_);
      }
      
      private function makeNameText(param1:String) : StringBuilder {
         return new LineBuilder().setParams("NameChangerPanel.yourName",{"name":param1});
      }
      
      private function performAction() : void {
         this.chooseName.dispatch();
      }
      
      private function onAddedToStage(param1:Event) : void {
         if(this.button_) {
            stage.addEventListener("keyDown",this.onKeyDown);
         }
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            this.performAction();
         }
      }
      
      private function onButtonClick(param1:MouseEvent) : void {
         this.performAction();
      }
   }
}
