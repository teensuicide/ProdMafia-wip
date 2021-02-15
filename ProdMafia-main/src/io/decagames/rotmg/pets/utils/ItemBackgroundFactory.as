package io.decagames.rotmg.pets.utils {
   import io.decagames.rotmg.pets.components.petItem.PetItemBackground;
   
   public class ItemBackgroundFactory {
       
      
      public function ItemBackgroundFactory() {
         super();
      }
      
      public static function create(param1:int, param2:Array, param3:uint, param4:Number) : PetItemBackground {
         return new PetItemBackground(param1,param2,param3,param4);
      }
   }
}
