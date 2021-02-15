package kabam.rotmg.chat.control {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.TextureDataConcrete;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.utils.Dictionary;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.social.model.SocialModel;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.view.ConfirmEmailModal;
   import kabam.rotmg.application.api.ApplicationSetup;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.chat.model.TellModel;
   import kabam.rotmg.chat.view.ChatListItemFactory;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.model.AddSpeechBalloonVO;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import kabam.rotmg.language.model.StringMap;
   import kabam.rotmg.messaging.impl.incoming.Text;
   import kabam.rotmg.news.view.NewsTicker;
   import kabam.rotmg.servers.api.ServerModel;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.signals.RealmServerNameSignal;
   
   public class TextHandler {
       
      
      private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908,16777215,5526612);
      
      private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060,16549442,13484223);
      
      private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110,61695,13880567);
      
      private const GUILD_SPEECH_COLORS:TextColors = new TextColors(4098560,10944349,13891532);
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var model:GameModel;
      
      [Inject]
      public var addTextLine:AddTextLineSignal;
      
      [Inject]
      public var addSpeechBalloon:AddSpeechBalloonSignal;
      
      [Inject]
      public var stringMap:StringMap;
      
      [Inject]
      public var tellModel:TellModel;
      
      [Inject]
      public var spamFilter:SpamFilter;
      
      [Inject]
      public var openDialogSignal:OpenDialogSignal;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var socialModel:SocialModel;
      
      [Inject]
      public var setup:ApplicationSetup;
      
      [Inject]
      public var realmServerNameSignal:RealmServerNameSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var similar:Dictionary;
      
      public function TextHandler() {
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         super();
         if(similar == null) {
            _loc5_ = "w".charCodeAt(0);
            _loc1_ = "r".charCodeAt(0);
            _loc4_ = "g".charCodeAt(0);
            _loc3_ = "t".charCodeAt(0);
            _loc2_ = "o".charCodeAt(0);
            similar = new Dictionary(true);
            similar["Ŕ"] = _loc1_;
            similar["ŕ"] = _loc1_;
            similar["Ŗ"] = _loc1_;
            similar["ŗ"] = _loc1_;
            similar["Ř"] = _loc1_;
            similar["ř"] = _loc1_;
            similar["Ŵ"] = _loc5_;
            similar["ŵ"] = _loc5_;
            similar["Ţ"] = _loc3_;
            similar["ţ"] = _loc3_;
            similar["Ť"] = _loc3_;
            similar["ť"] = _loc3_;
            similar["Ŧ"] = _loc3_;
            similar["ŧ"] = _loc3_;
            similar["Ț"] = _loc3_;
            similar["ț"] = _loc3_;
            similar["†"] = _loc3_;
            similar["‡"] = _loc3_;
            similar["Ĝ"] = _loc4_;
            similar["ĝ"] = _loc4_;
            similar["Ğ"] = _loc4_;
            similar["ğ"] = _loc4_;
            similar["Ġ"] = _loc4_;
            similar["ġ"] = _loc4_;
            similar["Ģ"] = _loc4_;
            similar["ģ"] = _loc4_;
         }
      }
      
      public function execute(param1:Text) : void {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc12_:* = null;
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc3_:* = null;
         var _loc10_:* = null;
         if(Parameters.lowCPUMode && param1.recipient_.length == 0) {
            if(Parameters.data.hideLowCPUModeChat && param1.numStars_ > -1) {
               return;
            }
         }
         var _loc13_:* = param1.numStars_ == -1;
         var _loc5_:Boolean = param1.name_ != this.model.player.name_ && !_loc13_ && !this.isSpecialRecipientChat(param1.recipient_);
         if(param1.numStars_ < Parameters.data.chatStarRequirement && _loc5_) {
            return;
         }
         if(param1.recipient_ != "" && Parameters.data.chatFriend && !this.socialModel.isMyFriend(param1.recipient_)) {
            return;
         }
         if(!Parameters.data.chatAll && _loc5_) {
            if(!(param1.recipient_ == "*Guild*" && Parameters.data.chatGuild)) {
               if(!(param1.numStars_ < Parameters.data.chatStarRequirement && param1.recipient_ != "" && Parameters.data.chatWhisper)) {
                  if(!(param1.recipient_ != "" && Parameters.data.chatWhisper)) {
                     return;
                  }
               }
            }
         }
         if(this.useCleanString(param1)) {
            _loc9_ = param1.cleanText_;
            param1.cleanText_ = this.replaceIfSlashServerCommand(param1.cleanText_);
         } else {
            _loc9_ = param1.text_;
            param1.text_ = this.replaceIfSlashServerCommand(param1.text_);
         }
         if(_loc13_ && this.isToBeLocalized(_loc9_)) {
            _loc9_ = this.getLocalizedString(_loc9_);
         }
         if(!_loc13_) {
            _loc11_ = getCustomMultiColors(param1.text_.toLowerCase());
            var _loc15_:int = 0;
            var _loc14_:* = Parameters.filtered;
            for each(var _loc7_ in Parameters.filtered) {
               if(_loc11_.indexOf(_loc7_) != -1) {
                  return;
               }
            }
            var _loc17_:int = 0;
            var _loc16_:* = Parameters.appendage;
            for each(_loc7_ in Parameters.appendage) {
               if(_loc11_.indexOf(_loc7_) != -1) {
                  return;
               }
            }
         } else if(param1.text_.indexOf("Current number of") != -1) {
            _loc3_ = "Enemies: " + param1.text_.substring(40,param1.text_.length - 1);
            this.hudModel.gameSprite.updateEnemyCounter(_loc3_);
            return;
         }
         if(param1.recipient_) {
            if(param1.recipient_ != this.model.player.name_ && !this.isSpecialRecipientChat(param1.recipient_)) {
               this.tellModel.push(param1.recipient_);
               this.tellModel.resetRecipients();
            } else if(param1.recipient_ == this.model.player.name_) {
               this.tellModel.push(param1.name_);
               this.tellModel.resetRecipients();
            }
         }
         if(_loc13_ && TextureDataConcrete.remoteTexturesUsed) {
            TextureDataConcrete.remoteTexturesUsed = false;
            if(this.setup.isServerLocal()) {
               _loc12_ = param1.name_;
               _loc6_ = param1.text_;
               param1.name_ = "";
               param1.text_ = "Remote Textures used in this build";
               this.addTextAsTextLine(param1);
               param1.name_ = _loc12_;
               param1.text_ = _loc6_;
            }
         }
         if(_loc13_) {
            if(param1.name_ == "" && param1.text_.indexOf("NexusPortal.") != -1) {
               this.dispatchServerName(param1.text_);
            }
            _loc4_ = -1;
            if(param1.text_ == "Please verify your email before chat" && this.hudModel != null && this.hudModel.gameSprite.map.name_ == "Nexus" && this.openDialogSignal != null) {
               this.openDialogSignal.dispatch(new ConfirmEmailModal());
            } else if(param1.name_ == "@ANNOUNCEMENT") {
               if(this.hudModel && this.hudModel.gameSprite && this.hudModel.gameSprite.newsTicker) {
                  this.hudModel.gameSprite.newsTicker.activateNewScrollText(param1.text_);
               } else {
                  NewsTicker.setPendingScrollText(param1.text_);
               }
            } else {
               _loc4_ = param1.text_.indexOf("Realm NexusPortal.");
               if(param1.text_.indexOf("Realm NexusPortal.") != -1) {
                  param1.text_ = param1.text_.substring(0,_loc4_) + param1.text_.substring(_loc4_ + "Realm NexusPortal.".length) + ".";
               }
            }
            if(Parameters.data.AutoResponder) {
               if(param1.name_ == "#Thessal the Mermaid Goddess" && param1.text_ == "Is King Alexander alive?") {
                  this.model.player.map_.gs_.gsc_.playerText("He lives and reigns and conquers the world");
               } else if(param1.name_ == "#Ghost of Skuld" && param1.text_.indexOf("\'READY\'") != -1) {
                  this.model.player.map_.gs_.gsc_.playerText("ready");
               } else if(param1.name_ == "#Craig, Intern of the Mad God" && param1.text_.indexOf("say SKIP and") != -1) {
                  this.model.player.map_.gs_.gsc_.playerText("skip");
               } else if(param1.name_ == "#Computer" && param1.text_.indexOf("Password:") != -1) {
                  this.model.player.map_.gs_.gsc_.playerText("Dr Terrible");
               } else if(param1.name_ == "#Master Rat") {
                  _loc10_ = getSplinterReply(param1.text_);
                  if(_loc10_ != "") {
                     this.hudModel.gameSprite.gsc_.playerText(_loc10_);
                  }
               }
            }
            _loc8_ = Parameters.timerPhaseTimes[param1.text_];
            if(_loc8_ > 0) {
               Parameters.timerActive = true;
               Parameters.phaseChangeAt = TimeUtil.getTrueTime() + _loc8_;
               Parameters.phaseName = Parameters.timerPhaseNames[param1.text_];
            }
         }
         if(param1.objectId_ >= 0) {
            this.showSpeechBaloon(param1,_loc9_);
         }
         if(_loc13_ || this.account.isRegistered() && (!Parameters.data.hidePlayerChat || this.isSpecialRecipientChat(param1.name_))) {
            this.addTextAsTextLine(param1);
         }
      }
      
      public function getSplinterReply(param1:String) : String {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "What time is it?":
               return "It\'s pizza time!";
            case "Where is the safest place in the world?":
               return "Inside my shell.";
            case "What is fast, quiet and hidden by the night?":
               return "A ninja of course!";
            case "How do you like your pizza?":
               return "Extra cheese, hold the anchovies.";
            case "Who did this to me?":
               return "Dr. Terrible, the mad scientist.";
            default:
               return "";
         }
      }
      
      public function addTextAsTextLine(param1:Text) : void {
         var _loc2_:ChatMessage = new ChatMessage();
         _loc2_.name = param1.name_;
         _loc2_.objectId = param1.objectId_;
         _loc2_.numStars = param1.numStars_;
         _loc2_.recipient = param1.recipient_;
         _loc2_.isWhisper = param1.recipient_ && !this.isSpecialRecipientChat(param1.recipient_);
         _loc2_.isToMe = param1.recipient_ == this.model.player.name_;
         _loc2_.isFromSupporter = param1.isSupporter;
         this.addMessageText(param1,_loc2_);
         this.addTextLine.dispatch(_loc2_);
      }
      
      public function addMessageText(param1:Text, param2:ChatMessage) : void {
         var _loc5_:* = null;
         var _loc4_:* = param1;
         var _loc3_:* = param2;
         try {
            _loc5_ = LineBuilder.fromJSON(_loc4_.text_);
         }
         catch(error:Error) {
         }
         if(_loc5_) {
            _loc3_.text = _loc5_.key;
            _loc3_.tokens = _loc5_.tokens;
         } else {
            _loc3_.text = !!useCleanString(_loc4_)?_loc4_.cleanText_:_loc4_.text_;
         }
      }
      
      private function isSpecialRecipientChat(param1:String) : Boolean {
         return param1.length > 0 && (param1.charAt(0) == "#" || param1.charAt(0) == "*");
      }
      
      private function dispatchServerName(param1:String) : void {
         var _loc2_:String = param1.substring(param1.indexOf(".") + 1);
         this.realmServerNameSignal.dispatch(_loc2_);
      }
      
      private function replaceIfSlashServerCommand(param1:String) : String {
         var _loc2_:* = null;
         if(param1.substr(0,7) == "74026S9") {
            _loc2_ = StaticInjectorContext.getInjector().getInstance(ServerModel);
            if(_loc2_ && _loc2_.getServer()) {
               return param1.replace("74026S9",_loc2_.getServer().name + ", ");
            }
         }
         return param1;
      }
      
      private function isToBeLocalized(param1:String) : Boolean {
         return param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}";
      }
      
      private function getLocalizedString(param1:String) : String {
         var _loc2_:LineBuilder = LineBuilder.fromJSON(param1);
         _loc2_.setStringMap(this.stringMap);
         return _loc2_.getString();
      }
      
      private function showSpeechBaloon(param1:Text, param2:String) : void {
         var _loc3_:* = null;
         var _loc5_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc6_:* = null;
         var _loc4_:GameObject = this.model.getGameObject(param1.objectId_);
         if(_loc4_) {
            _loc3_ = this.getColors(param1,_loc4_);
            _loc5_ = ChatListItemFactory.isTradeMessage(param1.numStars_,param1.objectId_,param2);
            _loc7_ = ChatListItemFactory.isGuildMessage(param1.name_);
            _loc6_ = new AddSpeechBalloonVO(_loc4_,param2,param1.name_,_loc5_,_loc7_,_loc3_.back,1,_loc3_.outline,1,_loc3_.text,param1.bubbleTime_,false,true);
            this.addSpeechBalloon.dispatch(_loc6_);
         }
      }
      
      private function getColors(param1:Text, param2:GameObject) : TextColors {
         if(param2.props_.isEnemy_) {
            return this.ENEMY_SPEECH_COLORS;
         }
         if(param1.recipient_ == "*Guild*") {
            return this.GUILD_SPEECH_COLORS;
         }
         if(param1.recipient_ != "") {
            return this.TELL_SPEECH_COLORS;
         }
         return this.NORMAL_SPEECH_COLORS;
      }
      
      private function useCleanString(param1:Text) : Boolean {
         return Parameters.data.filterLanguage && param1.cleanText_.length > 0 && param1.objectId_ != this.model.player.objectId_;
      }
      
      private function getCustomMultiColors(param1:String) : String {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = [];
         var _loc2_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_) {
            _loc4_ = param1.charAt(_loc6_);
            if(_loc4_ in similar) {
               _loc3_ = similar[_loc4_];
            } else {
               _loc3_ = param1.charCodeAt(_loc6_);
            }
            if(_loc3_ >= 48 && _loc3_ <= 57 || _loc3_ >= 97 && _loc3_ <= 122) {
               _loc5_.push(_loc3_);
            }
            _loc6_++;
         }
         return String.fromCharCode.apply(String,_loc5_);
      }
   }
}
