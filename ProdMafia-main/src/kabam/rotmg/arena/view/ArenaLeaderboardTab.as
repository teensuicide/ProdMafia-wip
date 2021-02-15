package kabam.rotmg.arena.view {
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.arena.model.ArenaLeaderboardFilter;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   
   public class ArenaLeaderboardTab extends Sprite {
      
      private static const OVER_COLOR:int = 16567065;
      
      private static const DOWN_COLOR:int = 16777215;
      
      private static const OUT_COLOR:int = 11711154;
       
      
      public const selected:Signal = new Signal(ArenaLeaderboardTab);
      
      public var label:StaticTextDisplay;
      
      public var readyToAlign:Signal;
      
      private var filter:ArenaLeaderboardFilter;
      
      private var isOver:Boolean;
      
      private var isDown:Boolean;
      
      private var isSelected:Boolean = false;
      
      public function ArenaLeaderboardTab(param1:ArenaLeaderboardFilter) {
         this.label = this.makeLabel();
         this.readyToAlign = label.textChanged;
         super();
         this.filter = param1;
         this.label.setStringBuilder(new LineBuilder().setParams(param1.getName()));
         addChild(this.label);
         this.addMouseListeners();
      }
      
      public function destroy() : void {
         this.removeMouseListeners();
      }
      
      public function getFilter() : ArenaLeaderboardFilter {
         return this.filter;
      }
      
      public function setSelected(param1:Boolean) : void {
         this.isSelected = param1;
         this.redraw();
      }
      
      private function addMouseListeners() : void {
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("mouseOut",this.onMouseOut);
         addEventListener("mouseDown",this.onMouseDown);
         addEventListener("mouseUp",this.onMouseUp);
         addEventListener("click",this.onClick);
      }
      
      private function removeMouseListeners() : void {
         removeEventListener("mouseOver",this.onMouseOver);
         removeEventListener("mouseOut",this.onMouseOut);
         removeEventListener("mouseDown",this.onMouseDown);
         removeEventListener("mouseUp",this.onMouseUp);
         removeEventListener("click",this.onClick);
      }
      
      private function redraw() : void {
         if(this.isOver) {
            this.label.setColor(16567065);
         } else if(this.isSelected || this.isDown) {
            this.label.setColor(16777215);
         } else {
            this.label.setColor(11711154);
         }
      }
      
      private function makeLabel() : StaticTextDisplay {
         var _loc1_:* = null;
         _loc1_ = new StaticTextDisplay();
         _loc1_.setBold(true).setColor(11776947).setSize(20);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         return _loc1_;
      }
      
      private function onClick(param1:MouseEvent) : void {
         if(!this.isSelected) {
            this.selected.dispatch(this);
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         this.isDown = false;
         this.redraw();
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         this.isDown = true;
         this.redraw();
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.isOver = false;
         this.isDown = false;
         this.redraw();
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.isOver = true;
         this.redraw();
      }
   }
}
