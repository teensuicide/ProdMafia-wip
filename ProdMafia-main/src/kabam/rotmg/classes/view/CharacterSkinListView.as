package kabam.rotmg.classes.view {
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import kabam.lib.ui.api.Size;
   import kabam.rotmg.util.components.VerticalScrollingList;
   
   public class CharacterSkinListView extends Sprite {
      
      public static const PADDING:int = 5;
      
      public static const WIDTH:int = 442;
      
      public static const HEIGHT:int = 400;
       
      
      private const list:VerticalScrollingList = makeList();
      
      private var items:Vector.<DisplayObject>;
      
      public function CharacterSkinListView() {
         super();
      }
      
      public function setItems(param1:Vector.<DisplayObject>) : void {
         this.items = param1;
         this.list.setItems(param1);
         this.onScrollStateChanged(this.list.isScrollbarVisible());
      }
      
      public function getListHeight() : Number {
         return this.list.getListHeight();
      }
      
      private function makeList() : VerticalScrollingList {
         var _loc1_:VerticalScrollingList = new VerticalScrollingList();
         _loc1_.setSize(new Size(442,400));
         _loc1_.scrollStateChanged.add(this.onScrollStateChanged);
         _loc1_.setPadding(5);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function onScrollStateChanged(param1:Boolean) : void {
         var _loc3_:* = null;
         var _loc2_:* = 420;
         if(!param1) {
            _loc2_ = _loc2_ + 22;
         }
         var _loc4_:* = this.items;
         var _loc7_:int = 0;
         var _loc6_:* = this.items;
         for each(_loc3_ in this.items) {
            _loc3_.setWidth(_loc2_);
         }
      }
   }
}
