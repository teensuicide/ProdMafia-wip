package com.company.assembleegameclient.ui.vault {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.scroll.UIScrollbar;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.textField.InputTextField;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class VaultView extends ModalPopup {
       
      
      private var searchInput:InputTextField;
      
      private var searchIcon:Bitmap;
      
      private var searchInset:SliceScalingBitmap;
      
      private var contentInset:SliceScalingBitmap;
      
      private var tiles:Vector.<InteractiveItemTile>;
      
      private var fakeGrid:ContainerGrid;
      
      private var scrollBar:UIScrollbar;
      
      private var gridContent:Sprite;
      
      public function VaultView(param1:String, param2:GameObject, param3:Player) {
         super(550,505,param1,DefaultLabelFormat.defaultSmallPopupTitle,new Rectangle(0,0,550,565),0.8,true,20,20);
         this.tiles = new Vector.<InteractiveItemTile>();
         this.fakeGrid = new ContainerGrid(param2,param3,true,true);
      }
      
      public function init(param1:Vector.<int>) : void {
         var _loc2_:* = null;
         this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",550);
         this.contentInset.height = 505;
         addChild(this.contentInset);
         this.gridContent = new Sprite();
         this.addChild(this.gridContent);
         this.scrollBar = new UIScrollbar(480);
         this.scrollBar.mouseRollSpeedFactor = 1;
         this.scrollBar.scrollObject = this;
         this.scrollBar.content = this.gridContent;
         this.scrollBar.x = this.contentInset.x + this.contentInset.width - 20;
         this.scrollBar.y = this.contentInset.y + 10;
         this.addChild(this.scrollBar);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length) {
            _loc2_ = new InteractiveItemTile(_loc3_,this.fakeGrid,true,true);
            _loc2_.setItem(param1[_loc3_]);
            this.tiles.push(_loc2_);
            _loc3_++;
         }
         this.gridContent.addChild(this.fakeGrid);
         _loc3_ = 0;
         while(_loc3_ < this.tiles.length) {
            this.fakeGrid.addTile(this.tiles[_loc3_],_loc3_);
            _loc3_++;
         }
      }
   }
}
