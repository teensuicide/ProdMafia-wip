package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.ui.panels.PortalPanel;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class Portal extends GameObject implements IInteractiveObject {
      
      private static const NAME_PARSER:RegExp = /(^\s+)\s\(([0-9]+)\/[0-9]+\)/;
       
      
      public var nexusPortal_:Boolean;
      
      public var lockedPortal_:Boolean;
      
      public var active_:Boolean = true;
      
      public var openedAtTimestamp:int = -1;
      
      public function Portal(param1:XML) {
         super(param1);
         isInteractive_ = true;
         this.nexusPortal_ = "NexusPortal" in param1;
         this.lockedPortal_ = "LockedPortal" in param1;
      }
      
      override public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
         var _loc4_:Boolean = super.addTo(param1,param2,param3);
         if(Parameters.data.autoEnterPortals) {
            if(Parameters.player && Parameters.player.getDistFromSelf(param2,param3) <= 4) {
               Parameters.player.follow(param2,param3);
            }
         }
         return _loc4_;
      }
      
      override protected function makeNameBitmapData() : BitmapData {
         return BitmapTextFactory.make(name_,16,16777215,true,IDENTITY_MATRIX,true);
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         super.draw(param1,param2,param3);
         if(this.nexusPortal_) {
            drawName(param1,param2,false);
         }
      }
      
      public function getPanel(param1:GameSprite) : Panel {
         return new PortalPanel(param1,this);
      }
   }
}
