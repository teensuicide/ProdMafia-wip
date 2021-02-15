package com.company.assembleegameclient.ui.panels.itemgrids {
   import com.company.assembleegameclient.objects.Container;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
   import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import flash.events.MouseEvent;
   import kabam.rotmg.constants.ItemConstants;
   import kabam.rotmg.text.model.TextKey;
   import org.osflash.signals.Signal;
   
   public class ItemGrid extends Panel {
      
      private static const NO_CUT:Array = [0,0,0,0];
      
      private static const CutsByNum:Object = {
         "1":[[1,0,0,1],NO_CUT,NO_CUT,[0,1,1,0]],
         "2":[[1,0,0,0],NO_CUT,NO_CUT,[0,1,0,0],[0,0,0,1],NO_CUT,NO_CUT,[0,0,1,0]],
         "3":[[1,0,0,1],NO_CUT,NO_CUT,[0,1,1,0],[1,0,0,0],NO_CUT,NO_CUT,[0,1,0,0],[0,0,0,1],NO_CUT,NO_CUT,[0,0,1,0]]
      };
       
      
      private const padding:uint = 4;
      
      private const rowLength:uint = 4;
      
      public const addToolTip:Signal = new Signal(ToolTip);
      
      public var owner:GameObject;
      
      public var curPlayer:Player;
      
      public var interactive:Boolean;
      
      protected var indexOffset:int;
      
      private var tooltip:ToolTip;
      
      private var tooltipFocusTile:ItemTile;
      
      private var prevEquips:Vector.<int>;
      
      public function ItemGrid(param1:GameObject, param2:Player, param3:int, param4:Boolean = false) {
         super(null);
         this.owner = param1;
         this.curPlayer = param2;
         this.indexOffset = param3;
         var _loc5_:Container = param1 as Container;
         if(param1 == param2 || _loc5_ || param4) {
            this.interactive = true;
         }
      }
      
      override public function draw() : void {
         this.setItems(this.owner.equipment_,this.indexOffset);
      }
      
      public function hideTooltip() : void {
         if(this.tooltip) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.tooltipFocusTile = null;
         }
      }
      
      public function refreshTooltip() : void {
         if(!stage || !this.tooltip || !this.tooltip.stage) {
            return;
         }
         if(this.tooltipFocusTile) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.addToolTipToTile(this.tooltipFocusTile);
         }
      }
      
      public function setItems(param1:Vector.<int>, param2:int = 0) : void {
      }
      
      public function enableInteraction(param1:Boolean) : void {
         mouseEnabled = param1;
      }
      
      protected function addToGrid(param1:ItemTile, param2:uint, param3:uint) : void {
         param1.drawBackground(CutsByNum[param2][param3]);
         param1.addEventListener("rollOver",this.onTileHover);
         param1.x = param3 % 4 * 44;
         param1.y = int(param3 / 4) * 44;
         addChild(param1);
      }
      
      protected function add(param1:ItemTile, param2:int) : void {
         if(!param1 || !this.owner) {
            return;
         }
         if(this.owner.equipment_ && param2 > this.owner.equipment_.length - 1) {
            this.owner.equipment_.push(param1.getItemId());
         }
         param1.addEventListener("rollOver",this.onTileHover);
         param1.x = 25 + param2 % 8 * 65;
         param1.y = 10 + int(param2 / 8) * 65;
         addChild(param1);
      }
      
      private function addToolTipToTile(param1:ItemTile) : void {
         var _loc2_:* = null;
         if(param1.itemSprite.itemId > 0) {
            this.tooltip = new EquipmentToolTip(param1.itemSprite.itemId,this.curPlayer,!!this.owner?this.owner.objectType_:-1,this.getCharacterType());
         } else {
            if(param1 is EquipmentTile) {
               _loc2_ = ItemConstants.itemTypeToName((param1 as EquipmentTile).itemType);
            } else {
               _loc2_ = "item.toolTip";
            }
            this.tooltip = new TextToolTip(3552822,10197915,null,"item.emptySlot",200,{"itemType":TextKey.wrapForTokenResolution(_loc2_)});
         }
         this.tooltip.attachToTarget(param1);
         this.addToolTip.dispatch(this.tooltip);
      }
      
      private function getCharacterType() : String {
         if(this.owner == this.curPlayer) {
            return "CURRENT_PLAYER";
         }
         if(this.owner is Player) {
            return "OTHER_PLAYER";
         }
         return "NPC";
      }
      
      private function onTileHover(param1:MouseEvent) : void {
         if(!stage) {
            return;
         }
         var _loc2_:ItemTile = param1.currentTarget as ItemTile;
         this.addToolTipToTile(_loc2_);
         this.tooltipFocusTile = _loc2_;
      }
   }
}
