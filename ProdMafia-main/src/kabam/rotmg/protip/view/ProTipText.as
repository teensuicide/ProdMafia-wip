package kabam.rotmg.protip.view {
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class ProTipText extends Sprite {
       
      
      private var text:TextFieldDisplayConcrete;
      
      public function ProTipText() {
         super();
      }
      
      public function setTip(param1:String) : void {
         this.text = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setWordWrap(true).setMultiLine(true).setTextWidth(580).setTextHeight(100).setHorizontalAlign("center");
         this.text.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         this.text.setStringBuilder(new LineBuilder().setParams("ProTipText.text",{"tip":param1}));
         this.text.x = -290;
         mouseEnabled = false;
         mouseChildren = false;
         addChild(this.text);
      }
   }
}
