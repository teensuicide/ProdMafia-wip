package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.Party;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.PlayerGameObjectListItem;
   import com.company.assembleegameclient.ui.menu.PlayerMenu;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.MoreColorUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class PartyPanel extends Panel {
       
      
      public var menuLayer:DisplayObjectContainer;
      
      public var memberPanels:Vector.<PlayerGameObjectListItem>;
      
      public var mouseOver_:Boolean;
      
      public var menu:PlayerMenu;
      
      private var prevLen:int;
      
      private var mapData:TextFieldDisplayConcrete;
      
      public function PartyPanel(param1:GameSprite) {
         memberPanels = new Vector.<PlayerGameObjectListItem>(6,true);
         super(param1);
         var _loc2_:String = param1.map.maxPlayers == 1?"":" (" + param1.map.playerLength + "/" + param1.map.maxPlayers + ")";
         this.mapData = new TextFieldDisplayConcrete().setStringBuilder(new StaticStringBuilder(param1.map.name_ + _loc2_)).setSize(12).setBold(true).setColor(16777215).setAutoSize("center");
         this.mapData.transform.colorTransform = MoreColorUtil.darkCT;
         this.mapData.x = 93;
         this.mapData.y = -5;
         addChild(this.mapData);
         this.prevLen = param1.map.playerLength;
         this.memberPanels[0] = this.createPartyMemberPanel(0,15);
         this.memberPanels[1] = this.createPartyMemberPanel(100,15);
         this.memberPanels[2] = this.createPartyMemberPanel(0,40);
         this.memberPanels[3] = this.createPartyMemberPanel(100,40);
         this.memberPanels[4] = this.createPartyMemberPanel(0,65);
         this.memberPanels[5] = this.createPartyMemberPanel(100,65);
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      }

      override public function draw():void {
         var _local3:* = null;
         var _local8:* = null;
         var _local5:* = null;
         var _local4:Number = NaN;
         var _local7:int = 0;
         var _local2:int = 0;
         var _local1:int = 0;
         var _local6:Party = gs_.map.party_;
         if (gs_.map.playerLength != this.prevLen) {
            this.mapData.setText(gs_.map.name_ +
                    (gs_.map.maxPlayers == 1 ? "" :
                    " (" + gs_.map.playerLength + "/" + gs_.map.maxPlayers + ")"));
            this.prevLen = gs_.map.playerLength;
         }
         if (_local6 == null) {
            for each(_local3 in this.memberPanels) {
               _local3.clear();
            }
            return;
         }
         while (_local1 < 6) {
            if (this.mouseOver_ || this.menu != null && this.menu.parent != null) {
               _local8 = this.memberPanels[_local1].go as Player;
            } else {
               _local8 = _local6.members_[_local1];
            }
            if (_local8 != null && _local8.map_ == null) {
               _local8 = null;
            }
            _local5 = null;
            if (_local8 != null) {
               if (_local8.hp_ < _local8.maxHP_ * 0.2) {
                  if (_local2 == 0) {
                     _local2 = TimeUtil.getTrueTime();
                  }
                  _local4 = int(Math.abs(Math.sin(_local2 / 200)) * 10) / 10;
                  _local7 = 128;
                  _local5 = new ColorTransform(1, 1, 1, 1, _local4 * _local7, -_local4 * _local7, -_local4 * _local7);
               }
               if (!_local8.starred_) {
                  if (_local5 != null) {
                     _local5.concat(MoreColorUtil.darkCT);
                  } else {
                     _local5 = MoreColorUtil.darkCT;
                  }
               }
            }
            this.memberPanels[_local1].draw(_local8, _local5);
            _local1++;
         }
      }
      
      public function dispose() : void {
         this.menuLayer = null;
         this.menu = null;
         this.memberPanels = null;
         removeEventListener("addedToStage",this.onAddedToStage);
         removeEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function createPartyMemberPanel(param1:int, param2:int) : PlayerGameObjectListItem {
         var _loc3_:PlayerGameObjectListItem = new PlayerGameObjectListItem(16777215,false,null);
         addChild(_loc3_);
         _loc3_.x = param1 - 5;
         _loc3_.y = param2 - 8;
         return _loc3_;
      }
      
      private function removeMenu() : void {
         if(this.menu != null) {
            this.menu.remove();
            this.menu = null;
         }
      }
      
      private function onAddedToStage(param1:Event) : void {
         var _loc2_:* = null;
         var _loc3_:* = this.memberPanels;
         var _loc6_:int = 0;
         var _loc5_:* = this.memberPanels;
         for each(_loc2_ in this.memberPanels) {
            _loc2_.addEventListener("mouseOver",this.onMouseOver,false,0,true);
            _loc2_.addEventListener("mouseOut",this.onMouseOut,false,0,true);
            _loc2_.addEventListener("mouseDown",this.onMouseDown);
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         var _loc2_:* = null;
         this.removeMenu();
         var _loc3_:* = this.memberPanels;
         var _loc6_:int = 0;
         var _loc5_:* = this.memberPanels;
         for each(_loc2_ in this.memberPanels) {
            _loc2_.removeEventListener("mouseOver",this.onMouseOver);
            _loc2_.removeEventListener("mouseOut",this.onMouseOut);
            _loc2_.removeEventListener("mouseDown",this.onMouseDown);
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         if(this.menu != null && this.menu.parent != null) {
            return;
         }
         var _loc2_:PlayerGameObjectListItem = param1.currentTarget as PlayerGameObjectListItem;
         var _loc3_:Player = _loc2_.go as Player;
         if(_loc3_ == null || _loc3_.texture == null) {
            return;
         }
         this.mouseOver_ = true;
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.mouseOver_ = false;
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         this.removeMenu();
         var _loc2_:PlayerGameObjectListItem = param1.currentTarget as PlayerGameObjectListItem;
         _loc2_.setEnabled(false);
         this.menu = new PlayerMenu();
         this.menu.init(gs_,_loc2_.go as Player);
         this.menuLayer.addChild(this.menu);
         this.menu.addEventListener("removedFromStage",this.onMenuRemoved);
      }
      
      private function onMenuRemoved(param1:Event) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = this.memberPanels;
         var _loc7_:int = 0;
         var _loc6_:* = this.memberPanels;
         for each(_loc2_ in this.memberPanels) {
            _loc3_ = _loc2_ as PlayerGameObjectListItem;
            if(_loc3_) {
               _loc3_.setEnabled(true);
            }
         }
         param1.currentTarget.removeEventListener("removedFromStage",this.onMenuRemoved);
      }
   }
}
