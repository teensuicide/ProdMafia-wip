package kabam.rotmg.ui.noservers {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   
   public class ProductionNoServersDialogFactory implements NoServersDialogFactory {
      
      private static const forums_link:String = "<font color=\"#7777EE\"><a href=\"http://forums.wildshadow.com/\">forums.wildshadow.com</a></font>";
      
      private static const TRACKING:String = "/offLine";
       
      
      public function ProductionNoServersDialogFactory() {
         super();
      }
      
      public function makeDialog() : Dialog {
         var _loc1_:Dialog = new Dialog("ProductionNoServersDialogFactory.tile","",null,null,"/offLine");
         _loc1_.textText_.setHTML(true);
         _loc1_.setTextParams("ProductionNoServersDialogFactory.body",{"forums_link":"<font color=\"#7777EE\"><a href=\"http://forums.wildshadow.com/\">forums.wildshadow.com</a></font>"});
         return _loc1_;
      }
   }
}
