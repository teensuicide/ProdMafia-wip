package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BoostPanelButton extends Sprite {
      
      public static const IMAGE_SET_NAME:String = "lofiInterfaceBig";
      
      public static const IMAGE_ID:int = 22;
       
      
      private var boostPanel:BoostPanel;
      
      private var player:Player;
      
      public function BoostPanelButton(param1:Player) {
         var _loc3_:* = null;
         super();
         this.player = param1;
         var _loc2_:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig",22);
         var _loc4_:BitmapData = TextureRedrawer.redraw(_loc2_,20,true,0);
         _loc3_ = new Bitmap(_loc4_);
         _loc3_.x = -7;
         _loc3_.y = -10;
         addChild(_loc3_);
         addEventListener("mouseOver",this.onButtonOver,false,0,true);
         addEventListener("mouseOut",this.onButtonOut,false,0,true);
      }
      
      private function positionBoostPanel() : void {
         this.boostPanel.x = -this.boostPanel.width;
         this.boostPanel.y = -this.boostPanel.height;
      }
      
      private function onButtonOver(param1:Event) : void {
         var _loc2_:* = new BoostPanel(this.player);
         this.boostPanel = _loc2_;
         addChild(_loc2_);
         this.boostPanel.resized.add(this.positionBoostPanel);
         this.positionBoostPanel();
      }
      
      private function onButtonOut(param1:Event) : void {
         if(this.boostPanel) {
            this.boostPanel.dispose();
            removeChild(this.boostPanel);
         }
      }
   }
}
