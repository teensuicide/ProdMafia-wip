package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.util.PointUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import kabam.rotmg.text.view.BitmapTextFactory;
   import kabam.rotmg.ui.view.components.PotionSlotView;
   
   public class ItemTileSprite extends Sprite {
      
      protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4,0,0,0,0,0,0.4,0,0,0,0,0,0.4,0,0,0,0,0,1,0])];
      
      private static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      private static const DOSE_MATRIX:Matrix = function():Matrix {
         var _loc1_:* = new Matrix();
         _loc1_.translate(8,7);
         return _loc1_;
      }();
       
      
      public var itemId:int;
      
      public var itemBitmap:Bitmap;
      
      public function ItemTileSprite() {
         super();
         this.itemBitmap = new Bitmap();
         addChild(this.itemBitmap);
         this.itemId = -1;
      }
      
      public function setDim(param1:Boolean) : void {
         filters = !!param1?DIM_FILTER:null;
      }
      
      public function setType(param1:int) : void {
         this.itemId = param1;
         this.drawTile();
      }
      
      public function drawTile() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = this.itemId;
         if(_loc4_ != -1) {
            _loc1_ = ObjectLibrary.getRedrawnTextureFromType(_loc4_,80,true);
            _loc3_ = ObjectLibrary.xmlLibrary_[_loc4_];
            if(_loc3_ && "Doses" in _loc3_) {
               _loc1_ = _loc1_.clone();
               _loc2_ = BitmapTextFactory.make(_loc3_.Doses,12,16777215,false,IDENTITY_MATRIX,false);
               _loc2_.applyFilter(_loc2_,_loc2_.rect,PointUtil.ORIGIN,PotionSlotView.READABILITY_SHADOW_2);
               _loc1_.draw(_loc2_,DOSE_MATRIX);
            }
            if(_loc3_ && "Quantity" in _loc3_) {
               _loc1_ = _loc1_.clone();
               _loc2_ = BitmapTextFactory.make(_loc3_.Quantity,12,16777215,false,IDENTITY_MATRIX,false);
               _loc2_.applyFilter(_loc2_,_loc2_.rect,PointUtil.ORIGIN,PotionSlotView.READABILITY_SHADOW_2);
               _loc1_.draw(_loc2_,DOSE_MATRIX);
            }
            this.itemBitmap.bitmapData = _loc1_;
            this.itemBitmap.x = -_loc1_.width / 2;
            this.itemBitmap.y = -_loc1_.height / 2;
            visible = true;
         } else {
            visible = false;
         }
      }
   }
}
