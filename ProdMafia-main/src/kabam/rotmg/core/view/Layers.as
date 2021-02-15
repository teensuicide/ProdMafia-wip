package kabam.rotmg.core.view {
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.popups.PopupView;
   import kabam.rotmg.dialogs.view.DialogsView;
   import kabam.rotmg.tooltips.view.TooltipsView;
   
   public class Layers extends Sprite {
       
      
      public var overlay:DisplayObjectContainer;
      
      public var top:DisplayObjectContainer;
      
      public var mouseDisabledTop:DisplayObjectContainer;
      
      public var api:DisplayObjectContainer;
      
      public var console:DisplayObjectContainer;
      
      private var menu:ScreensView;
      
      private var tooltips:TooltipsView;
      
      private var dialogs:DialogsView;
      
      private var popups:PopupView;
      
      public function Layers() {
         super();
         var _loc1_:* = new ScreensView();
         this.menu = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.overlay = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.top = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.mouseDisabledTop = _loc1_;
         addChild(_loc1_);
         this.mouseDisabledTop.mouseEnabled = false;
         _loc1_ = new PopupView();
         this.popups = _loc1_;
         addChild(_loc1_);
         _loc1_ = new DialogsView();
         this.dialogs = _loc1_;
         addChild(_loc1_);
         _loc1_ = new TooltipsView();
         this.tooltips = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.api = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Sprite();
         this.console = _loc1_;
         addChild(_loc1_);
      }
   }
}
