package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class ArenaPortal extends Portal implements IInteractiveObject {
       
      
      public function ArenaPortal(param1:XML) {
         super(param1);
         isInteractive_ = true;
         name_ = "";
      }
      
      override public function getPanel(param1:GameSprite) : Panel {
         return new ArenaPortalPanel(param1,this);
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         super.draw(param1,param2,param3);
         drawName(param1,param2,false);
      }
      
      override protected function makeNameBitmapData() : BitmapData {
         return BitmapTextFactory.make(name_,16,16777215,true,IDENTITY_MATRIX,true);
      }
   }
}
