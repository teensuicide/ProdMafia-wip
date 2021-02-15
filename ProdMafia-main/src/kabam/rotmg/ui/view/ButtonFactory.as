package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.screens.TitleMenuOption;
   
   public class ButtonFactory {
      
      public static const BUTTON_SIZE_LARGE:uint = 36;
      
      public static const BUTTON_SIZE_SMALL:uint = 22;
      
      private static const LEFT:String = "left";
      
      private static const CENTER:String = "center";
      
      private static const RIGHT:String = "right";
       
      
      public function ButtonFactory() {
         super();
      }
      
      private static function makeButton(param1:String, param2:int, param3:String, param4:Boolean = false, param5:uint = 16777215) : TitleMenuOption {
         var _loc6_:TitleMenuOption = new TitleMenuOption(param1,param2,param4,param5);
         _loc6_.setAutoSize(param3);
         _loc6_.setVerticalAlign("middle");
         return _loc6_;
      }
      
      public function getPlayButton() : TitleMenuOption {
         return makeButton("Screens.play",36,"center",true);
      }
      
      public function getClassesButton() : TitleMenuOption {
         return makeButton("Screens.classes",22,"left");
      }
      
      public function getMainButton() : TitleMenuOption {
         return makeButton("Screens.main",22,"right");
      }
      
      public function getDoneButton() : TitleMenuOption {
         return makeButton("Done.text",36,"center");
      }
      
      public function getAccountButton() : TitleMenuOption {
         return makeButton("Screens.account",22,"left");
      }
      
      public function getLegendsButton() : TitleMenuOption {
         return makeButton("Screens.legends",22,"left");
      }
      
      public function getServersButton() : TitleMenuOption {
         return makeButton("Screens.servers",22,"right");
      }
      
      public function getBackButton() : TitleMenuOption {
         return makeButton("Screens.back",36,"center");
      }
   }
}
