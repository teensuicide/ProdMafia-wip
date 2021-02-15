package kabam.rotmg.dailyLogin.view {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.GraphicsUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import kabam.rotmg.assets.services.IconFactory;
   import kabam.rotmg.dailyLogin.config.CalendarSettings;
   import kabam.rotmg.dailyLogin.model.CalendarDayModel;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class CalendarDayBox extends Sprite {
       
      
      public var day:CalendarDayModel;
      
      private var fill_:GraphicsSolidFill;
      
      private var fillCurrent_:GraphicsSolidFill;
      
      private var fillBlack_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsDataBackground:Vector.<IGraphicsData>;
      
      private var graphicsDataBackgroundCurrent:Vector.<IGraphicsData>;
      
      private var graphicsDataClaimedOverlay:Vector.<IGraphicsData>;
      
      private var redDot:Bitmap;
      
      private var boxCuts:Array;
      
      public function CalendarDayBox(param1:CalendarDayModel, param2:int, param3:Boolean) {
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         fill_ = new GraphicsSolidFill(3552822,1);
         fillCurrent_ = new GraphicsSolidFill(4889165,1);
         fillBlack_ = new GraphicsSolidFill(0,0.7);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,new GraphicsSolidFill(16777215));
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsDataBackground = new <IGraphicsData>[lineStyle_,fill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         graphicsDataBackgroundCurrent = new <IGraphicsData>[lineStyle_,fillCurrent_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         graphicsDataClaimedOverlay = new <IGraphicsData>[lineStyle_,fillBlack_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.day = param1;
         var _loc8_:int = Math.ceil(param1.dayNumber / 7);
         var _loc5_:int = Math.ceil(param2 / 7);
         if(param1.dayNumber == 1) {
            if(_loc5_ == 1) {
               this.boxCuts = [1,0,0,1];
            } else {
               this.boxCuts = [1,0,0,0];
            }
         } else if(param1.dayNumber == param2) {
            if(_loc5_ == 1) {
               this.boxCuts = [0,1,1,0];
            } else {
               this.boxCuts = [0,0,1,0];
            }
         } else if(_loc8_ == 1 && param1.dayNumber % 7 == 0) {
            this.boxCuts = [0,1,0,0];
         } else if(_loc8_ == _loc5_ && (param1.dayNumber - 1) % 7 == 0) {
            this.boxCuts = [0,0,0,1];
         } else {
            this.boxCuts = [0,0,0,0];
         }
         this.drawBackground(this.boxCuts,param3);
         if(param1.gold == 0 && param1.itemID > 0) {
            _loc6_ = new ItemTileRenderer(param1.itemID);
            addChild(_loc6_);
            _loc6_.x = Math.round(35);
            _loc6_.y = Math.round(35);
         }
         if(param1.gold > 0) {
            _loc9_ = new Bitmap();
            _loc9_.bitmapData = IconFactory.makeCoin(80);
            addChild(_loc9_);
            _loc9_.x = Math.round(35 - _loc9_.width / 2);
            _loc9_.y = Math.round(35 - _loc9_.height / 2);
         }
         this.displayDayNumber(param1.dayNumber);
         if(param1.claimKey != "") {
            _loc4_ = AssetLibrary.getImageFromSet("lofiInterface",52);
            _loc4_.colorTransform(new Rectangle(0,0,_loc4_.width,_loc4_.height),CalendarSettings.GREEN_COLOR_TRANSFORM);
            _loc4_ = TextureRedrawer.redraw(_loc4_,40,true,0);
            this.redDot = new Bitmap(_loc4_);
            this.redDot.x = 70 - Math.round(this.redDot.width / 2) - 10;
            this.redDot.y = -Math.round(this.redDot.width / 2) + 10;
            addChild(this.redDot);
         }
         if(param1.quantity > 1 || param1.gold > 0) {
            _loc7_ = new TextFieldDisplayConcrete().setSize(14).setColor(16777215).setTextWidth(70).setAutoSize("right");
            _loc7_.setStringBuilder(new StaticStringBuilder("x" + (param1.gold > 0?param1.gold.toString():param1.quantity.toString())));
            _loc7_.y = 52;
            _loc7_.x = -2;
            addChild(_loc7_);
         }
         if(param1.isClaimed) {
            this.markAsClaimed();
         }
      }
      
      public static function drawRectangleWithCuts(param1:Array, param2:int, param3:int, param4:uint, param5:Number, param6:Vector.<IGraphicsData>, param7:GraphicsPath) : Sprite {
         var _loc12_:Shape = new Shape();
         var _loc8_:Shape = new Shape();
         var _loc11_:Sprite = new Sprite();
         _loc11_.addChild(_loc12_);
         _loc11_.addChild(_loc8_);
         GraphicsUtil.clearPath(param7);
         GraphicsUtil.drawCutEdgeRect(0,0,param2,param3,4,param1,param7);
         _loc12_.graphics.clear();
         _loc12_.graphics.drawGraphicsData(param6);
         var _loc10_:GraphicsSolidFill = new GraphicsSolidFill(param4,param5);
         GraphicsUtil.clearPath(param7);
         var _loc9_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc10_,param7,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,param2,param3,4,param1,param7);
         _loc8_.graphics.drawGraphicsData(_loc9_);
         _loc8_.cacheAsBitmap = true;
         _loc8_.visible = false;
         return _loc11_;
      }
      
      public function getDay() : CalendarDayModel {
         return this.day;
      }
      
      public function markAsClaimed() : void {
         if(this.redDot && this.redDot.parent) {
            removeChild(this.redDot);
         }
         var _loc2_:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig",11);
         _loc2_ = TextureRedrawer.redraw(_loc2_,60,true,2997032);
         var _loc1_:Bitmap = new Bitmap(_loc2_);
         _loc1_.x = Math.round((70 - _loc1_.width) / 2);
         _loc1_.y = Math.round((70 - _loc1_.height) / 2);
         var _loc3_:Sprite = drawRectangleWithCuts(this.boxCuts,70,70,0,1,this.graphicsDataClaimedOverlay,this.path_);
         addChild(_loc3_);
         addChild(_loc1_);
      }
      
      public function drawBackground(param1:Array, param2:Boolean) : void {
         addChild(drawRectangleWithCuts(param1,70,70,3552822,1,!!param2?this.graphicsDataBackgroundCurrent:this.graphicsDataBackground,this.path_));
      }
      
      private function displayDayNumber(param1:int) : void {
         var _loc2_:* = null;
         _loc2_ = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(70);
         _loc2_.setBold(true);
         _loc2_.setStringBuilder(new StaticStringBuilder(param1.toString()));
         _loc2_.x = 4;
         _loc2_.y = 4;
         addChild(_loc2_);
      }
   }
}
