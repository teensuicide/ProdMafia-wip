package kabam.rotmg.game.view.components {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;
   
   public class StatView extends Sprite {
      
      public static var toMaxTextSignal:Signal = new Signal(Boolean);
       
      
      public const DEFAULT_FILTER:DropShadowFilter = new DropShadowFilter(0,0,0);
      
      public var fullName_:String;
      
      public var description_:String;
      
      public var nameText_:TextFieldDisplayConcrete;
      
      public var valText_:TextFieldDisplayConcrete;
      
      public var exaltValText:TextFieldDisplayConcrete;
      
      public var redOnZero_:Boolean;
      
      public var val_:int = -1;
      
      public var boost_:int = -1;
      
      public var max_:int = -1;
      
      public var exalted:int = -1;
      
      public var valColor_:uint = 11776947;
      
      public var level_:int = 0;
      
      public var toolTip_:TextToolTip;
      
      public var mouseOver:NativeSignal;
      
      public var mouseOut:NativeSignal;
      
      public function StatView(param1:String, param2:String, param3:String, param4:Boolean) {
         toolTip_ = new TextToolTip(3552822,10197915,"","",200);
         super();
         this.fullName_ = param2;
         this.description_ = param3;
         this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947);
         this.nameText_.setStringBuilder(new LineBuilder().setParams(param1));
         this.configureTextAndAdd(this.nameText_);
         this.valText_ = new TextFieldDisplayConcrete().setSize(11).setColor(this.valColor_).setBold(true);
         this.valText_.setStringBuilder(new StaticStringBuilder("-"));
         this.configureTextAndAdd(this.valText_);
         this.exaltValText = new TextFieldDisplayConcrete().setSize(11).setColor(1010609).setBold(true);
         this.exaltValText.setStringBuilder(new StaticStringBuilder(""));
         this.configureTextAndAdd(this.exaltValText);
         this.valText_.y = 1;
         this.exaltValText.y = 1;
         this.redOnZero_ = param4;
         this.mouseOver = new NativeSignal(this,"mouseOver",MouseEvent);
         this.mouseOut = new NativeSignal(this,"mouseOut",MouseEvent);
         toMaxTextSignal.add(this.setNewText);
      }
      
      public function configureTextAndAdd(param1:TextFieldDisplayConcrete) : void {
         param1.setAutoSize("left");
         param1.filters = [DEFAULT_FILTER];
         addChild(param1);
      }
      
      public function addTooltip() : void {
         this.toolTip_.setTitle(new LineBuilder().setParams(this.fullName_));
         this.toolTip_.setText(new LineBuilder().setParams(this.description_));
         if(!stage.contains(this.toolTip_)) {
            stage.addChild(this.toolTip_);
         }
      }
      
      public function removeTooltip() : void {
         if(this.toolTip_.parent != null) {
            this.toolTip_.parent.removeChild(this.toolTip_);
         }
      }
      
      public function draw(param1:int, param2:int, param3:int, param4:int, param5:int = 0) : void {
         var _loc6_:int = 0;
         if(param5 == this.level_ && param1 == this.val_ && param2 == this.boost_ && param4 == this.exalted) {
            return;
         }
         this.val_ = param1;
         this.boost_ = param2;
         this.max_ = param3;
         this.level_ = param5;
         this.exalted = param4;
         if(param1 - param2 >= param3) {
            _loc6_ = 16572160;
         } else if(this.redOnZero_ && this.val_ <= 0 || this.boost_ < 0) {
            _loc6_ = 16726072;
         } else if(this.boost_ > 0) {
            _loc6_ = 6206769;
         } else {
            _loc6_ = 11776947;
         }
         if(this.valColor_ != _loc6_) {
            this.valColor_ = _loc6_;
            this.valText_.setColor(this.valColor_);
         }
         this.setNewText(Parameters.data.toggleToMaxText);
      }
      
      public function setNewText(param1:Boolean) : void {
         var _loc3_:int = 0;
         var _loc2_:String = this.val_.toString();
         if(param1) {
            _loc3_ = this.max_ - (this.val_ - this.boost_);
            if(this.level_ >= 20 && _loc3_ > 0) {
               _loc2_ = _loc2_ + ("|" + _loc3_.toString());
            }
         }
         if(this.boost_ - this.exalted != 0) {
            _loc2_ = _loc2_ + (" (" + (this.boost_ - this.exalted > 0?"+":"") + (this.boost_ - this.exalted).toString() + ")");
         }
         this.valText_.setStringBuilder(new StaticStringBuilder(_loc2_));
         this.valText_.x = 24;
         if(this.exalted != 0) {
            this.exaltValText.setStringBuilder(new StaticStringBuilder("(+" + this.exalted + ")"));
            this.exaltValText.x = this.valText_.x + this.valText_.width - 2;
         }
      }
   }
}
