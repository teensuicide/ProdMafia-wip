package kabam.rotmg.account.web.view {
   import com.company.ui.BaseSimpleText;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   
   public class LabeledField extends FormField {
       
      
      public var nameText_:TextFieldDisplayConcrete;
      
      public var inputText_:BaseSimpleText;
      
      public var isHighlighted:Boolean;
      
      public function LabeledField(param1:String, param2:Boolean, param3:uint = 238, param4:uint = 30) {
         super();
         this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(11776947);
         this.nameText_.setBold(true);
         this.nameText_.setStringBuilder(new LineBuilder().setParams(param1));
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText_);
         this.inputText_ = new BaseSimpleText(20,11776947,true,param3,param4);
         this.inputText_.y = 30;
         this.inputText_.x = 6;
         this.inputText_.border = false;
         this.inputText_.displayAsPassword = param2;
         this.inputText_.updateMetrics();
         addChild(this.inputText_);
         this.setErrorHighlight(false);
      }
      
      override public function getHeight() : Number {
         return 68;
      }
      
      public function text() : String {
         return this.inputText_.text;
      }
      
      public function textChanged() : Signal {
         return this.nameText_.textChanged;
      }
      
      public function setErrorHighlight(param1:Boolean) : void {
         this.isHighlighted = param1;
         drawSimpleTextBackground(this.inputText_,0,0,param1);
      }
   }
}
