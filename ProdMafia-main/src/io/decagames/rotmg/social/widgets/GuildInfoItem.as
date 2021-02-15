package io.decagames.rotmg.social.widgets {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   
   public class GuildInfoItem extends BaseInfoItem {
       
      
      private var _gName:String;
      
      private var _gFame:int;
      
      public function GuildInfoItem(param1:String, param2:int) {
         super(332,70);
         this._gName = param1;
         this._gFame = param2;
         this.init();
      }
      
      private function init() : void {
         this.createGuildName();
         this.createGuildFame();
      }
      
      private function createGuildName() : void {
         var _loc1_:* = null;
         _loc1_ = new UILabel();
         _loc1_.text = this._gName;
         DefaultLabelFormat.guildInfoLabel(_loc1_,24);
         _loc1_.x = (_width - _loc1_.width) / 2;
         _loc1_.y = 12;
         addChild(_loc1_);
      }
      
      private function createGuildFame() : void {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _loc4_ = new Sprite();
         addChild(_loc4_);
         var _loc1_:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",226);
         _loc1_ = TextureRedrawer.redraw(_loc1_,40,true,0);
         _loc3_ = new Bitmap(_loc1_);
         _loc3_.y = -6;
         _loc4_.addChild(_loc3_);
         _loc2_ = new UILabel();
         _loc2_.text = this._gFame.toString();
         DefaultLabelFormat.guildInfoLabel(_loc2_);
         _loc2_.x = _loc3_.width;
         _loc2_.y = 5;
         _loc4_.addChild(_loc2_);
         _loc4_.x = (_width - _loc4_.width) / 2;
         _loc4_.y = 36;
      }
   }
}
