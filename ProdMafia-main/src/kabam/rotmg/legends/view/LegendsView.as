package kabam.rotmg.legends.view {
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.ui.Scrollbar;
   import com.company.rotmg.graphics.ScreenGraphic;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.legends.model.Legend;
   import kabam.rotmg.legends.model.Timespan;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.components.ScreenBase;
   import org.osflash.signals.Signal;
   
   public class LegendsView extends Sprite {
       
      
      public const timespanChanged:Signal = new Signal(Timespan);
      
      public const showDetail:Signal = new Signal(Legend);
      
      public const close:Signal = new Signal();
      
      private const items:Vector.<LegendListItem> = new Vector.<LegendListItem>(0);
      
      private const tabs:Object = {};
      
      private var title:TextFieldDisplayConcrete;
      
      private var loadingBanner:TextFieldDisplayConcrete;
      
      private var noLegendsBanner:TextFieldDisplayConcrete;
      
      private var mainContainer:Sprite;
      
      private var closeButton:TitleMenuOption;
      
      private var scrollBar:Scrollbar;
      
      private var listContainer:Sprite;
      
      private var selectedTab:LegendsTab;
      
      private var legends:Vector.<Legend>;
      
      private var count:int;
      
      public function LegendsView() {
         super();
         this.makeScreenBase();
         this.makeTitleText();
         this.makeLoadingBanner();
         this.makeNoLegendsBanner();
         this.makeMainContainer();
         this.makeScreenGraphic();
         this.makeLines();
         this.makeScrollbar();
         this.makeTimespanTabs();
         this.makeCloseButton();
      }
      
      public function clear() : void {
         this.listContainer && this.clearLegendsList();
         this.listContainer = null;
         this.scrollBar.visible = false;
      }
      
      public function setLegendsList(param1:Timespan, param2:Vector.<Legend>) : void {
         this.clear();
         this.updateTabs(this.tabs[param1.getId()]);
         this.listContainer = new Sprite();
         this.legends = param2;
         this.count = param2.length;
         this.items.length = this.count;
         this.noLegendsBanner.visible = this.count == 0;
         this.makeItemsFromLegends();
         this.mainContainer.addChild(this.listContainer);
         this.updateScrollbar();
      }
      
      public function showLoading() : void {
         this.loadingBanner.visible = true;
      }
      
      public function hideLoading() : void {
         this.loadingBanner.visible = false;
      }
      
      private function makeScreenBase() : void {
         addChild(new ScreenBase());
      }
      
      private function makeTitleText() : void {
         this.title = new TextFieldDisplayConcrete().setSize(32).setColor(11776947);
         this.title.setAutoSize("center");
         this.title.setBold(true);
         this.title.setStringBuilder(new LineBuilder().setParams("Screens.legends"));
         this.title.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.title.x = 400 - this.title.width / 2;
         this.title.y = 24;
         addChild(this.title);
      }
      
      private function makeLoadingBanner() : void {
         this.loadingBanner = new TextFieldDisplayConcrete().setSize(22).setColor(11776947);
         this.loadingBanner.setBold(true);
         this.loadingBanner.setAutoSize("center").setVerticalAlign("middle");
         this.loadingBanner.setStringBuilder(new LineBuilder().setParams("Loading.text"));
         this.loadingBanner.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.loadingBanner.x = 400;
         this.loadingBanner.y = 300;
         this.loadingBanner.visible = false;
         addChild(this.loadingBanner);
      }
      
      private function makeNoLegendsBanner() : void {
         this.noLegendsBanner = new TextFieldDisplayConcrete().setSize(22).setColor(11776947);
         this.noLegendsBanner.setBold(true);
         this.noLegendsBanner.setAutoSize("center").setVerticalAlign("middle");
         this.noLegendsBanner.setStringBuilder(new LineBuilder().setParams("Legends.EmptyList"));
         this.noLegendsBanner.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.noLegendsBanner.x = 400;
         this.noLegendsBanner.y = 300;
         this.noLegendsBanner.visible = false;
         addChild(this.noLegendsBanner);
      }
      
      private function makeMainContainer() : void {
         var _loc2_:* = null;
         _loc2_ = new Shape();
         var _loc1_:Graphics = _loc2_.graphics;
         _loc1_.beginFill(0);
         _loc1_.drawRect(0,0,756,430);
         _loc1_.endFill();
         this.mainContainer = new Sprite();
         this.mainContainer.x = 10;
         this.mainContainer.y = 110;
         this.mainContainer.addChild(_loc2_);
         this.mainContainer.mask = _loc2_;
         addChild(this.mainContainer);
      }
      
      private function makeScreenGraphic() : void {
         addChild(new ScreenGraphic());
      }
      
      private function makeLines() : void {
         var _loc2_:Shape = new Shape();
         addChild(_loc2_);
         var _loc1_:Graphics = _loc2_.graphics;
         _loc1_.lineStyle(2,5526612);
         _loc1_.moveTo(0,100);
         _loc1_.lineTo(800,100);
      }
      
      private function makeScrollbar() : void {
         this.scrollBar = new Scrollbar(16,400);
         this.scrollBar.x = 800 - this.scrollBar.width - 4;
         this.scrollBar.y = 104;
         addChild(this.scrollBar);
      }
      
      private function makeTimespanTabs() : void {
         var _loc3_:int = 0;
         var _loc2_:Vector.<Timespan> = Timespan.TIMESPANS;
         var _loc1_:int = _loc2_.length;
         while(_loc3_ < _loc1_) {
            this.makeTab(_loc2_[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      private function makeTab(param1:Timespan, param2:int) : LegendsTab {
         var _loc3_:LegendsTab = new LegendsTab(param1);
         this.tabs[param1.getId()] = _loc3_;
         _loc3_.x = 20 + param2 * 90;
         _loc3_.y = 70;
         _loc3_.selected.add(this.onTabSelected);
         addChild(_loc3_);
         return _loc3_;
      }
      
      private function onTabSelected(param1:LegendsTab) : void {
         if(this.selectedTab != param1) {
            this.updateTabAndSelectTimespan(param1);
         }
      }
      
      private function updateTabAndSelectTimespan(param1:LegendsTab) : void {
         this.updateTabs(param1);
         this.timespanChanged.dispatch(this.selectedTab.getTimespan());
      }
      
      private function updateTabs(param1:LegendsTab) : void {
         this.selectedTab && this.selectedTab.setIsSelected(false);
         this.selectedTab = param1;
         this.selectedTab.setIsSelected(true);
      }
      
      private function makeCloseButton() : void {
         this.closeButton = new TitleMenuOption("Done.text",36,false);
         this.closeButton.setAutoSize("center");
         this.closeButton.setVerticalAlign("middle");
         this.closeButton.x = 400;
         this.closeButton.y = 553;
         addChild(this.closeButton);
         this.closeButton.addEventListener("click",this.onCloseClick);
      }
      
      private function clearLegendsList() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.items;
         var _loc5_:int = 0;
         var _loc4_:* = this.items;
         for each(_loc3_ in this.items) {
            _loc3_.selected.remove(this.onItemSelected);
         }
         this.items.length = 0;
         this.mainContainer.removeChild(this.listContainer);
         this.listContainer = null;
      }
      
      private function makeItemsFromLegends() : void {
         var _loc1_:int = 0;
         while(_loc1_ < this.count) {
            this.items[_loc1_] = this.makeItemFromLegend(_loc1_);
            _loc1_++;
         }
      }
      
      private function makeItemFromLegend(param1:int) : LegendListItem {
         var _loc2_:Legend = this.legends[param1];
         var _loc3_:LegendListItem = new LegendListItem(_loc2_);
         _loc3_.y = param1 * 56;
         _loc3_.selected.add(this.onItemSelected);
         this.listContainer.addChild(_loc3_);
         return _loc3_;
      }
      
      private function updateScrollbar() : void {
         if(this.listContainer.height > 400) {
            this.scrollBar.visible = true;
            this.scrollBar.setIndicatorSize(400,this.listContainer.height);
            this.scrollBar.addEventListener("change",this.onScrollBarChange);
            this.positionScrollbarToDisplayFocussedLegend();
         } else {
            this.scrollBar.removeEventListener("change",this.onScrollBarChange);
            this.scrollBar.visible = false;
         }
      }
      
      private function positionScrollbarToDisplayFocussedLegend() : void {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Legend = this.getLegendFocus();
         if(_loc2_) {
            _loc1_ = this.legends.indexOf(_loc2_);
            _loc3_ = (_loc1_ + 0.5) * 56;
            this.scrollBar.setPos((_loc3_ - 200) / (this.listContainer.height - 400));
         }
      }
      
      private function getLegendFocus() : Legend {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = this.legends;
         var _loc6_:int = 0;
         var _loc5_:* = this.legends;
         for each(_loc1_ in this.legends) {
            if(_loc1_.isFocus) {
               _loc3_ = _loc1_;
               break;
            }
         }
         return _loc3_;
      }
      
      private function onItemSelected(param1:Legend) : void {
         this.showDetail.dispatch(param1);
      }
      
      private function onCloseClick(param1:MouseEvent) : void {
         this.close.dispatch();
      }
      
      private function onScrollBarChange(param1:Event) : void {
         this.listContainer.y = -this.scrollBar.pos() * (this.listContainer.height - 400);
      }
   }
}
