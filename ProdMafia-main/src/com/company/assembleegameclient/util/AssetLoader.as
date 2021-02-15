package com.company.assembleegameclient.util {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.particles.ParticleLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.IMusic;
import com.company.assembleegameclient.sound.SFX;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.forge.forgeProperties;
import com.company.assembleegameclient.ui.options.Options;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.ImageSet;
import flash.display.BitmapData;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;
import kabam.rotmg.assets.EmbeddedAssets;
import kabam.rotmg.assets.EmbeddedData;

public class AssetLoader {

   public static var atlases:Vector.<BitmapData> = new <BitmapData>[new EmbeddedAssets.ground().bitmapData,new EmbeddedAssets.chars().bitmapData,new EmbeddedAssets.charMasks().bitmapData,new EmbeddedAssets.mapObjs().bitmapData];


   public var music:IMusic;

   public function AssetLoader() {
      music = new MusicProxy();
      super();
   }

   private static function addImages() : void {
      var _loc11_:* = null;
      var _loc32_:int = 0;
      var _loc37_:int = 0;
      var _loc38_:* = null;
      var _loc28_:int = 0;
      var _loc24_:* = null;
      var _loc9_:int = 0;
      var _loc25_:int = 0;
      var _loc29_:int = 0;
      var _loc22_:* = null;
      var _loc6_:int = 0;
      var _loc2_:int = 0;
      var _loc44_:int = 0;
      var _loc7_:* = null;
      var _loc15_:int = 0;
      var _loc35_:int = 0;
      var _loc19_:int = 0;
      var _loc5_:int = 0;
      var _loc20_:* = null;
      var _loc13_:* = null;
      var _loc42_:* = null;
      var _loc17_:* = null;
      var _loc21_:* = null;
      var _loc12_:* = undefined;
      var _loc30_:int = 0;
      var _loc4_:* = undefined;
      var _loc40_:int = 0;
      var _loc39_:int = 0;
      var _loc8_:* = null;
      var _loc26_:* = undefined;
      var _loc27_:int = 0;
      var _loc46_:* = undefined;
      var _loc41_:int = 0;
      var _loc34_:int = 0;
      var _loc1_:int = 0;
      var _loc33_:int = 0;
      var _loc43_:* = null;
      var _loc36_:* = undefined;
      var _loc16_:Dictionary = new Dictionary();
      var _loc31_:Dictionary = new Dictionary();
      var _loc45_:Dictionary = new Dictionary();
      var _loc14_:Object = JSON.parse(String(new EmbeddedAssets.atlasData()));
      var _loc47_:int = _loc14_.sprites.length;
      var _loc18_:Vector.<String> = new Vector.<String>();
      var _loc10_:Vector.<String> = new Vector.<String>();
      _loc25_ = 0;
      while(_loc25_ < _loc47_) {
         _loc38_ = _loc14_.sprites[_loc25_];
         _loc28_ = parseInt(_loc38_.index);
         _loc24_ = _loc38_.spriteSheetName;
         _loc6_ = parseInt(_loc38_.atlasId);
         _loc22_ = atlases[_loc6_ - 1];
         _loc11_ = _loc38_.position;
         _loc32_ = parseInt(_loc11_.w);
         _loc37_ = parseInt(_loc11_.h);
         _loc2_ = parseInt(_loc11_.x);
         var _loc3_:int = parseInt(_loc11_.y);
         if(_loc6_ == 1) {
            _loc2_ = _loc2_ + 1;
            _loc3_ = _loc3_ + 1;
            _loc32_ = _loc32_ - 2;
            _loc37_ = _loc37_ - 2;
         }
         if(!(_loc24_ in _loc16_)) {
            _loc16_[_loc24_] = new Vector.<BitmapData>(0);
         }
         _loc44_ = _loc16_[_loc24_].length;
         if(_loc44_ - 1 < _loc28_) {
            _loc29_ = 0;
            while(_loc29_ < _loc28_ - _loc44_ + 1) {
               _loc16_[_loc24_].push(null);
               _loc29_++;
            }
         }
         _loc16_[_loc24_][_loc28_] = BitmapUtil.cropToBitmapData(_loc22_,_loc2_,_loc3_,_loc32_,_loc37_,_loc6_ == 1?0:_loc11_.padding);
         _loc25_++;
      }
      var _loc23_:int = _loc14_.animatedSprites.length;
      _loc25_ = 0;
      while(_loc25_ < _loc23_) {
         _loc38_ = _loc14_.animatedSprites[_loc25_];
         _loc28_ = parseInt(_loc38_.index);
         _loc24_ = _loc38_.spriteSheetName;
         _loc7_ = _loc38_.spriteData;
         _loc15_ = parseInt(_loc38_.action);
         _loc11_ = _loc7_.position;
         _loc32_ = parseInt(_loc7_.w);
         _loc37_ = parseInt(_loc7_.h);
         _loc9_ = parseInt(_loc38_.direction);
         _loc22_ = atlases[_loc7_.atlasId - 1];
         if(_loc18_.indexOf(_loc24_) == -1 && _loc9_ == 0) {
            _loc18_.push(_loc24_);
         }
         if(_loc18_.indexOf(_loc24_) != -1 && _loc9_ != 0) {
            _loc18_.splice(_loc18_.indexOf(_loc24_),1);
         }
         if(_loc10_.indexOf(_loc24_) == -1 && _loc9_ == 2) {
            _loc10_.push(_loc24_);
         }
         if(_loc10_.indexOf(_loc24_) != -1 && _loc9_ != 2) {
            _loc10_.splice(_loc10_.indexOf(_loc24_),1);
         }
         if(!(_loc24_ in _loc31_)) {
            _loc31_[_loc24_] = new Vector.<Vector.<Vector.<Vector.<MaskedImage>>>>(0);
         }
         if(!(_loc24_ in _loc45_)) {
            _loc45_[_loc24_] = new Vector.<int>(0);
         }
         _loc35_ = _loc31_[_loc24_].length;
         if(_loc35_ - 1 < _loc28_) {
            _loc29_ = 0;
            while(_loc29_ < _loc28_ - _loc35_ + 1) {
               _loc31_[_loc24_].push(new Vector.<Vector.<Vector.<MaskedImage>>>(0));
               _loc31_[_loc24_][_loc35_ + _loc29_].push(new <Vector.<MaskedImage>>[new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0)],new <Vector.<MaskedImage>>[new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0)],new <Vector.<MaskedImage>>[new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0)],new <Vector.<MaskedImage>>[new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0),new Vector.<MaskedImage>(0)]);
               _loc29_++;
            }
         }
         _loc19_ = _loc45_[_loc24_].length;
         if(_loc19_ - 1 < _loc28_) {
            _loc29_ = 0;
            while(_loc29_ < _loc28_ - _loc19_ + 1) {
               _loc45_[_loc24_].push(new <int>[-1,-1,-1]);
               _loc29_++;
            }
         }
         _loc5_ = _loc11_.w == _loc11_.h * 2 && _loc15_ == 2?_loc7_.padding:0;
         _loc20_ = null;
         _loc13_ = _loc7_.maskPosition;
         if(_loc13_.h != 0 && _loc13_.w != 0) {
            _loc20_ = BitmapUtil.cropToBitmapData(atlases[2],_loc13_.x,_loc13_.y,_loc13_.w,_loc13_.h,0,_loc5_);
         }
         _loc42_ = BitmapUtil.cropToBitmapData(_loc22_,_loc11_.x,_loc11_.y,_loc11_.w,_loc11_.h,0,_loc5_);
         if(!_loc31_[_loc24_][_loc28_][_loc9_][_loc15_]) {
            _loc31_[_loc24_][_loc28_][_loc9_][_loc15_] = new Vector.<MaskedImage>();
         } else {
            _loc31_[_loc24_][_loc28_][_loc9_][_loc15_].push(new MaskedImage(_loc42_,_loc20_));
         }
         if(_loc11_.h > _loc45_[_loc24_][_loc28_]) {
            _loc45_[_loc24_][_loc28_] = _loc11_.h;
         }
         _loc25_++;
      }
      var _loc49_:int = 0;
      var _loc48_:* = _loc16_;
      for(_loc17_ in _loc16_) {
         _loc21_ = new ImageSet();
         _loc12_ = _loc16_[_loc17_];
         _loc30_ = _loc12_.length;
         _loc25_ = 0;
         while(_loc25_ < _loc30_) {
            _loc21_.add(_loc12_[_loc25_]);
            _loc25_++;
         }
         AssetLibrary.addImageSet(_loc17_ as String,_loc21_);
      }
      _loc17_ = null;
      var _loc51_:int = 0;
      var _loc50_:* = _loc31_;
      for(_loc17_ in _loc31_) {
         _loc4_ = _loc31_[_loc17_];
         _loc40_ = _loc4_.length;
         _loc25_ = 0;
         while(_loc25_ < _loc40_) {
            _loc39_ = _loc45_[_loc17_][_loc25_];
            if(_loc39_ == 0 || _loc39_ == -1) {
               _loc39_ = 32;
            }
            _loc9_ = 1;
            _loc8_ = new AnimatedChar(_loc39_,_loc39_);
            _loc26_ = _loc4_[_loc25_];
            _loc27_ = _loc26_.length;
            _loc29_ = 0;
            while(_loc29_ < _loc27_) {
               if(!(_loc29_ == 1 || _loc29_ != 0 && _loc18_.indexOf(_loc17_ as String) != -1 || _loc29_ != 2 && _loc10_.indexOf(_loc17_ as String) != -1)) {
                  _loc46_ = _loc26_[_loc29_];
                  _loc41_ = _loc46_.length;
                  _loc33_ = 1;
                  while(_loc33_ < _loc41_) {
                     _loc1_ = 4 - _loc33_ - _loc46_[_loc33_].length;
                     if(_loc1_ > 0) {
                        if(_loc46_[_loc33_].length > 0) {
                           _loc43_ = _loc46_[_loc33_][_loc46_[_loc33_].length - 1];
                        } else if(_loc46_[_loc33_ == 1?2:1].length > 0) {
                           _loc43_ = _loc46_[_loc33_ == 1?2:1][_loc46_[_loc33_ == 1?2:1].length - 1];
                        }
                     }
                     _loc34_ = 0;
                     while(_loc34_ < _loc1_) {
                        _loc46_[_loc33_].push(!!_loc43_?_loc43_:new MaskedImage(new BitmapData(_loc39_,_loc39_,true,0),null));
                        _loc34_++;
                     }
                     _loc8_.setImageVec(_loc29_,_loc33_,_loc46_[_loc33_]);
                     if(_loc18_.indexOf(_loc17_ as String) != -1) {
                        _loc8_.setImageVec(2,_loc33_,_loc46_[_loc33_]);
                        _loc8_.setImageVec(3,_loc33_,_loc46_[_loc33_]);
                     }
                     if(_loc10_.indexOf(_loc17_ as String) != -1) {
                        _loc8_.setImageVec(0,_loc33_,_loc46_[_loc33_]);
                        _loc8_.setImageVec(3,_loc33_,_loc46_[_loc33_]);
                     }
                     if(_loc46_[_loc33_].length == 1 && _loc33_ == 2) {
                        _loc36_ = new Vector.<MaskedImage>(0);
                        _loc34_ = 0;
                        while(_loc34_ < 3) {
                           _loc36_.push(_loc46_[1][0]);
                           _loc34_++;
                        }
                        _loc8_.setImageVec(_loc29_,_loc33_,_loc36_);
                        if(_loc18_.indexOf(_loc17_ as String) != -1) {
                           _loc34_ = 1;
                           while(_loc34_ < 3) {
                              _loc8_.setImageVec(2,_loc34_,_loc36_);
                              _loc8_.setImageVec(3,_loc34_,_loc36_);
                              _loc34_++;
                           }
                        }
                        if(_loc10_.indexOf(_loc17_ as String) != -1) {
                           _loc34_ = 1;
                           while(_loc34_ < 3) {
                              _loc8_.setImageVec(0,_loc34_,_loc36_);
                              _loc8_.setImageVec(3,_loc34_,_loc36_);
                              _loc34_++;
                           }
                        }
                     }
                     _loc33_++;
                  }
               }
               _loc29_++;
            }
            AnimatedChars.add(_loc17_ as String,_loc8_);
            _loc25_++;
         }
      }
      atlases.length = 0;
   }

   private static function addIndividualSprites() : void {
      for each (var cls:* in EmbeddedAssets.individualSprites) {
         var str:String = cls.toLocaleString();
         str = str.substr("[object ".length);
         str = str.substr(0, str.length - 1); // ']'
         AssetLibrary.addImage(str, cls.bitmapData);
      }
   }

   private static function addSoundEffects() : void {
      SoundEffectLibrary.load("button_click");
      SoundEffectLibrary.load("death_screen");
      SoundEffectLibrary.load("enter_realm");
      SoundEffectLibrary.load("error");
      SoundEffectLibrary.load("inventory_move_item");
      SoundEffectLibrary.load("level_up");
      SoundEffectLibrary.load("loot_appears");
      SoundEffectLibrary.load("no_mana");
      SoundEffectLibrary.load("use_key");
      SoundEffectLibrary.load("use_potion");
   }

   private static function parseParticleEffects() : void {
      ParticleLibrary.parseFromXML(XML(new EmbeddedAssets.particlesXML()));
   }

   private static function parseGroundFiles() : void {
      var _loc3_:int = 0;
      var _loc2_:* = EmbeddedData.groundFiles;
      for each(var _loc1_ in EmbeddedData.groundFiles) {
         GroundLibrary.parseFromXML(XML(_loc1_));
      }
   }

   private static function parseObjectFiles() : void {
      var _loc2_:int = 0;
      var _loc1_:int = 0;
      while(_loc1_ < 25) {
         ObjectLibrary.parseFromXML(XML(EmbeddedData.objectFiles[_loc1_]));
         _loc1_++;
      }
      _loc2_ = 0;
      while(_loc2_ < EmbeddedData.objectFiles.length) {
         ObjectLibrary.parseDungeonXML(getQualifiedClassName(EmbeddedData.objectFiles[_loc2_]),XML(EmbeddedData.objectFiles[_loc2_]));
         _loc2_++;
      }
      ObjectLibrary.parseFromXML(XML(EmbeddedData.objectFiles[_loc1_]));
   }

   public function load() : void {
      addImages();
      addIndividualSprites();
      parseParticleEffects();
      parseGroundFiles();
      parseObjectFiles();
      addSoundEffects();
      ObjectLibrary.parseForgeXML(XML(new forgeProperties()));
      Parameters.load();
      Options.refreshCursor();
      this.music.load();
      SFX.load();
   }
}
}
