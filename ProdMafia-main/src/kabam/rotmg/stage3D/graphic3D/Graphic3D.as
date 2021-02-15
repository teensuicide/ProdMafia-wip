package kabam.rotmg.stage3D.graphic3D {
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.display3D.Context3D;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import kabam.rotmg.stage3D.GraphicsFillExtra;
   import kabam.rotmg.stage3D.proxies.Context3DProxy;
   import kabam.rotmg.stage3D.proxies.IndexBuffer3DProxy;
   import kabam.rotmg.stage3D.proxies.TextureProxy;
   import kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy;
   
   public class Graphic3D {
       
      
      [Inject]
      public var textureFactory:TextureFactory;
      
      [Inject]
      public var vertexBuffer:VertexBuffer3DProxy;
      
      [Inject]
      public var indexBuffer:IndexBuffer3DProxy;
      
      public var texture:TextureProxy;
      
      public var matrix3D:Matrix3D;
      
      private var bitmapData:BitmapData;
      
      private var matrix2D:Matrix;
      
      private var sinkLevel:Number = 0;
      
      private var offsetMatrix:Vector.<Number>;
      
      private var sinkOffset:Vector.<Number>;
      
      private var repeatDelta:Boolean = true;
      
      private var ctMult:Vector.<Number>;
      
      private var ctOffset:Vector.<Number>;
      
      private var repeat:Boolean;
      
      private var rawMatrix3D:Vector.<Number>;
      
      private var ct:ColorTransform;
      
      private var c3d:Context3D;
      
      public function Graphic3D() {
         this.matrix3D = new Matrix3D();
         this.sinkOffset = new Vector.<Number>(4,true);
         this.ctMult = new Vector.<Number>(4,true);
         this.ctOffset = new Vector.<Number>(4,true);
         this.rawMatrix3D = new Vector.<Number>(16,true);
         super();
      }
      
      public function setGraphic(param1:GraphicsBitmapFill, param2:Context3DProxy) : void {
         this.bitmapData = param1.bitmapData;
         this.repeatDelta = param1.repeat != this.repeat;
         this.repeat = param1.repeat;
         this.matrix2D = param1.matrix;
         this.texture = this.textureFactory.make(this.bitmapData);
         this.offsetMatrix = GraphicsFillExtra.getOffsetUV(param1);
         this.sinkLevel = GraphicsFillExtra.getSinkLevel(param1);
         if(this.sinkLevel != 0) {
            this.sinkOffset[1] = -this.sinkLevel;
            this.offsetMatrix = sinkOffset;
         }
         this.transform();
         this.ct = GraphicsFillExtra.getColorTransform(this.bitmapData);
         if(this.ctMult[0] != this.ct.redMultiplier || this.ctMult[1] != this.ct.greenMultiplier || this.ctMult[2] != this.ct.blueMultiplier || this.ctMult[3] != this.ct.alphaMultiplier || this.ctOffset[0] != this.ct.redOffset / 255 || this.ctOffset[1] != this.ct.greenOffset / 255 || this.ctOffset[2] != this.ct.blueOffset / 255 || this.ctOffset[3] != this.ct.alphaOffset / 255) {
            this.ctMult[0] = this.ct.redMultiplier;
            this.ctMult[1] = this.ct.greenMultiplier;
            this.ctMult[2] = this.ct.blueMultiplier;
            this.ctMult[3] = this.ct.alphaMultiplier;
            this.ctOffset[0] = this.ct.redOffset / 255;
            this.ctOffset[1] = this.ct.greenOffset / 255;
            this.ctOffset[2] = this.ct.blueOffset / 255;
            this.ctOffset[3] = this.ct.alphaOffset / 255;
            this.c3d = param2.GetContext3D();
            this.c3d.setProgramConstantsFromVector("fragment",2,ctMult);
            this.c3d.setProgramConstantsFromVector("fragment",3,ctOffset);
         }
      }
      
      public function render(param1:Context3DProxy) : void {
         if(this.repeatDelta) {
            param1.setProgram(Program3DFactory.getInstance().getProgram(param1,this.repeat));
         }
         param1.setTextureAt(0,this.texture);
         var _loc2_:Context3D = param1.GetContext3D();
         if(this.repeatDelta) {
            param1.setVertexBufferAt(0,this.vertexBuffer,0,"float3");
            param1.setVertexBufferAt(1,this.vertexBuffer,3,"float2");
         }
         _loc2_.setProgramConstantsFromVector("vertex",4,this.offsetMatrix);
         if(this.repeatDelta) {
            _loc2_.setVertexBufferAt(2,null,6,"float2");
         }
         param1.drawTriangles(this.indexBuffer);
      }
      
      public function getMatrix3D() : Matrix3D {
         return this.matrix3D;
      }
      
      private function transform() : void {
         this.matrix3D.identity();
         this.matrix3D.copyRawDataTo(rawMatrix3D);
         rawMatrix3D[4] = -this.matrix2D.c;
         rawMatrix3D[1] = -this.matrix2D.b;
         rawMatrix3D[0] = this.matrix2D.a;
         rawMatrix3D[5] = this.matrix2D.d;
         rawMatrix3D[12] = this.matrix2D.tx;
         rawMatrix3D[13] = -this.matrix2D.ty;
         this.matrix3D.copyRawDataFrom(rawMatrix3D);
         this.matrix3D.prependScale(Math.ceil(this.texture.getWidth()),Math.ceil(this.texture.getHeight()),1);
         this.matrix3D.prependTranslation(0.5,-0.5,0);
      }
   }
}
