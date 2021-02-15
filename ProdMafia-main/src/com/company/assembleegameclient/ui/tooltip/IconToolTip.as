package com.company.assembleegameclient.ui.tooltip {
   import flash.display.Bitmap;
   import flash.text.TextFormat;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   
   public class IconToolTip extends ToolTip {
       
      
      private var _title:String;
      
      private var _toolTipText:String;
      
      private var _icon:Bitmap;
      
      private var _titleLabel:UILabel;
      
      private var _tipLabel:UILabel;
      
      public function IconToolTip(param1:String, param2:String, param3:uint, param4:Number, param5:uint, param6:Number, param7:Boolean = true, param8:Bitmap = null) {
         super(param3,param4,param5,param6,param7);
         this._title = param1;
         this._toolTipText = param2;
         this._icon = param8;
         this.init();
      }
      
      public function positionIcon(param1:int, param2:int) : void {
         if(!this._icon) {
            return;
         }
         this._icon.x = param1;
         this._icon.y = param2;
         addChild(this._icon);
         draw();
      }
      
      private function init() : void {
         this.createTitleLabel();
         this.createTipLabel();
         if(this._icon) {
            this.positionIcon(width - this._icon.width / 2,height / 2 - this._icon.height / 2 + 3);
         }
      }
      
      private function createTitleLabel() : void {
         this._titleLabel = new UILabel();
         this._titleLabel.text = this._title;
         DefaultLabelFormat.defaultModalTitle(this._titleLabel);
         addChild(this._titleLabel);
      }
      
      private function createTipLabel() : void {
         this._tipLabel = new UILabel();
         this._tipLabel.text = this._toolTipText;
         DefaultLabelFormat.defaultTextModalText(this._tipLabel);
         var _loc1_:TextFormat = this._tipLabel.getTextFormat();
         _loc1_.color = 11776947;
         this._tipLabel.setTextFormat(_loc1_);
         this._tipLabel.y = this._titleLabel.y + this._titleLabel.height;
         addChild(this._tipLabel);
         draw();
      }
   }
}
