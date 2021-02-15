package kabam.rotmg.stage3D.shaders {
   import com.adobe.utils.AGALMiniAssembler;
   import flash.utils.ByteArray;
   
   public class FragmentShader {
       
      
      private var vertexProgram:ByteArray;
      
      public function FragmentShader() {
         super();
         var _loc1_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc1_.assemble("fragment","tex ft1, v0, fs0 <2d>\nmul ft1.x, ft1.x, fc2.x\nmul ft1.y, ft1.y, fc2.y\nmul ft1.z, ft1.z, fc2.z\nmul ft1.w, ft1.w, fc2.w\nadd ft1, ft1, fc3\nmov oc, ft1");
         this.vertexProgram = _loc1_.agalcode;
      }
      
      public function getVertexProgram() : ByteArray {
         return this.vertexProgram;
      }
   }
}
