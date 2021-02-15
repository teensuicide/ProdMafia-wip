package com.company.assembleegameclient.ui.exaltation {
import com.company.assembleegameclient.ui.exaltation.exaltationConfig;

import flash.geom.Rectangle;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;

public class ExaltationView extends ModalPopup {
   public function ExaltationView() {
      super(340, 505, "Exaltation", DefaultLabelFormat.defaultSmallPopupTitle,
              new Rectangle(0, 0, 340, 565));
   }
}
}