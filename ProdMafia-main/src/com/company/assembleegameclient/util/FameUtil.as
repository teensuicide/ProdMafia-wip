package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.rotmg.graphics.StarGraphic;
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class FameUtil {
      
      public static const MAX_STARS:int = 80;
      
      public static const STARS:Vector.<int> = new <int>[20,150,400,800,2000];
      
      private static const lightBlueCT:ColorTransform = new ColorTransform(0.541176470588235,0.596078431372549,0.870588235294118);
      
      private static const darkBlueCT:ColorTransform = new ColorTransform(0.192156862745098,0.301960784313725,0.858823529411765);
      
      private static const redCT:ColorTransform = new ColorTransform(0.756862745098039,0.152941176470588,0.176470588235294);
      
      private static const orangeCT:ColorTransform = new ColorTransform(0.968627450980392,0.576470588235294,0.117647058823529);
      
      private static const yellowCT:ColorTransform = new ColorTransform(1,1,0);
      
      public static const COLORS:Vector.<ColorTransform> = new <ColorTransform>[lightBlueCT,darkBlueCT,redCT,orangeCT,yellowCT];
       
      
      public function FameUtil() {
         super();
      }
      
      public static function maxStars() : int {
         return ObjectLibrary.playerChars_.length * STARS.length;
      }
      
      public static function numStars(param1:int) : int {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < STARS.length && param1 >= STARS[_loc2_]) {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function nextStarFame(param1:int, param2:int) : int {
         var _loc3_:int = 0;
         var _loc4_:int = Math.max(param1,param2);
         _loc3_ = 0;
         while(_loc3_ < STARS.length) {
            if(STARS[_loc3_] > _loc4_) {
               return STARS[_loc3_];
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function numAllTimeStars(param1:int, param2:int, param3:XML) : int {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = param3.ClassStats;
         for each(var _loc4_ in param3.ClassStats) {
            if(param1 == int(_loc4_.@objectType)) {
               _loc5_ = _loc4_.BestFame;
            } else {
               _loc6_ = _loc6_ + FameUtil.numStars(_loc4_.BestFame);
            }
         }
         _loc6_ = _loc6_ + FameUtil.numStars(Math.max(_loc5_,param2));
         return _loc6_;
      }

      public static function numStarsToBigImage(numStars:int):Sprite {
         var star:Sprite = numStarsToImage(numStars);
         star.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
         star.scaleX = 1.4;
         star.scaleY = 1.4;
         return star;
      }

      public static function numStarsToImage(numStars:int):Sprite {
         var star:Sprite = new StarGraphic();
         if (numStars < ObjectLibrary.playerChars_.length) {
            star.transform.colorTransform = lightBlueCT;
         } else if (numStars < ObjectLibrary.playerChars_.length * 2) {
            star.transform.colorTransform = darkBlueCT;
         } else if (numStars < ObjectLibrary.playerChars_.length * 3) {
            star.transform.colorTransform = redCT;
         } else if (numStars < ObjectLibrary.playerChars_.length * 4) {
            star.transform.colorTransform = orangeCT;
         } else if (numStars < ObjectLibrary.playerChars_.length * 5) {
            star.transform.colorTransform = yellowCT;
         }
         return star;
      }

      public static function numStarsToIcon(numStars:int):Sprite {
         var star:Sprite = null;
         star = numStarsToImage(numStars);
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginFill(0, 0.4);
         var w:int = star.width / 2 + 2;
         var h:int = star.height / 2 + 2;
         sprite.graphics.drawCircle(w, h, w);
         star.x = 2;
         star.y = 1;
         sprite.addChild(star);
         sprite.filters = [new DropShadowFilter(0, 0, 0, 0.5, 6, 6, 1)];
         return sprite;
      }
      
      public static function getFameIcon() : BitmapData {
         var _loc1_:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",224);
         return TextureRedrawer.redraw(_loc1_,40,true,0);
      }
      
      private static function getStar(param1:int) : Sprite {
         var _loc2_:Sprite = new StarGraphic();
         if(param1 < ObjectLibrary.playerChars_.length) {
            _loc2_.transform.colorTransform = lightBlueCT;
         } else if(param1 < ObjectLibrary.playerChars_.length * 2) {
            _loc2_.transform.colorTransform = darkBlueCT;
         } else if(param1 < ObjectLibrary.playerChars_.length * 3) {
            _loc2_.transform.colorTransform = redCT;
         } else if(param1 < ObjectLibrary.playerChars_.length * 4) {
            _loc2_.transform.colorTransform = orangeCT;
         } else if(param1 < ObjectLibrary.playerChars_.length * 5) {
            _loc2_.transform.colorTransform = yellowCT;
         }
         return _loc2_;
      }
   }
}
