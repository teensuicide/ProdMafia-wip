package kabam.rotmg.ui.view.components {
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import kabam.rotmg.assets.EmbeddedAssets;
   
   public class Spinner extends Sprite {
       
      
      public const graphic:DisplayObject = new EmbeddedAssets.StarburstSpinner();
      
      public var degreesPerSecond:Number;
      
      private var secondsElapsed:Number;
      
      private var previousSeconds:Number;
      
      public function Spinner() {
         super();
         this.secondsElapsed = 0;
         this.defaultConfig();
         this.addGraphic();
         addEventListener("enterFrame",this.onEnterFrame);
         addEventListener("removedFromStage",this.onRemoved);
      }
      
      private function defaultConfig() : void {
         this.degreesPerSecond = 50;
      }
      
      private function addGraphic() : void {
         addChild(this.graphic);
         this.graphic.x = -1 * width / 2;
         this.graphic.y = -1 * height / 2;
      }
      
      private function updateTimeElapsed() : void {
         var _loc1_:Number = TimeUtil.getTrueTime() / 1000;
         if(this.previousSeconds) {
            this.secondsElapsed = this.secondsElapsed + (_loc1_ - this.previousSeconds);
         }
         this.previousSeconds = _loc1_;
      }
      
      private function onRemoved(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemoved);
         removeEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void {
         this.updateTimeElapsed();
         rotation = this.degreesPerSecond * this.secondsElapsed % 360;
      }
   }
}
