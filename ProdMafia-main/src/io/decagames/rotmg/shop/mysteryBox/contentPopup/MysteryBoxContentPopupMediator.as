package io.decagames.rotmg.shop.mysteryBox.contentPopup {
   import flash.utils.Dictionary;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class MysteryBoxContentPopupMediator extends Mediator {
       
      
      [Inject]
      public var view:MysteryBoxContentPopup;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      private var closeButton:SliceScalingButton;
      
      private var contentGrids:Vector.<UIGrid>;
      
      private var jackpotsNumber:int = 0;
      
      private var jackpotsHeight:int = 0;
      
      private var jackpotUI:JackpotContainer;
      
      public function MysteryBoxContentPopupMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.addJackpots(this.view.info.jackpots);
         this.addContentList(this.view.info.contents,this.view.info.jackpots);
      }
      
      override public function destroy() : void {
         var _loc3_:* = null;
         this.closeButton.dispose();
         var _loc1_:* = this.contentGrids;
         var _loc5_:int = 0;
         var _loc4_:* = this.contentGrids;
         for each(_loc3_ in this.contentGrids) {
            _loc3_.dispose();
         }
         this.contentGrids = null;
      }
      
      private function addJackpots(param1:String) : void {
         var _loc15_:int = 0;
         var _loc16_:* = undefined;
         var _loc8_:int = 0;
         var _loc14_:* = undefined;
         var _loc5_:* = null;
         var _loc17_:* = null;
         var _loc13_:* = null;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc12_:int = 0;
         var _loc11_:Array = param1.split("|");
         var _loc6_:* = _loc11_;
         var _loc23_:int = 0;
         var _loc22_:* = _loc11_;
         for each(_loc5_ in _loc11_) {
            _loc17_ = _loc5_.split(",");
            _loc13_ = [];
            _loc10_ = [];
            _loc15_ = 0;
            _loc16_ = _loc17_;
            var _loc19_:int = 0;
            var _loc18_:* = _loc17_;
            for each(_loc9_ in _loc17_) {
               _loc7_ = _loc13_.indexOf(_loc9_);
               if(_loc7_ == -1) {
                  _loc13_.push(_loc9_);
                  _loc10_.push(1);
               } else {
                  _loc10_[_loc7_] = _loc10_[_loc7_] + 1;
               }
            }
            if(param1.length > 0) {
               _loc2_ = new UIGrid(220,5,4);
               _loc2_.centerLastRow = true;
               _loc8_ = 0;
               _loc14_ = _loc13_;
               var _loc21_:int = 0;
               var _loc20_:* = _loc13_;
               for each(_loc9_ in _loc13_) {
                  _loc3_ = new UIItemContainer(parseInt(_loc9_),4737096,0,40);
                  _loc3_.showTooltip = true;
                  _loc2_.addGridElement(_loc3_);
                  _loc12_ = _loc10_[_loc13_.indexOf(_loc9_)];
                  if(_loc12_ > 1) {
                     _loc3_.showQuantityLabel(_loc12_);
                  }
               }
               this.jackpotUI = new JackpotContainer();
               this.jackpotUI.x = 10;
               this.jackpotUI.y = 55 + this.jackpotsHeight - 22;
               if(this.jackpotsNumber == 0) {
                  this.jackpotUI.diamondBackground();
               } else if(this.jackpotsNumber == 1) {
                  this.jackpotUI.goldBackground();
               } else if(this.jackpotsNumber == 2) {
                  this.jackpotUI.silverBackground();
               }
               this.jackpotUI.addGrid(_loc2_);
               this.view.addChild(this.jackpotUI);
               this.jackpotsHeight = this.jackpotsHeight + (this.jackpotUI.height + 5);
               this.jackpotsNumber++;
            }
         }
      }
      
      private function addContentList(param1:String, param2:String) : void {
         var _loc31_:* = undefined;
         var _loc32_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc24_:int = 0;
         var _loc26_:* = undefined;
         var _loc36_:int = 0;
         var _loc38_:* = undefined;
         var _loc28_:int = 0;
         var _loc34_:* = undefined;
         var _loc29_:* = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc25_:* = null;
         var _loc20_:* = null;
         var _loc14_:* = null;
         var _loc35_:* = null;
         var _loc33_:Boolean = false;
         var _loc23_:* = null;
         var _loc39_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = undefined;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc27_:int = 0;
         var _loc37_:Array = param1.split("|");
         var _loc15_:Array = param2.split("|");
         var _loc21_:* = [];
         var _loc30_:* = _loc37_;
         var _loc46_:int = 0;
         var _loc45_:* = _loc37_;
         for each(_loc29_ in _loc37_) {
            _loc20_ = [];
            _loc14_ = _loc29_.split(";");
            _loc31_ = 0;
            _loc32_ = _loc14_;
            var _loc44_:int = 0;
            var _loc43_:* = _loc14_;
            for each(_loc35_ in _loc14_) {
               _loc33_ = false;
               _loc4_ = 0;
               _loc5_ = _loc15_;
               var _loc42_:int = 0;
               var _loc41_:* = _loc15_;
               for each(_loc23_ in _loc15_) {
                  if(_loc23_ == _loc35_) {
                     _loc33_ = true;
                     break;
                  }
               }
               if(!_loc33_) {
                  _loc39_ = _loc35_.split(",");
                  _loc20_.push(_loc39_);
               }
            }
            _loc21_[_loc27_] = _loc20_;
            _loc27_++;
         }
         _loc18_ = 475;
         _loc19_ = 30;
         if(this.jackpotsNumber > 0) {
            _loc18_ = _loc18_ - (this.jackpotsHeight + 10);
            _loc19_ = _loc19_ + (this.jackpotsHeight + 10);
         }
         this.contentGrids = new Vector.<UIGrid>(0);
         var _loc22_:Number = (260 - 5 * (_loc21_.length - 1)) / _loc21_.length;
         var _loc17_:* = _loc21_;
         var _loc54_:int = 0;
         var _loc53_:* = _loc21_;
         for each(_loc25_ in _loc21_) {
            _loc6_ = new UIGrid(_loc22_,1,5);
            _loc24_ = 0;
            _loc26_ = _loc25_;
            var _loc52_:int = 0;
            var _loc51_:* = _loc25_;
            for each(_loc3_ in _loc25_) {
               _loc8_ = new Vector.<ItemBox>();
               _loc10_ = new Dictionary();
               _loc36_ = 0;
               _loc38_ = _loc3_;
               var _loc48_:int = 0;
               var _loc47_:* = _loc3_;
               for each(_loc11_ in _loc3_) {
                  if(_loc10_[_loc11_]) {
                     _loc4_ = _loc10_;
                     _loc5_ = _loc11_;
                     _loc31_ = Number(_loc4_[_loc5_]) + 1;
                     _loc4_[_loc5_] = _loc31_;
                  } else {
                     _loc10_[_loc11_] = 1;
                  }
               }
               _loc7_ = [];
               _loc28_ = 0;
               _loc34_ = _loc3_;
               var _loc50_:int = 0;
               var _loc49_:* = _loc3_;
               for each(_loc9_ in _loc3_) {
                  if(_loc7_.indexOf(_loc9_) == -1) {
                     _loc13_ = new ItemBox(_loc9_,_loc10_[_loc9_],_loc21_.length == 1,"",false);
                     _loc13_.clearBackground();
                     _loc8_.push(_loc13_);
                     _loc7_.push(_loc9_);
                  }
               }
               _loc12_ = new ItemsSetBox(_loc8_);
               _loc6_.addGridElement(_loc12_);
            }
            _loc6_.y = _loc19_;
            _loc6_.x = 10 + _loc22_ * this.contentGrids.length + 5 * this.contentGrids.length;
            this.view.addChild(_loc6_);
            this.contentGrids.push(_loc6_);
         }
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
   }
}
