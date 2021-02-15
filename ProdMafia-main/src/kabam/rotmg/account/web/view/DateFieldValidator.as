package kabam.rotmg.account.web.view {
   import kabam.rotmg.account.ui.components.DateField;
   
   public class DateFieldValidator {
       
      
      public function DateFieldValidator() {
         super();
      }
      
      public static function getPlayerAge(param1:DateField) : uint {
         var _loc2_:Date = new Date(getBirthDate(param1));
         var _loc4_:Date = new Date();
         var _loc3_:uint = _loc4_.fullYear - _loc2_.fullYear;
         if(_loc2_.month > _loc4_.month || _loc2_.month == _loc4_.month && _loc2_.date > _loc4_.date) {
            _loc3_--;
         }
         return _loc3_;
      }
      
      public static function getBirthDate(param1:DateField) : Number {
         var _loc2_:String = param1.months.text + "/" + param1.days.text + "/" + param1.years.text;
         return Date.parse(_loc2_);
      }
   }
}
