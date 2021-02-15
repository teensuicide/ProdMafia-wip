package io.decagames.rotmg.supportCampaign.tooltips {
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class PointsTooltip extends ToolTip {
       
      
      private var pointsInfo:UILabel;
      
      private var supportIcon:SliceScalingBitmap;
      
      private var _shopButton:ShopBuyButton;
      
      public function PointsTooltip(param1:ShopBuyButton, param2:uint, param3:uint, param4:int, param5:Boolean = true) {
         super(param2,1,param3,1,param5);
         this._shopButton = param1;
         this.pointsInfo = new UILabel();
         DefaultLabelFormat.createLabelFormat(this.pointsInfo,14,15395562,"right",false);
         addChild(this.pointsInfo);
         this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI","campaign_Points");
         addChild(this.supportIcon);
      }
      
      public function get shopButton() : ShopBuyButton {
         return this._shopButton;
      }
      
      public function updatePoints(param1:int) : void {
         this.pointsInfo.text = "You will get " + param1;
         this.supportIcon.y = this.pointsInfo.y;
         this.supportIcon.x = this.pointsInfo.x + this.pointsInfo.width;
      }
   }
}
