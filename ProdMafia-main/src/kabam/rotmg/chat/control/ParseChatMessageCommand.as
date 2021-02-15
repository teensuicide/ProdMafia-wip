package kabam.rotmg.chat.control {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.ForgeProperties;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.Slot;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.assembleegameclient.util.TimeUtil;
import com.company.util.StringUtils;
import flash.events.Event;
import flash.geom.Point;
import flash.system.System;
import flash.utils.Dictionary;
import flash.utils.clearInterval;
import flash.utils.setInterval;
import flash.utils.setTimeout;

import io.decagames.rotmg.social.model.FriendRequestVO;
import io.decagames.rotmg.social.signals.FriendActionSignal;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.GetConCharListTask;
import kabam.rotmg.account.core.services.GetConServersTask;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.EnterGameSignal;

public class ParseChatMessageCommand {


   [Inject]
   public var data:String;

   [Inject]
   public var hudModel:HUDModel;

   [Inject]
   public var addTextLine:AddTextLineSignal;

   [Inject]
   public var enterGame:EnterGameSignal;

   [Inject]
   public var playGame:PlayGameSignal;

   [Inject]
   public var account:Account;

   public function ParseChatMessageCommand() {
      super();
   }

   private static function isServer(param1:String) : Boolean {
      var _loc4_:int = 0;
      var _loc3_:* = Server.serverAbbreviations;
      for(var _loc2_ in Server.serverAbbreviations) {
         if(_loc2_ == param1) {
            return true;
         }
      }
      return false;
   }

   private static function isChar(param1:String) : int {
      var _loc4_:int = 0;
      var _loc2_:* = null;
      var _loc5_:String = null;
      var _loc3_:int = -1;
      _loc4_ = 0;
      while(_loc4_ < Parameters.charNames.length) {
         _loc2_ = param1;
         _loc5_ = Parameters.charNames[_loc4_];
         if(_loc2_.substr(_loc2_.length - 1,1) == "2" && _loc5_.substr(_loc5_.length - 1,1) == "2") {
            if(_loc5_.substring(0,_loc2_.length - 1) == _loc2_.substr(0,_loc2_.length - 1)) {
               _loc3_ = Parameters.charIds[_loc4_];
               break;
            }
         } else if(_loc5_.substring(0,_loc2_.length) == _loc2_) {
            _loc3_ = Parameters.charIds[_loc4_];
            break;
         }
         _loc4_++;
      }
      if(_loc3_ > 0) {
         return _loc3_;
      }
      return -1;
   }

   private static function isRealmName(param1:String) : Boolean {
      var _loc2_:Vector.<String> = new <String>["pirate","deathmage","spectre","titan","gorgon","kraken","satyr","drake","chimera","dragon","wyrm","hydra","leviathan","minotaur","mummy","reaper","phoenix","giant","unicorn","harpy","gargoyle","snake","cube","goblin","hobbit","skeleton","scorpion","bat","ghost","slime","lich","orc","imp","spider","demon","blob","golem","sprite","flayer","ogre","djinn","cyclops","beholder","medusa"];
      return _loc2_.indexOf(param1) != -1;
   }

   public function execute() : void {
      var split:Array = this.data.split(" ");
      var command:String = (split[0] as String).toLowerCase();
      var text:String = "";
      var name:String = "";
      var time:uint = 0;
      var timeScale:Number = 0;
      var tpMulti:Number = 0;
      var player:Player = null;
      var go:GameObject = null;
      switch(command) {
         case "/h":
         case "/help":
            this.addTextLine.dispatch(ChatMessage.make("*Help*","helpCommand"));
            return;
         case "/c":
         case "/class":
         case "/classes":
            var objDict:Dictionary = new Dictionary();
            var playerCount:int = 0;
            for each(go in this.hudModel.gameSprite.map.goDict_) {
               if(go.props_.isPlayer_) {
                  objDict[go.objectType_] = objDict[go.objectType_] != undefined?objDict[go.objectType_] + 1:1;
                  playerCount = Number(playerCount) + 1;
               }
            }

            for (var objType:int in objDict)
               text += " " + ObjectLibrary.typeToDisplayId_[objType] + ": " + objDict[objType];

            this.addTextLine.dispatch(ChatMessage.make("*Help*","Classes online (" + playerCount + "):" + text));
            return;
         case "/chatlength":
         case "/cl":
            if(split.length == 2) {
               var len:int = parseInt(split[1]);
               if(!isNaN(len)) {
                  Parameters.data.chatLength = parseInt(split[1]);
                  Parameters.save();
                  this.hudModel.gameSprite.chatBox_.model.setVisibleItemCount();
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Chat length set to: " + Parameters.data.chatLength));
               } else {
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing an integer number. (no fractions)"));
               }
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect arguments! Syntax: /cl <integer>"));
            }
            return;
         case "/bgfps":
            this.handleFPSCommand("Background FPS","bgFPS",split,command);
            return;
         case "/fgfps":
            this.handleFPSCommand("Foreground FPS","fgFPS",split,command);
            return;
         case "/fps":
            this.handleFPSCommand("FPS Cap","customFPS",split,command);
            return;
         case "/ip":
            if(split.length == 1) {
               var server:Server = this.hudModel.gameSprite.gsc_.server_;
               var index:int = server.name.indexOf("NexusPortal.");
               this.addTextLine.dispatch(ChatMessage.make("*Help*",(index == -1?server.name:server.name.substring(index + "NexusPortal.".length)) + ": " + server.address));
               if(Parameters.data.ipClipboard) {
                  System.setClipboard(server.address);
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Successfully copied IP to Clipboard"));
               }
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","Invalid syntax! This command does not use any arguments."));
            }
            return;
         case "/goto":
            if(Parameters.data.shownGotoWarning) {
               if(split.length == 2) {
                  Parameters.enteringRealm = true;
                  this.jumpToIP(split[1]);
               } else {
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect arguments! Syntax: /goto <ip>"));
               }
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","WARNING! /goto can be used to steal your account information, meaning you should only use it on IPs you trust. Re-send the message for it to register."));
               Parameters.data.shownGotoWarning = true;
            }
            return;
         case "/conn":
            if(Parameters.data.replaceCon) {
               this.handleConCommand(split);
               return;
            }
            break;
         case "/con":
            if(!Parameters.data.replaceCon) {
               this.handleConCommand(split);
               return;
            }
            break;
         case "/pos":
         case "/loc":
            if(split.length == 1) {
               player = this.hudModel.gameSprite.map.player_;
               this.addTextLine.dispatch(ChatMessage.make("*Help*","Your location is x=\'" + player.x_ + "\', y=\'" + player.y_ + "\'"));
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","Invalid syntax! This command does not use any arguments."));
            }
            return;
         case "/mapscale":
         case "/mscale":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Map Scale is: " + Parameters.data.mscale));
                  break;
               case 1:
                  var mscale:Number = parseFloat(split[1]);
                  if(!isNaN(mscale)) {
                     Parameters.data.mscale = mscale;
                     Parameters.save();
                     Parameters.root.dispatchEvent(new Event("resize"));
                     this.hudModel.gameSprite.stage.dispatchEvent(new Event("resize"));
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Map Scale set to: " + Parameters.data.mscale));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing a number."));
                  break;
            }
            return;
         case "/ao":
         case "/ta":
         case "/togglealpha":
            if(split.length == 1) {
               Parameters.data.alphaOnOthers = !Parameters.data.alphaOnOthers;
               Parameters.save();
               this.addTextLine.dispatch(ChatMessage.make("*Help*","Player Transparency: " + (!!Parameters.data.alphaOnOthers?"ON":"OFF")));
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","Invalid syntax! This command does not use any arguments."));
            }
            return;
         case "/alpha":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Player Transparency value is: " + Parameters.data.alphaMan));
                  break;
               case 1:
                  var alpha:Number = parseFloat(split[1]);
                  if(!isNaN(alpha)) {
                     Parameters.data.alphaMan = alpha;
                     Parameters.save();
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Player Transparency value set to: " + Parameters.data.alphaMan));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing a number."));
                  break;
            }
            return;
         case "/setmsg1":
         case "/setmsg2":
         case "/setmsg3":
         case "/setmsg4":
            var msgId:int = parseInt(command.charAt(7));
            if(split.length > 1) {
               Parameters.data["customMessage" + msgId] = this.data.substring(9);
               this.addTextLine.dispatch(ChatMessage.make("*Help*","Message #" + msgId + " set to: " + Parameters.data["customMessage" + msgId]));
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Message #" + msgId + " is: \'" + Parameters.data["customMessage" + msgId] + "\'"));
            }
            return;
         case "/follow":
            switch(int(split.length) - 1) {
               case 0:
                  Parameters.followingName = false;
                  Parameters.followName = "";
                  Parameters.followPlayer = null;
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","No longer following: " + Parameters.followName));
                  break;
               case 1:
                  name = split[1] as String;
                  Parameters.followName = name;
                  var _loc7_:int = 0;
                  var _loc6_:* = this.hudModel.gameSprite.map.goDict_;
                  for each(go in this.hudModel.gameSprite.map.goDict_) {
                     if(go is Player && go.name_.toUpperCase() == name.toUpperCase()) {
                        Parameters.followPlayer = go;
                        Parameters.followName = name.toUpperCase();
                        Parameters.followingName = true;
                     }
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Now following: " + Parameters.followName));
            }
            return;
         case "/suicide":
            if(split.length == 1) {
               Parameters.suicideMode = !Parameters.suicideMode;
               Parameters.suicideAT = TimeUtil.getTrueTime();
               this.addTextLine.dispatch(ChatMessage.make("*Help*","Suicide Mode: " + (Parameters.suicideMode?"ON":"OFF")));
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","Invalid syntax! This command does not use any arguments."));
            }
            return;
         case "/spd":
         case "/setspd":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Speed is: " + this.hudModel.gameSprite.map.player_.speed_));
                  break;
               case 1:
                  var speed:int = parseInt(split[1]);
                  if(!isNaN(speed)) {
                     this.hudModel.gameSprite.map.player_.speed_ = speed;
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Speed set to: " + speed));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing an integer number. (no fractions)"));
                  break;
            }
            return;
         case "/fakelag":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Fake Lag is: " + Parameters.data.fakeLag));
                  break;
               case 1:
                  var lagMS:int = parseInt(split[1]);
                  if(!isNaN(lagMS)) {
                     Parameters.data.fakeLag = lagMS;
                     Parameters.save();
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Fake Lag set to: " + lagMS + " ms"));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing an integer number. (no fractions)"));
                  break;
            }
            return;
         case "/recondelay":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Reconnect Delay is: " + Parameters.data.reconnectDelay));
                  break;
               case 1:
                  var reconDelay:int = parseInt(split[1]);
                  if(!isNaN(reconDelay)) {
                     Parameters.data.reconnectDelay = reconDelay;
                     Parameters.save();
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Reconnect Delay set to: " + reconDelay + " ms"));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing an integer number. (no fractions)"));
                  break;
            }
            return;
         case "/renderdist":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Render Distance is: " + Parameters.data.renderDistance));
                  break;
               case 1:
                  var renderDist:int = parseInt(split[1]);
                  if(!isNaN(renderDist)) {
                     Parameters.data.renderDistance = renderDist;
                     Parameters.save();
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Render Distance set to: " + renderDist + " tiles"));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing an integer number. (no fractions)"));
                  break;
            }
            return;
         case "/addeveryone":
         case "/ae":
            var signal:FriendActionSignal = StaticInjectorContext.getInjector().getInstance(FriendActionSignal);
            for each(go in this.hudModel.gameSprite.map.goDict_) {
               if(go.props_.isPlayer_ && (go as Player).nameChosen_ && go.objectId_ != this.hudModel.gameSprite.map.player_.objectId_) {
                  signal.dispatch(new FriendRequestVO("/requestFriend",go.name_));
               }
            }
            return;
         case "/kickeveryone":
         case "/ke":
            var iv:uint = setInterval(function():void {
               for each(go in hudModel.gameSprite.map.goDict_) {
                  if(go.props_.isPlayer_ && (go as Player).nameChosen_ && go.objectId_ != hudModel.gameSprite.map.player_.objectId_) {
                     hudModel.gameSprite.gsc_.playerText("/kick " + go.name_);
                     return;
                  }
               }
            },2000);
            return;
         case "/mystic":
            text = "Mystics in train: ";
            for each(go in hudModel.gameSprite.map.goDict_) {
               if(go.objectType_ == 803) {
                  text += go.name_ + ", ";
               }
            }
            text = text.substring(0,text.length - 2);
            this.addTextLine.dispatch(ChatMessage.make("",text));
            text = "Mystics with > 0 and < max MP: ";
            for each(go in hudModel.gameSprite.map.goDict_) {
               if(go.objectType_ == 803) {
                  player = go as Player;
                  if(player.mp_ > 0 && player.mp_ < player.maxMP_) {
                     text += (go.name_ + ", ");
                  }
               }
            }
            text = text.substring(0,text.length - 2);
            this.addTextLine.dispatch(ChatMessage.make("",text));
            text = "Mystics stasised: ";
            time = TimeUtil.getTrueTime();
            for each(name in Parameters.mystics) {
               split = name.split(" ");
               text += (split[0] + " stasised " + (time - split[1] * 1) / 1000 + " seconds ago, ");
            }
            text = text.substring(0,text.length - 2);
            this.addTextLine.dispatch(ChatMessage.make("",text));
            return;
         case "/fpm":
         case "/fame":
            time = TimeUtil.getTrueTime() - Parameters.fpmStart;
            var fpm:int = Math.round(Parameters.fpmGain / time * 60000 * 100) / 100;
            this.hudModel.gameSprite.map.player_.textNotification(Parameters.fpmGain + " fame\n" + Math.floor(time / 600000) / 10 + " minutes\n" + fpm + " fame/min",14835456,3000);
            return;
         case "/fpmclear":
            Parameters.fpmStart = TimeUtil.getTrueTime();
            Parameters.fpmGain = 0;
            return;
         case "/timescale":
         case "/ts":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Time Scale is: " + Parameters.data.timeScale + "x"));
                  break;
               case 1:
                  timeScale = parseFloat(split[1]);
                  if(!isNaN(timeScale)) {
                     Parameters.data.timeScale = timeScale;
                     Parameters.save();
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Time Scale set to: " + timeScale + "x"));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you provide a number."));
                  break;
            }
            return;
         case "/tpmulti":
            switch(int(split.length) - 1) {
               case 0:
                  this.addTextLine.dispatch(ChatMessage.make("*Help*","Your current Teleport Modifier is: " + Parameters.data.tpMulti + "x"));
                  break;
               case 1:
                  tpMulti = parseFloat(split[1]);
                  if(!isNaN(tpMulti)) {
                     Parameters.data.tpMulti = tpMulti;
                     Parameters.save();
                     this.addTextLine.dispatch(ChatMessage.make("*Help*","Teleport Modifier: " + tpMulti + "x"));
                     break;
                  }
                  this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you provide a number."));
                  break;
            }
            return;
         case "/name":
            var n:String = this.data.substring("/name".length + 1);
            Parameters.data.customName = n;
            Parameters.save();
            this.hudModel.gameSprite.hudView.characterDetails.setName(n);
            this.addTextLine.dispatch(ChatMessage.make("*Help*","Name override set to: " + n));
            return;
         case "/uptime":
            var date:Date = new Date(null, null, null,
                    null, null, null, this.hudModel.gameSprite.gsc_.lastServerRealTimeMS_);
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME,
                    "The server has been up for " +
                    date.hours + " hours, " +
                    date.minutes + " minutes and " +
                    date.seconds + " seconds."));
            return;
         case "/an":
            var val:int = parseInt(split[1]);
            Parameters.data.AutoNexus = val;
            Parameters.save();
            this.addTextLine.dispatch(Parameters.HELP_CHAT_NAME,
                    "Your Auto Nexus percentage has been set to: " + val);
            return;
         case "/grank":
            var rank:int = parseInt(split[1]);
            this.hudModel.gameSprite.gsc_.changeGuildRank(this.hudModel.gameSprite.map.player_.name_, rank);
            this.addTextLine.dispatch(Parameters.HELP_CHAT_NAME,
                    "Your guild rank has been set to: " + rank);
            return;
         case "/exaltationclaim":
         case "/ec":
            this.hudModel.gameSprite.gsc_.exaltationClaim(parseInt(split[1]));
            return;
         case "/listblueprints":
         case "/lb":
            var unlocked:Vector.<int> = new <int>[];
            // plainly assigning would update ObjectLibrary and there's no real copy function
            unlocked = unlocked.concat(ObjectLibrary.defaultForgeables);
            for (var i:int = 0; i < this.hudModel.gameSprite.map.player_.unlockedBlueprints.length; i++)
               unlocked.push(this.hudModel.gameSprite.map.player_.unlockedBlueprints[i]);
            var ret:String = "";
            for (i = 0; i < unlocked.length; i++)
               ret += ObjectLibrary.typeToDisplayId_[unlocked[i]] + " (" + unlocked[i] + ")" +
                       (i != unlocked.length - 1 ? ", " : "");
            this.addTextLine.dispatch(ChatMessage.make("",
                    "Unlocked blueprints: " + ret));
            return;
         case "/unlockedblueprints":
         case "/ub":
            var unlocked:Vector.<int> = this.hudModel.gameSprite.map.player_.unlockedBlueprints;
            var ret:String = "";
            for (i = 0; i < unlocked.length; i++)
               ret += ObjectLibrary.typeToDisplayId_[unlocked[i]] + " (" + unlocked[i] + ")" +
                       (i != unlocked.length - 1 ? ", " : "");
            this.addTextLine.dispatch(ChatMessage.make("",
                    "Unlocked blueprints: " + (ret == "" ? "None" : ret)));
            return;
         case "/forgedata":
         case "/fd":
            var itemName:String = this.data.substr(split[0].length + 1);
            var itemType:int = ObjectLibrary.idToTypeLower[itemName.toLowerCase()];
            var props:ForgeProperties = ObjectLibrary.forgePropsLibrary[itemType];
            if (props)
               this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME,
                       "Forge properties for the item '" + props.objId + "':        \n" +
                       "Item id: " + props.objType + "        \n" +
                       "Description: " + props.description + "        \n" +
                       "Resource gain: " + props.commonResourceGain + " common, " + props.rareResourceGain + " rare, " + props.legendaryResourceGain + " legendary        \n" +
                       "Resource cost: " + props.commonResourceReq + " common, " + props.rareResourceReq + " rare, " + props.legendaryResourceReq + " legendary        \n" +
                       "Craftable: " + props.canCraft + "        \n" +
                       "Dismantleable: " + props.canDismantle + "        \n" +
                       "Blueprint required: " + props.blueprintRequired + "        \n" +
                       "Forgefire cost: " + props.forgefireCost + "        \n" +
                       "Forgefire reduction when dismantled: " + props.forgefireDismantle + "        \n" +
                       "Limit of 1 per dismantle: " + props.isIngredient));
            else this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME,
                    "No forge property found for item '" + itemName + "'."));
            return;
         case "/forge":
            var vec:Vector.<SlotObjectData> = new Vector.<SlotObjectData>();
            var vault:GameObject = null;
            player = this.hudModel.gameSprite.map.player_;
            for each (var go:GameObject in this.hudModel.gameSprite.map.goDict_)
               if (go.objectType_ == 0x0504) {
                  vault = go;
                  break;
               }

            var itemId:int = parseInt(split[1]);
            for (var i:int = 2; i < split.length; i++) {
               var param:String = split[i];
               var fromVault:Boolean = false;
               if (param.charAt(0) == 'v') {
                  fromVault = true;
                  param = param.substr(1, param.length);
               }

               var slotId:int = parseInt(param);

               var slotObj:SlotObjectData = new SlotObjectData();
               slotObj.objectId_ = fromVault ? vault.objectId_ : player.objectId_;
               slotObj.slotId_ = slotId;
               slotObj.objectType_ = fromVault ? vault.equipment_[slotId] : player.equipment_[slotId];
               vec.push(slotObj);
            }

            this.hudModel.gameSprite.gsc_.forgeRequest(itemId, vec);
            return;
         default:
            this.hudModel.gameSprite.gsc_.playerText(this.data);
            return;
      }
   }

   private function handleConCommand(param1:Array) : void {
      var _loc8_:* = null;
      var _loc2_:* = null;
      var _loc9_:* = null;
      if(param1.length <= 1 || param1.length >= 6) {
         _loc8_ = !!Parameters.data.replaceCon?"/conn":"/con";
         this.addTextLine.dispatch(ChatMessage.make("*Error*","Usage: " + _loc8_ + " <server> <character> <realm> <bazaar>"));
         return;
      }
      var _loc6_:int = -1;
      var _loc4_:* = "";
      var _loc7_:* = "";
      var _loc5_:* = "";
      var _loc11_:int = 0;
      var _loc10_:* = param1;
      for each(var _loc3_ in param1) {
         _loc3_ = _loc3_.toLowerCase();
         if(isServer(_loc3_)) {
            _loc4_ = _loc3_;
         }
         _loc6_ = isChar(_loc3_);
         if(isRealmName(_loc3_)) {
            _loc7_ = _loc3_;
         }
         if(_loc3_ == "left" || _loc3_ == "right") {
            _loc5_ = _loc3_;
         }
      }
      if(_loc4_ != "") {
         _loc2_ = StaticInjectorContext.getInjector().getInstance(GetConServersTask);
         _loc2_.start();
      }
      if(_loc6_ != -1) {
         _loc9_ = StaticInjectorContext.getInjector().getInstance(GetConCharListTask);
         _loc9_.start();
      }
      if(_loc7_ != "") {
         Parameters.realmName = _loc7_;
      }
      if(_loc5_ != "") {
         Parameters.bazaarJoining = true;
         Parameters.bazaarLR = _loc5_;
         Parameters.bazaarDist = Math.random() * 10;
         if(_loc4_ == "" && this.hudModel.gameSprite.map.isNexus) {
            return;
         }
      }
      jumpToServer(_loc4_,_loc6_);
   }

   private function handleFPSCommand(param1:String, param2:String, param3:Array, param4:String) : void {
      var _loc5_:int = 0;
      switch(int(param3.length) - 1) {
         case 0:
            this.addTextLine.dispatch(ChatMessage.make("*Help*","Your " + param1 + " is: " + Parameters.data[param2]));
            break;
         case 1:
            _loc5_ = parseInt(param3[1]);
            if(!isNaN(_loc5_)) {
               Parameters.data[param2] = parseInt(param3[1]);
               Parameters.save();
               if(param2 == "customFPS") {
                  Main.STAGE.frameRate = Parameters.data[param2];
               }
               this.addTextLine.dispatch(ChatMessage.make("*Help*",param1 + " set to: " + Parameters.data[param2]));
               break;
            }
            this.addTextLine.dispatch(ChatMessage.make("*Error*","Incorrect length! Make sure you are providing an integer number. (no fractions)"));
            break;
      }
   }

   public function jumpToServer(param1:String, param2:int = -1) : void {
      var _loc5_:Boolean = false;
      var _loc3_:GameInitData = null;
      if(param2 != -1 && param1 == "") {
         _loc5_ = true;
      }
      if(param2 == -1) {
         param2 = this.hudModel.gameSprite.gsc_.charId_;
      }
      if(param1 == "") {
         param1 = Parameters.data.preferredServer;
      }
      param1 = param1.toLowerCase();
      var _loc4_:Boolean = this.hudModel.gameSprite.map && this.hudModel.gameSprite.map.player_;
      var _loc6_:String = Server.serverAbbreviations[param1];
      if(_loc6_ == null && !_loc5_) {
         if(_loc4_) {
            this.hudModel.gameSprite.map.player_.addTextLine.dispatch(ChatMessage.make("*Error*","Invalid server " + param1));
         }
      } else {
         if(Parameters.data.preferredServer == _loc6_ && !_loc5_ && _loc4_) {
            this.hudModel.gameSprite.map.player_.addTextLine.dispatch(ChatMessage.make("","Already in " + _loc6_ + ", joining anyways"));
         }
         if(_loc6_ && !_loc5_) {
            Parameters.data.preferredServer = _loc6_;
         }
         Parameters.save();
         this.enterGame.dispatch();
         _loc3_ = new GameInitData();
         _loc3_.createCharacter = false;
         _loc3_.charId = param2;
         _loc3_.isNewGame = true;
         this.playGame.dispatch(_loc3_);
      }
   }

   public function jumpToIP(param1:String) : void {
      Parameters.isGoto = true;

      this.enterGame.dispatch();
      var _loc2_:GameInitData = new GameInitData();
      _loc2_.server = new Server();
      _loc2_.server.port = 2050;
      _loc2_.server.setName(param1);
      _loc2_.server.address = param1;
      _loc2_.createCharacter = false;
      _loc2_.charId = this.hudModel.gameSprite.gsc_.charId_;
      _loc2_.isNewGame = true;
      this.playGame.dispatch(_loc2_);
   }
}
}
