package kabam.rotmg.arena.view {
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class ArenaWaveCounter extends Sprite {
       
      
      private const waveText:StaticTextDisplay = makeWaveText();
      
      private const waveStringBuilder:LineBuilder = new LineBuilder();
      
      public function ArenaWaveCounter() {
         super();
      }
      
      public function setWaveNumber(param1:int) : void {
         this.waveText.setStringBuilder(this.waveStringBuilder.setParams("ArenaLeaderboardListItem.waveNumber",{"waveNumber":param1}));
      }
      
      private function makeWaveText() : StaticTextDisplay {
         var _loc1_:StaticTextDisplay = new StaticTextDisplay();
         _loc1_.setSize(24).setBold(true).setColor(16777215);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         addChild(_loc1_);
         return _loc1_;
      }
   }
}
