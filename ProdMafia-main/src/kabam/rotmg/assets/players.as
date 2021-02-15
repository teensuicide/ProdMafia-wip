package kabam.rotmg.assets {
import mx.core.ByteArrayAsset;

[Embed(source="players.txt", mimeType="application/octet-stream")]
public class players extends ByteArrayAsset {
   public function players() {
      super();
   }
}
}