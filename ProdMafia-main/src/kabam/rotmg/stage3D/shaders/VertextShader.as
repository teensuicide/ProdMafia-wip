package kabam.rotmg.stage3D.shaders {
   import com.adobe.utils.AGALMiniAssembler;
   import flash.utils.ByteArray;
   
   public class VertextShader extends AGALMiniAssembler {
       
      
      private var vertexProgram:ByteArray;
      
      public function VertextShader() {
         super();
         var _loc1_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc1_.assemble("vertex","m44 op, va0, vc0\nadd vt1, va1, vc4\nmov v0, vt1");
         this.vertexProgram = _loc1_.agalcode;
      }
      
      public function getVertexProgram() : ByteArray {
         return this.vertexProgram;
      }
   }
}
