package com.company.assembleegameclient.map {
   import com.company.assembleegameclient.background.Background;
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
   import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
   import com.company.assembleegameclient.objects.BasicObject;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Party;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.Projectile;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   
   public class AbstractMap extends Sprite {
       
      
      public var playerLength:int;
      
      public var gs_:AGameSprite;
      
      public var name_:String;
      
      public var player_:Player = null;
      
      public var showDisplays_:Boolean;
      
      public var mapWidth:int;
      
      public var mapHeight:int;
      
      public var back_:int;
      
      public var background_:Background = null;
      
      public var mapOverlay_:MapOverlay = null;
      
      public var partyOverlay_:PartyOverlay = null;
      
      public var party_:Party = null;
      
      public var quest_:Quest = null;
      
      public var isPetYard:Boolean = false;
      
      public var isTrench:Boolean = false;
      
      public var isNexus:Boolean = false;
      
      public var isRealm:Boolean = false;
      
      public var isVault:Boolean = false;
      
      public var isQuestRoom:Boolean = false;
      
      public var vulnPlayerDict_:Vector.<GameObject>;
      
      public var vulnEnemyDict_:Vector.<GameObject>;
      
      public var visProjDict:Vector.<Projectile>;
      
      public var goDict_:Dictionary;
      
      public var map_:Sprite;
      
      public var squares:Vector.<Square>;
      
      public var boDict_:Dictionary;
      
      public var merchLookup_:Object;
      
      public var signalRenderSwitch:Signal;
      
      public var maxPlayers:int;
      
      protected var allowPlayerTeleport_:Boolean;
      
      public function AbstractMap() {
         vulnPlayerDict_ = new Vector.<GameObject>();
         vulnEnemyDict_ = new Vector.<GameObject>();
         visProjDict = new Vector.<Projectile>();
         goDict_ = new Dictionary();
         map_ = new Sprite();
         squares = new Vector.<Square>();
         boDict_ = new Dictionary();
         merchLookup_ = {};
         signalRenderSwitch = new Signal(Boolean);
         super();
      }
      
      public function setProps(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean, param7:int = 0) : void {
      }
      
      public function setHitAreaProps(param1:int, param2:int) : void {
      }
      
      public function addObj(param1:BasicObject, param2:Number, param3:Number) : void {
      }
      
      public function setGroundTile(param1:int, param2:int, param3:uint) : void {
      }
      
      public function initialize() : void {
      }
      
      public function dispose() : void {
      }
      
      public function resetOverlays() : void {
      }
      
      public function update(param1:int, param2:int) : void {
      }
      
      public function pSTopW(param1:Number, param2:Number) : Point {
         return null;
      }
      
      public function removeObj(param1:int) : void {
      }
      
      public function calcVulnerables() : void {
      }
      
      public function draw(param1:Camera, param2:int) : void {
      }
      
      public function allowPlayerTeleport() : Boolean {
         return this.name_ != "Nexus" && this.allowPlayerTeleport_;
      }
      
      public function saveMap(param1:Boolean) : void {
      }
      
      public function findPlayer(param1:String) : Player {
         return null;
      }
      
      public function findObject(param1:int) : GameObject {
         return null;
      }
      
      public function needsMapHack(param1:String) : int {
         return 0;
      }
      
      public function saveJson() : void {
      }
      
      public function startSaveMap() : void {
      }
      
      public function printOffsetPosition() : void {
      }
      
      public function enumGOAngles() : Number {
         return 0;
      }
   }
}
