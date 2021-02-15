package com.company.assembleegameclient.game {
   import com.company.assembleegameclient.map.AbstractMap;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.tutorial.Tutorial;
   import com.company.util.Hit;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.messaging.impl.GameServerConnection;
   import kabam.rotmg.messaging.impl.incoming.MapInfo;
   import kabam.rotmg.ui.view.HUDView;
   import org.osflash.signals.Signal;
   
   public class AGameSprite extends Sprite {
       
      
      public const closed:Signal = new Signal();
      
      public var isEditor:Boolean;
      
      public var tutorial_:Tutorial;
      
      public var mui_:MapUserInput;
      
      public var lastUpdate_:int;
      
      public var lastUpdateReal:int;
      
      public var statsStart:int = 0;
      
      public var statsFrameNumber:int = 0;
      
      public var statsFPS:int = 0;
      
      public var map:AbstractMap;
      
      public var model:PlayerModel;
      
      public var hudView:HUDView;
      
      public var gsc_:GameServerConnection;
      
      public var isSafeMap:Boolean = false;
      
      public var deathOverlay:Bitmap;
      
      public var hitQueue:Vector.<Hit>;
      
      public var moveRecords_:MoveRecords;
      
      public var camera_:Camera;
      
      public function AGameSprite() {
         hitQueue = new Vector.<Hit>();
         moveRecords_ = new MoveRecords();
         camera_ = new Camera();
         super();
      }
      
      public function initialize() : void {
      }
      
      public function setFocus(param1:GameObject) : void {
      }
      
      public function applyMapInfo(param1:MapInfo) : void {
      }
      
      public function showDailyLoginCalendar() : void {
      }
      
      public function evalIsNotInCombatMapArea() : Boolean {
         return false;
      }
      
      public function fixFullScreen() : void {
      }
   }
}
