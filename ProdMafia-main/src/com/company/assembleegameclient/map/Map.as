package com.company.assembleegameclient.map {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
   import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
   import com.company.assembleegameclient.objects.BasicObject;
   import com.company.assembleegameclient.objects.Character;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Party;
   import com.company.assembleegameclient.objects.Projectile;
   import com.company.assembleegameclient.objects.particles.ParticleEffect;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.PointUtil;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.stage3D.GraphicsFillExtra;
   import kabam.rotmg.stage3D.Render3D;
   import kabam.rotmg.stage3D.Renderer;
   import kabam.rotmg.stage3D.graphic3D.Program3DFactory;
   import kabam.rotmg.stage3D.graphic3D.TextureFactory;
   import kabam.rotmg.ui.signals.RealmOryxSignal;
   
   public class Map extends AbstractMap {
      
      public static const CLOTH_BAZAAR:String = "Cloth Bazaar";
      
      public static const NEXUS:String = "Nexus";
      
      public static const DAILY_QUEST_ROOM:String = "Daily Quest Room";
      
      public static const DAILY_LOGIN_ROOM:String = "Daily Login Room";
      
      public static const PET_YARD_1:String = "Pet Yard";
      
      public static const PET_YARD_2:String = "Pet Yard 2";
      
      public static const PET_YARD_3:String = "Pet Yard 3";
      
      public static const PET_YARD_4:String = "Pet Yard 4";
      
      public static const PET_YARD_5:String = "Pet Yard 5";
      
      public static const REALM:String = "Realm of the Mad God";
      
      public static const ORYX_CHAMBER:String = "Oryx\'s Chamber";
      
      public static const GUILD_HALL:String = "Guild Hall";
      
      public static const GUILD_HALL_2:String = "Guild Hall 2";
      
      public static const GUILD_HALL_3:String = "Guild Hall 3";
      
      public static const GUILD_HALL_4:String = "Guild Hall 4";
      
      public static const GUILD_HALL_5:String = "Guild Hall 5";
      
      public static const NEXUS_EXPLANATION:String = "Nexus_Explanation";
      
      public static const VAULT:String = "Vault";
      
      private static const VISIBLE_SORT_FIELDS:Array = ["sortVal_","objectId_"];
      
      private static const VISIBLE_SORT_PARAMS:Array = [16,16];
      
      protected static const BLIND_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.05,0.05,0.05,0,0,0.05,0.05,0.05,0,0,0.05,0.05,0.05,0,0,0.05,0.05,0.05,1,0]);
      
      public static var forceSoftwareRender:Boolean = false;
      
      public static var texture:BitmapData;
      
      protected static var BREATH_CT:ColorTransform = new ColorTransform(1,0.215686274509804,0,0);
       
      
      public var visible_:Array;
      
      public var visibleUnder_:Array;
      
      public var visibleSquares_:Vector.<Square>;
      
      public var topSquares_:Vector.<Square>;
      
      private var inUpdate_:Boolean = false;
      
      private var objsToAdd_:Vector.<BasicObject>;
      
      private var idsToRemove_:Vector.<int>;
      
      private var forceSoftwareMap:Dictionary;
      
      private var oryxObjectId:int;
      
      private var graphicsData_:Vector.<GraphicsBitmapFill>;
      
      public function Map(param1:AGameSprite) {
         objsToAdd_ = new Vector.<BasicObject>();
         idsToRemove_ = new Vector.<int>();
         forceSoftwareMap = new Dictionary();
         graphicsData_ = new Vector.<GraphicsBitmapFill>();
         visible_ = [];
         visibleUnder_ = [];
         visibleSquares_ = new Vector.<Square>();
         topSquares_ = new Vector.<Square>();
         super();
         gs_ = param1;
         mapOverlay_ = new MapOverlay();
         partyOverlay_ = new PartyOverlay(this);
         party_ = new Party(this);
         quest_ = new Quest(this);
         StaticInjectorContext.getInjector().getInstance(GameModel).gameObjects = goDict_;
      }
      
      override public function enumGOAngles() : Number {
         var _loc11_:* = NaN;
         _loc11_ = 0.523598775598299;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc1_:Number = player_.x_;
         var _loc10_:Number = player_.y_;
         var _loc12_:Vector.<int> = new Vector.<int>(10,true);
         var _loc5_:int = this.vulnEnemyDict_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_) {
            _loc6_ = this.vulnEnemyDict_[_loc7_];
            _loc8_ = Math.floor(Math.atan2(Math.abs(_loc10_ - _loc6_.y_),Math.abs(_loc1_ - _loc6_.x_)) / 0.523598775598299);
            if(_loc8_ > 0 && _loc8_ < 11) {
               var _loc13_:* = _loc8_ - 1;
               var _loc14_:* = _loc12_[_loc13_] + PointUtil.distanceXY(_loc6_.x_,_loc6_.y_,_loc1_,_loc10_);
               _loc12_[_loc13_] = _loc14_;
            }
            _loc7_++;
         }
         var _loc2_:int = this.visProjDict.length;
         _loc7_ = 0;
         while(_loc7_ < _loc2_) {
            _loc9_ = this.visProjDict[_loc7_];
            _loc8_ = Math.floor(Math.atan2(Math.abs(_loc10_ - _loc9_.y_),Math.abs(_loc1_ - _loc9_.x_)) / 0.523598775598299);
            if(_loc8_ > 0 && _loc8_ < 11) {
               _loc14_ = _loc8_ - 1;
               _loc13_ = _loc12_[_loc14_] + PointUtil.distanceXY(_loc9_.x_,_loc9_.y_,_loc1_,_loc10_);
               _loc12_[_loc14_] = _loc13_;
            }
            _loc7_++;
         }
         var _loc3_:int = 2147483647;
         var _loc4_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < 10) {
            if(_loc3_ > _loc12_[_loc7_]) {
               _loc3_ = _loc12_[_loc7_];
               _loc4_ = _loc7_;
            }
            _loc7_++;
         }
         return ((_loc4_ + 1) * 30 + 15) * 3.14159265358979 / 180;
      }
      
      override public function calcVulnerables() : void {
         var _loc2_:* = null;
         var _loc1_:GameObject = null;
         this.vulnEnemyDict_.length = 0;
         this.vulnPlayerDict_.length = 0;
         this.visProjDict.length = 0;
         this.playerLength = 0;
         for each(var _loc3_ in boDict_) {
            _loc2_ = _loc3_ as Projectile;
            if(_loc2_ && _loc2_.damagesPlayers_) {
               this.visProjDict.push(_loc2_);
            }
         }
         for each(_loc1_ in goDict_) {
            if(_loc1_.props_.isEnemy_) {
               if(!_loc1_.dead_ && !_loc1_.isInvincible) {
                        if((_loc1_.condition_[0] & 11534336) == 0) {
                           this.vulnEnemyDict_.push(_loc1_);
                        }
               }
            } else if(_loc1_.props_.isPlayer_) {
               this.playerLength++;
               if(!_loc1_.isPaused && !_loc1_.isInvincible && !_loc1_.isStasis && !_loc1_.dead_) {
                  this.vulnPlayerDict_.push(_loc1_);
               }
            }
         }
      }
      
      override public function setProps(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean, param7:int = 0) : void {
         mapWidth = param1;
         mapHeight = param2;
         name_ = param3;
         back_ = param4;
         allowPlayerTeleport_ = param5;
         showDisplays_ = param6;
         maxPlayers = param7;
         this.forceSoftwareRenderCheck(name_);
      }
      
      override public function initialize() : void {
         squares.length = mapWidth * mapHeight;
         addChild(map_);
         addChild(mapOverlay_);
         addChild(partyOverlay_);
         isPetYard = name_.substr(0,8) == "Pet Yard";
         isQuestRoom = name_.indexOf("Quest") != -1;
      }
      
      override public function dispose() : void {
         var _loc3_:* = null;
         var _loc2_:* = null;
         gs_ = null;
         background_ = null;
         map_ = null;
         mapOverlay_ = null;
         partyOverlay_ = null;
         squares.length = 0;
         squares = null;
         var _loc5_:int = 0;
         var _loc4_:* = goDict_;
         for each(_loc3_ in goDict_) {
            _loc3_.dispose();
         }
         goDict_ = null;
         var _loc7_:int = 0;
         var _loc6_:* = boDict_;
         for each(_loc2_ in boDict_) {
            _loc2_.dispose();
         }
         boDict_ = null;
         merchLookup_ = null;
         player_ = null;
         party_ = null;
         quest_ = null;
         this.objsToAdd_ = null;
         this.idsToRemove_ = null;
         TextureFactory.disposeTextures();
         GraphicsFillExtra.dispose();
         Program3DFactory.getInstance().dispose();
      }
      
      override public function update(param1:int, param2:int) : void {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         this.inUpdate_ = true;
         for each(_loc3_ in goDict_) {
            if(_loc3_ && this.idsToRemove_ != null && this.idsToRemove_.indexOf(_loc3_.objectId_) == -1 && !_loc3_.update(param1,param2)) {
               this.idsToRemove_.push(_loc3_.objectId_);
            }
         }
         for each(_loc3_ in boDict_) {
            if(_loc3_ && this.idsToRemove_ != null && this.idsToRemove_.indexOf(_loc3_.objectId_) == -1 && !_loc3_.update(param1,param2)) {
               this.idsToRemove_ && this.idsToRemove_.push(_loc3_.objectId_);
            }
         }
         this.inUpdate_ = false;
         for each(_loc3_ in this.objsToAdd_) {
            this.internalAddObj(_loc3_);
         }
         if(this.objsToAdd_) {
            this.objsToAdd_.length = 0;
         }
         for each(_loc4_ in this.idsToRemove_) {
            this.internalRemoveObj(_loc4_);
         }
         if(this.idsToRemove_) {
            this.idsToRemove_.length = 0;
         }
         party_.update(param1, param2);
      }
      
      override public function pSTopW(param1:Number, param2:Number) : Point {
         var _loc3_:* = null;
         var _loc4_:* = this.visibleSquares_;
         var _loc7_:int = 0;
         var _loc6_:* = this.visibleSquares_;
         for each(_loc3_ in this.visibleSquares_) {
            if(_loc3_.faces_.length != 0 && _loc3_.faces_[0].face.contains(param1,param2)) {
               return new Point(_loc3_.centerX_,_loc3_.centerY_);
            }
         }
         return null;
      }
      
      override public function setGroundTile(param1:int, param2:int, param3:uint) : void {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:Square = null;
         var _loc8_:Square = this.getSquare(param1,param2);
         _loc8_.setTileType(param3);
         var _loc7_:int = param1 < mapWidth - 1?param1 + 1:param1;
         var _loc10_:int = param2 < mapHeight - 1?param2 + 1:param2;
         var _loc4_:int = param1 > 0?param1 - 1:param1;
         while(_loc4_ <= _loc7_) {
            _loc6_ = param2 > 0?param2 - 1:param2;
            while(_loc6_ <= _loc10_) {
               _loc5_ = _loc4_ + _loc6_ * mapWidth;
               _loc9_ = squares[_loc5_];
               if(_loc9_ != null && (_loc9_.props_ && _loc9_.props_.hasEdge_ || _loc9_.tileType != param3)) {
                  _loc9_.faces_.length = 0;
               }
               _loc6_++;
            }
            _loc4_++;
         }
      }
      
      override public function addObj(param1:BasicObject, param2:Number, param3:Number) : void {
         param1.x_ = param2;
         param1.y_ = param3;
         if(param1 is ParticleEffect) {
            (param1 as ParticleEffect).reducedDrawEnabled = !Parameters.data.particleEffect;
         }
         if(this.inUpdate_) {
            this.objsToAdd_.push(param1);
         } else {
            this.internalAddObj(param1);
         }
      }
      
      override public function removeObj(param1:int) : void {
         if(this.inUpdate_) {
            this.idsToRemove_.push(param1);
         } else {
            this.internalRemoveObj(param1);
         }
      }
      
      override public function draw(param1:Camera, param2:int) : void {
         var _loc6_:int = 0;
         var _loc11_:Rectangle = param1.clipRect_;
         x = -_loc11_.x * 800 / Main.STAGE.stageWidth * Parameters.data.mscale;
         y = -_loc11_.y * 600 / Main.STAGE.stageHeight * Parameters.data.mscale;
         Main.STAGE.stage3Ds[0].x = 400 - Main.STAGE.stageWidth / 2;
         Main.STAGE.stage3Ds[0].y = 300 - Main.STAGE.stageHeight / 2;
         var _loc3_:uint = 0;
         var _loc8_:Render3D = null;
         var _loc5_:Square = null;
         var _loc9_:GameObject = null;
         var _loc10_:BasicObject = null;
         var _loc4_:int = 0;
         this.visible_.length = 0;
         this.visibleUnder_.length = 0;
         this.visibleSquares_.length = 0;
         this.topSquares_.length = 0;
         this.graphicsData_.length = 0;
         var _loc7_:int = Parameters.data.renderDistance - 1;
         _loc6_ = -_loc7_;
         while(_loc6_ <= _loc7_) {
            _loc4_ = -_loc7_;
            while(_loc4_ <= _loc7_) {
               if(_loc6_ * _loc6_ + _loc4_ * _loc4_ <= _loc7_ * _loc7_) {
                  _loc5_ = this.lookupSquare(_loc6_ + this.player_.x_,_loc4_ + this.player_.y_);
                  if(_loc5_ != null) {
                     _loc5_.lastVisible_ = param2;
                     _loc5_.draw(this.graphicsData_,param1,param2);
                     this.visibleSquares_.push(_loc5_);
                     if(_loc5_.topFace_ != null) {
                        this.topSquares_.push(_loc5_);
                     }
                  }
               }
               _loc4_++;
            }
            _loc6_++;
         }
         for each(_loc9_ in this.goDict_) {
            _loc9_.drawn_ = false;
            if(_loc9_.dead_ && _loc9_.hp_ > 0) {
               _loc9_.dead_ = false;
            }
            if(!_loc9_.dead_) {
               _loc5_ = _loc9_.square;
               if(!(_loc5_ == null || _loc5_.lastVisible_ != param2)) {
                  _loc9_.drawn_ = true;
                  _loc9_.computeSortVal(param1);
                  if(_loc9_.objectId_ == player_.objectId_) {
                     _loc9_.sortVal_ = 9999;
                  }
                  if(_loc9_.props_.drawUnder_) {
                     if(_loc9_.props_.drawOnGround_) {
                        _loc9_.draw(this.graphicsData_,param1,param2);
                     } else {
                        this.visibleUnder_.push(_loc9_);
                     }
                  } else {
                     this.visible_.push(_loc9_);
                  }
               }
            }
         }
         for each(_loc10_ in this.boDict_) {
            _loc10_.drawn_ = false;
            _loc5_ = _loc10_.square;
            if(!(_loc5_ == null || _loc5_.lastVisible_ != param2)) {
               _loc10_.drawn_ = true;
               _loc10_.computeSortVal(param1);
               this.visible_.push(_loc10_);
            }
         }
         if(this.visibleUnder_.length > 0) {
            if(!Parameters.data.disableSorting) {
               this.visibleUnder_.sortOn(VISIBLE_SORT_FIELDS,VISIBLE_SORT_PARAMS);
            }
            for each(_loc10_ in this.visibleUnder_) {
               _loc10_.draw(this.graphicsData_,param1,param2);
            }
         }
         if(!Parameters.data.disableSorting) {
            this.visible_.sortOn(VISIBLE_SORT_FIELDS,VISIBLE_SORT_PARAMS);
         }
         for each(_loc10_ in this.visible_) {
            _loc10_.draw(this.graphicsData_,param1,param2);
         }
         if(this.topSquares_.length > 0) {
            for each(_loc5_ in this.topSquares_) {
               _loc5_.drawTop(this.graphicsData_,param1,param2);
            }
         }
         if(Renderer.inGame) {
            _loc3_ = this.getFilterIndex();
            _loc8_ = StaticInjectorContext.getInjector().getInstance(Render3D);
            _loc8_.dispatch(this.graphicsData_,_loc3_);
            if(param2 % 149 == 0) {
               GraphicsFillExtra.manageSize();
            }
         }
         this.mapOverlay_.draw(param1,param2);
         this.partyOverlay_.draw(param1,param2);
      }
      
      public function internalAddObj(param1:BasicObject) : void {
         if(!param1.addTo(this,param1.x_,param1.y_)) {
            return;
         }
         var _loc2_:Dictionary = param1 is GameObject?goDict_:boDict_;
         if(_loc2_[param1.objectId_] != null) {
            if(!isPetYard) {
               return;
            }
         }
         if(name_ == "Oryx\'s Chamber" && this.oryxObjectId == 0) {
            if(param1 is Character && (param1 as Character).getName() == "Oryx the Mad God") {
               this.oryxObjectId = param1.objectId_;
            }
         }
         _loc2_[param1.objectId_] = param1;
      }
      
      public function internalRemoveObj(param1:int) : void {
         var _loc2_:Dictionary = goDict_;
         var _loc3_:BasicObject = _loc2_[param1];
         if(_loc3_ == null) {
            _loc2_ = boDict_;
            _loc3_ = _loc2_[param1];
            if(_loc3_ == null) {
               return;
            }
            delete boDict_[param1];
         } else {
            delete goDict_[param1];
         }
         _loc3_.removeFromMap();
         if(name_ == "Oryx\'s Chamber" && param1 == this.oryxObjectId) {
            StaticInjectorContext.getInjector().getInstance(RealmOryxSignal).dispatch();
         }
      }
      
      public function getSquare(param1:Number, param2:Number) : Square {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 >= mapHeight) {
            return null;
         }
         var _loc3_:int = int(param1) + int(param2) * mapWidth;
         var _loc4_:Square = squares[_loc3_];
         if(_loc4_ == null) {
            _loc4_ = new Square(this,int(param1),int(param2));
            squares[_loc3_] = _loc4_;
         }
         return _loc4_;
      }
      
      public function lookupSquare(param1:int, param2:int) : Square {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 >= mapHeight) {
            return null;
         }
         return squares[param1 + param2 * mapWidth];
      }
      
      private function forceSoftwareRenderCheck(param1:String) : void {
         forceSoftwareRender = this.forceSoftwareMap[param1] != null || Main.STAGE != null && Main.STAGE.stage3Ds[0].context3D == null;
      }
      
      private function getFilterIndex() : uint {
         var _loc1_:int = 0;
         if(player_ != null && (player_.condition_[0] & 1049216) != 0) {
            if(player_.isPaused) {
               _loc1_ = 1;
            } else if(player_.isBlind) {
               _loc1_ = 2;
            } else if(player_.isDrunk) {
               _loc1_ = 3;
            }
         }
         return _loc1_;
      }
   }
}
