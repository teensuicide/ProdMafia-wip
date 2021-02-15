package com.company.assembleegameclient.map.mapoverlay {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.ui.model.HUDModel;
   
   public class SpeechBalloon extends Sprite implements IMapOverlayElement {
       
      
      public var go_:GameObject;
      
      public var lifetime_:int;
      
      public var hideable_:Boolean;
      
      public var offset_:Point;
      
      public var text_:TextField;
      
      private var backgroundFill_:GraphicsSolidFill;
      
      private var outlineFill_:GraphicsSolidFill;
      
      private var lineStyle_:GraphicsStroke;
      
      private var path_:GraphicsPath;
      
      private var graphicsData_:Vector.<IGraphicsData>;
      
      private var senderName:String;
      
      private var isTrade:Boolean;
      
      private var isGuild:Boolean;
      
      private var startTime_:int = 0;
      
      public function SpeechBalloon(param1:GameObject, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:uint, param7:Number, param8:uint, param9:Number, param10:uint, param11:int, param12:Boolean, param13:Boolean) {
         offset_ = new Point();
         backgroundFill_ = new GraphicsSolidFill(0,1);
         outlineFill_ = new GraphicsSolidFill(16777215,1);
         lineStyle_ = new GraphicsStroke(2,false,"normal","none","round",3,outlineFill_);
         path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         graphicsData_ = new <IGraphicsData>[lineStyle_,backgroundFill_,path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         super();
         this.go_ = param1;
         this.senderName = param3;
         this.isTrade = param4;
         this.isGuild = param5;
         this.lifetime_ = param11 * 1000;
         this.hideable_ = param13;
         this.text_ = new TextField();
         this.text_.autoSize = "left";
         this.text_.embedFonts = true;
         this.text_.width = 150;
         var _loc15_:TextFormat = new TextFormat();
         _loc15_.font = "Myriad Pro";
         _loc15_.size = 14;
         _loc15_.bold = param12;
         _loc15_.color = param10;
         this.text_.defaultTextFormat = _loc15_;
         this.text_.selectable = false;
         this.text_.mouseEnabled = false;
         this.text_.multiline = true;
         this.text_.wordWrap = true;
         this.text_.text = param2;
         addChild(this.text_);
         var _loc17_:int = this.text_.textWidth + 4;
         var _loc14_:int = _loc17_ * 0.5;
         this.offset_.x = _loc17_ * -0.5;
         this.backgroundFill_.color = param6;
         this.backgroundFill_.alpha = param7;
         this.outlineFill_.color = param8;
         this.outlineFill_.alpha = param9;
         graphics.clear();
         GraphicsUtil.clearPath(this.path_);
         GraphicsUtil.drawCutEdgeRect(-6,-6,_loc17_ + 12,height + 12,4,[1,1,1,1],this.path_);
         this.path_.commands.splice(6,0,2,2,2);
         var _loc16_:int = height;
         this.path_.data.splice(12,0,_loc14_ + 8,_loc16_ + 6,_loc14_,_loc16_ + 18,_loc14_ - 8,_loc16_ + 6);
         graphics.drawGraphicsData(this.graphicsData_);
         filters = [new DropShadowFilter(0,0,0,1,16,16)];
         this.offset_.y = -height - this.go_.texture.height * (param1.size_ * 0.01) * 5 - 2;
         visible = false;
         addEventListener("rightClick",this.onSpeechBalloonRightClicked);
      }
      
      public function draw(param1:Camera, param2:int) : Boolean {
         if(this.startTime_ == 0) {
            this.startTime_ = param2;
         }
         var _loc3_:int = param2 - this.startTime_;
         if(_loc3_ > this.lifetime_ || this.go_ != null && this.go_.map_ == null) {
            return false;
         }
         if(this.go_ == null || !this.go_.drawn_) {
            visible = false;
            return true;
         }
         if(this.hideable_ && !Parameters.data.textBubbles) {
            visible = false;
            return true;
         }
         visible = true;
         x = this.go_.posS_[0] + this.offset_.x;
         y = this.go_.posS_[1] + this.offset_.y;
         return true;
      }
      
      public function getGameObject() : GameObject {
         return this.go_;
      }
      
      public function dispose() : void {
         parent.removeChild(this);
      }
      
      private function onSpeechBalloonRightClicked(param1:MouseEvent) : void {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         try {
            _loc2_ = this.go_.objectId_;
            _loc4_ = StaticInjectorContext.getInjector().getInstance(HUDModel);
            if(_loc4_.gameSprite.map.goDict_[_loc2_] != null && _loc4_.gameSprite.map.goDict_[_loc2_] is Player && _loc4_.gameSprite.map.player_.objectId_ != _loc2_) {
               _loc3_ = _loc4_.gameSprite.map.goDict_[_loc2_] as Player;
               _loc4_.gameSprite.addChatPlayerMenu(_loc3_,param1.stageX,param1.stageY);
            } else if(!this.isTrade && this.senderName != null && this.senderName != "" && _loc4_.gameSprite.map.player_.name_ != this.senderName) {
               _loc4_.gameSprite.addChatPlayerMenu(null,param1.stageX,param1.stageY,this.senderName,this.isGuild);
            } else if(this.isTrade && this.senderName != null && this.senderName != "" && _loc4_.gameSprite.map.player_.name_ != this.senderName) {
               _loc4_.gameSprite.addChatPlayerMenu(null,param1.stageX,param1.stageY,this.senderName,false,true);
            }
            return;
         }
         catch(e:Error) {
            return;
         }
      }
   }
}
