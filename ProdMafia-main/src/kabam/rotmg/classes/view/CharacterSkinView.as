package kabam.rotmg.classes.view {
   import com.company.assembleegameclient.screens.AccountScreen;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.rotmg.graphics.ScreenGraphic;
   import flash.display.Shape;
   import flash.display.Sprite;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.view.CreditDisplay;
   import kabam.rotmg.ui.view.SignalWaiter;
   import kabam.rotmg.ui.view.components.ScreenBase;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   import org.swiftsuspenders.Injector;
   
   public class CharacterSkinView extends Sprite {
       
      
      public var play:Signal;
      
      public var back:Signal;
      
      public var waiter:SignalWaiter;
      
      private var playBtn:TitleMenuOption;
      
      private var backBtn:TitleMenuOption;
      
      public function CharacterSkinView() {
         super();
         this.init();
      }
      
      public function setPlayButtonEnabled(param1:Boolean) : void {
         if(!param1) {
            this.playBtn.deactivate();
         }
      }
      
      private function init() : void {
         this.makeScreenBase();
         this.makeAccountScreen();
         this.makeLines();
         this.makeCreditDisplay();
         this.makeScreenGraphic();
         this.playBtn = this.makePlayButton();
         this.backBtn = this.makeBackButton();
         this.makeListView();
         this.makeClassDetailView();
         this.waiter = this.makeSignalWaiter();
         this.play = new NativeMappedSignal(this.playBtn,"click");
         this.back = new NativeMappedSignal(this.backBtn,"click");
      }
      
      private function makeScreenBase() : void {
         var _loc1_:ScreenBase = new ScreenBase();
         addChild(_loc1_);
      }
      
      private function makeAccountScreen() : void {
         var _loc1_:AccountScreen = new AccountScreen();
         addChild(_loc1_);
      }
      
      private function makeCreditDisplay() : void {
         var _loc2_:CreditDisplay = new CreditDisplay(null,true);
         var _loc1_:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
         if(_loc1_ != null) {
            _loc2_.draw(_loc1_.getCredits(),_loc1_.getFame(),_loc1_.getForgefire());
         }
         _loc2_.x = 800;
         _loc2_.y = 20;
         addChild(_loc2_);
      }
      
      private function makeLines() : void {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.clear();
         _loc1_.graphics.lineStyle(2,5526612);
         _loc1_.graphics.moveTo(0,105);
         _loc1_.graphics.lineTo(800,105);
         _loc1_.graphics.moveTo(346,105);
         _loc1_.graphics.lineTo(346,526);
         addChild(_loc1_);
      }
      
      private function makeScreenGraphic() : void {
         var _loc1_:ScreenGraphic = new ScreenGraphic();
         addChild(_loc1_);
      }
      
      private function makePlayButton() : TitleMenuOption {
         var _loc1_:TitleMenuOption = new TitleMenuOption("Screens.play",36,false);
         _loc1_.setAutoSize("center");
         _loc1_.setVerticalAlign("middle");
         _loc1_.x = 400 - _loc1_.width / 2;
         _loc1_.y = 550;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeBackButton() : TitleMenuOption {
         var _loc1_:* = null;
         _loc1_ = new TitleMenuOption("Screens.back",22,false);
         _loc1_.setVerticalAlign("middle");
         _loc1_.x = 30;
         _loc1_.y = 550;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeListView() : void {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Injector = StaticInjectorContext.getInjector();
         var _loc1_:SeasonalEventModel = _loc4_.getInstance(SeasonalEventModel);
         if(_loc1_.isChallenger) {
            _loc3_ = new UILabel();
            DefaultLabelFormat.createLabelFormat(_loc3_,18,16711680,"center",true);
            _loc3_.width = 200;
            _loc3_.multiline = true;
            _loc3_.wordWrap = true;
            _loc3_.text = "Skins are not available in Rifts Mode";
            _loc3_.x = 600 - _loc3_.width / 2;
            _loc3_.y = (600 - _loc3_.height) / 2;
            addChild(_loc3_);
         } else {
            _loc2_ = new CharacterSkinListView();
            _loc2_.x = 351;
            _loc2_.y = 110;
            addChild(_loc2_);
         }
      }
      
      private function makeClassDetailView() : void {
         var _loc1_:* = null;
         _loc1_ = new ClassDetailView();
         _loc1_.x = 5;
         _loc1_.y = 110;
         addChild(_loc1_);
      }
      
      private function makeSignalWaiter() : SignalWaiter {
         var _loc1_:SignalWaiter = new SignalWaiter();
         _loc1_.push(this.playBtn.changed);
         _loc1_.complete.add(this.positionOptions);
         return _loc1_;
      }
      
      private function positionOptions() : void {
         this.playBtn.x = stage.stageWidth / 2;
      }
   }
}
