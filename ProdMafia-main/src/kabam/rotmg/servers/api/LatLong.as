package kabam.rotmg.servers.api {
   public final class LatLong {
      
      private static const TO_DEGREES:Number = 57.2957795130823;
      
      private static const TO_RADIANS:Number = 0.0174532925199433;
      
      private static const DISTANCE_SCALAR:Number = 111189.57696;
       
      
      public var latitude:Number;
      
      public var longitude:Number;
      
      public function LatLong(param1:Number, param2:Number) {
         super();
         this.latitude = param1;
         this.longitude = param2;
      }
      
      public static function distance(param1:LatLong, param2:LatLong) : Number {
         var _loc4_:Number = 0.0174532925199433 * (param1.longitude - param2.longitude);
         var _loc5_:Number = 0.0174532925199433 * param1.latitude;
         var _loc3_:Number = 0.0174532925199433 * param2.latitude;
         var _loc6_:Number = Math.sin(_loc5_) * Math.sin(_loc3_) + Math.cos(_loc5_) * Math.cos(_loc3_) * Math.cos(_loc4_);
         _loc6_ = 57.2957795130823 * Math.acos(_loc6_) * 111189.57696;
         return _loc6_;
      }
      
      public function toString() : String {
         return "(" + this.latitude + ", " + this.longitude + ")";
      }
   }
}
