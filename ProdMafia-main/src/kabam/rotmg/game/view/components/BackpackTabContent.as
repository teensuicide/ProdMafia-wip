package kabam.rotmg.game.view.components {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
   import flash.display.Sprite;
   import kabam.rotmg.ui.view.PotionInventoryView;
   
   public class BackpackTabContent extends Sprite {
       
      
      private var backpackContent:Sprite;
      
      private var backpackPotionsInventory:PotionInventoryView;
      
      private var _backpack:InventoryGrid;
      
      public function BackpackTabContent(param1:Player) {
         backpackContent = new Sprite();
         backpackPotionsInventory = new PotionInventoryView(param1.quickSlotUpgrade);
         super();
         this.init(param1);
         this.addChildren();
         this.positionChildren();
         name = "Backpack";
      }
      
      public function get backpack() : InventoryGrid {
         return this._backpack;
      }
      
      private function init(param1:Player) : void {
         name = "Backpack";
         this._backpack = new InventoryGrid(param1,param1,12,true);
      }
      
      private function positionChildren() : void {
         this.backpackContent.x = 7;
         this.backpackContent.y = 7;
         this.backpackPotionsInventory.y = this._backpack.height + 4;
      }
      
      private function addChildren() : void {
         this.backpackContent.addChild(this._backpack);
         this.backpackContent.addChild(this.backpackPotionsInventory);
         addChild(this.backpackContent);
      }
   }
}
