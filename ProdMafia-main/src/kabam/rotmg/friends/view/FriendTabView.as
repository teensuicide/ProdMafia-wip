package kabam.rotmg.friends.view {
   import com.company.ui.BaseSimpleText;
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kabam.rotmg.game.view.components.TabBackground;
   import kabam.rotmg.game.view.components.TabTextView;
   import kabam.rotmg.game.view.components.TabView;
   import org.osflash.signals.Signal;
   
   public class FriendTabView extends Sprite {
       
      
      public const tabSelected:Signal = new Signal(String);
      
      private const TAB_WIDTH:int = 120;
      
      private const TAB_HEIGHT:int = 30;
      
      private const tabSprite:Sprite = new Sprite();
      
      private const background:Sprite = new Sprite();
      
      private const containerSprite:Sprite = new Sprite();
      
      public var tabs:Vector.<TabView>;
      
      public var currentTabIndex:int;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var contents:Vector.<Sprite>;
      
      public function FriendTabView(param1:Number, param2:Number) {
         tabs = new Vector.<TabView>();
         contents = new Vector.<Sprite>();
         super();
         this._width = param1;
         this._height = param2;
         this.tabSprite.addEventListener("click",this.onTabClicked);
         addChild(this.tabSprite);
         this.drawBackground();
         addChild(this.containerSprite);
      }
      
      public function destroy() : void {
         while(numChildren > 0) {
            this.removeChildAt(numChildren - 1);
         }
         this.tabSprite.removeEventListener("click",this.onTabClicked);
         this.tabs = null;
         this.contents = null;
      }
      
      public function addTab(param1:BaseSimpleText, param2:Sprite) : void {
         var _loc3_:int = this.tabs.length;
         var _loc4_:TabView = this.addTextTab(_loc3_,param1 as BaseSimpleText);
         this.tabs.push(_loc4_);
         this.tabSprite.addChild(_loc4_);
         param2.y = 35;
         this.contents.push(param2);
         this.containerSprite.addChild(param2);
         if(_loc3_ > 0) {
            param2.visible = false;
         } else {
            _loc4_.setSelected(true);
            this.showContent(0);
            this.tabSelected.dispatch(param2.name);
         }
      }
      
      public function clearTabs() : void {
         var _loc2_:int = 0;
         this.currentTabIndex = 0;
         var _loc1_:uint = this.tabs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_) {
            this.tabSprite.removeChild(this.tabs[_loc2_]);
            this.containerSprite.removeChild(this.contents[_loc2_]);
            _loc2_++;
         }
         this.tabs = new Vector.<TabView>();
         this.contents = new Vector.<Sprite>();
      }
      
      public function removeTab() : void {
      }
      
      public function setSelectedTab(param1:uint) : void {
         this.selectTab(this.tabs[param1]);
      }
      
      public function showTabBadget(param1:uint, param2:int) : void {
         var _loc3_:TabView = this.tabs[param1];
         (_loc3_ as TabTextView).setBadge(param2);
      }
      
      private function selectTab(param1:TabView) : void {
         var _loc2_:* = null;
         if(param1) {
            _loc2_ = this.tabs[this.currentTabIndex];
            if(_loc2_.index != param1.index) {
               _loc2_.setSelected(false);
               param1.setSelected(true);
               this.showContent(param1.index);
               this.tabSelected.dispatch(this.contents[param1.index].name);
            }
         }
      }
      
      private function addTextTab(param1:int, param2:BaseSimpleText) : TabTextView {
         var _loc4_:* = null;
         var _loc3_:Sprite = new TabBackground(120,30);
         _loc4_ = new TabTextView(param1,_loc3_,param2);
         _loc4_.x = param1 * (param2.width + 12);
         _loc4_.y = 4;
         return _loc4_;
      }
      
      private function showContent(param1:int) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 != this.currentTabIndex) {
            _loc2_ = this.contents[this.currentTabIndex];
            _loc3_ = this.contents[param1];
            _loc2_.visible = false;
            _loc3_.visible = true;
            this.currentTabIndex = param1;
         }
      }
      
      private function drawBackground() : void {
         var _loc3_:GraphicsSolidFill = new GraphicsSolidFill(2368034,1);
         var _loc1_:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         var _loc2_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc3_,_loc1_,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,this._width,this._height - 27,6,[1,1,1,1],_loc1_);
         this.background.graphics.drawGraphicsData(_loc2_);
         this.background.y = 27;
         addChild(this.background);
      }
      
      private function onTabClicked(param1:MouseEvent) : void {
         this.selectTab(param1.target.parent as TabView);
      }
   }
}
