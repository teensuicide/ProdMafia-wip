package kabam.rotmg.chat.view {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.ui.model.HUDModel;
   
   public class ChatListItem extends Sprite {
      
      private static const CHAT_ITEM_TIMEOUT:uint = 20000;
       
      
      public var playerObjectId:int;
      
      public var playerName:String = "";
      
      public var fromGuild:Boolean = false;
      
      public var isTrade:Boolean = false;
      
      private var itemWidth:int;
      
      private var list:Vector.<DisplayObject>;
      
      private var count:uint;
      
      private var layoutHeight:uint;
      
      private var creationTime:uint;
      
      private var timedOutOverride:Boolean;
      
      public function ChatListItem(param1:Vector.<DisplayObject>, param2:int, param3:int, param4:Boolean, param5:int, param6:String, param7:Boolean, param8:Boolean) {
         super();
         mouseEnabled = true;
         tabEnabled = false;
         this.itemWidth = param2;
         this.layoutHeight = param3;
         this.list = param1;
         this.count = param1.length;
         this.creationTime = TimeUtil.getTrueTime();
         this.timedOutOverride = param4;
         this.playerObjectId = param5;
         this.playerName = param6;
         this.fromGuild = param7;
         this.isTrade = param8;
         this.layoutItems();
         this.addItems();
         addEventListener("rightMouseDown",this.onRightMouseDown);
      }
      
      public function isTimedOut() : Boolean {
         return TimeUtil.getTrueTime() > this.creationTime + 20000 || this.timedOutOverride;
      }
      
      public function dispose() : void {
         var _loc3_:* = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         removeEventListener("rightMouseDown",this.onRightMouseDown);
         while(numChildren > 0) {
            _loc1_ = removeChildAt(0);
            if(_loc1_ is ChatList) {
               ChatList(_loc1_).dispose();
            }
         }
         if(this.list) {
            _loc3_ = uint(this.list.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_) {
               if(this.list[_loc2_] as Bitmap != null) {
                  (this.list[_loc2_] as Bitmap).bitmapData.dispose();
                  this.list[_loc2_] = null;
               }
               _loc2_++;
            }
            this.list = null;
         }
      }
      
      private function layoutItems() : void {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < this.count) {
            _loc3_ = this.list[_loc4_];
            _loc1_ = _loc3_.getRect(_loc3_);
            _loc3_.x = _loc5_;
            _loc3_.y = (this.layoutHeight - _loc1_.height) * 0.5 - this.layoutHeight;
            if(_loc5_ + _loc1_.width > this.itemWidth) {
               _loc3_.x = 0;
               _loc5_ = 0;
               _loc2_ = 0;
               while(_loc2_ < _loc4_) {
                  this.list[_loc2_].y = this.list[_loc2_].y - this.layoutHeight;
                  _loc2_++;
               }
            }
            _loc5_ = _loc5_ + _loc1_.width;
            _loc4_++;
         }
      }
      
      private function addItems() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.list;
         var _loc5_:int = 0;
         var _loc4_:* = this.list;
         for each(_loc3_ in this.list) {
            addChild(_loc3_);
         }
      }
      
      public function onRightMouseDown(param1:MouseEvent) : void {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         try {
            _loc2_ = StaticInjectorContext.getInjector().getInstance(HUDModel);
            _loc4_ = _loc2_.gameSprite.map;
            if(_loc4_.goDict_[this.playerObjectId] != null && _loc4_.goDict_[this.playerObjectId] is Player && _loc4_.player_.objectId_ != this.playerObjectId) {
               _loc3_ = _loc4_.goDict_[this.playerObjectId] as Player;
               if(param1.shiftKey) {
                  _loc4_.gs_.gsc_.teleport(_loc3_.objectId_);
               } else {
                  _loc2_.gameSprite.addChatPlayerMenu(_loc3_,param1.stageX,param1.stageY);
               }
            } else if(!this.isTrade && this.playerName && this.playerName != "" && _loc4_.player_.name_ != this.playerName) {
               _loc2_.gameSprite.addChatPlayerMenu(null,param1.stageX,param1.stageY,this.playerName,this.fromGuild);
            } else if(this.isTrade && this.playerName && this.playerName != "" && _loc4_.player_.name_ != this.playerName) {
               _loc2_.gameSprite.addChatPlayerMenu(null,param1.stageX,param1.stageY,this.playerName,false,true);
            }
            return;
         }
         catch(e:Error) {
            return;
         }
      }
   }
}
