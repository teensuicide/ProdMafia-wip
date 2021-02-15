package kabam.rotmg.minimap.view {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import flash.utils.Dictionary;
   import kabam.rotmg.core.view.Layers;
   import kabam.rotmg.game.focus.control.SetGameFocusSignal;
   import kabam.rotmg.game.signals.ExitGameSignal;
   import kabam.rotmg.minimap.control.MiniMapZoomSignal;
   import kabam.rotmg.minimap.control.UpdateGameObjectTileSignal;
   import kabam.rotmg.minimap.control.UpdateGroundTileSignal;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.signals.UpdateHUDSignal;
   import robotlegs.bender.extensions.mediatorMap.api.IMediator;
   
   public class MiniMapMediator implements IMediator {
       
      
      [Inject]
      public var view:MiniMap;
      
      [Inject]
      public var model:HUDModel;
      
      [Inject]
      public var setFocus:SetGameFocusSignal;
      
      [Inject]
      public var updateGroundTileSignal:UpdateGroundTileSignal;
      
      [Inject]
      public var updateGameObjectTileSignal:UpdateGameObjectTileSignal;
      
      [Inject]
      public var miniMapZoomSignal:MiniMapZoomSignal;
      
      [Inject]
      public var updateHUD:UpdateHUDSignal;
      
      [Inject]
      public var exitGameSignal:ExitGameSignal;
      
      [Inject]
      public var layers:Layers;
      
      public function MiniMapMediator() {
         super();
      }
      
      public function initialize() : void {
         this.view.setMap(this.model.gameSprite.map);
         this.setFocus.add(this.onSetFocus);
         this.updateHUD.add(this.onUpdateHUD);
         this.updateGameObjectTileSignal.add(this.onUpdateGameObjectTile);
         this.updateGroundTileSignal.add(this.onUpdateGroundTile);
         this.miniMapZoomSignal.add(this.onMiniMapZoom);
         this.exitGameSignal.add(this.onExitGame);
         this.view.menuLayer = this.layers.top;
      }
      
      public function destroy() : void {
         this.setFocus.remove(this.onSetFocus);
         this.updateHUD.remove(this.onUpdateHUD);
         this.updateGameObjectTileSignal.remove(this.onUpdateGameObjectTile);
         this.updateGroundTileSignal.remove(this.onUpdateGroundTile);
         this.miniMapZoomSignal.remove(this.onMiniMapZoom);
         this.exitGameSignal.remove(this.onExitGame);
      }
      
      private function onExitGame() : void {
         this.view.deactivate();
      }
      
      private function onSetFocus(param1:String) : void {
         var _loc2_:GameObject = this.getFocusById(param1);
         this.view.setFocus(_loc2_);
      }
      
      private function getFocusById(param1:String) : GameObject {
         var _loc3_:* = null;
         if(param1 == "") {
            return this.view.map.player_;
         }
         var _loc2_:Dictionary = this.view.map.goDict_;
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc3_ in _loc2_) {
            if(_loc3_.name_ == param1) {
               return _loc3_;
            }
         }
         return this.view.map.player_;
      }
      
      private function onUpdateGroundTile(param1:int, param2:int, param3:uint) : void {
         this.view.setGroundTile(param1,param2,param3);
      }
      
      private function onUpdateGameObjectTile(param1:int, param2:int, param3:GameObject) : void {
         this.view.setGameObjectTile(param1,param2,param3);
      }
      
      private function onMiniMapZoom(param1:String) : void {
         if(param1 == "IN") {
            this.view.zoomIn();
         } else if(param1 == "OUT") {
            this.view.zoomOut();
         }
      }
      
      private function onUpdateHUD(param1:Player) : void {
         this.view.draw();
      }
   }
}
