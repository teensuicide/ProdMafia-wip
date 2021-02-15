package kabam.rotmg.util.components {
   import com.company.assembleegameclient.parameters.Parameters;
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
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import kabam.rotmg.assets.services.IconFactory;
   import kabam.rotmg.ui.view.SignalWaiter;
   import kabam.rotmg.util.components.api.BuyButton;
   
   public class SimpleButton extends BuyButton {
      
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
      
      public var text:TextField;
      
      public var icon:Bitmap;
      
      public var price:int = -1;
      
      public var currency:int = -1;
      
      public var _width:int = -1;
      
      private var graphicsData:Vector.<IGraphicsData>;
      
      private var withOutLine:Boolean = false;
      
      private var outLineColor:int = 5526612;
      
      private var fixedWidth:int = -1;
      
      private var fixedHeight:int = -1;
      
      private var textVertMargin:int = 4;
      
      public function SimpleButton(param1:String, param2:int = -1, param3:int = -1, param4:Boolean = false) {
         graphicsData = new <IGraphicsData>[enabledFill,graphicsPath,GraphicsUtil.END_FILL];
         super();
         this.prefix = param1;
         this.text = new TextField();
         var _loc5_:TextFormat = new TextFormat();
         _loc5_.size = 16;
         _loc5_.font = "Myriad Pro";
         _loc5_.bold = true;
         _loc5_.align = "left";
         _loc5_.leftMargin = 0;
         _loc5_.indent = 0;
         _loc5_.leading = 0;
         this.text.textColor = 3552822;
         this.text.autoSize = "center";
         this.text.selectable = false;
         this.text.defaultTextFormat = _loc5_;
         this.text.setTextFormat(_loc5_);
         this.waiter.complete.add(this.updateUI);
         this.waiter.complete.addOnce(this.readyForPlacementDispatch);
         addChild(this.text);
         this.icon = new Bitmap();
         addChild(this.icon);
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
         if(param2 != -1) {
            this.setPrice(param2,param3);
         } else {
            this.text.text = param1;
            this.updateUI();
         }
         this.withOutLine = param4;
      }
      
      override public function setPrice(param1:int, param2:int) : void {
         if(this.price != param1 || this.currency != param2) {
            this.price = param1;
            this.currency = param2;
            this.text.text = this.prefix + param1.toString();
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
      
      public function getPrice() : int {
         return this.price;
      }
      
      public function setText(param1:String) : void {
         this.text.text = param1;
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
         Mouse.cursor = "button";
         this.enabledFill.color = 16768133;
         this.draw();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         Mouse.cursor = Parameters.data.cursorSelect;
         this.enabledFill.color = 16777215;
         this.draw();
      }
   }
}
