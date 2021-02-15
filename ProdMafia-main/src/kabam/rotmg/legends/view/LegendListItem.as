package kabam.rotmg.legends.view {
   import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.IIterator;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.legends.model.Legend;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   
   public class LegendListItem extends Sprite {
      
      private static const FONT_SIZE:int = 22;
      
      public static const WIDTH:int = 756;
      
      public static const HEIGHT:int = 56;
       
      
      public const selected:Signal = new Signal(Legend);
      
      private var legend:Legend;
      
      private var placeText:TextFieldDisplayConcrete;
      
      private var characterBitmap:Bitmap;
      
      private var nameText:TextFieldDisplayConcrete;
      
      private var inventoryGrid:EquippedGrid;
      
      private var totalFameText:TextFieldDisplayConcrete;
      
      private var fameIcon:Bitmap;
      
      private var isOver:Boolean;
      
      public function LegendListItem(param1:Legend) {
         super();
         this.legend = param1;
         this.makePlaceText();
         this.makeCharacterBitmap();
         this.makeNameText();
         this.makeInventory();
         this.makeTotalFame();
         this.makeFameIcon();
         this.addMouseListeners();
         this.draw();
      }
      
      private function makePlaceText() : void {
         this.placeText = new TextFieldDisplayConcrete().setSize(22).setColor(this.getTextColor());
         var _loc1_:String = this.legend.place == -1?"---":this.legend.place.toString() + ".";
         this.placeText.setBold(this.legend.place != -1);
         this.placeText.setStringBuilder(new StaticStringBuilder(_loc1_));
         this.placeText.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.placeText.x = 82 - this.placeText.width;
         this.placeText.y = 17;
         addChild(this.placeText);
      }
      
      private function makeCharacterBitmap() : void {
         this.characterBitmap = new Bitmap(this.legend.character);
         this.characterBitmap.x = 116;
         this.characterBitmap.y = 28 - this.characterBitmap.height / 2 - 2;
         addChild(this.characterBitmap);
      }
      
      private function makeNameText() : void {
         this.nameText = new TextFieldDisplayConcrete().setSize(22).setColor(this.getTextColor());
         this.nameText.setBold(true);
         this.nameText.setStringBuilder(new StaticStringBuilder(this.legend.name));
         this.nameText.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.nameText.x = 170;
         this.nameText.y = 17;
         addChild(this.nameText);
      }
      
      private function makeInventory() : void {
         var _loc1_:* = null;
         this.inventoryGrid = new EquippedGrid(null,this.legend.equipmentSlots,null);
         var _loc2_:IIterator = this.inventoryGrid.createInteractiveItemTileIterator();
         while(_loc2_.hasNext()) {
            _loc1_ = InteractiveItemTile(_loc2_.next());
            _loc1_.setInteractive(false);
         }
         this.inventoryGrid.setItems(this.legend.equipment);
         this.inventoryGrid.x = 400;
         this.inventoryGrid.y = 8;
         addChild(this.inventoryGrid);
      }
      
      private function makeTotalFame() : void {
         this.totalFameText = new TextFieldDisplayConcrete().setSize(22).setColor(this.getTextColor());
         this.totalFameText.setBold(true);
         this.totalFameText.setStringBuilder(new StaticStringBuilder(this.legend.totalFame.toString()));
         this.totalFameText.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.totalFameText.x = 660 - this.totalFameText.width;
         this.totalFameText.y = 17;
         addChild(this.totalFameText);
      }
      
      private function makeFameIcon() : void {
         var _loc1_:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",224);
         this.fameIcon = new Bitmap(TextureRedrawer.redraw(_loc1_,40,true,0));
         this.fameIcon.x = 630;
         this.fameIcon.y = 28 - this.fameIcon.height / 2;
         addChild(this.fameIcon);
      }
      
      private function getTextColor() : uint {
         var _loc1_:int = 0;
         if(this.legend.isOwnLegend) {
            _loc1_ = 16564761;
         } else if(this.legend.place == 1) {
            _loc1_ = 16646031;
         } else {
            _loc1_ = 16777215;
         }
         return _loc1_;
      }
      
      private function addMouseListeners() : void {
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
         addEventListener("click",this.onClick);
      }
      
      private function draw() : void {
         graphics.clear();
         graphics.beginFill(0,!!this.isOver?0.4:0.001);
         graphics.drawRect(0,0,756,56);
         graphics.endFill();
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.isOver = true;
         this.draw();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.isOver = false;
         this.draw();
      }
      
      private function onClick(param1:MouseEvent) : void {
         this.selected.dispatch(this.legend);
      }
   }
}
