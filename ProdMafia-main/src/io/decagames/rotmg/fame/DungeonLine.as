package io.decagames.rotmg.fame {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.TextureDataConcrete;
import com.company.assembleegameclient.util.TextureRedrawer;

import flash.display.Bitmap;

public class DungeonLine extends StatsLine {


    public function DungeonLine(param1:String, param2:String, param3:String) {
        this.dungeonTextureName = param2;
        super(param1, param3, "", 1);
    }
    private var dungeonTextureName:String;
    private var dungeonBitmap:Bitmap;

    override protected function setLabelsPosition():void {
        var _loc1_:* = null;
        var _loc2_:TextureDataConcrete = ObjectLibrary.dungeonToPortalTextureData_[this.dungeonTextureName];
        if (_loc2_) {
            _loc1_ = _loc2_.getTexture();
            _loc1_ = TextureRedrawer.redraw(_loc1_, 40, true, 0, false);
            this.dungeonBitmap = new Bitmap(_loc1_);
            this.dungeonBitmap.x = -Math.round(_loc1_.width / 2) + 13;
            this.dungeonBitmap.y = -Math.round(_loc1_.height / 2) + 11;
            addChild(this.dungeonBitmap);
        }
        label.y = 4;
        label.x = 24;
        lineHeight = 25;
        if (fameValue) {
            fameValue.y = 4;
        }
        if (lock) {
            lock.y = -6;
        }
    }

    override public function clean():void {
        super.clean();
        if (this.dungeonBitmap) {
            this.dungeonBitmap.bitmapData.dispose();
        }
    }
}
}
