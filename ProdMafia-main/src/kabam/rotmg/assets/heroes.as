package kabam.rotmg.assets {
import mx.core.ByteArrayAsset;

[Embed(source="heroes.txt", mimeType="application/octet-stream")]
public class heroes extends ByteArrayAsset {
   public function heroes() {
      super();
   }
}
}