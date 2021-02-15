package io.decagames.rotmg.pets.data.family {
public class PetFamilyColors {

    public static const AQUATIC:uint = 2453493;

    public static const AUTOMATON:uint = 5853776;

    public static const AVIAN:uint = 16483201;

    public static const CANINE:uint = 15828793;

    public static const EXOTIC:uint = 15673487;

    public static const FARM:uint = 6897954;

    public static const FELINE:uint = 14519612;

    public static const HUMANOID:uint = 13074611;

    public static const INSECT:uint = 1109351;

    public static const PENGUIN:uint = 2631720;

    public static const REPTILE:uint = 49227;

    public static const SPOOKY:uint = 10564850;

    public static const WOODLAND:uint = 8269343;

    public static const MISCELLANEOUS:uint = 16725303;

    public static const KEYS_TO_COLORS:Object = {
        "Pets.humanoid": 13074611,
        "Pets.feline": 14519612,
        "Pets.canine": 15828793,
        "Pets.avian": 16483201,
        "Pets.exotic": 15673487,
        "Pets.farm": 6897954,
        "Pets.woodland": 8269343,
        "Pets.reptile": 49227,
        "Pets.insect": 1109351,
        "Pets.penguin": 2631720,
        "Pets.aquatic": 2453493,
        "Pets.spooky": 10564850,
        "Pets.automaton": 5853776,
        "Pets.miscellaneous": 16725303,
        "? ? ? ?": 16725303
    };

    public static function getColorByFamilyKey(param1:String):uint {
        return KEYS_TO_COLORS[PetFamilyKeys.getTranslationKey(param1)];
    }

    public function PetFamilyColors() {
        super();
    }
}
}
