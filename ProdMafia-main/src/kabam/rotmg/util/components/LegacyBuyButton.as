package kabam.rotmg.util.components {
   import com.company.util.GraphicsUtil;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import kabam.rotmg.assets.services.IconFactory;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   import kabam.rotmg.util.components.api.BuyButton;
   
   public class LegacyBuyButton extends BuyButton {
      
      private static const BEVEL:int = 4;
      
      private static const PADDING:int = 2;
      
      public static const coin:BitmapData = IconFactory.makeCoin();
      
      public static const fortune:BitmapData = IconFactory.makeFortune();
      
      public static const fame:BitmapData = IconFactory.makeFame();
      
      public static const guildFame:BitmapData = IconFactory.makeGuildFame();
      
      private static const grayfilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
       
      
      private const enabledFill:GraphicsSolidFill = new GraphicsSolidFill(16777215,1);
      
      private const disabledFill:GraphicsSolidFill = new GraphicsSolidFill(8355711,1);
      
      private const graphicsPath:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
      
      private const waiter:SignalWaiter = new SignalWaiter();
      
      public var prefix:String;
      
      public var text:TextFieldDisplayConcrete;
      
      public var icon:Bitmap;
      
      public var price:int = -1;
      
      public var currency:int = -1;
      
      public var _width:int = -1;
      
      private var staticStringBuilder:StaticStringBuilder;
      
      private var lineBuilder:LineBuilder;
      
      private var graphicsData:Vector.<IGraphicsData>;
      
      private var withOutLine:Boolean = false;
      
      private var outLineColor:int = 5526612;
      
      private var fixedWidth:int = -1;
      
      private var fixedHeight:int = -1;
      
      private var textVertMargin:int = 4;
      
      public function LegacyBuyButton(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false) {
         staticStringBuilder = new StaticStringBuilder("");
         lineBuilder = new LineBuilder();
         graphicsData = new <IGraphicsData>[enabledFill,graphicsPath,GraphicsUtil.END_FILL];
         super();
         this.prefix = param1;
         this.text = new TextFieldDisplayConcrete().setSize(param2).setColor(!!param6?15544368:3552822).setBold(true);
         this.waiter.push(this.text.textChanged);
         var _loc7_:StringBuilder = param1 != ""?this.lineBuilder.setParams(param1,{"cost":param3.toString()}):this.staticStringBuilder.setString(param3.toString());
         this.text.setStringBuilder(_loc7_);
         this.waiter.complete.add(this.updateUI);
         this.waiter.complete.addOnce(this.readyForPlacementDispatch);
         addChild(this.text);
         this.icon = new Bitmap();
         addChild(this.icon);
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
         this.setPrice(param3,param4);
         this.withOutLine = param5;
      }
      
      override public function setPrice(param1:int, param2:int) : void {
         var _loc3_:* = null;
         if(this.price != param1 || this.currency != param2) {
            this.price = param1;
            this.currency = param2;
            _loc3_ = this.prefix != ""?this.lineBuilder.setParams(this.prefix,{"cost":param1.toString()}):this.staticStringBuilder.setString(param1.toString());
            this.text.setStringBuilder(_loc3_);
            this.updateUI();
         }
      }
      
      override public function setEnabled(param1:Boolean) : void {
         if(param1 != mouseEnabled) {
            mouseEnabled = param1;
            filters = !!param1?[]:[grayfilter];
            this.draw();
         }
      }
      
      override public function setWidth(param1:int) : void {
         this._width = param1;
         this.updateUI();
      }
      
      public function setStringBuilder(param1:StringBuilder) : void {
         this.text.setStringBuilder(param1);
         this.updateUI();
      }
      
      public function getPrice() : int {
         return this.price;
      }
      
      public function setText(param1:String) : void {
         this.text.setStringBuilder(new StaticStringBuilder(param1));
         this.updateUI();
      }
      
      public function draw() : void {
         this.graphicsData[0] = !!mouseEnabled?this.enabledFill:this.disabledFill;
         graphics.clear();
         graphics.drawGraphicsData(this.graphicsData);
         if(this.withOutLine) {
            this.drawOutline(graphics);
         }
      }
      
      public function freezeSize() : void {
         this.fixedHeight = this.getHeight();
         this.fixedWidth = this.getWidth();
      }
      
      public function unfreezeSize() : void {
         this.fixedHeight = -1;
         this.fixedWidth = -1;
      }
      
      public function scaleButtonWidth(param1:Number) : void {
         this.fixedWidth = this.getWidth() * param1;
         this.updateUI();
      }
      
      public function scaleButtonHeight(param1:Number) : void {
         this.textVertMargin = this.textVertMargin * param1;
         this.updateUI();
      }
      
      public function setOutLineColor(param1:int) : void {
         this.outLineColor = param1;
      }
      
      private function updateUI() : void {
         this.updateText();
         this.updateIcon();
         this.updateBackground();
         this.draw();
      }
      
      private function readyForPlacementDispatch() : void {
         this.updateUI();
         readyForPlacement.dispatch();
      }
      
      private function updateIcon() : void {
         switch(int(this.currency)) {
            case 0:
               this.icon.bitmapData = coin;
               break;
            case 1:
               this.icon.bitmapData = fame;
               break;
            case 2:
               this.icon.bitmapData = guildFame;
               break;
            case 3:
               this.icon.bitmapData = fortune;
         }
         this.updateIconPosition();
      }
      
      private function updateBackground() : void {
         GraphicsUtil.clearPath(this.graphicsPath);
         GraphicsUtil.drawCutEdgeRect(0,0,this.getWidth(),this.getHeight(),4,[1,1,1,1],this.graphicsPath);
      }
      
      private function updateText() : void {
         this.text.x = (this.getWidth() - this.icon.width - this.text.width - 2) * 0.5;
         this.text.y = this.textVertMargin;
      }
      
      private function updateIconPosition() : void {
         this.icon.x = this.text.x + this.text.width;
         this.icon.y = (this.getHeight() - this.icon.height - 1) * 0.5;
      }
      
      private function getWidth() : int {
         return this.fixedWidth != -1?this.fixedWidth:Math.max(this._width,this.text.width + this.icon.width + 8);
      }
      
      private function getHeight() : int {
         return this.fixedHeight != -1?this.fixedHeight:this.text.height + this.textVertMargin * 2;
      }
      
      private function drawOutline(param1:Graphics) : void {
         var _loc2_:GraphicsSolidFill = new GraphicsSolidFill(0,0.01);
         var _loc4_:GraphicsSolidFill = new GraphicsSolidFill(this.outLineColor,0.6);
         var _loc5_:GraphicsStroke = new GraphicsStroke(4,false,"normal","none","round",3,_loc4_);
         var _loc3_:GraphicsPath = new GraphicsPath();
         GraphicsUtil.drawCutEdgeRect(0,0,this.getWidth(),this.getHeight(),4,GraphicsUtil.ALL_CUTS,_loc3_);
         var _loc6_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc5_,_loc2_,_loc3_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         param1.drawGraphicsData(_loc6_);
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.enabledFill.color = 16768133;
         this.draw();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.enabledFill.color = 16777215;
         this.draw();
      }
   }
}
