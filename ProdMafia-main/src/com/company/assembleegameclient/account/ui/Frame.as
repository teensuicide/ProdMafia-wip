package com.company.assembleegameclient.account.ui {
   import com.company.assembleegameclient.ui.DeprecatedClickableText;
   import com.company.util.GraphicsUtil;
   import flash.display.DisplayObject;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.account.web.view.LabeledField;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.service.GoogleAnalytics;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class Frame extends Sprite {
      
      private static const INDENT:Number = 17;
       
      
      public var titleText_:TextFieldDisplayConcrete;
      
      public var leftButton_:DeprecatedClickableText;
      
      public var rightButton_:DeprecatedClickableText;
      
      public var analyticsPageName_:String;
      
      public var w_:int = 288;
      
      public var h_:int = 100;
      
      public var textInputFields_:Vector.<TextInputField>;
      
      public var navigationLinks_:Vector.<DeprecatedClickableText>;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      private var googleAnalytics:GoogleAnalytics;
      
      private var titleFill_:GraphicsSolidFill;
      
      private var backgroundFill_:GraphicsSolidFill;
      
      private var outlineFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path1_:GraphicsPath;
      
      private var path2_:GraphicsPath;
      
      public function Frame(param1:String, param2:String, param3:String, param4:String = "", param5:int = 288) {
         textInputFields_ = new Vector.<TextInputField>();
         navigationLinks_ = new Vector.<DeprecatedClickableText>();
         titleFill_ = new GraphicsSolidFill(5066061,1);
         backgroundFill_ = new GraphicsSolidFill(3552822,1);
         outlineFill_ = new GraphicsSolidFill(16777215,1);
         lineStyle_ = new GraphicsStroke(1,false,"normal","none","round",3,outlineFill_);
         path1_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         path2_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         this.graphicsData_ = new <IGraphicsData>[backgroundFill_,path2_,GraphicsUtil.END_FILL,titleFill_,path1_,GraphicsUtil.END_FILL,lineStyle_,path2_,GraphicsUtil.END_STROKE];
         super();
         this.w_ = param5;
         this.googleAnalytics = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
         this.titleText_ = new TextFieldDisplayConcrete().setSize(13).setColor(11776947);
         this.titleText_.setStringBuilder(new LineBuilder().setParams(param1));
         this.titleText_.filters = [new DropShadowFilter(0,0,0)];
         this.titleText_.x = 5;
         this.titleText_.y = 3;
         this.titleText_.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         addChild(this.titleText_);
         this.makeAndAddLeftButton(param2);
         this.makeAndAddRightButton(param3);
         this.analyticsPageName_ = param4;
         filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         addEventListener("addedToStage",this.onAddedToStage);
      }
      
      public function addLabeledField(param1:LabeledField) : void {
         addChild(param1);
         param1.y = this.h_ - 60;
         param1.x = 17;
         this.h_ = this.h_ + param1.getHeight();
      }
      
      public function addTextInputField(param1:TextInputField) : void {
         this.textInputFields_.push(param1);
         addChild(param1);
         param1.y = this.h_ - 60;
         param1.x = 17;
         this.h_ = this.h_ + param1.height;
      }
      
      public function addNavigationText(param1:DeprecatedClickableText) : void {
         this.navigationLinks_.push(param1);
         param1.x = 17;
         addChild(param1);
         this.positionText(param1);
      }
      
      public function addComponent(param1:DisplayObject, param2:int = 8) : void {
         addChild(param1);
         param1.y = this.h_ - 66;
         param1.x = param2;
         this.h_ = this.h_ + param1.height;
      }
      
      public function addPlainText(param1:String, param2:Object = null) : void {
         plainText = param1;
         tokens = param2;
         var plainText:String = plainText;
         var tokens:Object = tokens;
         var position:Function = function():void {
            positionText(text);
            draw();
         };
         var text:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(16777215);
         text.setStringBuilder(new LineBuilder().setParams(plainText,tokens));
         text.filters = [new DropShadowFilter(0,0,0)];
         text.textChanged.add(position);
         addChild(text);
      }
      
      public function addTitle(param1:String) : void {
         var _loc2_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(20).setColor(11711154).setBold(true);
         _loc2_.setStringBuilder(new LineBuilder().setParams(param1));
         _loc2_.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         addChild(_loc2_);
         _loc2_.y = this.h_ - 60;
         _loc2_.x = 15;
         this.h_ = this.h_ + 40;
      }
      
      public function addCheckBox(param1:CheckBoxField) : void {
         addChild(param1);
         param1.y = this.h_ - 66;
         param1.x = 17;
         this.h_ = this.h_ + 44;
      }
      
      public function addRadioBox(param1:PaymentMethodRadioButtons) : void {
         addChild(param1);
         param1.y = this.h_ - 66;
         param1.x = 18;
         this.h_ = this.h_ + param1.height;
      }
      
      public function addSpace(param1:int) : void {
         this.h_ = this.h_ + param1;
      }
      
      public function disable() : void {
         var _loc3_:* = null;
         mouseEnabled = false;
         mouseChildren = false;
         var _loc1_:* = this.navigationLinks_;
         var _loc5_:int = 0;
         var _loc4_:* = this.navigationLinks_;
         for each(_loc3_ in this.navigationLinks_) {
            _loc3_.setDefaultColor(11776947);
         }
         this.leftButton_.setDefaultColor(11776947);
         this.rightButton_.setDefaultColor(11776947);
      }
      
      public function enable() : void {
         var _loc3_:* = null;
         mouseEnabled = true;
         mouseChildren = true;
         var _loc1_:* = this.navigationLinks_;
         var _loc5_:int = 0;
         var _loc4_:* = this.navigationLinks_;
         for each(_loc3_ in this.navigationLinks_) {
            _loc3_.setDefaultColor(16777215);
         }
         this.leftButton_.setDefaultColor(16777215);
         this.rightButton_.setDefaultColor(16777215);
      }
      
      protected function positionText(param1:DisplayObject) : void {
         param1.y = this.h_ - 66;
         param1.x = 17;
         this.h_ = this.h_ + 20;
      }
      
      protected function draw() : void {
         graphics.clear();
         GraphicsUtil.clearPath(this.path1_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,this.w_,32,4,[1,1,0,0],this.path1_);
         GraphicsUtil.clearPath(this.path2_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,this.w_,this.h_,4,[1,1,1,1],this.path2_);
         this.leftButton_.y = this.h_ - 52;
         this.rightButton_.y = this.h_ - 52;
         graphics.drawGraphicsData(this.graphicsData_);
      }
      
      private function makeAndAddLeftButton(param1:String) : void {
         this.leftButton_ = new DeprecatedClickableText(18,true,param1);
         if(param1 != "") {
            this.leftButton_.buttonMode = true;
            this.leftButton_.x = 109;
            addChild(this.leftButton_);
         }
      }
      
      private function makeAndAddRightButton(param1:String) : void {
         this.rightButton_ = new DeprecatedClickableText(18,true,param1);
         if(param1 != "") {
            this.rightButton_.buttonMode = true;
            this.rightButton_.x = this.w_ - this.rightButton_.width - 26;
            this.rightButton_.setAutoSize("right");
            addChild(this.rightButton_);
         }
      }
      
      protected function onAddedToStage(param1:Event) : void {
         this.draw();
         x = stage.stageWidth / 2 - (this.w_ - 6) / 2;
         y = stage.stageHeight / 2 - height / 2;
         if(this.textInputFields_.length > 0) {
            stage.focus = this.textInputFields_[0].inputText_;
         }
         if(this.analyticsPageName_ && this.googleAnalytics) {
            this.googleAnalytics.trackPageView(this.analyticsPageName_);
         }
      }
   }
}
