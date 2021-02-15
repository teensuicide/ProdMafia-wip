package kabam.rotmg.game.view.components {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
   import flash.display.Sprite;
   import kabam.rotmg.ui.view.PotionInventoryView;
   
   public class InventoryTabContent extends Sprite {
       
      
      private var storageContent:Sprite;
      
      private var potionsInventory:PotionInventoryView;
      
      private var _storage:InventoryGrid;
      
      public function InventoryTabContent(param1:Player) {
         storageContent = new Sprite();
         potionsInventory = new PotionInventoryView(param1.quickSlotUpgrade);
         super();
         this.init(param1);
         this.addChildren();
         this.positionChildren();
         name = "Main Inventory";
      }
      
      public function get storage() : InventoryGrid {
         return this._storage;
      }
      
      private function init(param1:Player) : void {
         this._storage = new InventoryGrid(param1,param1,4);
         this.storageContent.name = "Main Inventory";
      }
      
      private function addChildren() : void {
         this.storageContent.addChild(this._storage);
         this.storageContent.addChild(this.potionsInventory);
         addChild(this.storageContent);
      }
      
      private function positionChildren() : void {
         this.storageContent.x = 7;
         this.storageContent.y = 7;
         this.potionsInventory.y = this._storage.height + 4;
      }
   }
}
