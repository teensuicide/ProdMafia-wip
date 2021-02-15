package io.decagames.rotmg.pets.data.skin {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class PetSkinRenderer {


    public function PetSkinRenderer() {
        super();
    }
    protected var _skinType:int;
    protected var skin:AnimatedChar;

    public function getSkinBitmap():Bitmap {
        this.makeSkin();
        if (this.skin == null) {
            return null;
        }
        var _loc2_:MaskedImage = this.skin.imageFromAngle(0, 0, 0);
        var _loc1_:int = this.skin.getHeight() == 16 ? 40 : 80;
        var _loc3_:BitmapData = TextureRedrawer.resize(_loc2_.image_, _loc2_.mask_, _loc1_, true, 0, 0);
        _loc3_ = GlowRedrawer.outlineGlow(_loc3_, 0);
        return new Bitmap(_loc3_);
    }

    public function getSkinMaskedImage():MaskedImage {
        this.makeSkin();
        return !this.skin ? null : this.skin.imageFromAngle(0, 0, 0);
    }

    protected function makeSkin():void {
        var _loc2_:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(this._skinType));
        if (_loc2_ == null) {
            return;
        }
        var _loc1_:String = _loc2_.AnimatedTexture.File;
        var _loc3_:int = _loc2_.AnimatedTexture.Index;
        this.skin = AnimatedChars.getAnimatedChar(_loc1_, _loc3_);
    }
}
}
