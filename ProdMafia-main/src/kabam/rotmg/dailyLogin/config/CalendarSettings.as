package kabam.rotmg.dailyLogin.config {
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class CalendarSettings {
      
      public static const NUMBER_OF_COLUMNS:int = 7;
      
      public static const BOX_WIDTH:int = 70;
      
      public static const BOX_HEIGHT:int = 70;
      
      public static const ITEM_SIZE:int = 100;
      
      public static const BOX_MARGIN:int = 10;
      
      public static const BOX_BORDER:int = 2;
      
      public static const CLAIM_WARNING_BEFORE_DAYS:int = 3;
      
      public static const DAILY_LOGIN_MODAL_PADDING:int = 20;
      
      public static const DAILY_LOGIN_TABS_PADDING:int = 10;
      
      public static const DAILY_LOGIN_MODAL_HEIGHT_MARGIN:int = 100;
      
      public static const TABS_HEIGHT:int = 30;
      
      public static const TABS_FONT_SIZE:int = 16;
      
      public static const TABS_WIDTH:int = 200;
      
      public static const TABS_Y_POSITION:int = 70;
      
      public static const GREEN_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0,0.776470588235294,0.0235294117647059);
       
      
      public function CalendarSettings() {
         super();
      }
      
      public static function getCalendarModalRectangle(param1:int, param2:Boolean) : Rectangle {
         var _loc3_:int = Math.ceil(param1 / 7);
         return new Rectangle(0,0,610,90 + 70 * _loc3_ + (_loc3_ - 1) * 10 + 100 + (!!param2?20:0));
      }
      
      public static function getTabsRectangle(param1:int) : Rectangle {
         var _loc2_:int = Math.ceil(param1 / 7);
         return new Rectangle(0,0,570,70 * _loc2_ + (_loc2_ - 1) * 10 + 20);
      }
   }
}
