package io.decagames.rotmg.shop.packages.contentPopup {
   import flash.utils.Dictionary;
   import io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemBox;
   import io.decagames.rotmg.shop.mysteryBox.contentPopup.SlotBox;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PackageBoxContentPopupMediator extends Mediator {
       
      
      [Inject]
      public var view:PackageBoxContentPopup;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      private var closeButton:SliceScalingButton;
      
      private var contentGrids:UIGrid;
      
      public function PackageBoxContentPopupMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.addContentList(this.view.info.contents,this.view.info.charSlot,this.view.info.vaultSlot,this.view.info.gold);
      }
      
      override public function destroy() : void {
         this.closeButton.clickSignal.remove(this.onClose);
         this.closeButton.dispose();
         this.contentGrids.dispose();
         this.contentGrids = null;
      }
      
      private function addContentList(param1:String, param2:int, param3:int, param4:int) : void {
         var _loc16_:int = 0;
         var _loc13_:* = undefined;
         var _loc7_:* = undefined;
         var _loc6_:* = undefined;
         var _loc5_:* = undefined;
         var _loc21_:int = 0;
         var _loc15_:* = undefined;
         var _loc17_:* = null;
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc8_:* = null;
         var _loc18_:* = null;
         var _loc20_:* = null;
         var _loc12_:* = null;
         var _loc10_:* = null;
         var _loc19_:* = null;
         this.contentGrids = new UIGrid(255,1,2);
         if(param1 != "") {
            _loc17_ = param1.split(",");
            _loc11_ = new Dictionary();
            _loc16_ = 0;
            _loc13_ = _loc17_;
            var _loc23_:int = 0;
            var _loc22_:* = _loc17_;
            for each(_loc14_ in _loc17_) {
               if(_loc11_[_loc14_]) {
                  _loc7_ = _loc11_;
                  _loc6_ = _loc14_;
                  _loc5_ = Number(_loc7_[_loc6_]) + 1;
                  _loc7_[_loc6_] = _loc5_;
               } else {
                  _loc11_[_loc14_] = 1;
               }
            }
            _loc8_ = [];
            _loc21_ = 0;
            _loc15_ = _loc17_;
            var _loc25_:int = 0;
            var _loc24_:* = _loc17_;
            for each(_loc18_ in _loc17_) {
               if(_loc8_.indexOf(_loc18_) == -1) {
                  _loc20_ = new ItemBox(_loc18_,_loc11_[_loc18_],true,"",false);
                  this.contentGrids.addGridElement(_loc20_);
                  _loc8_.push(_loc18_);
               }
            }
         }
         if(param2 > 0) {
            _loc12_ = new SlotBox("CHAR_SLOT",param2,true,"",false);
            this.contentGrids.addGridElement(_loc12_);
         }
         if(param3 > 0) {
            _loc10_ = new SlotBox("VAULT_SLOT",param3,true,"",false);
            this.contentGrids.addGridElement(_loc10_);
         }
         if(param4 > 0) {
            _loc19_ = new SlotBox("GOLD_SLOT",param4,true,"",false);
            this.contentGrids.addGridElement(_loc19_);
         }
         this.contentGrids.y = this.view.infoLabel.textHeight + 8;
         this.contentGrids.x = 10;
         this.view.addChild(this.contentGrids);
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
   }
}
