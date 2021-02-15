package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.objects.particles.EffectProperties;
   import com.company.assembleegameclient.util.AnimatedChars;
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import kabam.rotmg.application.api.ApplicationSetup;
   import kabam.rotmg.core.StaticInjectorContext;
   
   public class TextureDataConcrete extends TextureData {
      
      public static var remoteTexturesUsed:Boolean = false;
       
      
      private var isUsingLocalTextures:Boolean;
      
      public function TextureDataConcrete(param1:XML) {
         var _loc2_:* = null;
         super();
         this.isUsingLocalTextures = this.getWhetherToUseLocalTextures();
         if("Texture" in param1) {
            this.parse(XML(param1.Texture),String(param1.@id));
         } else if("AnimatedTexture" in param1) {
            this.parse(XML(param1.AnimatedTexture),String(param1.@id));
         } else if("RemoteTexture" in param1) {
            this.parse(XML(param1.RemoteTexture));
         } else if("RandomTexture" in param1) {
            this.parse(XML(param1.RandomTexture),String(param1.@id));
         } else {
            this.parse(param1);
         }
         var _loc4_:int = 0;
         var _loc3_:* = param1.AltTexture;
         for each(_loc2_ in param1.AltTexture) {
            this.parse(_loc2_);
         }
         if("Mask" in param1) {
            this.parse(XML(param1.Mask));
         }
         if("Effect" in param1) {
            this.parse(XML(param1.Effect));
         }
      }
      
      override public function getTexture(param1:int = 0) : BitmapData {
         if(randomTextureData_ == null) {
            return texture_;
         }
         var _loc2_:TextureData = randomTextureData_[param1 % randomTextureData_.length];
         return _loc2_.getTexture(param1);
      }
      
      override public function getAltTextureData(param1:int) : TextureData {
         if(altTextures_ == null) {
            return null;
         }
         return altTextures_[param1];
      }
      
      private function getWhetherToUseLocalTextures() : Boolean {
         var _loc1_:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
         return _loc1_.useLocalTextures();
      }
      
      private function parse(param1:XML, param2:String = "") : void {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = param1;
         var _loc4_:* = _loc3_.name().toString();
         var _loc8_:* = _loc4_;
         switch(_loc8_) {
            case "Texture":
               if(_loc3_) {
                  texture_ = AssetLibrary.getImageFromSet(_loc3_.File,_loc3_.Index);
               } else {
                  texture_ = AssetLibrary.getImageFromSet("lofiObj3",0);
               }
               return;
            case "Mask":
               if(_loc3_) {
                  mask_ = AssetLibrary.getImageFromSet(_loc3_.File,_loc3_.Index);
               } else {
                  mask_ = AssetLibrary.getImageFromSet("lofiObj3",0);
               }
               return;
            case "Effect":
               if(_loc3_) {
                  effectProps_ = new EffectProperties(_loc3_);
               }
               return;
            case "AnimatedTexture":
               animatedChar_ = AnimatedChars.getAnimatedChar(_loc3_.File,_loc3_.Index);
               if(!animatedChar_) {
                  animatedChar_ = AnimatedChars.getAnimatedChar("players",0);
               }
               _loc5_ = animatedChar_.imageFromAngle(0,0,0);
               texture_ = _loc5_.image_;
               mask_ = _loc5_.mask_;
               return;
            case "RandomTexture":
               randomTextureData_ = new Vector.<TextureData>();
               _loc4_ = 0;
               _loc8_ = 0;
               var _loc7_:* = _loc3_.children();
               for each(_loc6_ in _loc3_.children()) {
                  randomTextureData_.push(new TextureDataConcrete(_loc6_));
               }
               return;
            case "AltTexture":
               if(altTextures_ == null) {
                  altTextures_ = new Dictionary();
               }
               altTextures_[int(_loc3_.@id)] = new TextureDataConcrete(_loc3_);
               return;
            default:
               return;
         }
      }
   }
}
