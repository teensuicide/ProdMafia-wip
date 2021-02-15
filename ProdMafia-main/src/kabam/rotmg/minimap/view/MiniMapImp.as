package kabam.rotmg.minimap.view {
   import com.company.assembleegameclient.map.AbstractMap;
   import com.company.assembleegameclient.map.GroundLibrary;
   import com.company.assembleegameclient.objects.Character;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.GuildHallPortal;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.Portal;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
   import com.company.assembleegameclient.ui.tooltip.PlayerGroupToolTip;
   import com.company.util.AssetLibrary;
   import com.company.util.PointUtil;
   import com.company.util.RectangleUtil;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class MiniMapImp extends MiniMap {
      
      public static const MOUSE_DIST_SQ:int = 25;
      
      private static var objectTypeColorDict_:Dictionary = new Dictionary();
       
      
      public var _width:int;
      
      public var _height:int;
      
      public var zoomIndex:int = 0;
      
      public var windowRect_:Rectangle;
      
      public var active:Boolean = true;
      
      public var maxWH_:Point;
      
      public var miniMapData_:BitmapData;
      
      public var slayermapData:BitmapData;
      
      public var zoomLevels:Vector.<Number>;
      
      public var blueArrow_:BitmapData;
      
      public var groundLayer_:Shape;
      
      public var characterLayer_:Shape;
      
      public var enemyLayer_:Shape;
      
      private var focus:GameObject;
      
      private var zoomButtons:MiniMapZoomButtons;
      
      private var isMouseOver:Boolean = false;
      
      private var tooltip:PlayerGroupToolTip = null;
      
      private var menu:PlayerGroupMenu = null;
      
      private var mapMatrix_:Matrix;
      
      private var arrowMatrix_:Matrix;
      
      private var players_:Vector.<Player>;
      
      private var tempPoint:Point;
      
      private var _rotateEnableFlag:Boolean;
      
      private var scores:Vector.<int>;
      
      public function MiniMapImp(param1:int, param2:int) {
         zoomLevels = new Vector.<Number>();
         mapMatrix_ = new Matrix();
         arrowMatrix_ = new Matrix();
         players_ = new Vector.<Player>();
         tempPoint = new Point();
         super();
         this._width = param1;
         this._height = param2;
         this._rotateEnableFlag = Parameters.data.allowMiniMapRotation;
         this.makeVisualLayers();
         this.addMouseListeners();
      }
      
      public static function gameObjectToColor(param1:GameObject) : uint {
         var _loc2_:* = param1.objectType_;
         if(!(_loc2_ in objectTypeColorDict_)) {
            objectTypeColorDict_[_loc2_] = param1.getColor();
         }
         return objectTypeColorDict_[_loc2_];
      }
      
      override public function setMap(param1:AbstractMap) : void {
         this.map = param1;
         this.makeViewModel();
         if(map.name_ == "Realm of the Mad God") {
            scores = new Vector.<int>(13);
         }
      }
      
      override public function setFocus(param1:GameObject) : void {
         this.focus = param1;
      }
      
      override public function setGroundTile(param1:int, param2:int, param3:uint) : void {
         var _loc4_:uint = GroundLibrary.getColor(param3);
         this.miniMapData_.setPixel(param1,param2,_loc4_);
      }
      
      override public function setGameObjectTile(param1:int, param2:int, param3:GameObject) : void {
         var _loc4_:uint = gameObjectToColor(param3);
         this.miniMapData_.setPixel(param1,param2,_loc4_);
      }
      
      override public function draw() : void {
         var _loc8_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc9_:* = 0;
         var _loc1_:* = null;
         var _loc12_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         this._rotateEnableFlag = this._rotateEnableFlag && Parameters.data.allowMiniMapRotation;
         this.groundLayer_.graphics.clear();
         this.characterLayer_.graphics.clear();
         this.enemyLayer_.graphics.clear();
         if(!this.focus) {
            return;
         }
         if(!this.active) {
            return;
         }
         var _loc24_:Number = this.zoomLevels[this.zoomIndex];
         this.mapMatrix_.identity();
         this.mapMatrix_.translate(-this.focus.x_,-this.focus.y_);
         this.mapMatrix_.scale(_loc24_,_loc24_);
         var _loc14_:Point = this.mapMatrix_.transformPoint(PointUtil.ORIGIN);
         var _loc15_:Point = this.mapMatrix_.transformPoint(this.maxWH_);
         var _loc2_:* = 0;
         if(_loc14_.x > this.windowRect_.left) {
            _loc2_ = this.windowRect_.left - _loc14_.x;
         } else if(_loc15_.x < this.windowRect_.right) {
            _loc2_ = this.windowRect_.right - _loc15_.x;
         }
         var _loc11_:* = 0;
         if(_loc14_.y > this.windowRect_.top) {
            _loc11_ = this.windowRect_.top - _loc14_.y;
         } else if(_loc15_.y < this.windowRect_.bottom) {
            _loc11_ = this.windowRect_.bottom - _loc15_.y;
         }
         this.mapMatrix_.translate(_loc2_,_loc11_);
         _loc14_ = this.mapMatrix_.transformPoint(PointUtil.ORIGIN);
         if(_loc24_ >= 1 && this._rotateEnableFlag) {
            this.mapMatrix_.rotate(-Parameters.data.cameraAngle);
         }
         var _loc3_:Rectangle = new Rectangle();
         _loc3_.x = Math.max(this.windowRect_.x,_loc14_.x);
         _loc3_.y = Math.max(this.windowRect_.y,_loc14_.y);
         _loc3_.right = Math.min(this.windowRect_.right,_loc14_.x + this.maxWH_.x * _loc24_);
         _loc3_.bottom = Math.min(this.windowRect_.bottom,_loc14_.y + this.maxWH_.y * _loc24_);
         _loc12_ = this.groundLayer_.graphics;
         _loc12_.beginBitmapFill(this.miniMapData_,this.mapMatrix_,false);
         _loc12_.drawRect(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
         _loc12_.endFill();
         _loc12_ = this.characterLayer_.graphics;
         _loc6_ = this.enemyLayer_.graphics;
         var _loc16_:Number = mouseX - this._width * 0.5;
         var _loc17_:Number = mouseY - this._height * 0.5;
         this.players_.length = 0;
         var _loc21_:* = map.goDict_;
         var _loc26_:int = 0;
         var _loc25_:* = map.goDict_;
         for each(_loc4_ in map.goDict_) {
            if(!(_loc4_.props_.noMiniMap_ || _loc4_ == this.focus)) {
               _loc1_ = _loc4_ as Player;
               if(_loc1_) {
                  if(_loc1_.isPaused) {
                     _loc9_ = 8355711;
                  } else if(Parameters.data.newMiniMapColors && _loc1_.isFellowGuild_ && !_loc1_.starred_) {
                     _loc9_ = 52992;
                  } else if(_loc1_.isFellowGuild_) {
                     _loc9_ = 65280;
                  } else if(Parameters.data.newMiniMapColors && !_loc1_.nameChosen_ && _loc1_.starred_) {
                     _loc9_ = 16777215;
                  } else if(Parameters.data.newMiniMapColors && !_loc1_.nameChosen_) {
                     _loc9_ = 13619151;
                  } else if(Parameters.data.newMiniMapColors && !_loc1_.starred_) {
                     _loc9_ = 13618944;
                  } else {
                     _loc9_ = 16776960;
                  }
               } else if(_loc4_ is Character) {
                  if(_loc4_.props_.isEnemy_) {
                     if(_loc4_.props_.color_ != -1) {
                        _loc9_ = uint(_loc4_.props_.color_);
                     } else {
                        _loc9_ = 16711680;
                     }
                  } else {
                     _loc9_ = uint(gameObjectToColor(_loc4_));
                  }
               } else if(_loc4_ is Portal || _loc4_ is GuildHallPortal) {
                  _loc9_ = 255;
               } else {
                  continue;
               }
               _loc8_ = this.mapMatrix_.a * _loc4_.x_ + this.mapMatrix_.c * _loc4_.y_ + this.mapMatrix_.tx;
               _loc19_ = this.mapMatrix_.b * _loc4_.x_ + this.mapMatrix_.d * _loc4_.y_ + this.mapMatrix_.ty;
               if(_loc8_ <= this._width * -0.5 || _loc8_ >= this._width * 0.5 || _loc19_ <= this._height * -0.5 || _loc19_ >= this._height * 0.5) {
                  RectangleUtil.lineSegmentIntersectXY(this.windowRect_,0,0,_loc8_,_loc19_,this.tempPoint);
                  _loc8_ = this.tempPoint.x;
                  _loc19_ = this.tempPoint.y;
               }
               if(_loc1_ && this.isMouseOver && (this.menu == null || this.menu.parent == null)) {
                  _loc10_ = _loc16_ - _loc8_;
                  _loc23_ = _loc17_ - _loc19_;
                  _loc13_ = _loc10_ * _loc10_ + _loc23_ * _loc23_;
                  if(_loc13_ < 25) {
                     this.players_.push(_loc1_);
                  }
               }
               if(_loc4_ is Character && _loc4_.props_.isEnemy_) {
                  _loc6_.beginFill(_loc9_);
                  _loc6_.drawRect(_loc8_ - 2,_loc19_ - 2,4,4);
                  _loc6_.endFill();
               } else {
                  _loc12_.beginFill(_loc9_);
                  _loc12_.drawRect(_loc8_ - 2,_loc19_ - 2,4,4);
                  _loc12_.endFill();
               }
            }
         }
         if(this.players_.length != 0) {
            if(this.tooltip == null) {
               this.tooltip = new PlayerGroupToolTip(this.players_);
               menuLayer.addChild(this.tooltip);
            } else if(!this.areSamePlayers(this.tooltip.players_,this.players_)) {
               this.tooltip.setPlayers(this.players_);
            }
         } else if(this.tooltip) {
            if(this.tooltip.parent) {
               this.tooltip.parent.removeChild(this.tooltip);
            }
            this.tooltip = null;
         }
         var _loc5_:Number = this.focus.x_;
         var _loc7_:Number = this.focus.y_;
         var _loc18_:Number = this.mapMatrix_.a * _loc5_ + this.mapMatrix_.c * _loc7_ + this.mapMatrix_.tx;
         var _loc22_:Number = this.mapMatrix_.b * _loc5_ + this.mapMatrix_.d * _loc7_ + this.mapMatrix_.ty;
         this.arrowMatrix_.identity();
         this.arrowMatrix_.translate(-4,-5);
         this.arrowMatrix_.scale(8 / this.blueArrow_.width,32 / this.blueArrow_.height);
         if(!(_loc24_ >= 1 && this._rotateEnableFlag)) {
            this.arrowMatrix_.rotate(Parameters.data.cameraAngle);
         }
         this.arrowMatrix_.translate(_loc18_,_loc22_);
         _loc12_.beginBitmapFill(this.blueArrow_,this.arrowMatrix_,false);
         _loc12_.drawRect(_loc18_ - 16,_loc22_ - 16,32,32);
         _loc12_.endFill();
      }
      
      override public function zoomIn() : void {
         this.zoomIndex = this.zoomButtons.setZoomLevel(this.zoomIndex - 1);
      }
      
      override public function zoomOut() : void {
         this.zoomIndex = this.zoomButtons.setZoomLevel(this.zoomIndex + 1);
      }
      
      override public function deactivate() : void {
      }
      
      public function dispose() : void {
         var _loc3_:int = 0;
         var _loc2_:* = this.players_;
         for each(var _loc1_ in this.players_) {
            _loc1_ && _loc1_.dispose();
            _loc1_ = null;
         }
         this.mapMatrix_ = null;
         this.arrowMatrix_ = null;
         this.removeDecorations();
      }
      
      private function makeViewModel() : void {
         this.windowRect_ = new Rectangle(this._width * -0.5,this._height * -0.5,this._width,this._height);
         this.maxWH_ = new Point(map.mapWidth,map.mapHeight);
         this.miniMapData_ = new BitmapData(this.maxWH_.x,this.maxWH_.y,false,0);
         var _loc2_:Number = Math.max(this._width / this.maxWH_.x,this._height / this.maxWH_.y);
         var _loc1_:* = 4;
         while(_loc1_ > _loc2_) {
            this.zoomLevels.push(_loc1_);
            _loc1_ = Number(_loc1_ / 2);
         }
         this.zoomLevels.push(_loc2_);
         if(this.zoomButtons) {
            this.zoomButtons.setZoomLevels(this.zoomLevels.length);
         }
      }
      
      private function makeVisualLayers() : void {
         this.blueArrow_ = AssetLibrary.getImageFromSet("lofiInterface",54).clone();
         this.blueArrow_.colorTransform(this.blueArrow_.rect,new ColorTransform(0,0,1));
         graphics.clear();
         graphics.beginFill(1776411);
         graphics.drawRect(0,0,this._width,this._height);
         graphics.endFill();
         this.groundLayer_ = new Shape();
         this.groundLayer_.x = this._width / 2;
         this.groundLayer_.y = this._height / 2;
         addChild(this.groundLayer_);
         this.characterLayer_ = new Shape();
         this.characterLayer_.x = this._width / 2;
         this.characterLayer_.y = this._height / 2;
         addChild(this.characterLayer_);
         this.enemyLayer_ = new Shape();
         this.enemyLayer_.x = this._width / 2;
         this.enemyLayer_.y = this._height / 2;
         addChild(this.enemyLayer_);
         this.zoomButtons = new MiniMapZoomButtons();
         this.zoomButtons.x = this._width - 20;
         this.zoomButtons.zoom.add(this.onZoomChanged);
         this.zoomButtons.setZoomLevels(this.zoomLevels.length);
         addChild(this.zoomButtons);
      }
      
      private function addMouseListeners() : void {
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("mouseOut",this.onMouseOut);
         addEventListener("rightClick",this.onMapRightClick);
         addEventListener("click",this.onMapClick);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function onZoomChanged(param1:int) : void {
         this.zoomIndex = param1;
      }
      
      private function addMenu() : void {
         this.menu = new PlayerGroupMenu(map,this.tooltip.players_);
         this.menu.x = this.tooltip.x + 12;
         this.menu.y = this.tooltip.y;
         menuLayer.addChild(this.menu);
      }
      
      private function removeDecorations() : void {
         this.removeTooltip();
         this.removeMenu();
      }
      
      private function removeTooltip() : void {
         if(this.tooltip != null) {
            if(this.tooltip.parent != null) {
               this.tooltip.parent.removeChild(this.tooltip);
            }
            this.tooltip = null;
         }
      }
      
      private function removeMenu() : void {
         if(this.menu != null) {
            if(this.menu.parent != null) {
               this.menu.parent.removeChild(this.menu);
            }
            this.menu = null;
         }
      }
      
      private function areSamePlayers(param1:Vector.<Player>, param2:Vector.<Player>) : Boolean {
         var _loc3_:int = 0;
         var _loc4_:int = param1.length;
         if(_loc4_ != param2.length) {
            return false;
         }
         while(_loc3_ < _loc4_) {
            if(param1[_loc3_] != param2[_loc3_]) {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         this.active = false;
         this.removeDecorations();
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.isMouseOver = true;
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.isMouseOver = false;
      }
      
      private function onMapRightClick(param1:MouseEvent) : void {
         if(this.players_.length != 0) {
            this.players_[0].map_.gs_.gsc_.teleport(this.players_[0].objectId_);
         }
      }
      
      private function onMapClick(param1:MouseEvent) : void {
         if(this.tooltip == null || this.tooltip.parent == null || this.tooltip.players_ == null || this.tooltip.players_.length == 0) {
            return;
         }
         this.removeMenu();
         this.addMenu();
         this.removeTooltip();
      }
   }
}
