package kabam.rotmg.stage3D {
   import com.adobe.utils.AGALMiniAssembler;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.GraphicsBitmapFill;
   import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.Texture;
   import flash.geom.Matrix3D;
   import flash.utils.ByteArray;
   import kabam.rotmg.stage3D.Object3D.Util;
   import kabam.rotmg.stage3D.graphic3D.Graphic3D;
   import kabam.rotmg.stage3D.proxies.Context3DProxy;
   import org.swiftsuspenders.Injector;
   
   public class Renderer {
      
      public static const STAGE3D_FILTER_PAUSE:uint = 1;
      
      public static const STAGE3D_FILTER_BLIND:uint = 2;
      
      public static const STAGE3D_FILTER_DRUNK:uint = 3;
      
      private static const POST_FILTER_VERTEX_CONSTANTS:Vector.<Number> = new <Number>[1,2,0,0];
      
      private static const GRAYSCALE_FRAGMENT_CONSTANTS:Vector.<Number> = new <Number>[0.3,0.59,0.11,0];
      
      private static const BLIND_FRAGMENT_CONSTANTS:Vector.<Number> = new <Number>[0.05,0.05,0.05,0];
      
      private static const POST_FILTER_POSITIONS:Vector.<Number> = new <Number>[-1,1,0,0,1,1,1,0,1,-1,1,1,-1,-1,0,1];
      
      private static const POST_FILTER_TRIS:Vector.<uint> = new <uint>[0,2,3,0,1,2];
      
      public static var inGame:Boolean;
       
      
      [Inject]
      public var context3D:Context3DProxy;
      
      [Inject]
      public var injector:Injector;
      
      public var program2:Program3D;
      
      protected var vertexShader:String;
      
      protected var fragmentShader:String;
      
      protected var blurFragmentConstants:Vector.<Number>;
      
      protected var projection:Matrix3D;
      
      private var tX:Number;
      
      private var tY:Number;
      
      private var postProcessingProgram:Program3D;
      
      private var blurPostProcessing:Program3D;
      
      private var shadowProgram:Program3D;
      
      private var graphic3D:Graphic3D;
      
      private var stageHeight:Number = 800;
      
      private var stageWidth:Number = 600;
      
      private var sceneTexture:Texture;
      
      private var blurFactor:Number = 0.01;
      
      private var postFilterVertexBuffer:VertexBuffer3D;
      
      private var postFilterIndexBuffer:IndexBuffer3D;
      
      private var cullSet:Boolean;
      
      private var m3d:Matrix3D;
      
      private var gm3d:Matrix3D;
      
      public function Renderer(param1:Render3D) {
         m3d = new Matrix3D();
         this.vertexShader = "dp4 op.x, va0, vc0\ndp4 op.y, va0, vc1\nmov op.z, vc2.z\nmov op.w, vc3.w\nmov v0, va1.xy\nmov v0.z, va0.z\n";
         this.fragmentShader = "tex ft0, v0, fs0 <2d,clamp,linear,mipnearest>\nmul ft0, ft0, v0.zzzz\nmov oc, ft0\n";
         this.blurFragmentConstants = Vector.<Number>([0.4,0.6,0.4,1.5]);
         super();
         this.setTranslationToTitle();
         param1.add(this.onRender);
      }
      
      public function init(param1:Context3D) : void {
         this.projection = Util.perspectiveProjection(56,1,0.1,2048);
         var _loc2_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc2_.assemble("vertex",this.vertexShader);
         var _loc10_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc10_.assemble("fragment",this.fragmentShader);
         this.program2 = context3D.createProgram().getProgram3D();
         this.program2.upload(_loc2_.agalcode,_loc10_.agalcode);
         var _loc5_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc5_.assemble("vertex","mov op, va0\nadd vt0, vc0.xxxx, va0\ndiv vt0, vt0, vc0.yyyy\nsub vt0.y, vc0.x, vt0.y\nmov v0, vt0\n");
         var _loc7_:ByteArray = _loc5_.agalcode;
         _loc5_.assemble("fragment","tex ft0, v0, fs0 <2d,clamp,linear>\ndp3 ft0.x, ft0, fc0\nmov ft0.y, ft0.x\nmov ft0.z, ft0.x\nmov oc, ft0\n");
         var _loc3_:ByteArray = _loc5_.agalcode;
         this.postProcessingProgram = param1.createProgram();
         this.postProcessingProgram.upload(_loc7_,_loc3_);
         _loc5_.assemble("vertex","m44 op, va0, vc0\nmov v0, va1\n");
         var _loc6_:ByteArray = _loc5_.agalcode;
         _loc5_.assemble("fragment","sub ft0, v0, fc0\nsub ft0.zw, ft0.zw, ft0.zw\ndp3 ft1, ft0, ft0\nsqt ft1, ft1\ndiv ft1.xy, ft1.xy, fc0.zz\npow ft1.x, ft1.x, fc0.w\nmul ft0.xy, ft0.xy, ft1.xx\ndiv ft0.xy, ft0.xy, ft1.yy\nadd ft0.xy, ft0.xy, fc0.xy\ntex oc, ft0, fs0<2d,clamp>\n");
         var _loc8_:ByteArray = _loc5_.agalcode;
         this.blurPostProcessing = param1.createProgram();
         this.blurPostProcessing.upload(_loc6_,_loc8_);
         _loc5_.assemble("vertex","m44 op, va0, vc0\nmov v0, va1\nmov v1, va2\n");
         var _loc4_:ByteArray = _loc5_.agalcode;
         _loc5_.assemble("fragment","sub ft0.xy, v1.xy, fc4.xx\nmul ft0.xy, ft0.xy, ft0.xy\nadd ft0.x, ft0.x, ft0.y\nslt ft0.y, ft0.x, fc4.y\nmul oc, v0, ft0.yyyy\n");
         var _loc9_:ByteArray = _loc5_.agalcode;
         this.shadowProgram = param1.createProgram();
         this.shadowProgram.upload(_loc4_,_loc9_);
         this.sceneTexture = param1.createTexture(1024,1024,"bgra",true);
         this.postFilterVertexBuffer = param1.createVertexBuffer(4,4);
         this.postFilterVertexBuffer.uploadFromVector(POST_FILTER_POSITIONS,0,4);
         this.postFilterIndexBuffer = param1.createIndexBuffer(6);
         this.postFilterIndexBuffer.uploadFromVector(POST_FILTER_TRIS,0,6);
         this.graphic3D = this.injector.getInstance(Graphic3D);
      }
      
      private function onRender(param1:Vector.<GraphicsBitmapFill>, param2:uint) : void {
         if(Main.STAGE.stageWidth != this.stageWidth || Main.STAGE.stageHeight != this.stageHeight) {
            this.resizeStage3DBackBuffer();
         }
         if(Renderer.inGame) {
            this.setTranslationToGame();
         } else {
            this.setTranslationToTitle();
         }
         if(param2 > 0) {
            this.renderWithPostEffect(param1,param2);
         } else {
            this.renderScene(param1);
         }
         this.context3D.present();
      }
      
      private function resizeStage3DBackBuffer() : void {
         if(Main.STAGE.stageWidth > 1 || Main.STAGE.stageHeight > 1) {
            Main.STAGE.stage3Ds[0].context3D.configureBackBuffer(Main.STAGE.stageWidth,Main.STAGE.stageHeight,0,false);
            this.stageWidth = Main.STAGE.stageWidth;
            this.stageHeight = Main.STAGE.stageHeight;
         }
      }
      
      private function renderWithPostEffect(param1:Vector.<GraphicsBitmapFill>, param2:uint) : void {
         this.context3D.GetContext3D().setRenderToTexture(this.sceneTexture,true);
         this.renderScene(param1);
         this.context3D.GetContext3D().setRenderToBackBuffer();
         switch(param2) {
            case STAGE3D_FILTER_PAUSE:
            case STAGE3D_FILTER_BLIND:
               this.context3D.GetContext3D().setProgram(this.postProcessingProgram);
               this.context3D.GetContext3D().setTextureAt(0, this.sceneTexture);
               this.context3D.GetContext3D().clear(0.5, 0.5, 0.5);
               this.context3D.GetContext3D().setVertexBufferAt(0, this.postFilterVertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
               this.context3D.GetContext3D().setVertexBufferAt(1, null);
               break;
            case STAGE3D_FILTER_DRUNK:
               this.context3D.GetContext3D().setProgram(this.blurPostProcessing);
               this.context3D.GetContext3D().setTextureAt(0, this.sceneTexture);
               this.context3D.GetContext3D().clear(0.5, 0.5, 0.5);
               this.context3D.GetContext3D().setVertexBufferAt(0, this.postFilterVertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
               this.context3D.GetContext3D().setVertexBufferAt(1, this.postFilterVertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
               break;
         }
         this.context3D.GetContext3D().setVertexBufferAt(2,null);
         switch(param2) {
            case STAGE3D_FILTER_PAUSE:
               this.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, POST_FILTER_VERTEX_CONSTANTS);
               this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, GRAYSCALE_FRAGMENT_CONSTANTS);
               break;
            case STAGE3D_FILTER_BLIND:
               this.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, POST_FILTER_VERTEX_CONSTANTS);
               this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, BLIND_FRAGMENT_CONSTANTS);
               break;
            case STAGE3D_FILTER_DRUNK:
               if ((((this.blurFragmentConstants[3] <= 0.2)) || ((this.blurFragmentConstants[3] >= 1.8)))) {
                  this.blurFactor = (this.blurFactor * -1);
               }
               this.blurFragmentConstants[3] = (this.blurFragmentConstants[3] + this.blurFactor);
               this.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, new Matrix3D());
               this.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, this.blurFragmentConstants, (this.blurFragmentConstants.length / 4));
               break;
         }
         this.context3D.GetContext3D().clear(0,0,0,1);
         this.context3D.GetContext3D().drawTriangles(this.postFilterIndexBuffer);
      }
      
      private function renderScene(param1:Vector.<GraphicsBitmapFill>) : void {
         var _loc3_:int = 0;
         this.context3D.clear();
         this.gm3d = this.graphic3D.getMatrix3D();
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_) {
            if(!this.cullSet) {
               this.context3D.GetContext3D().setCulling("none");
               this.cullSet = true;
            }
            this.graphic3D.setGraphic(param1[_loc3_],this.context3D);
            this.m3d.identity();
            this.m3d.append(this.gm3d);
            this.m3d.appendScale(1 / (this.stageWidth / Parameters.data.mscale / 2),
                    1 / (this.stageHeight / Parameters.data.mscale / 2),1);
            this.m3d.appendTranslation(this.tX / (this.stageWidth / Parameters.data.mscale),
                    this.tY / (this.stageHeight / Parameters.data.mscale),0);
            this.context3D.setProgramConstantsFromMatrix("vertex",0,this.m3d,true);
            this.graphic3D.render(this.context3D);
            _loc3_++;
         }
      }
      
      private function setTranslationToGame() : void {
         this.tX = -200 * Main.STAGE.stageWidth / 800;
         this.tY = Parameters.data.centerOnPlayer?(Camera.CenterRect.y + Camera.CenterRect.height / 2) * 2:Number((Camera.OffCenterRect.y + Camera.OffCenterRect.height / 2) * 2);
      }
      
      private function setTranslationToTitle() : void {
         this.tY = 0;
         this.tX = 0;
      }
   }
}
