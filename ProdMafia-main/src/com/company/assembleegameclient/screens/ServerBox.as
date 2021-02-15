package com.company.assembleegameclient.screens {
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class ServerBox extends Sprite {
      
      public static const WIDTH:int = 384;
      
      public static const HEIGHT:int = 52;
       
      
      public var value_:String;
      
      private var nameText_:TextFieldDisplayConcrete;
      
      private var statusText_:TextFieldDisplayConcrete;
      
      private var selected_:Boolean = false;
      
      private var over_:Boolean = false;
      
      public function ServerBox(param1:Server) {
         super();
         this.value_ = param1 == null?null:param1.name;
         this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true);
         if(param1 == null) {
            this.nameText_.setStringBuilder(new LineBuilder().setParams("ServerBox.best"));
         } else {
            this.nameText_.setStringBuilder(new StaticStringBuilder(param1.name));
         }
         this.nameText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.nameText_.x = 18;
         this.nameText_.setVerticalAlign("middle");
         this.nameText_.y = 26;
         addChild(this.nameText_);
         this.addUI(param1);
         this.draw();
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
      }
      
      public function setSelected(param1:Boolean) : void {
         this.selected_ = param1;
         this.draw();
      }
      
      private function addUI(server:Server) : void {
         var onTextChanged:Function = function():void {
            makeStatusText(color,text);
         };
         if(server != null) {
            var color:uint = 65280;
            var text:String = "ServerBox.normal";
            if(server.isFull()) {
               color = 16711680;
               text = "ServerBox.full";
            } else if(server.isCrowded()) {
               color = 16549442;
               text = "ServerBox.crowded";
            }
            this.nameText_.textChanged.addOnce(onTextChanged);
         }
      }
      
      private function makeStatusText(param1:uint, param2:String) : void {
         this.statusText_ = new TextFieldDisplayConcrete().setSize(18).setColor(param1).setBold(true).setAutoSize("center");
         this.statusText_.setStringBuilder(new LineBuilder().setParams(param2));
         this.statusText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.statusText_.x = 288;
         this.statusText_.y = 26 - this.nameText_.height / 2;
         addChild(this.statusText_);
      }
      
      private function draw() : void {
         graphics.clear();
         if(this.selected_) {
            graphics.lineStyle(2,16777103);
         }
         graphics.beginFill(!!this.over_?7039851:6052956,1);
         graphics.drawRect(0,0,384,52);
         if(this.selected_) {
            graphics.lineStyle();
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.over_ = true;
         this.draw();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.over_ = false;
         this.draw();
      }
   }
}
