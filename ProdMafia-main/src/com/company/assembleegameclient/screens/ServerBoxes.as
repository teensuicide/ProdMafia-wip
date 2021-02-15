package com.company.assembleegameclient.screens {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kabam.rotmg.servers.api.Server;
   
   public class ServerBoxes extends Sprite {
       
      
      private var boxes_:Vector.<ServerBox>;
      
      private var _isChallenger:Boolean;
      
      public function ServerBoxes(param1:Vector.<Server>, param2:Boolean = false) {
         var _loc6_:int = 0;
         boxes_ = new Vector.<ServerBox>();
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = null;
         super();
         this._isChallenger = param2;
         _loc3_ = new ServerBox(null);
         _loc3_.setSelected(true);
         _loc3_.x = 0;
         _loc3_.addEventListener("mouseDown",this.onMouseDown);
         addChild(_loc3_);
         this.boxes_.push(_loc3_);
         var _loc8_:Server = makeLocalhostServer();
         _loc3_ = new ServerBox(_loc8_);
         if(_loc8_.name == Parameters.data.preferredServer) {
            this.setSelected(_loc3_);
         }
         _loc3_.x = 388;
         _loc3_.addEventListener("mouseDown",this.onMouseDown);
         addChild(_loc3_);
         this.boxes_.push(_loc3_);
         _loc6_ = 2;
         _loc7_ = Parameters.data.preferredServer;
         Parameters.paramServerJoinedOnce = false;
         var _loc4_:* = param1;
         var _loc11_:int = 0;
         var _loc10_:* = param1;
         for each(_loc9_ in param1) {
            if(_loc9_.address != "127.0.0.1") {
               _loc3_ = new ServerBox(_loc9_);
               if(_loc9_.name == _loc7_) {
                  this.setSelected(_loc3_);
               }
               _loc3_.x = _loc6_ % 2 * 388;
               _loc3_.y = int(_loc6_ / 2) * 56;
               _loc3_.addEventListener("mouseDown",this.onMouseDown);
               addChild(_loc3_);
               this.boxes_.push(_loc3_);
               _loc6_++;
            }
         }
      }
      
      public static function makeLocalhostServer() : Server {
         return new Server().setName("Proxy").setAddress("127.0.0.1").setPort(2050).setLatLong(Infinity,Infinity).setUsage(0).setIsAdminOnly(false);
      }
      
      private function setSelected(param1:ServerBox) : void {
         var _loc2_:* = null;
         var _loc3_:* = this.boxes_;
         var _loc6_:int = 0;
         var _loc5_:* = this.boxes_;
         for each(_loc2_ in this.boxes_) {
            _loc2_.setSelected(false);
         }
         param1.setSelected(true);
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         var _loc3_:ServerBox = param1.currentTarget as ServerBox;
         if(_loc3_ == null) {
            return;
         }
         this.setSelected(_loc3_);
         var _loc2_:String = _loc3_.value_;
         Parameters.data.preferredServer = _loc2_;
         Parameters.save();
      }
   }
}
