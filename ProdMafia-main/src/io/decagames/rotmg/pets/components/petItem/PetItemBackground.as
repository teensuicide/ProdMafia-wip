package io.decagames.rotmg.pets.components.petItem {
   import com.company.util.GraphicsUtil;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.display.IGraphicsData;
   import flash.display.Sprite;
   
   public class PetItemBackground extends Sprite {
       
      
      public function PetItemBackground(param1:int, param2:Array, param3:uint, param4:Number) {
         super();
         var _loc6_:GraphicsSolidFill = new GraphicsSolidFill(param3,param4);
         var _loc5_:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         var _loc7_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc6_,_loc5_,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,param1,param1,param1 / 12,param2,_loc5_);
         graphics.drawGraphicsData(_loc7_);
      }
   }
}
