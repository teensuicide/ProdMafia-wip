package com.company.assembleegameclient.map {
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsGradientFill;
   import flash.display.GraphicsPath;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   
   public class GradientOverlay extends Shape {
       
      
      private const gradientFill_:GraphicsGradientFill = new GraphicsGradientFill("linear",[0,0],[0,1],[0,255],GraphicsUtil.getGradientMatrix(10,600));
      
      private const gradientPath_:GraphicsPath = GraphicsUtil.getRectPath(0,0,10,600);
      
      private var gradientGraphicsData_:Vector.<IGraphicsData>;
      
      public function GradientOverlay() {
         gradientGraphicsData_ = new <IGraphicsData>[gradientFill_,gradientPath_,GraphicsUtil.END_FILL];
         super();
         graphics.drawGraphicsData(this.gradientGraphicsData_);
         visible = false;
      }
   }
}
