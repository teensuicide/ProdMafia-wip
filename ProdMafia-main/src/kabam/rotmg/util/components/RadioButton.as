package kabam.rotmg.util.components {
   import com.company.util.GraphicsUtil;
   import flash.display.Graphics;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import org.osflash.signals.Signal;
   
   public class RadioButton extends Sprite {
       
      
      public const changed:Signal = new Signal(Boolean);
      
      private const WIDTH:int = 28;
      
      private const HEIGHT:int = 28;
      
      private var unselected:Shape;
      
      private var selected:Shape;
      
      public function RadioButton() {
         super();
         var _loc1_:* = this.makeUnselected();
         this.unselected = _loc1_;
         addChild(_loc1_);
         _loc1_ = this.makeSelected();
         this.selected = _loc1_;
         addChild(_loc1_);
         this.setSelected(false);
      }
      
      public function setSelected(param1:Boolean) : void {
         this.unselected.visible = !param1;
         this.selected.visible = param1;
         this.changed.dispatch(param1);
      }
      
      private function makeUnselected() : Shape {
         var _loc1_:Shape = new Shape();
         this.drawOutline(_loc1_.graphics);
         return _loc1_;
      }
      
      private function makeSelected() : Shape {
         var _loc1_:Shape = new Shape();
         this.drawOutline(_loc1_.graphics);
         this.drawFill(_loc1_.graphics);
         return _loc1_;
      }
      
      private function drawOutline(param1:Graphics) : void {
         var _loc2_:GraphicsSolidFill = new GraphicsSolidFill(0,0.01);
         var _loc4_:GraphicsSolidFill = new GraphicsSolidFill(16777215,1);
         var _loc5_:GraphicsStroke = new GraphicsStroke(2,false,"normal","none","round",3,_loc4_);
         var _loc3_:GraphicsPath = new GraphicsPath();
         GraphicsUtil.drawCutEdgeRect(0,0,28,28,4,GraphicsUtil.ALL_CUTS,_loc3_);
         var _loc6_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc5_,_loc2_,_loc3_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         param1.drawGraphicsData(_loc6_);
      }
      
      private function drawFill(param1:Graphics) : void {
         var _loc2_:GraphicsSolidFill = new GraphicsSolidFill(16777215,1);
         var _loc4_:GraphicsPath = new GraphicsPath();
         GraphicsUtil.drawCutEdgeRect(4,4,20,20,2,GraphicsUtil.ALL_CUTS,_loc4_);
         var _loc3_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc2_,_loc4_,GraphicsUtil.END_FILL];
         param1.drawGraphicsData(_loc3_);
      }
   }
}
