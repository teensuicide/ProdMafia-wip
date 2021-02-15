package kabam.rotmg.account.core.view {
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   
   public class EmptyFrame extends Sprite {
      
      public static const TEXT_MARGIN:int = 20;
       
      
      public var register:Signal;
      
      public var cancel:Signal;
      
      protected var modalWidth:Number;
      
      protected var modalHeight:Number;
      
      protected var closeButton:DialogCloseButton;
      
      protected var background:Sprite;
      
      protected var backgroundContainer:Sprite;
      
      protected var title:TextFieldDisplayConcrete;
      
      protected var desc:TextFieldDisplayConcrete;
      
      public function EmptyFrame(param1:int = 288, param2:int = 150, param3:String = "") {
         super();
         this.modalWidth = param1;
         this.modalHeight = param2;
         x = Main.STAGE.stageWidth / 2 - this.modalWidth / 2;
         y = Main.STAGE.stageHeight / 2 - this.modalHeight / 2;
         if(param3 != "") {
            this.setTitle(param3,true);
         }
         if(this.background == null) {
            this.backgroundContainer = new Sprite();
            this.background = this.makeModalBackground();
            this.backgroundContainer.addChild(this.background);
            addChild(this.backgroundContainer);
         }
         if(param3 != "") {
            this.setTitle(param3,true);
         }
      }
      
      public function setWidth(param1:Number) : void {
         this.modalWidth = param1;
         x = Main.STAGE.stageWidth / 2 - this.modalWidth / 2;
         this.refreshBackground();
      }
      
      public function setHeight(param1:Number) : void {
         this.modalHeight = param1;
         y = Main.STAGE.stageHeight / 2 - this.modalHeight / 2;
         this.refreshBackground();
      }
      
      public function setTitle(param1:String, param2:Boolean) : void {
         if(this.title != null && this.title.parent != null) {
            removeChild(this.title);
         }
         if(param1 != null) {
            this.title = this.getText(param1,20,5,param2);
            addChild(this.title);
         } else {
            this.title = null;
         }
      }
      
      public function setDesc(param1:String, param2:Boolean) : void {
         if(param1 != null) {
            if(this.desc != null && this.desc.parent != null) {
               removeChild(this.desc);
            }
            this.desc = this.getText(param1,20,50,param2);
            addChild(this.desc);
         }
      }
      
      public function setCloseButton(param1:Boolean) : void {
         if(this.closeButton == null && param1) {
            this.closeButton = PetsViewAssetFactory.returnCloseButton(this.modalWidth);
            this.closeButton.addEventListener("click",this.onCloseClick);
            addEventListener("removedFromStage",this.onRemovedFromStage);
            addChild(this.closeButton);
         } else if(this.closeButton != null && !param1) {
            removeChild(this.closeButton);
            this.closeButton = null;
         }
      }
      
      public function alignAssets() : void {
         this.desc.setTextWidth(this.modalWidth - 40);
         this.title.setTextWidth(this.modalWidth - 40);
      }
      
      protected function getText(param1:String, param2:int, param3:int, param4:Boolean) : TextFieldDisplayConcrete {
         var _loc5_:* = null;
         _loc5_ = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(this.modalWidth - 40);
         _loc5_.setBold(true);
         if(param4) {
            _loc5_.setStringBuilder(new StaticStringBuilder(param1));
         } else {
            _loc5_.setStringBuilder(new LineBuilder().setParams(param1));
         }
         _loc5_.setWordWrap(true);
         _loc5_.setMultiLine(true);
         _loc5_.setAutoSize("center");
         _loc5_.setHorizontalAlign("center");
         _loc5_.filters = [new DropShadowFilter(0,0,0)];
         _loc5_.x = param2;
         _loc5_.y = param3;
         return _loc5_;
      }
      
      protected function makeModalBackground() : Sprite {
         x = Main.STAGE.stageWidth / 2 - this.modalWidth / 2;
         y = Main.STAGE.stageHeight / 2 - this.modalHeight / 2;
         var _loc1_:PopupWindowBackground = new PopupWindowBackground();
         _loc1_.draw(this.modalWidth,this.modalHeight,0);
         if(this.title != null) {
            _loc1_.divide("HORIZONTAL_DIVISION",30);
         }
         return _loc1_;
      }
      
      protected function refreshBackground() : void {
         this.backgroundContainer.removeChild(this.background);
         this.background = this.makeModalBackground();
         this.backgroundContainer.addChild(this.background);
      }
      
      public function onCloseClick(param1:MouseEvent) : void {
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemovedFromStage);
         if(this.closeButton != null) {
            this.closeButton.removeEventListener("click",this.onCloseClick);
         }
      }
   }
}
