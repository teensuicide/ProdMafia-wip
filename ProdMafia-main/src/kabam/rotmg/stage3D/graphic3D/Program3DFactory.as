package kabam.rotmg.stage3D.graphic3D {
   import kabam.rotmg.stage3D.proxies.Context3DProxy;
   import kabam.rotmg.stage3D.proxies.Program3DProxy;
   import kabam.rotmg.stage3D.shaders.FragmentShader;
   import kabam.rotmg.stage3D.shaders.FragmentShaderRepeat;
   import kabam.rotmg.stage3D.shaders.VertextShader;
   
   public class Program3DFactory {
      
      public static const TYPE_REPEAT_ON:Boolean = true;
      
      public static const TYPE_REPEAT_OFF:Boolean = false;
      
      private static var instance:Program3DFactory;
       
      
      private var repeatProgram:Program3DProxy;
      
      private var noRepeatProgram:Program3DProxy;
      
      public function Program3DFactory(param1:String = "") {
         super();
         if(param1 != "yoThisIsInternal") {
            throw new Error("Program3DFactory is a singleton. Use Program3DFactory.getInstance()");
         }
      }
      
      public static function getInstance() : Program3DFactory {
         if(instance == null) {
            instance = new Program3DFactory("yoThisIsInternal");
         }
         return instance;
      }
      
      public function dispose() : void {
         if(this.repeatProgram) {
            this.repeatProgram.getProgram3D().dispose();
         }
         if(this.noRepeatProgram) {
            this.noRepeatProgram.getProgram3D().dispose();
         }
         instance = null;
      }
      
      public function getProgram(param1:Context3DProxy, param2:Boolean) : Program3DProxy {
         var _loc3_:* = null;
         var _loc4_:* = param2;
         var _loc5_:* = _loc4_;
         switch(_loc5_) {
            case true:
               if(this.repeatProgram == null) {
                  this.repeatProgram = param1.createProgram();
                  this.repeatProgram.upload(new VertextShader().getVertexProgram(),new FragmentShaderRepeat().getVertexProgram());
               }
               _loc3_ = this.repeatProgram;
               break;
            case false:
               if(this.noRepeatProgram == null) {
                  this.noRepeatProgram = param1.createProgram();
                  this.noRepeatProgram.upload(new VertextShader().getVertexProgram(),new FragmentShader().getVertexProgram());
               }
               _loc3_ = this.noRepeatProgram;
               break;
            default:
               if(this.repeatProgram == null) {
                  this.repeatProgram = param1.createProgram();
                  this.repeatProgram.upload(new VertextShader().getVertexProgram(),new FragmentShaderRepeat().getVertexProgram());
               }
               _loc3_ = this.repeatProgram;
         }
         return _loc3_;
      }
   }
}
