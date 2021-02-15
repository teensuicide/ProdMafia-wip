package kabam.rotmg.mysterybox.components {
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.mysterybox.services.MysteryBoxModel;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.swiftsuspenders.Injector;
   
   public class MysteryBoxSelectModal extends Sprite {
      
      public static const TEXT_MARGIN:int = 20;
      
      public static var modalWidth:int;
      
      public static var modalHeight:int;
      
      public static var aMysteryBoxHeight:int;
      
      public static var open:Boolean;
      
      public static var backgroundImageEmbed:Class = MysteryBoxSelectModal_backgroundImageEmbed;
       
      
      private var closeButton:DialogCloseButton;
      
      private var box_:Sprite;
      
      private var mysteryData:Object;
      
      private var titleString:String = "MysteryBoxSelectModal.titleString";
      
      private var selectEntries:Vector.<MysteryBoxSelectEntry>;
      
      public function MysteryBoxSelectModal() {
         box_ = new Sprite();
         super();
         modalWidth = 385;
         modalHeight = 60;
         aMysteryBoxHeight = 77;
         this.selectEntries = new Vector.<MysteryBoxSelectEntry>();
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc1_:MysteryBoxModel = _loc2_.getInstance(MysteryBoxModel);
         this.mysteryData = _loc1_.getBoxesOrderByWeight();
         addEventListener("removedFromStage",this.onRemovedFromStage);
         addChild(this.box_);
         this.addBoxChildren();
         this.positionAndStuff();
         open = true;
      }
      
      public static function getRightBorderX() : int {
         return 300 + modalWidth / 2;
      }
      
      private static function makeModalBackground(param1:int, param2:int) : PopupWindowBackground {
         var _loc3_:PopupWindowBackground = new PopupWindowBackground();
         _loc3_.draw(param1,param2,1);
         return _loc3_;
      }
      
      public function getText(param1:String, param2:int, param3:int) : TextFieldDisplayConcrete {
         var _loc4_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(modalWidth - 40);
         _loc4_.setBold(true);
         _loc4_.setStringBuilder(new LineBuilder().setParams(param1));
         _loc4_.setWordWrap(true);
         _loc4_.setMultiLine(true);
         _loc4_.setAutoSize("center");
         _loc4_.setHorizontalAlign("center");
         _loc4_.filters = [new DropShadowFilter(0,0,0)];
         _loc4_.x = param2;
         _loc4_.y = param3;
         return _loc4_;
      }
      
      public function updateContent() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.selectEntries;
         var _loc5_:int = 0;
         var _loc4_:* = this.selectEntries;
         for each(_loc3_ in this.selectEntries) {
            _loc3_.updateContent();
         }
      }
      
      private function positionAndStuff() : void {
         this.box_.x = 300 - modalWidth / 2;
         this.box_.y = Main.STAGE.stageHeight / 2 - modalHeight / 2;
      }
      
      private function addBoxChildren() : void {
         var _loc8_:* = NaN;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = this.mysteryData;
         var _loc11_:int = 0;
         var _loc10_:* = this.mysteryData;
         for each(_loc6_ in this.mysteryData) {
            modalHeight = modalHeight + aMysteryBoxHeight;
         }
         _loc1_ = new backgroundImageEmbed();
         _loc1_.width = modalWidth + 1;
         _loc1_.height = modalHeight - 25;
         _loc1_.y = 27;
         _loc1_.alpha = 0.95;
         this.box_.addChild(_loc1_);
         this.box_.addChild(makeModalBackground(modalWidth,modalHeight));
         this.closeButton = PetsViewAssetFactory.returnCloseButton(modalWidth);
         this.box_.addChild(this.closeButton);
         this.box_.addChild(this.getText(this.titleString,20,6).setSize(18));
         _loc8_ = 50;
         _loc3_ = 0;
         var _loc5_:* = this.mysteryData;
         var _loc13_:int = 0;
         var _loc12_:* = this.mysteryData;
         for each(_loc6_ in this.mysteryData) {
            if(_loc3_ != 6) {
               _loc9_ = new MysteryBoxSelectEntry(_loc6_);
               _loc9_.x = x + 20;
               _loc9_.y = y + _loc8_;
               _loc8_ = Number(_loc8_ + aMysteryBoxHeight);
               this.box_.addChild(_loc9_);
               this.selectEntries.push(_loc9_);
               _loc3_++;
               continue;
            }
            break;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         open = false;
      }
   }
}
