package kabam.rotmg.assets {
import kabam.rotmg.assets.individual.*;

public class EmbeddedAssets {
   public static var ground:Class = groundTiles;
   public static var mapObjs:Class = mapObjects;
   public static var charMasks:Class = characters_masks;
   public static var chars:Class = characters;
   public static var atlasData:Class = spritesheet;

   // the local class name will not be parsed, but must be different than the
   // global class name (the one getting parsed) to avoid collision issues

   // it's also recommended to keep the global class' naming to be identical to the
   // dumped .png's name in cases where applicable (no invalid characters)
   public static var BGPillars0:Class = BGPillars_0;
   public static var BGPillars1:Class = BGPillars_1;
   public static var BGPillars2:Class = BGPillars_2;
   public static var BGPillars3:Class = BGPillars_3;
   public static var BGPillars4:Class = BGPillars_4;
   public static var BGPillars5:Class = BGPillars_5;
   public static var fireforgePoints:Class = fireforge_points;
   public static var iconCombatGrey:Class = icon_combat_grey;
   public static var iconExalted:Class = icon_exalted;
   public static var iconFilter:Class = icon_filter;
   public static var iconFilterAbilities:Class = icon_filter_abilities;
   public static var iconFilterAccessory:Class = icon_filter_accessory;
   public static var iconFilterArmor:Class = icon_filter_armor;
   public static var iconFilterConsumables:Class = icon_filter_consumables;
   public static var iconFilterToken:Class = icon_filter_token;
   public static var iconFilterWeapons:Class = icon_filter_weapons;
   public static var iconHeart:Class = icon_heart;
   public static var iconSearch:Class = icon_search;
   public static var materialCommon:Class = material_common;
   public static var materialRare:Class = material_rare;
   public static var materialLegendary:Class = material_legendary;

   public static var individualSprites:Array = [
      new BGPillars0(), new BGPillars1(), new BGPillars2(),
      new BGPillars3(), new BGPillars4(), new BGPillars5(),
      new fireforgePoints(), new iconCombatGrey(), new iconExalted(),
      new iconFilter(), new iconFilterAbilities(), new iconFilterAccessory(),
      new iconFilterArmor(), new iconFilterConsumables(), new iconFilterToken(),
      new iconFilterWeapons(), new iconHeart(), new iconSearch(),
      new materialCommon(), new materialRare(), new materialLegendary()
   ];

   public static var particlesXML:Class = particles;

   public function EmbeddedAssets() {
      super();
   }
}
}