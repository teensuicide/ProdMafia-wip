package kabam.rotmg.stage3D.graphic3D {
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import kabam.rotmg.stage3D.proxies.Context3DProxy;
   import kabam.rotmg.stage3D.proxies.TextureProxy;
   
   public class TextureFactory {
      
      private static var textures:Dictionary = new Dictionary();
      
      private static var count:int = 0;
       
      
      [Inject]
      public var context3D:Context3DProxy;
      
      public function TextureFactory() {
         super();
      }
      
      public static function disposeTextures() : void {
         var _loc3_:int = 0;
         var _loc2_:* = textures;
         for each(var _loc1_ in textures) {
            _loc1_.dispose();
            _loc1_ = null;
         }
         textures = new Dictionary();
         count = 0;
      }
      
      private static function getNextPowerOf2(param1:int) : Number {
         param1--;
         param1 = param1 | param1 >> 1;
         param1 = param1 | param1 >> 2;
         param1 = param1 | param1 >> 4;
         param1 = param1 | param1 >> 8;
         param1 = param1 | param1 >> 16;
         param1++;
         return param1;
      }
      
      public function make(param1:BitmapData) : TextureProxy {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextureProxy = null;
         if(param1 == null) {
            return null;
         }
         if(param1 in textures) {
            return textures[param1];
         }
         _loc4_ = getNextPowerOf2(param1.width);
         _loc2_ = getNextPowerOf2(param1.height);
         _loc3_ = this.context3D.createTexture(_loc4_,_loc2_,"bgra",true);
         var _loc5_:BitmapData = new BitmapData(_loc4_,_loc2_,true,0);
         _loc5_.copyPixels(param1,param1.rect,new Point(0,0));
         _loc3_.uploadFromBitmapData(_loc5_);
         if(count > 1000) {
            disposeTextures();
         }
         textures[param1] = _loc3_;
         count = Number(count) + 1;
         return _loc3_;
      }
   }
}
