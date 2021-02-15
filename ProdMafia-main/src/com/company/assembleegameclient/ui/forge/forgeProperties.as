package com.company.assembleegameclient.ui.forge {

import mx.core.ByteArrayAsset;

[Embed(source="forgeProperties.txt", mimeType="application/octet-stream")]
public class forgeProperties extends ByteArrayAsset {
   public function forgeProperties() {
      super();
   }
}
}