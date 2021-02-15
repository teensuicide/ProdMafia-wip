package kabam.rotmg.dailyLogin.view {
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class CalendarTabsView extends Sprite {
       
      
      private var fill_:GraphicsSolidFill;
      
      private var fillTransparent_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsDataBackgroundTransparent:Vector.<IGraphicsData>;
      
      private var modalRectangle:Rectangle;
      
      private var tabs:Vector.<CalendarTabButton>;
      
      private var calendar:CalendarView;
      
      public function CalendarTabsView() {
         fill_ = new GraphicsSolidFill(3552822,1);
         fillTransparent_ = new GraphicsSolidFill(3552822,0);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,new GraphicsSolidFill(16777215));
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsDataBackgroundTransparent = new <IGraphicsData>[lineStyle_,fillTransparent_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
      }
      
      public function init(param1:Rectangle) : void {
         this.modalRectangle = param1;
         this.tabs = new Vector.<CalendarTabButton>();
      }
      
      public function addCalendar(param1:String, param2:String, param3:String) : CalendarTabButton {
         var _loc4_:* = null;
         _loc4_ = new CalendarTabButton(param1,param3,param2,"idle",this.tabs.length);
         this.addChild(_loc4_);
         _loc4_.x = 199 * this.tabs.length;
         this.tabs.push(_loc4_);
         return _loc4_;
      }
      
      public function selectTab(param1:String) : void {
         var _loc2_:* = null;
         var _loc3_:* = this.tabs;
         var _loc6_:int = 0;
         var _loc5_:* = this.tabs;
         for each(_loc2_ in this.tabs) {
            if(_loc2_.calendarType == param1) {
               _loc2_.state = "selected";
            } else {
               _loc2_.state = "idle";
            }
         }
         if(this.calendar) {
            removeChild(this.calendar);
         }
         this.calendar = new CalendarView();
         addChild(this.calendar);
         this.calendar.x = 10;
      }
      
      public function drawTabs() : void {
         this.drawBorder();
      }
      
      private function drawBorder() : void {
         var _loc1_:Sprite = new Sprite();
         this.drawRectangle(_loc1_,this.modalRectangle.width,this.modalRectangle.height);
         addChild(_loc1_);
         _loc1_.y = 30;
      }
      
      private function drawRectangle(param1:Sprite, param2:int, param3:int) : void {
         param1.addChild(CalendarDayBox.drawRectangleWithCuts([0,0,1,1],param2,param3,3552822,1,this.graphicsDataBackgroundTransparent,this.path_));
      }
   }
}
