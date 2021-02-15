package kabam.rotmg.dailyLogin.view {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
   import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import kabam.rotmg.constants.ItemConstants;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.text.model.TextKey;
   import kabam.rotmg.text.view.BitmapTextFactory;
   import org.swiftsuspenders.Injector;
   
   public class ItemTileRenderer extends Sprite {
      
      protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4,0,0,0,0,0,0.4,0,0,0,0,0,0.4,0,0,0,0,0,1,0])];
      
      private static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      private static const DOSE_MATRIX:Matrix = function():Matrix {
         var _loc1_:Matrix = new Matrix();
         _loc1_.translate(10,5);
         return _loc1_;
      }();
       
      
      private var itemId:int;
      
      private var tooltip:ToolTip;
      
      private var itemBitmap:Bitmap;
      
      public function ItemTileRenderer(param1:int) {
         super();
         this.itemId = param1;
         this.itemBitmap = new Bitmap();
         addChild(this.itemBitmap);
         this.drawTile();
         this.addEventListener("mouseOver",this.onTileHover);
         this.addEventListener("mouseOut",this.onTileOut);
      }
      
      public function drawTile() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = this.itemId;
         if(_loc5_ != -1) {
            _loc1_ = ObjectLibrary.getRedrawnTextureFromType(_loc5_,100,true);
            _loc3_ = ObjectLibrary.xmlLibrary_[_loc5_];
            if(_loc3_ && _loc3_.hasOwnProperty("Doses")) {
               _loc1_ = _loc1_.clone();
               _loc4_ = BitmapTextFactory.make(_loc3_.Doses,12,16777215,false,IDENTITY_MATRIX,false);
               _loc1_.draw(_loc4_,DOSE_MATRIX);
            }
            if(_loc3_ && _loc3_.hasOwnProperty("Quantity")) {
               _loc1_ = _loc1_.clone();
               _loc2_ = BitmapTextFactory.make(_loc3_.Quantity,12,16777215,false,IDENTITY_MATRIX,false);
               _loc1_.draw(_loc2_,DOSE_MATRIX);
            }
            this.itemBitmap.bitmapData = _loc1_;
            this.itemBitmap.x = -_loc1_.width / 2;
            this.itemBitmap.y = -_loc1_.width / 2;
            visible = true;
         } else {
            visible = false;
         }
      }
      
      private function addToolTipToTile(param1:ItemTile) : void {
         var _loc3_:* = null;
         if(this.itemId > 0) {
            this.tooltip = new EquipmentToolTip(this.itemId,null,-1,"");
         } else {
            if(param1 is EquipmentTile) {
               _loc3_ = ItemConstants.itemTypeToName((param1 as EquipmentTile).itemType);
            } else {
               _loc3_ = "item.toolTip";
            }
            this.tooltip = new TextToolTip(3552822,10197915,null,"item.emptySlot",200,{"itemType":TextKey.wrapForTokenResolution(_loc3_)});
         }
         this.tooltip.attachToTarget(param1);
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc4_:ShowTooltipSignal = _loc2_.getInstance(ShowTooltipSignal);
         _loc4_.dispatch(this.tooltip);
      }
      
      private function onTileOut(param1:MouseEvent) : void {
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc3_:HideTooltipsSignal = _loc2_.getInstance(HideTooltipsSignal);
         _loc3_.dispatch();
      }
      
      private function onTileHover(param1:MouseEvent) : void {
         if(!stage) {
            return;
         }
         var _loc2_:ItemTile = param1.currentTarget as ItemTile;
         this.addToolTipToTile(_loc2_);
      }
   }
}
