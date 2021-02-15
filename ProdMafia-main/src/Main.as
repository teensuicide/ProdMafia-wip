package {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.StageProxy;
import com.hurlant.crypto.Crypto;
import com.hurlant.crypto.symmetric.ICipher;

import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.UncaughtErrorEvent;
import flash.filesystem.File;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

import io.decagames.rotmg.dailyQuests.config.DailyQuestsConfig;
import io.decagames.rotmg.nexusShop.config.NexusShopConfig;
import io.decagames.rotmg.pets.config.PetsConfig;
import io.decagames.rotmg.seasonalEvent.config.SeasonalEventConfig;
import io.decagames.rotmg.social.config.SocialConfig;
import io.decagames.rotmg.supportCampaign.config.SupportCampaignConfig;
import io.decagames.rotmg.tos.config.ToSConfig;
import kabam.lib.net.NetConfig;
import kabam.rotmg.account.AccountConfig;
import kabam.rotmg.appengine.AppEngineConfig;
import kabam.rotmg.application.ApplicationConfig;
import kabam.rotmg.application.ApplicationSpecificConfig;
import kabam.rotmg.arena.ArenaConfig;
import kabam.rotmg.assets.AssetsConfig;
import kabam.rotmg.build.BuildConfig;
import kabam.rotmg.characters.CharactersConfig;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.classes.ClassesConfig;
import kabam.rotmg.core.CoreConfig;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dailyLogin.config.DailyLoginConfig;
import kabam.rotmg.death.DeathConfig;
import kabam.rotmg.dialogs.DialogsConfig;
import kabam.rotmg.errors.ErrorConfig;
import kabam.rotmg.external.ExternalConfig;
import kabam.rotmg.fame.FameConfig;
import kabam.rotmg.game.GameConfig;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.language.LanguageConfig;
import kabam.rotmg.legends.LegendsConfig;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.data.WorldPosData;
import kabam.rotmg.minimap.MiniMapConfig;
import kabam.rotmg.mysterybox.MysteryBoxConfig;
import kabam.rotmg.news.NewsConfig;
import kabam.rotmg.packages.PackageConfig;
import kabam.rotmg.promotions.PromotionsConfig;
import kabam.rotmg.protip.ProTipConfig;
import kabam.rotmg.servers.ServersConfig;
import kabam.rotmg.stage3D.Stage3DConfig;
import kabam.rotmg.startup.StartupConfig;
import kabam.rotmg.startup.control.StartupSignal;
import kabam.rotmg.text.TextConfig;
import kabam.rotmg.tooltips.TooltipsConfig;
import kabam.rotmg.ui.UIConfig;
import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.api.IContext;

[SWF(frameRate="60", backgroundColor="#000000", width="800", height="600")]
public class Main extends Sprite {
   public static var STAGE:Stage;
   public static var sWidth:Number = 800;
   public static var sHeight:Number = 600;
   public static var focus:Boolean = true;

   protected var context:IContext;

   private static const PACKET_DUMP:Class = PacketDump;
   private static const INBOUND:Boolean = false;

   public function Main() {
      super();
      if (stage) {
         stage.addEventListener("resize",this.onStageResize,false,0,true);
         this.setup();
      } else {
         addEventListener("addedToStage",this.onAddedToStage);
      }


      var ba:ByteArray = ByteArray(new PACKET_DUMP());
      var cipher:ICipher = Crypto.getCipher("rc4",
              INBOUND ? Parameters.RANDOM2_BA : Parameters.RANDOM1_BA);
      cipher.decrypt(ba);
      var bytes:int = ba.bytesAvailable;
      for (var i:int = 0; i < bytes; i++)
         trace(ba.readByte());
   }

   private static function uncaughtErrorHandler(param1:UncaughtErrorEvent) : void {
      if (!Parameters.data.logErrors)
         return;

      var _loc3_:* = null;
      if(param1.error is Error) {
         _loc3_ = (param1.error as Error).getStackTrace();
      } else if(param1.error is ErrorEvent) {
         _loc3_ = (param1.error as ErrorEvent).text;
      } else {
         _loc3_ = param1.text;
      }
      param1.preventDefault();
      var _loc4_:File = File.documentsDirectory.resolvePath("prod-errors.log");
      var _loc5_:FileStream = new FileStream();
      _loc5_.open(_loc4_,"append");
      var _loc2_:Date = new Date();
      _loc5_.writeUTFBytes("\n[" + (_loc2_.monthUTC + 1) + "/" + _loc2_.dateUTC + "/" + _loc2_.fullYearUTC + " " + trailZero(_loc2_.hoursUTC) + ":" + trailZero(_loc2_.minutesUTC) + ":" + trailZero(_loc2_.secondsUTC) + "] " + _loc3_);
      _loc5_.close();
      var _loc6_:AddTextLineSignal = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
      _loc6_.dispatch(ChatMessage.make("*Error*","Uncaught Error! A full stack trace can be viewed in your Documents folder."));
   }

   private static function trailZero(param1:int) : String {
      var _loc2_:String = param1.toString();
      if(_loc2_.length == 1) {
         _loc2_ = "0" + _loc2_;
      }
      return _loc2_;
   }

   private function setup() : void {
      stage.addEventListener("keyDown",this.onKeyDown);
      stage.scaleMode = "exactFit";
      this.createContext();
      new AssetLoader().load();
      this.context.injector.getInstance(StartupSignal).dispatch();
      STAGE = stage;
      STAGE.frameRate = Parameters.data.customFPS;
      addFocusListeners();
      Parameters.root = root;
      if(Parameters.data.fullscreen) {
         stage.displayState = "fullScreenInteractive";
      }
      loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError",uncaughtErrorHandler);
   }

   private function addFocusListeners() : void {
      stage.addEventListener("activate",this.onActivate,false,0,true);
      stage.addEventListener("deactivate",this.onDeactivate,false,0,true);
   }

   private function createContext() : void {
      this.context = new StaticInjectorContext();
      this.context.injector.map(LoaderInfo).toValue(root.stage.root.loaderInfo);
      var _loc1_:StageProxy = new StageProxy(this);
      this.context.injector.map(StageProxy).toValue(_loc1_);
      this.context.extend(MVCSBundle,SignalCommandMapExtension).configure(BuildConfig,StartupConfig,NetConfig,AssetsConfig,DialogsConfig,ApplicationConfig,LanguageConfig,TextConfig,AppEngineConfig,AccountConfig,ErrorConfig,CoreConfig,ApplicationSpecificConfig,DeathConfig,CharactersConfig,ServersConfig,GameConfig,UIConfig,MiniMapConfig,LegendsConfig,NewsConfig,FameConfig,TooltipsConfig,PromotionsConfig,ProTipConfig,ClassesConfig,PackageConfig,PetsConfig,DailyLoginConfig,Stage3DConfig,ArenaConfig,ExternalConfig,MysteryBoxConfig,DailyQuestsConfig,SocialConfig,NexusShopConfig,ToSConfig,SupportCampaignConfig,SeasonalEventConfig,this);
      this.context.logLevel = 32;
   }

   public function onStageResize(param1:Event) : void {
      this.scaleX = stage.stageWidth / 800;
      this.scaleY = stage.stageHeight / 600;
      this.x = (800 - stage.stageWidth) / 2;
      this.y = (600 - stage.stageHeight) / 2;
      sWidth = stage.stageWidth;
      sHeight = stage.stageHeight;
   }

   private function onAddedToStage(param1:Event) : void {
      stage.addEventListener("resize",this.onStageResize,false,0,true);
      removeEventListener("addedToStage",this.onAddedToStage);
      this.setup();
   }

   private function onActivate(param1:Event) : void {
      focus = true;
   }

   private function onDeactivate(param1:Event) : void {
      focus = false;
   }

   private function onKeyDown(param1:KeyboardEvent) : void {
      if(param1.keyCode == 27) {
         param1.preventDefault();
      }
   }
}
}
