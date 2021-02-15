package io.decagames.rotmg.pets.data.family {
public class PetFamilyKeys {

    public static const KEYS:Object = {
        "Humanoid": "Pets.humanoid",
        "Feline": "Pets.feline",
        "Canine": "Pets.canine",
        "Avian": "Pets.avian",
        "Exotic": "Pets.exotic",
        "Farm": "Pets.farm",
        "Woodland": "Pets.woodland",
        "Reptile": "Pets.reptile",
        "Insect": "Pets.insect",
        "Penguin": "Pets.penguin",
        "Aquatic": "Pets.aquatic",
        "Spooky": "Pets.spooky",
        "Automaton": "Pets.automaton"
    };

    public static function getTranslationKey(param1:String):String {
        var _loc2_:String = KEYS[param1];
        return _loc2_ || (param1 == "? ? ? ?" ? "Pets.miscellaneous" : "");
    }

    public function PetFamilyKeys() {
        super();
    }
}
}
