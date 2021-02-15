package {
import mx.core.ByteArrayAsset;

[Embed(source="dump.bin", mimeType="application/octet-stream")]
public class PacketDump extends ByteArrayAsset {
   public function PacketDump() {
      super();
   }
}
}