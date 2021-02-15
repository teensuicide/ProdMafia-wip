package kabam.rotmg.classes.view {
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   
   public class CharacterSkinLimitedBanner extends Sprite {
      
      private static const CharacterSkinLimitedBanner_LimitedBanner_:Class = CharacterSkinLimitedBanner_LimitedBanner;
       
      
      private const limitedText:TextFieldDisplayConcrete = makeText();
      
      private const limitedBanner = makeLimitedBanner();
      
      public const readyForPositioning:Signal = new Signal();
      
      public function CharacterSkinLimitedBanner() {
         super();
      }
      
      public function layout() : void {
         this.limitedText.y = height / 2 - this.limitedText.height / 2 + 1;
         this.limitedBanner.x = this.limitedText.x + this.limitedText.width;
         this.readyForPositioning.dispatch();
      }
      
      private function makeText() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(16).setColor(11776947).setBold(true);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         _loc1_.setStringBuilder(new LineBuilder().setParams("CharacterSkinListItem.limited"));
         _loc1_.textChanged.addOnce(this.layout);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeLimitedBanner() : * {
         var _loc1_:* = new CharacterSkinLimitedBanner_LimitedBanner_();
         addChild(_loc1_);
         return _loc1_;
      }
   }
}
