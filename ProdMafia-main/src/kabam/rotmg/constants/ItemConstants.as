package kabam.rotmg.constants {
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   
   public class ItemConstants {
      
      public static const NO_ITEM:int = -1;
      
      public static const ALL_TYPE:int = 0;
      
      public static const SWORD_TYPE:int = 1;
      
      public static const DAGGER_TYPE:int = 2;
      
      public static const BOW_TYPE:int = 3;
      
      public static const TOME_TYPE:int = 4;
      
      public static const SHIELD_TYPE:int = 5;
      
      public static const LEATHER_TYPE:int = 6;
      
      public static const PLATE_TYPE:int = 7;
      
      public static const WAND_TYPE:int = 8;
      
      public static const RING_TYPE:int = 9;
      
      public static const POTION_TYPE:int = 10;
      
      public static const SPELL_TYPE:int = 11;
      
      public static const SEAL_TYPE:int = 12;
      
      public static const CLOAK_TYPE:int = 13;
      
      public static const ROBE_TYPE:int = 14;
      
      public static const QUIVER_TYPE:int = 15;
      
      public static const HELM_TYPE:int = 16;
      
      public static const STAFF_TYPE:int = 17;
      
      public static const POISON_TYPE:int = 18;
      
      public static const SKULL_TYPE:int = 19;
      
      public static const TRAP_TYPE:int = 20;
      
      public static const ORB_TYPE:int = 21;
      
      public static const PRISM_TYPE:int = 22;
      
      public static const SCEPTER_TYPE:int = 23;
      
      public static const KATANA_TYPE:int = 24;
      
      public static const SHURIKEN_TYPE:int = 25;
      
      public static const EGG_TYPE:int = 26;
      
      public static const WAKI_TYPE:int = 27;
      
      public static const LUTE_TYPE:int = 28;
       
      
      public function ItemConstants() {
         super();
      }
      
      public static function itemTypeToName(param1:int) : String {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case 0:
               return "EquipmentType.Any";
            case 1:
               return "EquipmentType.Sword";
            case 2:
               return "EquipmentType.Dagger";
            case 3:
               return "EquipmentType.Bow";
            case 4:
               return "EquipmentType.Tome";
            case 5:
               return "EquipmentType.Shield";
            case 6:
               return "EquipmentType.LeatherArmor";
            case 7:
               return "EquipmentType.Armor";
            case 8:
               return "EquipmentType.Wand";
            case 9:
               return "EquipmentType.Accessory";
            case 10:
               return "EquipmentType.Potion";
            case 11:
               return "EquipmentType.Spell";
            case 12:
               return "EquipmentType.HolySeal";
            case 13:
               return "EquipmentType.Cloak";
            case 14:
               return "EquipmentType.Robe";
            case 15:
               return "EquipmentType.Quiver";
            case 16:
               return "EquipmentType.Helm";
            case 17:
               return "EquipmentType.Staff";
            case 18:
               return "EquipmentType.Poison";
            case 19:
               return "EquipmentType.Skull";
            case 20:
               return "EquipmentType.Trap";
            case 21:
               return "EquipmentType.Orb";
            case 22:
               return "EquipmentType.Prism";
            case 23:
               return "EquipmentType.Scepter";
            case 24:
               return "EquipmentType.Katana";
            case 25:
               return "EquipmentType.Shuriken";
            case 26:
               return "EquipmentType.Any";
            case 27:
               return "Wakizashi";
            case 28:
               return "Lute";
            default:
               return "EquipmentType.InvalidType";
         }
      }
      
      public static function itemTypeToBaseSprite(param1:int) : BitmapData {
         var _loc2_:* = null;
         var _loc3_:* = param1;
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case 0:
               break;
            case 1:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",48);
               break;
            case 2:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",96);
               break;
            case 3:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",80);
               break;
            case 4:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",80);
               break;
            case 5:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",112);
               break;
            case 6:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",0);
               break;
            case 7:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",32);
               break;
            case 8:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",64);
               break;
            case 9:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj",44);
               break;
            case 11:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",64);
               break;
            case 12:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",160);
               break;
            case 13:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",32);
               break;
            case 14:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",16);
               break;
            case 15:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",48);
               break;
            case 16:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",96);
               break;
            case 17:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj5",112);
               break;
            case 18:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",128);
               break;
            case 19:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",0);
               break;
            case 20:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",16);
               break;
            case 21:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",144);
               break;
            case 22:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",176);
               break;
            case 23:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",192);
               break;
            case 24:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj3",540);
               break;
            case 25:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj3",555);
               break;
            case 27:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",224);
               break;
            case 28:
               _loc2_ = AssetLibrary.getImageFromSet("lofiObj6",208);
         }
         return _loc2_;
      }
   }
}
