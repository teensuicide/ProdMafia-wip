package io.decagames.rotmg.pets.components.caretaker {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   import kabam.rotmg.util.graphics.ButtonLayoutHelper;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class CaretakerQueryDialog extends Sprite {
      
      public static const WIDTH:int = 480;
      
      public static const HEIGHT:int = 428;
      
      public static const TITLE:String = "CaretakerQueryDialog.title";
      
      public static const QUERY:String = "CaretakerQueryDialog.query";
      
      public static const CLOSE:String = "Close.text";
      
      public static const BACK:String = "Screens.back";
      
      public static const CATEGORIES:Array = [{
         "category":"CaretakerQueryDialog.category_petYard",
         "info":"CaretakerQueryDialog.info_petYard"
      },{
         "category":"CaretakerQueryDialog.category_pets",
         "info":"CaretakerQueryDialog.info_pets"
      },{
         "category":"CaretakerQueryDialog.category_abilities",
         "info":"CaretakerQueryDialog.info_abilities"
      },{
         "category":"CaretakerQueryDialog.category_feedingPets",
         "info":"CaretakerQueryDialog.info_feedingPets"
      },{
         "category":"CaretakerQueryDialog.category_fusingPets",
         "info":"CaretakerQueryDialog.info_fusingPets"
      },{
         "category":"CaretakerQueryDialog.category_evolution",
         "info":"CaretakerQueryDialog.info_evolution"
      }];
       
      
      private const layoutWaiter:SignalWaiter = makeDeferredLayout();
      
      private const container:DisplayObjectContainer = makeContainer();
      
      private const background:PopupWindowBackground = makeBackground();
      
      private const caretaker:CaretakerQueryDialogCaretaker = makeCaretaker();
      
      private const title:TextFieldDisplayConcrete = makeTitle();
      
      private const categories:CaretakerQueryDialogCategoryList = makeCategoryList();
      
      private const backButton:DeprecatedTextButton = makeBackButton();
      
      private const closeButton:DeprecatedTextButton = makeCloseButton();
      
      public const closed:Signal = new NativeMappedSignal(closeButton,"click");
      
      public function CaretakerQueryDialog() {
         super();
      }
      
      public function setCaretakerIcon(param1:BitmapData) : void {
         this.caretaker.setCaretakerIcon(param1);
      }
      
      private function makeDeferredLayout() : SignalWaiter {
         var _loc1_:SignalWaiter = new SignalWaiter();
         _loc1_.complete.addOnce(this.onLayout);
         return _loc1_;
      }
      
      private function onLayout() : void {
         var _loc1_:ButtonLayoutHelper = new ButtonLayoutHelper();
         _loc1_.layout(480,this.closeButton);
         _loc1_.layout(480,this.backButton);
      }
      
      private function makeContainer() : DisplayObjectContainer {
         var _loc1_:* = null;
         _loc1_ = new Sprite();
         _loc1_.x = 160;
         _loc1_.y = 86;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeBackground() : PopupWindowBackground {
         var _loc1_:PopupWindowBackground = new PopupWindowBackground();
         _loc1_.draw(480,428);
         _loc1_.divide("HORIZONTAL_DIVISION",34);
         this.container.addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeCaretaker() : CaretakerQueryDialogCaretaker {
         var _loc1_:* = null;
         _loc1_ = new CaretakerQueryDialogCaretaker();
         _loc1_.x = 20;
         _loc1_.y = 50;
         this.container.addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = PetsViewAssetFactory.returnTextfield(16777215,18,true);
         _loc1_.setStringBuilder(new LineBuilder().setParams("CaretakerQueryDialog.title"));
         _loc1_.setAutoSize("center");
         _loc1_.x = 240;
         _loc1_.y = 24;
         this.container.addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeBackButton() : DeprecatedTextButton {
         var _loc1_:DeprecatedTextButton = new DeprecatedTextButton(16,"Screens.back",80);
         _loc1_.y = 382;
         _loc1_.visible = false;
         _loc1_.addEventListener("click",this.onBack);
         this.container.addChild(_loc1_);
         this.layoutWaiter.push(_loc1_.textChanged);
         return _loc1_;
      }
      
      private function makeCloseButton() : DeprecatedTextButton {
         var _loc1_:DeprecatedTextButton = new DeprecatedTextButton(16,"Close.text",110);
         _loc1_.y = 382;
         this.container.addChild(_loc1_);
         this.layoutWaiter.push(_loc1_.textChanged);
         return _loc1_;
      }
      
      private function makeCategoryList() : CaretakerQueryDialogCategoryList {
         var _loc1_:CaretakerQueryDialogCategoryList = new CaretakerQueryDialogCategoryList(CATEGORIES);
         _loc1_.x = 20;
         _loc1_.y = 110;
         _loc1_.selected.add(this.onCategorySelected);
         this.container.addChild(_loc1_);
         this.layoutWaiter.push(_loc1_.ready);
         return _loc1_;
      }
      
      private function onCategorySelected(param1:String) : void {
         this.categories.visible = false;
         this.closeButton.visible = false;
         this.backButton.visible = true;
         this.caretaker.showDetail(param1);
      }
      
      private function onBack(param1:MouseEvent) : void {
         this.caretaker.showSpeech();
         this.categories.visible = true;
         this.closeButton.visible = true;
         this.backButton.visible = false;
      }
   }
}
