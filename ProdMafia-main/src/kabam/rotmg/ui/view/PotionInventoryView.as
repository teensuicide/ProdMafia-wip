package kabam.rotmg.ui.view {
   import flash.display.Sprite;
   import kabam.rotmg.ui.view.components.PotionSlotView;
   
   public class PotionInventoryView extends Sprite {
      private static const LEFT_BUTTON_CUTS:Array = [1, 0, 0, 1];
      private static const MID_BUTTON_CUTS:Array = [0, 0, 0, 0];
      private static const RIGHT_BUTTON_CUTS:Array = [0, 1, 1, 0];

      public function PotionInventoryView(hasUpgrade:Boolean) {
         var psv:PotionSlotView = null;
         var i:int = 0;
         super();
         if (hasUpgrade)
            for (; i < 3; i++) {
               psv = new PotionSlotView([LEFT_BUTTON_CUTS, MID_BUTTON_CUTS, RIGHT_BUTTON_CUTS][i], i, 58);
               psv.x = 1 + i * 58;
               addChild(psv);
            }
         else
            for (; i < 2; i++) {
               psv = new PotionSlotView([LEFT_BUTTON_CUTS, RIGHT_BUTTON_CUTS][i], i, 88);
               psv.x = i * 88;
               addChild(psv);
            }
      }
   }
}
