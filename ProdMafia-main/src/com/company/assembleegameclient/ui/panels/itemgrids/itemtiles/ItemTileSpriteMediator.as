package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ItemTileSpriteMediator extends Mediator {
       
      
      [Inject]
      public var view:ItemTileSprite;
      
      public function ItemTileSpriteMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.drawTile();
      }
   }
}
