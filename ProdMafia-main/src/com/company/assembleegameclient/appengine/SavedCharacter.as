package com.company.assembleegameclient.appengine {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.AnimatedChar;
   import com.company.assembleegameclient.util.AnimatedChars;
   import com.company.assembleegameclient.util.MaskedImage;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.util.CachingColorTransformer;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import org.swiftsuspenders.Injector;
   
   public class SavedCharacter {
       
      
      public var charXML_:XML;
      
      public var name_:String = null;
      
      private var pet:PetVO;
      
      public function SavedCharacter(param1:XML, param2:String) {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         super();
         this.charXML_ = param1;
         this.name_ = param2;
         if(this.charXML_.hasOwnProperty("Pet")) {
            _loc5_ = new XML(this.charXML_.Pet);
            _loc4_ = _loc5_.@instanceId;
            _loc3_ = StaticInjectorContext.getInjector().getInstance(PetsModel).getPetVO(_loc4_);
            _loc3_.apply(_loc5_);
            this.setPetVO(_loc3_);
         }
      }
      
      public static function getImage(param1:SavedCharacter, param2:XML, param3:int, param4:int, param5:Number, param6:Boolean, param7:Boolean) : BitmapData {
         var _loc12_:AnimatedChar = AnimatedChars.getAnimatedChar(param2.AnimatedTexture.File,param2.AnimatedTexture.Index);
         var _loc8_:MaskedImage = _loc12_.imageFromDir(param3,param4,param5);
         var _loc11_:int = param1 != null?param1.tex1():0;
         var _loc10_:int = param1 != null?param1.tex2():0;
         var _loc9_:BitmapData = TextureRedrawer.resize(_loc8_.image_,_loc8_.mask_,100,false,_loc11_,_loc10_);
         _loc9_ = GlowRedrawer.outlineGlow(_loc9_,0);
         if(!param6) {
            _loc9_ = CachingColorTransformer.transformBitmapData(_loc9_,new ColorTransform(0,0,0,0.5,0,0,0,0));
         } else if(!param7) {
            _loc9_ = CachingColorTransformer.transformBitmapData(_loc9_,new ColorTransform(0.75,0.75,0.75,1,0,0,0,0));
         }
         return _loc9_;
      }
      
      public static function compare(param1:SavedCharacter, param2:SavedCharacter) : Number {
         var _loc4_:Number = !Parameters.data.charIdUseMap.hasOwnProperty(param1.charId())?0:Parameters.data.charIdUseMap[param1.charId()];
         var _loc3_:Number = !Parameters.data.charIdUseMap.hasOwnProperty(param2.charId())?0:Parameters.data.charIdUseMap[param2.charId()];
         if(_loc4_ != _loc3_) {
            return _loc3_ - _loc4_;
         }
         return param2.xp() - param1.xp();
      }
      
      public function charId() : int {
         return int(this.charXML_.@id);
      }
      
      public function fameBonus() : Number {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc3_:Player = Player.fromPlayerXML("",this.charXML_);
         _loc2_ = 0;
         while(_loc2_ < 4) {
            if(_loc3_.equipment_ && _loc3_.equipment_.length > _loc2_) {
               _loc5_ = _loc3_.equipment_[_loc2_];
               if(_loc5_ != -1) {
                  _loc4_ = ObjectLibrary.xmlLibrary_[_loc5_];
                  if(_loc4_ && "FameBonus" in _loc4_) {
                     _loc1_ = _loc1_ + Number(_loc4_.FameBonus);
                  }
               }
            }
            _loc2_++;
         }
         return _loc1_ / 100;
      }
      
      public function name() : String {
         return this.name_;
      }
      
      public function objectType() : int {
         return this.charXML_.ObjectType;
      }
      
      public function skinType() : int {
         return this.charXML_.Texture;
      }
      
      public function level() : int {
         return this.charXML_.Level;
      }
      
      public function tex1() : int {
         return this.charXML_.Tex1;
      }
      
      public function tex2() : int {
         return this.charXML_.Tex2;
      }
      
      public function xp() : int {
         return this.charXML_.Exp;
      }
      
      public function fame() : int {
         return this.charXML_.CurrentFame;
      }
      
      public function hp() : int {
         return this.charXML_.MaxHitPoints;
      }
      
      public function mp() : int {
         return this.charXML_.MaxMagicPoints;
      }
      
      public function att() : int {
         return this.charXML_.Attack;
      }
      
      public function def() : int {
         return this.charXML_.Defense;
      }
      
      public function spd() : int {
         return this.charXML_.Speed;
      }
      
      public function dex() : int {
         return this.charXML_.Dexterity;
      }
      
      public function vit() : int {
         return this.charXML_.HpRegen;
      }
      
      public function wis() : int {
         return this.charXML_.MpRegen;
      }
      
      public function displayId() : String {
         return ObjectLibrary.typeToDisplayId_[this.objectType()];
      }
      
      public function getIcon(param1:int = 100) : BitmapData {
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc4_:ClassesModel = _loc2_.getInstance(ClassesModel);
         var _loc3_:CharacterFactory = _loc2_.getInstance(CharacterFactory);
         var _loc5_:CharacterClass = _loc4_.getCharacterClass(this.objectType());
         var _loc7_:CharacterSkin = _loc5_.skins.getSkin(this.skinType()) || _loc5_.skins.getDefaultSkin();
         var _loc6_:BitmapData = _loc3_.makeIcon(_loc7_.template,param1,this.tex1(),this.tex2());
         return _loc6_;
      }
      
      public function bornOn() : String {
         if(!("CreationDate" in this.charXML_)) {
            return "Unknown";
         }
         return this.charXML_.CreationDate;
      }
      
      public function getPetVO() : PetVO {
         return this.pet;
      }
      
      public function setPetVO(param1:PetVO) : void {
         this.pet = param1;
      }
   }
}
