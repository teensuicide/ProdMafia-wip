package kabam.rotmg.stage3D {
   import com.company.assembleegameclient.util.Stage3DProxy;
   import com.company.assembleegameclient.util.StageProxy;
   import flash.events.Event;
   import kabam.rotmg.stage3D.graphic3D.Graphic3DHelper;
   import kabam.rotmg.stage3D.graphic3D.IndexBufferFactory;
   import kabam.rotmg.stage3D.graphic3D.TextureFactory;
   import kabam.rotmg.stage3D.graphic3D.VertexBufferFactory;
   import kabam.rotmg.stage3D.proxies.Context3DProxy;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.framework.api.IConfig;
   
   public class Stage3DConfig implements IConfig {
       
      
      [Inject]
      public var stageProxy:StageProxy;
      
      [Inject]
      public var injector:Injector;
      
      public var renderer:Renderer;
      
      private var stage3D:Stage3DProxy;
      
      public function Stage3DConfig() {
         super();
      }
      
      public function configure() : void {
         this.mapSingletons();
         this.stage3D = this.stageProxy.getStage3Ds(0);
         this.stage3D.addEventListener("context3DCreate",this.onContextCreate);
         this.stage3D.requestContext3D();
      }
      
      private function mapSingletons() : void {
         this.injector.map(Render3D).asSingleton();
         this.injector.map(TextureFactory).asSingleton();
         this.injector.map(IndexBufferFactory).asSingleton();
         this.injector.map(VertexBufferFactory).asSingleton();
      }
      
      private function onContextCreate(param1:Event) : void {
         this.stage3D.removeEventListener("context3DCreate",this.onContextCreate);
         var _loc2_:Context3DProxy = this.stage3D.getContext3D();
         _loc2_.configureBackBuffer(800,600,0);
         _loc2_.setBlendFactors("sourceAlpha","oneMinusSourceAlpha");
         _loc2_.setDepthTest(false,"lessEqual");
         this.injector.map(Context3DProxy).toValue(_loc2_);
         Graphic3DHelper.map(this.injector);
         this.renderer = this.injector.getInstance(Renderer);
         this.renderer.init(_loc2_.GetContext3D());
      }
   }
}
