package kabam.rotmg.ui.view {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.AccountScreen;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.ui.SoundIcon;
import com.worlize.gif.GIFPlayer;
import com.worlize.gif.events.GIFPlayerEvent;

import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
import flash.utils.ByteArray;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.model.EnvironmentData;
   import kabam.rotmg.ui.view.components.DarkLayer;
   import kabam.rotmg.ui.view.components.MenuOptionsBar;
   import org.osflash.signals.Signal;
   
   public class TitleView extends Sprite {

      private static var Gif:Class = Deez;

      public static var queueEmailConfirmation:Boolean = false;
      
      public static var queuePasswordPrompt:Boolean = false;
      
      public static var queuePasswordPromptFull:Boolean = false;
      
      public static var queueRegistrationPrompt:Boolean = false;
       
      
      public var playClicked:Signal;
      
      public var accountClicked:Signal;
      
      public var legendsClicked:Signal;
      
      private var versionText:TextFieldDisplayConcrete;
      
      private var copyrightText:TextFieldDisplayConcrete;
      
      private var menuOptionsBar:MenuOptionsBar;
      
      private var data:EnvironmentData;
      
      private var _buttonFactory:ButtonFactory;
      
      public function TitleView() {
         super();
         init();
      }
      
      public function get buttonFactory() : ButtonFactory {
         return this._buttonFactory;
      }
      
      public function init() : void {
         this._buttonFactory = new ButtonFactory();
         addChildAt(new DarkLayer(), 0);

         var player:GIFPlayer = new GIFPlayer();
         player.loadBytes(new Gif() as ByteArray);
         player.addEventListener(GIFPlayerEvent.COMPLETE, function (_:GIFPlayerEvent) : void {
            player.scaleX = 800 / player.width;
            player.scaleY = 600 / player.height;
            addChildAt(player, 0);
         });

         menuOptionsBar = makeMenuOptionsBar();
         addChildAt(menuOptionsBar, 1);
         addChildAt(new AccountScreen(), 2);
         makeChildren();
         addChildAt(new SoundIcon(), 3);
      }
      
      public function makeText() : TextFieldDisplayConcrete {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(8355711);
         _loc1_.filters = [new DropShadowFilter(0,0,0)];
         return _loc1_;
      }
      
      public function initialize(param1:EnvironmentData) : void {
         this.data = param1;
         this.updateVersionText();
      }
      
      private function makeMenuOptionsBar() : MenuOptionsBar {
         var _loc2_:TitleMenuOption = this._buttonFactory.getPlayButton();
         var _loc1_:TitleMenuOption = this._buttonFactory.getAccountButton();
         var _loc3_:TitleMenuOption = this._buttonFactory.getLegendsButton();
         this.playClicked = _loc2_.clicked;
         this.accountClicked = _loc1_.clicked;
         this.legendsClicked = _loc3_.clicked;
         var _loc4_:MenuOptionsBar = new MenuOptionsBar();
         _loc4_.addButton(_loc2_,"CENTER");
         _loc4_.addButton(_loc1_,"LEFT");
         _loc4_.addButton(_loc3_,"RIGHT");
         return _loc4_;
      }
      
      private function makeChildren() : void {
         this.versionText = this.makeText().setHTML(true).setAutoSize("left").setVerticalAlign("middle");
         this.versionText.y = 589.45;
         addChild(this.versionText);
         this.copyrightText = this.makeText().setAutoSize("right").setVerticalAlign("middle");
         this.copyrightText.setStringBuilder(new StaticStringBuilder("© 2021 DurgaSOFT SOLUTION"));
         this.copyrightText.filters = [new DropShadowFilter(0,0,0)];
         this.copyrightText.x = 800;
         this.copyrightText.y = 589.45;
         addChild(this.copyrightText);
      }
      
      private function updateVersionText() : void {
         this.versionText.setStringBuilder(new StaticStringBuilder("RotMG #" + Parameters.CLIENT_VERSION));
      }
   }
}
