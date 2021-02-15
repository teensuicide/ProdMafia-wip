package kabam.rotmg.util.components {
   import com.company.rotmg.graphics.StarGraphic;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class StarsView extends Sprite {
      
      private static const TOTAL:int = 5;
      
      private static const MARGIN:int = 4;
      
      private static const CORNER:int = 15;
      
      private static const BACKGROUND_COLOR:uint = 2434341;
      
      private static const EMPTY_STAR_COLOR:uint = 8618883;
      
      private static const FILLED_STAR_COLOR:uint = 16777215;
       
      
      private const stars:Vector.<StarGraphic> = makeStars();
      
      private const background:Sprite = makeBackground();
      
      public function StarsView() {
         super();
      }
      
      public function setStars(param1:int) : void {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5) {
            this.updateStar(_loc2_,param1);
            _loc2_++;
         }
      }
      
      private function makeStars() : Vector.<StarGraphic> {
         var _loc1_:Vector.<StarGraphic> = this.makeStarList();
         this.layoutStars(_loc1_);
         return _loc1_;
      }
      
      private function makeStarList() : Vector.<StarGraphic> {
         var _loc1_:int = 0;
         var _loc2_:Vector.<StarGraphic> = new Vector.<StarGraphic>(5,true);
         while(_loc1_ < 5) {
            _loc2_[_loc1_] = new StarGraphic();
            addChild(_loc2_[_loc1_]);
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function layoutStars(param1:Vector.<StarGraphic>) : void {
         var _loc2_:int = 0;
         while(_loc2_ < 5) {
            param1[_loc2_].x = 4 + param1[0].width * _loc2_;
            param1[_loc2_].y = 4;
            _loc2_++;
         }
      }
      
      private function makeBackground() : Sprite {
         var _loc1_:Sprite = new Sprite();
         this.drawBackground(_loc1_.graphics);
         addChildAt(_loc1_,0);
         return _loc1_;
      }
      
      private function drawBackground(param1:Graphics) : void {
         var _loc2_:StarGraphic = this.stars[0];
         var _loc4_:int = _loc2_.width * 5 + 8;
         var _loc3_:int = _loc2_.height + 8;
         param1.clear();
         param1.beginFill(2434341);
         param1.drawRoundRect(0,0,_loc4_,_loc3_,15,15);
         param1.endFill();
      }
      
      private function updateStar(param1:int, param2:int) : void {
         var _loc4_:StarGraphic = this.stars[param1];
         var _loc3_:ColorTransform = _loc4_.transform.colorTransform;
         _loc3_.color = param1 < param2?16777215:8618883;
         _loc4_.transform.colorTransform = _loc3_;
      }
   }
}
