package kabam.rotmg.game.view.components {
   import flash.display.Sprite;
   
   public class StatsTabContent extends Sprite {
       
      
      private var stats:StatsView;
      
      public function StatsTabContent(param1:uint) {
         stats = new StatsView();
         super();
         this.init();
         this.positionChildren(param1);
         this.addChildren();
         name = "Stats";
      }
      
      private function addChildren() : void {
         addChild(this.stats);
      }
      
      private function positionChildren(param1:uint) : void {
         this.stats.y = (param1 - 27) / 2 - this.stats.height / 2;
      }
      
      private function init() : void {
         this.stats.name = "Stats";
      }
   }
}
