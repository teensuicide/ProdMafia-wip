package kabam.rotmg.messaging.impl.data {
   import flash.utils.IDataInput;
   
   public class CompressedInt {
       
      
      public function CompressedInt() {
         super();
      }
      
      public static function read(data:IDataInput) : int {
         var ret:int = 0;
         var trail:int = data.readUnsignedByte();
         var above64:Boolean = (trail & 64) != 0;
         var shift:int = 6;
         ret = trail & 63;

         while (trail & 128) {
            trail = data.readUnsignedByte();
            ret |= (trail & 127) << shift;
            shift += 7;
         }

         if (above64)
            ret = -ret;

         return ret;
      }
   }
}
