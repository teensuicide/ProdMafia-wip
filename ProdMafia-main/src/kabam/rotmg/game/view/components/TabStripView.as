package kabam.rotmg.game.view.components {
   import com.company.assembleegameclient.objects.ImageFactory;
   import com.company.assembleegameclient.ui.icons.IconButtonFactory;
   import com.company.ui.BaseSimpleText;
   import com.company.util.GraphicsUtil;
   import flash.display.Bitmap;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class TabStripView extends Sprite {
       
      
      public const tabSelected:Signal = new Signal(String);
      
      public const WIDTH:Number = 186;
      
      public const HEIGHT:Number = 153;
      
      private const tabSprite:Sprite = new Sprite();
      
      private const background:Sprite = new Sprite();
      
      private const containerSprite:Sprite = new Sprite();
      
      public var iconButtonFactory:IconButtonFactory;
      
      public var imageFactory:ImageFactory;
      
      public var tabs:Vector.<TabView>;
      
      public var currentTabIndex:int;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var contents:Vector.<Sprite>;
      
      public function TabStripView(param1:Number = 186, param2:Number = 153) {
         tabs = new Vector.<TabView>();
         contents = new Vector.<Sprite>();
         super();
         this._width = param1;
         this._height = param2;
         this.tabSprite.addEventListener("click",this.onTabClicked);
         addChild(this.tabSprite);
         this.drawBackground();
         addChild(this.containerSprite);
         this.containerSprite.y = 27;
      }
      
      public function dispose() : void {
         this.tabSprite.removeEventListener("click",this.onTabClicked);
         this.tabs.length = 0;
         this.contents.length = 0;
      }
      
      public function setSelectedTab(param1:uint) : void {
         this.selectTab(this.tabs[param1]);
      }
      
      public function getTabView(param1:Class) : * {
         var _loc2_:* = null;
         var _loc3_:* = this.contents;
         var _loc6_:int = 0;
         var _loc5_:* = this.contents;
         for each(_loc2_ in this.contents) {
            if(_loc2_ is param1) {
               return _loc2_ as param1;
            }
         }
         return null;
      }
      
      public function drawBackground() : void {
         var _loc2_:GraphicsSolidFill = new GraphicsSolidFill(2368034,1);
         var _loc1_:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         var _loc3_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc2_,_loc1_,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,this._width,this._height - 27,6,[1,1,1,1],_loc1_);
         this.background.graphics.drawGraphicsData(_loc3_);
         this.background.y = 27;
         addChild(this.background);
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
      
      public function addTab(param1:*, param2:Sprite) : void {
         var _loc3_:* = null;
         var _loc4_:int = this.tabs.length;
         if(param1 is Bitmap) {
            _loc3_ = this.addIconTab(_loc4_,param1 as Bitmap);
         } else if(param1 is BaseSimpleText) {
            _loc3_ = this.addTextTab(_loc4_,param1 as BaseSimpleText);
         }
         this.tabs.push(_loc3_);
         this.tabSprite.addChild(_loc3_);
         this.contents.push(param2);
         this.containerSprite.addChild(param2);
         if(_loc4_ > 0) {
            param2.visible = false;
         } else {
            _loc3_.setSelected(true);
            this.showContent(0);
            this.tabSelected.dispatch(param2.name);
         }
      }
      
      public function removeTab() : void {
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
      
      private function addIconTab(param1:int, param2:Bitmap) : TabIconView {
         var _loc3_:* = null;
         var _loc4_:Sprite = new TabBackground();
         _loc3_ = new TabIconView(param1,_loc4_,param2);
         _loc3_.x = param1 * (_loc4_.width + 2);
         _loc3_.y = 8;
         return _loc3_;
      }
      
      private function addTextTab(param1:int, param2:BaseSimpleText) : TabTextView {
         var _loc4_:Sprite = new TabBackground();
         var _loc3_:TabTextView = new TabTextView(param1,_loc4_,param2);
         _loc3_.x = param1 * (_loc4_.width + 2);
         _loc3_.y = 8;
         return _loc3_;
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
      
      private function onTabClicked(param1:MouseEvent) : void {
         this.selectTab(param1.target.parent as TabView);
      }
   }
}
