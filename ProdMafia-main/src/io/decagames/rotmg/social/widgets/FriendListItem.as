package io.decagames.rotmg.social.widgets {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.icons.IconButton;
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.events.Event;
   import io.decagames.rotmg.social.model.FriendVO;
   
   public class FriendListItem extends BaseListItem {
       
      
      public var teleportButton:IconButton;
      
      public var messageButton:IconButton;
      
      public var removeButton:IconButton;
      
      public var acceptButton:IconButton;
      
      public var rejectButton:IconButton;
      
      public var blockButton:IconButton;
      
      private var _vo:FriendVO;
      
      public function FriendListItem(param1:FriendVO, param2:int) {
         super(param2);
         this._vo = param1;
         this.init();
      }
      
      public function get vo() : FriendVO {
         return this._vo;
      }
      
      override protected function init() : void {
         super.init();
         addEventListener("removedFromStage",this.onRemoved);
         this.setState();
         createListLabel(this._vo.getName());
         createListPortrait(this._vo.getPortrait());
      }
      
      private function setState() : void {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = int(_state) - 1;
         switch(_loc4_) {
            case 0:
               _loc1_ = this._vo.getServerName();
               _loc2_ = !!Parameters.data.preferredServer?Parameters.data.preferredServer:Parameters.data.bestServer;
               if(_loc2_ != _loc1_) {
                  _loc3_ = "Your friend is playing on server: " + _loc1_ + ". " + "Clicking this will take you to this server.";
                  this.teleportButton = addButton("lofiInterface2",3,230,12,"Friend.TeleportTitle",_loc3_);
               }
               this.messageButton = addButton("lofiInterfaceBig",21,255,12,"PlayerMenu.PM");
               this.removeButton = addButton("lofiInterfaceBig",12,280,12,"Friend.RemoveRight");
               return;
            case 1:
               hoverTooltipDelegate.setDisplayObject(_characterContainer);
               setToolTipTitle("Last Seen:");
               setToolTipText(TimeUtil.humanReadableTime(this._vo.lastLogin) + " ago!");
               this.removeButton = addButton("lofiInterfaceBig",12,280,12,"Friend.RemoveRight","Friend.RemoveRightDesc");
               return;
            case 2:
               this.acceptButton = addButton("lofiInterfaceBig",11,230,12,"Guild.accept");
               this.rejectButton = addButton("lofiInterfaceBig",12,255,12,"Guild.rejection");
               this.blockButton = addButton("lofiInterfaceBig",8,280,12,"Friend.BlockRight","Friend.BlockRightDesc");
            default:
               return;
         }
      }
      
      private function onRemoved(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemoved);
         this.teleportButton && this.teleportButton.destroy();
         this.messageButton && this.messageButton.destroy();
         this.removeButton && this.removeButton.destroy();
         this.acceptButton && this.acceptButton.destroy();
      }
   }
}
