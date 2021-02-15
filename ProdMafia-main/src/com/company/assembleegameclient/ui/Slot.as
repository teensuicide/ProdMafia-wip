package com.company.assembleegameclient.ui {
   import com.company.util.GraphicsUtil;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import kabam.rotmg.constants.ItemConstants;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class Slot extends Sprite {
      
      public static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      public static const WIDTH:int = 40;
      
      public static const HEIGHT:int = 40;
      
      public static const BORDER:int = 4;
      
      private static const greyColorFilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(3552822));
       
      
      public var type_:int;
      
      public var hotkey_:int;
      
      public var cuts_:Array;
      
      public var backgroundImage_:Bitmap;
      
      protected var fill_:GraphicsSolidFill;
      
      protected var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      public function Slot(param1:int, param2:int, param3:Array) {
         fill_ = new GraphicsSolidFill(5526612,1);
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[fill_,path_,GraphicsUtil.END_FILL];
         super();
         this.type_ = param1;
         this.hotkey_ = param2;
         this.cuts_ = param3;
         this.drawBackground();
      }
      
      protected function offsets(param1:int, param2:int, param3:Boolean) : Point {
         var _loc4_:Point = new Point();
         var _loc5_:* = int(param2) - 9;
         switch(_loc5_) {
            case 0:
               _loc4_.x = param1 == 2878?0:-2;
               _loc4_.y = !!param3?-2:0;
               break;
            case 2:
               _loc4_.y = -2;
               break;
            default:
               _loc4_.x = param1 == 2878?0:-2;
               _loc4_.y = !!param3?-2:0;
         }
         return _loc4_;
      }
      
      protected function drawBackground() : void {
         var _loc2_:* = null;
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(0,0,20,20,4,this.cuts_,this.path_);
         graphics.clear();
         graphics.drawGraphicsData(this.graphicsData_);
         var _loc3_:BitmapData = ItemConstants.itemTypeToBaseSprite(this.type_);
         if(this.backgroundImage_ == null) {
            if(_loc3_ != null) {
               _loc2_ = this.offsets(-1,this.type_,true);
               this.backgroundImage_ = new Bitmap(_loc3_);
               this.backgroundImage_.x = 2 + _loc2_.x;
               this.backgroundImage_.y = 2 + _loc2_.y;
               this.backgroundImage_.scaleX = 2;
               this.backgroundImage_.scaleY = 2;
               this.backgroundImage_.filters = [greyColorFilter];
               addChild(this.backgroundImage_);
            } else if(this.hotkey_ > 0) {
               _loc3_ = BitmapTextFactory.make(this.hotkey_.toString(),13,3552822,true,IDENTITY_MATRIX,false);
               this.backgroundImage_ = new Bitmap(_loc3_);
               this.backgroundImage_.x = 10 - _loc3_.width / 2;
               this.backgroundImage_.y = 2;
               addChild(this.backgroundImage_);
            }
         }
      }
   }
}
