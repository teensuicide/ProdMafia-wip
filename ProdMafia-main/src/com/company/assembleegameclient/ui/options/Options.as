package com.company.assembleegameclient.ui.options {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.sound.Music;
   import com.company.assembleegameclient.sound.SFX;
   import com.company.assembleegameclient.ui.StatusBar;
   import com.company.rotmg.graphics.ScreenGraphic;
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.ui.Mouse;
   import flash.ui.MouseCursorData;
   import io.decagames.rotmg.ui.scroll.UIScrollbar;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.game.view.components.StatView;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   import kabam.rotmg.ui.UIUtils;
   import kabam.rotmg.ui.signals.ToggleShowTierTagSignal;
   
   public class Options extends Sprite {
      
      public static const Y_POSITION:int = 550;
      
      public static const SCROLL_HEIGHT:int = 420;
      
      public static const SCROLL_Y_OFFSET:int = 102;
      
      public static const CHAT_COMMAND:String = "chatCommand";
      
      public static const CHAT:String = "chat";
      
      public static const TELL:String = "tell";
      
      public static const GUILD_CHAT:String = "guildChat";
      
      public static const SCROLL_CHAT_UP:String = "scrollChatUp";
      
      public static const SCROLL_CHAT_DOWN:String = "scrollChatDown";
      
      private static var registeredCursors:Vector.<String> = new Vector.<String>(0);
       
      
      private var gs_:GameSprite;
      
      private var continueButton_:TitleMenuOption;
      
      private var resetToDefaultsButton_:TitleMenuOption;
      
      private var homeButton_:TitleMenuOption;
      
      private var tabs_:Vector.<OptionsTabTitle>;
      
      private var selected_:OptionsTabTitle;
      
      private var options_:Vector.<Sprite>;
      
      private var defaultTab_:OptionsTabTitle;
      
      private var scroll:UIScrollbar;
      
      private var scrollContainer:Sprite;
      
      private var scrollContainerBottom:Shape;
      
      public function Options(param1:GameSprite) {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         tabs_ = new Vector.<OptionsTabTitle>();
         options_ = new Vector.<Sprite>();
         var _loc5_:* = null;
         var _loc8_:* = null;
         _loc3_ = new <String>["Options.Controls","Options.HotKeys","Options.Chat","Options.Graphics","Options.Sound","Options.Friend","Experimental","Debuffs","Auto","Loot","World","Visual","Other"];
         super();
         this.gs_ = param1;
         graphics.clear();
         graphics.beginFill(2829099,0.8);
         graphics.drawRect(0,0,800,600);
         graphics.endFill();
         graphics.lineStyle(1,6184542);
         graphics.moveTo(0,100);
         graphics.lineTo(800,100);
         graphics.lineStyle();
         _loc5_ = new TextFieldDisplayConcrete().setSize(36).setColor(16777215);
         _loc5_.setBold(true);
         _loc5_.setStringBuilder(new LineBuilder().setParams("Options.title"));
         _loc5_.setAutoSize("center");
         _loc5_.filters = [new DropShadowFilter(0,0,0)];
         _loc5_.x = 400 - _loc5_.width / 2;
         _loc5_.y = 8;
         addChild(_loc5_);
         addChild(new ScreenGraphic());
         this.continueButton_ = new TitleMenuOption("Options.continueButton",36,false);
         this.continueButton_.setVerticalAlign("middle");
         this.continueButton_.setAutoSize("center");
         this.continueButton_.addEventListener("click",this.onContinueClick);
         addChild(this.continueButton_);
         this.resetToDefaultsButton_ = new TitleMenuOption("Options.resetToDefaultsButton",22,false);
         this.resetToDefaultsButton_.setVerticalAlign("middle");
         this.resetToDefaultsButton_.setAutoSize("left");
         this.resetToDefaultsButton_.addEventListener("click",this.onResetToDefaultsClick);
         addChild(this.resetToDefaultsButton_);
         this.homeButton_ = new TitleMenuOption("Options.homeButton",22,false);
         this.homeButton_.setVerticalAlign("middle");
         this.homeButton_.setAutoSize("right");
         this.homeButton_.addEventListener("click",this.onHomeClick);
         addChild(this.homeButton_);
         var _loc7_:int = 14;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length) {
            _loc2_ = new OptionsTabTitle(_loc3_[_loc4_]);
            _loc2_.x = _loc7_;
            _loc2_.y = 50 + 25 * (int(_loc4_ / 7));
            if(_loc4_ % 7 == 0) {
               _loc7_ = 14;
               _loc2_.x = _loc7_;
            }
            _loc7_ = _loc7_ + 104;
            if(_loc2_.text_ == Parameters.data.lastTab) {
               _loc8_ = _loc2_;
            }
            addChild(_loc2_);
            _loc2_.addEventListener("click",this.onTabClick);
            this.tabs_.push(_loc2_);
            _loc4_++;
         }
         if(_loc8_) {
            this.defaultTab_ = _loc8_;
         } else {
            this.defaultTab_ = this.tabs_[0];
         }
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
         var _loc6_:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
         _loc6_.dispatch();
         this.createScrollWindow();
      }
      
      public static function refreshCursor() : void {
         var _loc2_:* = null;
         var _loc1_:* = undefined;
         if(Parameters.data.cursorSelect != "auto" && registeredCursors.indexOf(Parameters.data.cursorSelect) == -1) {
            _loc2_ = new MouseCursorData();
            _loc2_.hotSpot = new Point(15,15);
            _loc1_ = new Vector.<BitmapData>(1,true);
            _loc1_[0] = AssetLibrary.getImageFromSet("cursorsEmbed",Parameters.data.cursorSelect);
            _loc2_.data = _loc1_;
            Mouse.registerCursor(Parameters.data.cursorSelect,_loc2_);
            registeredCursors.push(Parameters.data.cursorSelect);
         }
         Mouse.cursor = Parameters.data.cursorSelect;
      }
      
      public static function calculateIgnoreBitmask() : void {
         var _loc1_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(Parameters.data.ignoreQuiet) {
            _loc1_ = uint(_loc1_ | 4);
         }
         if(Parameters.data.ignoreWeak) {
            _loc1_ = uint(_loc1_ | 8);
         }
         if(Parameters.data.ignoreSlowed) {
            _loc1_ = uint(_loc1_ | 16);
         }
         if(Parameters.data.ignoreSick) {
            _loc1_ = uint(_loc1_ | 32);
         }
         if(Parameters.data.ignoreDazed) {
            _loc1_ = uint(_loc1_ | 64);
         }
         if(Parameters.data.ignoreStunned) {
            _loc1_ = uint(_loc1_ | 128);
         }
         if(Parameters.data.ignoreParalyzed) {
            _loc1_ = uint(_loc1_ | 16384);
         }
         if(Parameters.data.ignoreBleeding) {
            _loc1_ = uint(_loc1_ | 65536);
         }
         if(Parameters.data.ignoreArmorBroken) {
            _loc1_ = uint(_loc1_ | 134217728);
         }
         if(Parameters.data.ignorePetStasis) {
            _loc1_ = uint(_loc1_ | 4194304);
         }
         if(Parameters.data.ignorePetrified) {
            _loc3_ = uint(_loc3_ | 8);
         }
         if(Parameters.data.ignoreSilenced) {
            _loc3_ = uint(_loc3_ | 65536);
         }
         if(Parameters.data.ignoreBlind) {
            _loc2_ = uint(_loc2_ | 256);
         }
         if(Parameters.data.ignoreHallucinating) {
            _loc2_ = uint(_loc2_ | 512);
         }
         if(Parameters.data.ignoreDrunk) {
            _loc2_ = uint(_loc2_ | 1024);
         }
         if(Parameters.data.ignoreConfused) {
            _loc2_ = uint(_loc2_ | 2048);
         }
         if(Parameters.data.ignoreUnstable) {
            _loc2_ = uint(_loc2_ | 1073741824);
         }
         if(Parameters.data.ignoreDarkness) {
            _loc2_ = uint(_loc2_ | -2147483648);
         }
         Parameters.data.ssdebuffBitmask = _loc1_;
         Parameters.data.ssdebuffBitmask2 = _loc3_;
         Parameters.data.ccdebuffBitmask = _loc2_;
      }
      
      private static function makeOnOffLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[makeLineBuilder("Options.On"),makeLineBuilder("Options.Off")];
      }
      
      private static function makeHighLowLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("High"),new StaticStringBuilder("Low")];
      }
      
      private static function makeReconDelayLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("0 ms"),new StaticStringBuilder("100 ms"),new StaticStringBuilder("250 ms"),new StaticStringBuilder("500 ms"),new StaticStringBuilder("750 ms"),new StaticStringBuilder("1000 ms"),new StaticStringBuilder("1500 ms"),new StaticStringBuilder("2000 ms")];
      }

      private static function makePauseDelayLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("0 ms"),new StaticStringBuilder("100 ms"),new StaticStringBuilder("250 ms"),new StaticStringBuilder("500 ms"),new StaticStringBuilder("750 ms"),new StaticStringBuilder("1000 ms"),new StaticStringBuilder("1500 ms"),new StaticStringBuilder("2000 ms")];
      }
      
      private static function makeStarSelectLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("5"),new StaticStringBuilder("10")];
      }
      
      private static function makeFameDeltaLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("0"),new StaticStringBuilder("0.25"),new StaticStringBuilder("0.5"),new StaticStringBuilder("0.75"),new StaticStringBuilder("1"),new StaticStringBuilder("1.5"),new StaticStringBuilder("2")];
      }
      
      private static function makeFameCheckLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("50"),new StaticStringBuilder("100"),new StaticStringBuilder("150"),new StaticStringBuilder("225"),new StaticStringBuilder("300"),new StaticStringBuilder("400"),new StaticStringBuilder("500")];
      }
      
      private static function makeCursorSelectLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("ProX"),new StaticStringBuilder("X2"),new StaticStringBuilder("X3"),new StaticStringBuilder("X4"),new StaticStringBuilder("Corner1"),new StaticStringBuilder("Corner2"),new StaticStringBuilder("Symb"),new StaticStringBuilder("Alien"),new StaticStringBuilder("Xhair"),new StaticStringBuilder("Chusto1"),new StaticStringBuilder("Chusto2")];
      }
      
      private static function makeLineBuilder(param1:String) : LineBuilder {
         return new LineBuilder().setParams(param1);
      }
      
      private static function onBarTextToggle() : void {
         StatusBar.barTextSignal.dispatch(Parameters.data.toggleBarText);
      }
      
      private static function onToMaxTextToggle() : void {
         StatusBar.barTextSignal.dispatch(Parameters.data.toggleBarText);
         StatView.toMaxTextSignal.dispatch(Parameters.data.toggleToMaxText);
      }
      
      private static function makeDegreeOptions() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("45°"),new StaticStringBuilder("0°")];
      }
      
      private static function onDefaultCameraAngleChange() : void {
         Parameters.data.cameraAngle = Parameters.data.defaultCameraAngle;
         Parameters.save();
      }
      
      private static function makePetHiddenLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[makeLineBuilder("Hide All"),makeLineBuilder("Show All"),makeLineBuilder("Show Mine")];
      }
      
      private static function chatLengthLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("11"),new StaticStringBuilder("12"),new StaticStringBuilder("13"),new StaticStringBuilder("14"),new StaticStringBuilder("15"),new StaticStringBuilder("16"),new StaticStringBuilder("17"),new StaticStringBuilder("18"),new StaticStringBuilder("19"),new StaticStringBuilder("20")];
      }
      
      private static function makeRightClickOptions() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("Quest"),new StaticStringBuilder("Ability"),new StaticStringBuilder("Camera")];
      }
      
      private static function makeAllyShootLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("All"),new StaticStringBuilder("Proj")];
      }
      
      private static function makeHpBarLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("All"),new StaticStringBuilder("Enemy"),new StaticStringBuilder("Self & En."),new StaticStringBuilder("Self"),new StaticStringBuilder("Ally")];
      }
      
      private static function makeForceExpLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("On"),new StaticStringBuilder("Self")];
      }
      
      private static function makeBarTextLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("All"),new StaticStringBuilder("Fame"),new StaticStringBuilder("HP/MP")];
      }
      
      private static function onVSyncToggle() : void {
         //Main.STAGE.vsyncEnabled = Parameters.data.vSync;
      }
      
      private static function onFullscreenToggle() : void {
         Main.STAGE.displayState = !!Parameters.data.fullscreen?"fullScreenInteractive":"normal";
      }
      
      public function addAutoOptions() : void {
         this.addOptionAndPosition(new KeyMapper("AAHotkey","AutoAim Hotkey","Toggle AutoAim"));
         this.addOptionAndPosition(new KeyMapper("AAModeHotkey","AimMode Hotkey","Switch AutoAim\'s aim mode"));
         this.addOptionAndPosition(new KeyMapper("AutoAbilityHotkey","Auto Ability Hotkey","Toggle Auto Ability"));
         this.addOptionAndPosition(new ChoiceOption("AAOn",makeOnOffLabels(),[true,false],"AutoAim","Automatically aim at enemies",null));
         this.addOptionAndPosition(new ChoiceOption("AAMinManaPercent",this.AutoManaPercentValues(),[-1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100],"Auto Ability MP %","Minimum MP value required before Auto Ability uses your ability (if set to 70%, it will use your ability when your mana is at or above 70% and will not use it when your current mp is below 70%",this.resetMPVals));
         this.addOptionAndPosition(new ChoiceOption("AutoNexus",this.AutoNexusValues(),[0,5,10,15,20,25,30,35,40,45,50,60],"Autonexus Percent","The percent of health at which to autonexus at",resetHPVals));
         this.addOptionAndPosition(new ChoiceOption("AutoSyncClientHP",makeOnOffLabels(),[true,false],"AutoSync ClientHP","Automatically sets your clientHP to your server HP if the difference between them is more than 60 hp for 600ms [WARNING, you can die with this on]",null));
         this.addOptionAndPosition(new ChoiceOption("AATargetLead",makeOnOffLabels(),[true,false],"AutoAim Target Lead","Projectile deflection, makes autoaim shoot ahead of enemies so the projectile will collide with the enemy",null));
         this.addOptionAndPosition(new ChoiceOption("autoDecrementHP",makeOnOffLabels(),[true,false],"Remove HP when dealing damage","Decreases an enemy\'s health when you deal damage to them, this allows you to one shot enemies with spellbombs",null));
         this.addOptionAndPosition(new ChoiceOption("shootAtWalls",makeOnOffLabels(),[true,false],"Shoot at Walls","Make AutoAim aim at stuff like Walls and Davy barrels",null));
         this.addOptionAndPosition(new ChoiceOption("autoaimAtInvulnerable",makeOnOffLabels(),[true,false],"Aim at Invulnerable","Make AutoAim aim at invulnerable enemies or not",null));
         this.addOptionAndPosition(new ChoiceOption("AABoundingDist",this.BoundingDistValues(),[1,2,3,4,5,6,7,8,9,10,15,20,30,50],"Bounding Distance","Restrict AutoAim to see only as far as the bounding distance from the mouse cursor in closest to cursor aim mode",null));
         this.addOptionAndPosition(new ChoiceOption("onlyAimAtExcepted",makeOnOffLabels(),[true,false],"Only Aim at Excepted","Only AutoAims at the enemies in your exception list",null));
         this.addOptionAndPosition(new ChoiceOption("autoHPPercent",this.AutoHPPotValues(),[0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75],"Auto HP Pot Threshold","Sets the health percentage at which to use an HP potion",resetHPVals));
         this.addOptionAndPosition(new ChoiceOption("autoMPPercent",this.AutoMPPotValues(),[0,-1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75],"Auto MP Pot Threshold","Sets the mana percentage at which to use an MP potion, Abil % means it will drink until it has enough MP to use your ability",resetMPVals));
         this.addOptionAndPosition(new ChoiceOption("autohpPotDelay",this.AutoHPPotDelayValues(),[100,200,300,400,500,600,700,800,900,1000],"Auto HP Pot Delay","Sets the delay between drinking HP pots",null));
         this.addOptionAndPosition(new ChoiceOption("autompPotDelay",this.AutoHPPotDelayValues(),[100,200,300,400,500,600,700,800,900,1000],"Auto MP Pot Delay","Sets the delay between drinking MP pots",null));
         this.addOptionAndPosition(new ChoiceOption("AutoHealPercentage",this.AutoHealValues(),[0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,99,100],"Autoheal Threshold","Sets the health percentage at which to heal",resetHPVals));
         this.addOptionAndPosition(new ChoiceOption("spellbombHPThreshold",this.spellbombThresholdValues(),[0,250,500,750,1000,1250,1500,1750,2000,2500,3000,4000,5000,6000,7000,8000,9000,10000,15000,20000],"AutoAbility Health Threshold","Sets the enemy current health value at which Auto Ability will target enemies (ie, if it is set to 5000, then the auto ability will only attempt to shoot at enemies with greater than 5000 health), use /sbthreshold to set a specific value",null));
         this.addOptionAndPosition(new ChoiceOption("skullHPThreshold",this.skullThresholdValues(),[0,100,250,500,800,1000,2000,4000,8000],"AOE AutoAbility Health Threshold","Sets the enemy current health value at which Auto Ability will target enemies for AOE abilities like Necro, Assassin, Huntress, Sorc, (ie, if it is set to 1000, then the Auto Ability will only attempt to shoot at enemies with greater than 1000 health), use /aathreshold to set a specific value",null));
         this.addOptionAndPosition(new ChoiceOption("skullTargets",this.skullTargetsValues(),[0,1,2,3,4,5,6,7,8,9,10],"Min AOE AutoAbility Targets","Sets the amount of enemies required in your AOE ability\'s radius before using the ability, use /aatargets to set a specific value",null));
         this.addOptionAndPosition(new ChoiceOption("AutoResponder",makeOnOffLabels(),[true,false],"AutoResponder","Automatically replies to Thessal/Cem/LoD/Sewer text",null));
         this.addOptionAndPosition(new ChoiceOption("aaDistance",this.aaDistanceValues(),[0,0.5,1,1.5,2,2.5,3],"AutoAim Distance Increase","Adds additional range to AutoAim\'s range",null));
         this.addOptionAndPosition(new ChoiceOption("BossPriority",makeOnOffLabels(),[true,false],"Boss Priority","Makes AutoAim prioritize Boss enemies over everything else - \"bosses\" includes all Quests and certain dungeon bosses which are not quests, such as the Shatters bosses",null));
         this.addOptionAndPosition(new ChoiceOption("spamPrismNumber",this.skullTargetsValues(),[0,1,2,3,4,5,6,7,8,9,10],"Spam Trickster Prism","Uses non teleporting Trickster prisms when this many enemies are around, with auto ability enabled",null));
      }
      
      public function addAutoLootOptions() : void {
         this.addOptionAndPosition(new KeyMapper("AutoLootHotkey","Auto Loot","Toggles Auto Loot which automatically loots nearby items based on customizable criteria"));
         this.addOptionAndPosition(new ChoiceOption("autoLootUpgrades",makeOnOffLabels(),[true,false],"Loot Upgrades","Pick up items with a higher tier than your current equips (UTs and STs are excluded)",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootWeaponTier",this.ZeroThirteen(),[999,0,1,2,3,4,5,6,7,8,9,10,11,12,13],"Min Weapon Tier","Minimum tier required for AutoLoot of tiered Weapons",this.updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootAbilityTier",this.ZeroSix(),[999,0,1,2,3,4,5,6],"Min Ability Tier","Minimum tier required for AutoLoot of tiered Abilities",this.updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootArmorTier",this.ZeroFourteen(),[999,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],"Min Armor Tier","Minimum tier required for AutoLoot of tiered Armors",this.updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootRingTier",this.ZeroSix(),[999,0,1,2,3,4,5,6],"Min Ring Tier","Minimum tier required for AutoLoot of tiered Rings",this.updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootXPBonus",alFBValues(),[-1,1,2,3,4,5,6,7],"Min XP Bonus","Loot all items with a XP bonus equal to or above the specified amount",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootFeedPower",alFPValues(),[-1,100,200,300,400,500,600,700,800,900,1000,1200,1400,1600,1800,2000],"Min Feed Power","Loot all items with a feed power equal to or above the specified amount",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootHPPots",makeOnOffLabels(),[true,false],"Loot HP Potions","Loot all HP potions",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootMPPots",makeOnOffLabels(),[true,false],"Loot MP Potions","Loot all MP potions",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootLifeManaPots",makeOnOffLabels(),[true,false],"Loot Life/Mana Potions","Loot all Life and Mana potions",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootRainbowPots",makeOnOffLabels(),[true,false],"Loot Rainbow Potions","Loot all Atk/Def/Spd/Dex/Vit/Wis potions",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootSkins",makeOnOffLabels(),[true,false],"Loot Skins","Loot all skins",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootKeys",makeOnOffLabels(),[true,false],"Loot Keys","Loot all keys",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootPetSkins",makeOnOffLabels(),[true,false],"Loot Pet Skins","Loot all pet skins",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootUTs",makeOnOffLabels(),[true,false],"Loot UT Items","Loots White Bag and ST items",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootMarks",makeOnOffLabels(),[true,false],"Loot Marks","Loot all Dungeon Quest Marks",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootEggs",makeEggLabels(),[-1,0,1,2,3],"Loot Pet Eggs","Loot all Pet Eggs above the specified level",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootConsumables",makeOnOffLabels(),[true,false],"Loot Consumables","Loot all Consumables, which includes (but not limited to) Tinctures, Effusions, Pet Stones, Skins",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootSoulbound",makeOnOffLabels(),[true,false],"Loot Soulbound Items","Loot everything Soulbound",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootStackables",makeOnOffLabels(),[true,false],"Loot Stackables","Loot all stackable items",updateWanted));
         this.addOptionAndPosition(new ChoiceOption("autoLootInVault",makeOnOffLabels(),[true,false],"Auto Loot in Vault","Auto loot from bags in vault",null));
      }
      
      public function updateWanted() : void {
         Parameters.needToRecalcDesireables = true;
      }
      
      public function ZeroSix() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("0"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6")];
      }
      
      public function ZeroThirteen() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("0"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("11"),new StaticStringBuilder("12"),new StaticStringBuilder("13")];
      }
      
      public function ZeroFourteen() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("0"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("11"),new StaticStringBuilder("12"),new StaticStringBuilder("13"),new StaticStringBuilder("14")];
      }
      
      public function addWorldOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("ethDisable",makeOnOffLabels(),[true,false],"Offset Etherite","Offsets your firing angle if you have an Etherite equipped to make it so your shots are in a straight line",null));
         this.addOptionAndPosition(new ChoiceOption("cultiststaffDisable",makeOnOffLabels(),[true,false],"Reverse Cultist Staff","Reverses the angle of the Staff of Unholy Sacrifice (which normally shoots backwards) to make it so you shoot forwards",null));
         this.addOptionAndPosition(new ChoiceOption("offsetColossus",makeOnOffLabels(),[true,false],"Offset Colossus Sword","Attempts to shoot straight, try /colo 0.4 and /colo 0.2",null));
         this.addOptionAndPosition(new ChoiceOption("offsetVoidBow",makeOnOffLabels(),[true,false],"Offset Void Bow","Offsets your firing angle if you have a Bow of the Void equipped to make it so your shots are in a straight line",null));
         this.addOptionAndPosition(new ChoiceOption("offsetCelestialBlade",makeOnOffLabels(),[true,false],"Offset Celestial Blade","Offsets your firing angle if you have a Celestial Blade equipped to make it so your shots are in a straight line",null));
         this.addOptionAndPosition(new ChoiceOption("damageIgnored",makeOnOffLabels(),[true,false],"Damage Ignored Enemies","Prevents your shots from damaging enemies that are ignored",null));
         this.addOptionAndPosition(new KeyMapper("PassesCoverHotkey","Projectile Noclip","Toggle allowing projectiles to pass through solid objects like trees and walls"));
         this.addOptionAndPosition(new KeyMapper("anchorTeleport","Teleport to Anchor","Teleports you to the player you have anchored (set via /anchor <name> or the player menu)"));
         this.addOptionAndPosition(new KeyMapper("QuestTeleport","Teleport to Quest","Teleports to the player closest to your quest"));
         this.addOptionAndPosition(new ChoiceOption("ignoreIce",makeOnOffLabels(),[true,false],"Ignore Ice and Push","Disables the slidy ice tiles and sprite world pushing tiles",null));
         this.addOptionAndPosition(new KeyMapper("tradeNearestPlayerKey","Trade Nearest Player","Sends a trade request to the nearest player"));
         this.addOptionAndPosition(new ChoiceOption("passThroughInvuln",makeOnOffLabels(),[true,false],"Pass Through Invuln","Makes your projectiles not hit things that are invulnerable (unless your projectile would inflict a status effect), THIS INCLUDES TUTORIAL TURRETS, TURN IT OFF WHEN ACCURACY FARMING",null));
         this.addOptionAndPosition(new ChoiceOption("safeWalk",makeOnOffLabels(),[true,false],"Safe Walk","Makes lava tiles act as if they were unwalkable.",null));
         this.addOptionAndPosition(new KeyMapper("TextPause","/pause","Say \"/pause\""));
         this.addOptionAndPosition(new KeyMapper("TextThessal","Dying Thessal Text","Say the \"He lives\" quote"));
         this.addOptionAndPosition(new KeyMapper("TextDraconis","LoD Black Text","Say \"black\""));
         this.addOptionAndPosition(new KeyMapper("TextCem","Cem Ready Text","Say \"ready\""));
         this.addOptionAndPosition(new KeyMapper("sayCustom1","Custom 1","Sends a custom message, set this message with /setmsg1"));
         this.addOptionAndPosition(new KeyMapper("sayCustom2","Custom 2","Sends a custom message, set this message with /setmsg2"));
         this.addOptionAndPosition(new KeyMapper("sayCustom3","Custom 3","Sends a custom message, set this message with /setmsg3"));
         this.addOptionAndPosition(new KeyMapper("sayCustom4","Custom 4","Sends a custom message, set this message with /setmsg4"));
         this.addOptionAndPosition(new ChoiceOption("mysticAAShootGroup",makeOnOffLabels(),[true,false],"Stasis Enemy Group Instead of Self","Make Mystic\'s orbs stasis groups of enemies instead of self",null));
      }
      
      public function addVisualOptions() : void {
         this.addOptionAndPosition(new KeyMapper("LowCPUModeHotKey","Low CPU Mode","Disables a lot of rendering and stuff"));
         this.addOptionAndPosition(new ChoiceOption("hideLowCPUModeChat",makeOnOffLabels(),[true,false],"Hide Chat in Low CPU Mode","Controls whether normal chat is shown in Low CPU Mode",null));
         this.addOptionAndPosition(new ChoiceOption("showQuestBar",makeOnOffLabels(),[true,false],"Show Quest Bar","Show the HP bar of your Quest at the top",null));
         this.addOptionAndPosition(new ChoiceOption("hideLockList",makeOnOffLabels(),[true,false],"Hide Nonlocked","Hide non locked players",null));
         this.addOptionAndPosition(new ChoiceOption("hidePets2",makePetHiddenLabels(),[0,1,2],"Hide Pets","Make other players or all players pets hidden",null));
         this.addOptionAndPosition(new ChoiceOption("lootPreview",makeOnOffLabels(),[true,false],"Loot Preview","Shows previews of equipment over bags",null));
         this.addOptionAndPosition(new ChoiceOption("showDamageOnEnemy",makeOnOffLabels(),[true,false],"Show Dealt %","Shows the % of damage you\'ve done to an enemy, below that enemy (note, only counts projectile damage, it does not include damage from poison, trap, scepter, etc)",null));
         this.addOptionAndPosition(new ChoiceOption("showMobInfo",makeOnOffLabels(),[true,false],"Show Mob Info","Shows the object itemType above mobs",this.onShowMobInfo));
         this.addOptionAndPosition(new ChoiceOption("liteMonitor",makeOnOffLabels(),[true,false],"Lite Stats Monitor","Replaces the Net Jitter stats monitor with a \"lite\" one that also measures ping",null));
         this.addOptionAndPosition(new ChoiceOption("showClientStat",makeOnOffLabels(),[true,false],"Show ClientStat","Output when you get a ClientStat packet, which shows when things like TilesSeen, GodsKilled, DungeonsCompleted, etc changes",null));
         this.addOptionAndPosition(new ChoiceOption("liteParticle",makeOnOffLabels(),[true,false],"Reduced Particles","Shows only Bombs/Poisons/Traps/Vents",null));
         this.addOptionAndPosition(new ChoiceOption("ignoreStatusText",makeOnOffLabels(),[true,false],"Ignore Status Effect Text","Don\'t draw Dazed/Status/Cursed/etc Status Text above enemies",null));
         this.addOptionAndPosition(new ChoiceOption("bigLootBags",makeOnOffLabels(),[true,false],"Big Loot Bags","Makes soulbound loot bags twice as big",null));
         this.addOptionAndPosition(new ChoiceOption("alphaOnOthers",makeOnOffLabels(),[true,false],"Make Other Players Transparent","Makes nonlocked players and their pets transparent, toggleable with /ao and transparency level customizable with /alpha 0.2",null));
         this.addOptionAndPosition(new ChoiceOption("showAOGuildies",makeOnOffLabels(),[true,false],"Show Guildmates with Alpha","Makes guildmates always visible when /ao is enabled",null));
         this.addOptionAndPosition(new ChoiceOption("showFameGoldRealms",makeOnOffLabels(),[true,false],"Always Show Credit Display","Makes the credit display always visible when in Realms and Dungeons",null));
         this.addOptionAndPosition(new ChoiceOption("showEnemyCounter",makeOnOffLabels(),[true,false],"Show Remaining Enemy Counter","Shows the \"Enemies left in dungeon\" in a text area instead of in chat",null));
         this.addOptionAndPosition(new ChoiceOption("showTimers",makeOnOffLabels(),[true,false],"Show Phase Timers","Shows a countdown for enemy phase and custom set timers",null));
         this.addOptionAndPosition(new ChoiceOption("noRotate",makeOnOffLabels(),[true,false],"Disable Shot Rotation","Makes Shots not have their rotation effect, which prevents a lot of lag especially in Lost Halls",null));
         this.addOptionAndPosition(new ChoiceOption("showWhiteBagEffect",makeOnOffLabels(),[true,false],"White Bag Effect","Shows a particle effect and plays a sound when white bags spawn",null));
         this.addOptionAndPosition(new ChoiceOption("showOrangeBagEffect",makeOnOffLabels(),[true,false],"Orange Bag Effect","Shows a particle effect and plays a sound when orange bags spawn",null));
         this.addOptionAndPosition(new ChoiceOption("showInventoryTooltip",makeOnOffLabels(),[true,false],"Show Inventory on Player Tooltips","Shows other people\'s inventories when hovering their name in the player grid, note you can only see when items change",null));
         this.addOptionAndPosition(new ChoiceOption("showRange",makeOnOffLabels(),[true,false],"Weapon Range Indicator","Shows a circle indicating the range of your weapon",null));
      }
      
      public function toggleSideBarGradient() : void {
         this.gs_.hudView.sidebarGradientOverlay_.visible = Parameters.data.showSidebarGradient;
      }
      
      public function toggleBars() : void {
         this.gs_.hudView.statMeters.dispose();
         this.gs_.hudView.statMeters.init();
      }
      
      public function onShowMobInfo() : void {
         if(!Parameters.data.showMobInfo && this.gs_.map.mapOverlay_) {
            this.gs_.map.mapOverlay_.removeChildren(0);
         }
      }
      
      public function addOtherOptions() : void {
         this.addOptionAndPosition(new KeyMapper("aimAtQuest","Aim at Quest","Sets your camera angle in the direction of your quest"));
         this.addOptionAndPosition(new KeyMapper("resetClientHP","Reset Client HP","Sets your Client HP to your Server HP, if you need to manually sync Health"));
         this.addOptionAndPosition(new KeyMapper("SelfTPHotkey","Tele Self","Teleports you to yourself for a free second of invincibility"));
         this.addOptionAndPosition(new ChoiceOption("TradeDelay",makeOnOffLabels(),[true,false],"No Trade Delay","Remove the 3 second trade delay",null));
         this.addOptionAndPosition(new ChoiceOption("skipPopups",makeOnOffLabels(),[true,false],"Ignore Startup Popups","Hides all popups when you first load the client",null));
         this.addOptionAndPosition(new ChoiceOption("extraPlayerMenu",makeOnOffLabels(),[true,false],"Extended Player Menu","Show extra options on player menus when you click in chat or in the party list",null));
         this.addOptionAndPosition(new ChoiceOption("replaceCon",makeOnOffLabels(),[true,false],"Replace /con with /conn","So you can itemType /con to the proxy server",null));
         this.addOptionAndPosition(new ChoiceOption("dynamicHPcolor",makeOnOffLabels(),[true,false],"Dynamic Damage Text Color","Makes the damage text change color based on health",null));
         this.addOptionAndPosition(new ChoiceOption("mobNotifier",makeOnOffLabels(),[true,false],"Treasure Room Notifier","Plays a sound when a Troom is opened",null));
         this.addOptionAndPosition(new ChoiceOption("rightClickOption",makeRightClickOptions(),["Off","Quest","Ability","Camera"],"Right Click Option","Select the functionality you want on right click: none, quest follow (hold down right click to walk towards your quest), spellbomb/ability assist (uses your ability at the enemy closest to your cursor), camera (rotates your camera when holding right click)",null));
         this.addOptionAndPosition(new ChoiceOption("tiltCam",makeOnOffLabels(),[true,false],"Tilt Camera X Axis","Allows the Right Click Option, when on Camera, to rotate the X Axis of the Camera\'s perspective",null));
         this.addOptionAndPosition(new ChoiceOption("chatLength",chatLengthLabels(),[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"Chat Length","Determines the number of lines chat shows (5 is the standard, previously it was 10)",this.onChatLengthChange));
         this.addOptionAndPosition(new ChoiceOption("followIntoPortals",makeOnOffLabels(),[true,false],"Follow Into Portal","If the player you\'re /following enters a portal, having this on tries to join them",null));
         this.addOptionAndPosition(new ChoiceOption("FocusFPS",makeOnOffLabels(),[true,false],"Background FPS","Lower FPS when the client loses focus (alt tabbing, minimizing, etc), set the background values with /bgfps # and foreground with /fgfps #",null));
         this.addOptionAndPosition(new KeyMapper("TombCycleKey","Tomb Boss Cycle","Ignores Tomb bosses in the order of Bes Nut Geb, whichever boss name is shown when pressing the key is the boss that is attackable (works with Ice Tomb bosses as well), you will need Damage Ignored Enemies OFF, type /tomb to clear all Tomb bosses from ignore list if you need to attack all of them"));
         this.addOptionAndPosition(new ChoiceOption("rightClickSelectAll",makeOnOffLabels(),[true,false],"Right Click Trade to Select All","When in a trade, right clicking the trade button will select all items in the trade at once",null));
         this.addOptionAndPosition(new ChoiceOption("reconnectDelay",makeReconDelayLabels(),[0,100,250,500,750,1000,1500,2000],"Connection Delay","Amount of time to wait between switching maps, normal amount is is 2000 milliseconds, 250 ms will usually work fine without any issues - use /recondelay # for a custom delay",null));
         this.addOptionAndPosition(new KeyMapper("noClipKey","No Clip Key","The key which toggles whether to No Clip"));
         this.addOptionAndPosition(new ChoiceOption("ipClipboard",makeOnOffLabels(),[true,false],"Copy IP","This toggles whether to copy the IP to Clipboard when using /ip",null));
         this.addOptionAndPosition(new ChoiceOption("reducedLava",makeOnOffLabels(),[true,false],"Reduced Ground Damage","This toggles whether to take less damage when in lava (like noclip)",null));
         this.addOptionAndPosition(new KeyMapper("ReconRealm","Realm Reconnect","The key which allows you to visit the Realm you were last in"));
         this.addOptionAndPosition(new KeyMapper("depositKey","Deposit Key","The key which deposits all your items into the Vault, if possible"));
         this.addOptionAndPosition(new KeyMapper("TogglePlayerFollow","Toggle Player Follow","Set with /follow <name>, press this hotkey to toggle on and off"));
         this.addOptionAndPosition(new ChoiceOption("logErrors",makeOnOffLabels(),[true,false],"Log Errors","This toggles whether to log errors, for debugging purposes",null));
         this.addOptionAndPosition(new ChoiceOption("tutorialMode",makeOnOffLabels(),[true,false],"Tutorial Mode","This toggles whether to load into the Tutorial when attempting to enter the Nexus",null));
         this.addOptionAndPosition(new ChoiceOption("pauseDelay",makePauseDelayLabels(),[0,100,250,500,750,1000,1500,2000],"Pause Delay","Amount of time to wait between switching maps, normal amount is is 2000 milliseconds, 250 ms will usually work fine without any issues - use /recondelay # for a custom delay",null));
         this.addOptionAndPosition(new KeyMapper("pauseAnywhere", "Pause Anywhere", "The key which pauses you without map restrictions when pressed"));
         this.addOptionAndPosition(new KeyMapper("noClipPause","No Clip Pause","Pauses after using noclip "));
         this.addOptionAndPosition(new KeyMapper("tpCursor","Tp to Cursor","Teleport to position of your cursor"));
      }
      
      public function addOptionsChoiceOption() : void {
         var _loc2_:String = Capabilities.os.split(" ")[0] == "Mac"?"Command":"Ctrl";
         var _loc1_:ChoiceOption = new ChoiceOption("inventorySwap",makeOnOffLabels(),[true,false],"Options.SwitchItemInBackpack","",null);
         _loc1_.setTooltipText(new LineBuilder().setParams("Options.SwitchItemInBackpackDesc",{"key":_loc2_}));
         this.addOptionAndPosition(_loc1_);
      }
      
      public function addInventoryOptions() : void {
         var _loc1_:* = null;
         var _loc2_:int = 1;
         while(_loc2_ <= 8) {
            _loc1_ = new KeyMapper("useInvSlot" + _loc2_,"","");
            _loc1_.setDescription(new LineBuilder().setParams("Options.InventorySlotN",{"n":_loc2_}));
            _loc1_.setTooltipText(new LineBuilder().setParams("Options.InventorySlotNDesc",{"n":_loc2_}));
            this.addOptionAndPosition(_loc1_);
            _loc2_++;
         }
      }
      
      private function AutoNexusValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("5%"),new StaticStringBuilder("10%"),new StaticStringBuilder("15%"),new StaticStringBuilder("20%"),new StaticStringBuilder("25%"),new StaticStringBuilder("30%"),new StaticStringBuilder("35%"),new StaticStringBuilder("40%"),new StaticStringBuilder("45%"),new StaticStringBuilder("50%"),new StaticStringBuilder("60%")];
      }

      private function createScrollWindow() : void {
         this.scrollContainerBottom = new Shape();
         this.scrollContainerBottom.graphics.beginFill(13434624,0);
         this.scrollContainerBottom.graphics.drawRect(0,0,800,60);
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(13434624,0.6);
         _loc1_.graphics.drawRect(0,102,800,420);
         addChild(_loc1_);
         this.scrollContainer = new Sprite();
         this.scrollContainer.mask = _loc1_;
         addChild(this.scrollContainer);
         this.scroll = new UIScrollbar(420);
         this.scroll.mouseRollSpeedFactor = 1.5;
         this.scroll.content = this.scrollContainer;
         this.scroll.x = 780;
         this.scroll.y = 102;
         this.scroll.visible = false;
         addChild(this.scroll);
      }
      
      private function setSelected(param1:OptionsTabTitle) : void {
         if(param1 == this.selected_) {
            return;
         }
         if(this.selected_) {
            this.selected_.setSelected(false);
         }
         this.selected_ = param1;
         this.selected_.setSelected(true);
         this.removeOptions();
         this.scrollContainer.y = 0;
         var _loc2_:* = this.selected_.text_;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "Options.Controls":
               this.addControlsOptions();
               break;
            case "Options.HotKeys":
               this.addHotKeysOptions();
               break;
            case "Options.Chat":
               this.addChatOptions();
               break;
            case "Options.Graphics":
               this.addGraphicsOptions();
               break;
            case "Options.Sound":
               this.addSoundOptions();
               break;
            case "Options.Misc":
               this.addMiscOptions();
               break;
            case "Options.Friend":
               this.addFriendOptions();
               this.addMiscOptions();
               break;
            case "Experimental":
               this.addExperimentalOptions();
               break;
            case "Debuffs":
               this.addDebuffsOptions();
               break;
            case "Auto":
               this.addAutoOptions();
               break;
            case "Loot":
               this.addAutoLootOptions();
               break;
            case "World":
               this.addWorldOptions();
               break;
            case "Visual":
               this.addVisualOptions();
               break;
            case "Other":
               this.addOtherOptions();
         }
         this.checkForScroll();
      }
      
      private function checkForScroll() : void {
         if(this.scrollContainer.height >= 420) {
            this.scrollContainerBottom.y = 102 + this.scrollContainer.height;
            this.scrollContainer.addChild(this.scrollContainerBottom);
            this.scroll.visible = true;
         } else {
            this.scroll.visible = false;
         }
      }
      
      private function addDebuffsOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("ignoreQuiet",makeOnOffLabels(),[true,false],"Ignore Quiet","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreWeak",makeOnOffLabels(),[true,false],"Ignore Weak","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreSlowed",makeOnOffLabels(),[true,false],"Ignore Slowed","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreSick",makeOnOffLabels(),[true,false],"Ignore Sick","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreDazed",makeOnOffLabels(),[true,false],"Ignore Dazed","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreStunned",makeOnOffLabels(),[true,false],"Ignore Stunned","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreParalyzed",makeOnOffLabels(),[true,false],"Ignore Paralyzed","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreBleeding",makeOnOffLabels(),[true,false],"Ignore Bleeding","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreArmorBroken",makeOnOffLabels(),[true,false],"Ignore Armor Broken","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignorePetStasis",makeOnOffLabels(),[true,false],"Ignore Pet Stasis","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignorePetrified",makeOnOffLabels(),[true,false],"Ignore Petrified","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreSilenced",makeOnOffLabels(),[true,false],"Ignore Silence","Server Sided, can DC, On means ignoring shot",calculateIgnoreBitmask,16711680));
         this.addOptionAndPosition(new ChoiceOption("ignoreBlind",makeOnOffLabels(),[true,false],"Ignore Blind","Client Sided, safe to ignore",calculateIgnoreBitmask));
         this.addOptionAndPosition(new ChoiceOption("ignoreHallucinating",makeOnOffLabels(),[true,false],"Ignore Hallucinating","Client Sided, safe to ignore",calculateIgnoreBitmask));
         this.addOptionAndPosition(new ChoiceOption("ignoreDrunk",makeOnOffLabels(),[true,false],"Ignore Drunk","Client Sided, safe to ignore",calculateIgnoreBitmask));
         this.addOptionAndPosition(new ChoiceOption("ignoreConfused",makeOnOffLabels(),[true,false],"Ignore Confused","Client Sided, safe to ignore",calculateIgnoreBitmask));
         this.addOptionAndPosition(new ChoiceOption("ignoreUnstable",makeOnOffLabels(),[true,false],"Ignore Unstable","Client Sided, safe to ignore",calculateIgnoreBitmask));
         this.addOptionAndPosition(new ChoiceOption("ignoreDarkness",makeOnOffLabels(),[true,false],"Ignore Darkness","Client Sided, safe to ignore",calculateIgnoreBitmask));
      }
      
      private function resetHPVals() : void {
         if(this.gs_ && this.gs_.map && this.gs_.map.player_) {
            this.gs_.map.player_.calcHealthPercent();
         }
      }
      
      private function resetMPVals() : void {
         if(this.gs_ && this.gs_.map && this.gs_.map.player_) {
            this.gs_.map.player_.calcManaPercent();
         }
      }
      
      private function volumeValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("0.1"),new StaticStringBuilder("0.2"),new StaticStringBuilder("0.3"),new StaticStringBuilder("0.4"),new StaticStringBuilder("0.5"),new StaticStringBuilder("0.6"),new StaticStringBuilder("0.7"),new StaticStringBuilder("0.8"),new StaticStringBuilder("0.9"),new StaticStringBuilder("1.0"),new StaticStringBuilder("1.1"),new StaticStringBuilder("1.2"),new StaticStringBuilder("1.3"),new StaticStringBuilder("1.4"),new StaticStringBuilder("1.5"),new StaticStringBuilder("1.6"),new StaticStringBuilder("1.7"),new StaticStringBuilder("1.8"),new StaticStringBuilder("1.9"),new StaticStringBuilder("2.0")];
      }
      
      private function make1to8labels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("#0"),new StaticStringBuilder("#1"),new StaticStringBuilder("#2"),new StaticStringBuilder("#3"),new StaticStringBuilder("#4"),new StaticStringBuilder("#5"),new StaticStringBuilder("#6"),new StaticStringBuilder("#7"),new StaticStringBuilder("#8")];
      }
      
      private function makeEggLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("Common"),new StaticStringBuilder("Uncommon"),new StaticStringBuilder("Rare"),new StaticStringBuilder("Legendary")];
      }
      
      private function alFBValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("1%"),new StaticStringBuilder("2%"),new StaticStringBuilder("3%"),new StaticStringBuilder("4%"),new StaticStringBuilder("5%"),new StaticStringBuilder("6%"),new StaticStringBuilder("7%")];
      }
      
      private function alFPValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("100 FP"),new StaticStringBuilder("200 FP"),new StaticStringBuilder("300 FP"),new StaticStringBuilder("400 FP"),new StaticStringBuilder("500 FP"),new StaticStringBuilder("600 FP"),new StaticStringBuilder("700 FP"),new StaticStringBuilder("800 FP"),new StaticStringBuilder("900 FP"),new StaticStringBuilder("1000 FP"),new StaticStringBuilder("1200 FP"),new StaticStringBuilder("1400 FP"),new StaticStringBuilder("1600 FP"),new StaticStringBuilder("1800 FP"),new StaticStringBuilder("2000 FP")];
      }
      
      private function aaDistanceValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("0"),new StaticStringBuilder("0.5"),new StaticStringBuilder("1"),new StaticStringBuilder("1.5"),new StaticStringBuilder("2"),new StaticStringBuilder("2.5"),new StaticStringBuilder("3")];
      }
      
      private function BoundingDistValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("15"),new StaticStringBuilder("20"),new StaticStringBuilder("30"),new StaticStringBuilder("50")];
      }
      
      private function AutoHealValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("5%"),new StaticStringBuilder("10%"),new StaticStringBuilder("15%"),new StaticStringBuilder("20%"),new StaticStringBuilder("25%"),new StaticStringBuilder("30%"),new StaticStringBuilder("35%"),new StaticStringBuilder("40%"),new StaticStringBuilder("45%"),new StaticStringBuilder("50%"),new StaticStringBuilder("55%"),new StaticStringBuilder("60%"),new StaticStringBuilder("65%"),new StaticStringBuilder("70%"),new StaticStringBuilder("75%"),new StaticStringBuilder("80%"),new StaticStringBuilder("85%"),new StaticStringBuilder("90%"),new StaticStringBuilder("95%"),new StaticStringBuilder("99%"),new StaticStringBuilder("100%")];
      }
      
      private function AutoManaPercentValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("5%"),new StaticStringBuilder("10%"),new StaticStringBuilder("15%"),new StaticStringBuilder("20%"),new StaticStringBuilder("25%"),new StaticStringBuilder("30%"),new StaticStringBuilder("35%"),new StaticStringBuilder("40%"),new StaticStringBuilder("45%"),new StaticStringBuilder("50%"),new StaticStringBuilder("55%"),new StaticStringBuilder("60%"),new StaticStringBuilder("65%"),new StaticStringBuilder("70%"),new StaticStringBuilder("75%"),new StaticStringBuilder("80%"),new StaticStringBuilder("85%"),new StaticStringBuilder("90%"),new StaticStringBuilder("95%"),new StaticStringBuilder("100%")];
      }
      
      private function AutoHPPotValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("5%"),new StaticStringBuilder("10%"),new StaticStringBuilder("15%"),new StaticStringBuilder("20%"),new StaticStringBuilder("25%"),new StaticStringBuilder("30%"),new StaticStringBuilder("35%"),new StaticStringBuilder("40%"),new StaticStringBuilder("45%"),new StaticStringBuilder("50%"),new StaticStringBuilder("55%"),new StaticStringBuilder("60%"),new StaticStringBuilder("65%"),new StaticStringBuilder("70%"),new StaticStringBuilder("75%")];
      }
      
      private function AutoMPPotValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("Abil %"),new StaticStringBuilder("5%"),new StaticStringBuilder("10%"),new StaticStringBuilder("15%"),new StaticStringBuilder("20%"),new StaticStringBuilder("25%"),new StaticStringBuilder("30%"),new StaticStringBuilder("35%"),new StaticStringBuilder("40%"),new StaticStringBuilder("45%"),new StaticStringBuilder("50%"),new StaticStringBuilder("55%"),new StaticStringBuilder("60%"),new StaticStringBuilder("65%"),new StaticStringBuilder("70%"),new StaticStringBuilder("75%")];
      }
      
      private function AutoHPPotDelayValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("100ms"),new StaticStringBuilder("200ms"),new StaticStringBuilder("300ms"),new StaticStringBuilder("400ms"),new StaticStringBuilder("500ms"),new StaticStringBuilder("600ms"),new StaticStringBuilder("700ms"),new StaticStringBuilder("800ms"),new StaticStringBuilder("900ms"),new StaticStringBuilder("1000ms")];
      }
      
      private function spellbombThresholdValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("250 HP"),new StaticStringBuilder("500 HP"),new StaticStringBuilder("750 HP"),new StaticStringBuilder("1000 HP"),new StaticStringBuilder("1250 HP"),new StaticStringBuilder("1500 HP"),new StaticStringBuilder("1750 HP"),new StaticStringBuilder("2000 HP"),new StaticStringBuilder("2500 HP"),new StaticStringBuilder("3000 HP"),new StaticStringBuilder("4000 HP"),new StaticStringBuilder("5000 HP"),new StaticStringBuilder("6000 HP"),new StaticStringBuilder("7000 HP"),new StaticStringBuilder("8000 HP"),new StaticStringBuilder("9000 HP"),new StaticStringBuilder("10000 HP"),new StaticStringBuilder("15000 HP"),new StaticStringBuilder("20000 HP")];
      }
      
      private function skullThresholdValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("100 HP"),new StaticStringBuilder("250 HP"),new StaticStringBuilder("500 HP"),new StaticStringBuilder("800 HP"),new StaticStringBuilder("1000 HP"),new StaticStringBuilder("2000 HP"),new StaticStringBuilder("4000 HP"),new StaticStringBuilder("8000 HP")];
      }
      
      private function skullTargetsValues() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Off"),new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("3"),new StaticStringBuilder("4"),new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10")];
      }
      
      private function makeFameTpCdLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("1000"),new StaticStringBuilder("2000"),new StaticStringBuilder("3000"),new StaticStringBuilder("4000"),new StaticStringBuilder("5000"),new StaticStringBuilder("6000"),new StaticStringBuilder("7000"),new StaticStringBuilder("8000"),new StaticStringBuilder("9000"),new StaticStringBuilder("10000")];
      }
      
      private function makePointOffsetLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("0.1"),new StaticStringBuilder("0.2"),new StaticStringBuilder("0.3"),new StaticStringBuilder("0.4"),new StaticStringBuilder("0.5"),new StaticStringBuilder("0.75"),new StaticStringBuilder("1.0"),new StaticStringBuilder("1.5"),new StaticStringBuilder("2.0"),new StaticStringBuilder("2.5"),new StaticStringBuilder("3.0"),new StaticStringBuilder("3.5")];
      }
      
      private function makeTeleDistLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("1"),new StaticStringBuilder("2"),new StaticStringBuilder("4"),new StaticStringBuilder("8"),new StaticStringBuilder("16"),new StaticStringBuilder("32"),new StaticStringBuilder("64")];
      }
      
      private function makeDistThreshLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("5"),new StaticStringBuilder("6"),new StaticStringBuilder("7"),new StaticStringBuilder("8"),new StaticStringBuilder("9"),new StaticStringBuilder("10"),new StaticStringBuilder("15"),new StaticStringBuilder("20"),new StaticStringBuilder("25"),new StaticStringBuilder("30"),new StaticStringBuilder("35"),new StaticStringBuilder("40")];
      }
      
      private function makeOffsetLabels() : Vector.<StringBuilder> {
         return new <StringBuilder>[new StaticStringBuilder("Middle"),new StaticStringBuilder("Further"),new StaticStringBuilder("Front"),new StaticStringBuilder("Furthest")];
      }
      
      private function onChatLengthChange() : void {
         this.gs_.chatBox_.model.setVisibleItemCount();
      }
      
      private function close() : void {
         stage.focus = null;
         parent.removeChild(this);
         if(Parameters.needToRecalcDesireables) {
            Parameters.setAutolootDesireables();
            Parameters.needToRecalcDesireables = false;
         }
      }
      
      private function removeOptions() : void {
         var _loc3_:* = null;
         if(this.scrollContainer.contains(this.scrollContainerBottom)) {
            this.scrollContainer.removeChild(this.scrollContainerBottom);
         }
         var _loc1_:* = this.options_;
         var _loc5_:int = 0;
         var _loc4_:* = this.options_;
         for each(_loc3_ in this.options_) {
            this.scrollContainer.removeChild(_loc3_);
         }
         this.options_.length = 0;
      }
      
      private function addControlsOptions() : void {
         this.addOptionAndPosition(new KeyMapper("moveUp","Options.MoveUp","Options.MoveUpDesc"));
         this.addOptionAndPosition(new KeyMapper("moveLeft","Options.MoveLeft","Options.MoveLeftDesc"));
         this.addOptionAndPosition(new KeyMapper("moveDown","Options.MoveDown","Options.MoveDownDesc"));
         this.addOptionAndPosition(new KeyMapper("moveRight","Options.MoveRight","Options.MoveRightDesc"));
         this.addOptionAndPosition(this.makeAllowCameraRotation());
         this.addOptionAndPosition(this.makeAllowMiniMapRotation());
         this.addOptionAndPosition(new KeyMapper("rotateLeft","Options.RotateLeft","Options.RotateLeftDesc",!Parameters.data.allowRotation));
         this.addOptionAndPosition(new KeyMapper("rotateRight","Options.RotateRight","Options.RotateRightDesc",!Parameters.data.allowRotation));
         this.addOptionAndPosition(new KeyMapper("useSpecial","Options.UseSpecialAbility","Options.UseSpecialAbilityDesc"));
         this.addOptionAndPosition(new KeyMapper("autofireToggle","Options.AutofireToggle","Options.AutofireToggleDesc"));
         this.addOptionAndPosition(new KeyMapper("toggleHPBar","Options.ToggleHPBar","Options.ToggleHPBarDesc"));
         this.addOptionAndPosition(new KeyMapper("resetToDefaultCameraAngle","Options.ResetCamera","Options.ResetCameraDesc"));
         this.addOptionAndPosition(new KeyMapper("togglePerformanceStats","Options.TogglePerformanceStats","Options.TogglePerformanceStatsDesc"));
         this.addOptionAndPosition(new KeyMapper("toggleCentering","Options.ToggleCentering","Options.ToggleCenteringDesc"));
         this.addOptionAndPosition(new KeyMapper("interact","Options.InteractOrBuy","Options.InteractOrBuyDesc"));
      }
      
      private function makeAllowCameraRotation() : ChoiceOption {
         return new ChoiceOption("allowRotation",makeOnOffLabels(),[true,false],"Options.AllowRotation","Options.AllowRotationDesc",this.onAllowRotationChange);
      }
      
      private function makeAllowMiniMapRotation() : ChoiceOption {
         return new ChoiceOption("allowMiniMapRotation",makeOnOffLabels(),[true,false],"Options.AllowMiniMapRotation","Options.AllowMiniMapRotationDesc",null);
      }
      
      private function onAllowRotationChange() : void {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.options_.length) {
            _loc1_ = this.options_[_loc2_] as KeyMapper;
            if(_loc1_ != null) {
               if(_loc1_.paramName_ == "rotateLeft" || _loc1_.paramName_ == "rotateRight") {
                  _loc1_.setDisabled(!Parameters.data.allowRotation);
               }
            }
            _loc2_++;
         }
      }
      
      private function addHotKeysOptions() : void {
         this.addOptionAndPosition(new KeyMapper("quickSlotKey1","Activate Quick Slot 1","This will consume one of the items placed on the first quick slot"));
         this.addOptionAndPosition(new KeyMapper("quickSlotKey2","Activate Quick Slot 2","This will consume one of the items placed on the second quick slot"));
         this.addOptionAndPosition(new KeyMapper("quickSlotKey3","Activate Quick Slot 3","This will consume one of the items placed on the third quick slot"));
         this.addInventoryOptions();
         this.addOptionAndPosition(new KeyMapper("miniMapZoomIn","Options.MiniMapZoomIn","Options.MiniMapZoomInDesc"));
         this.addOptionAndPosition(new KeyMapper("miniMapZoomOut","Options.MiniMapZoomOut","Options.MiniMapZoomOutDesc"));
         this.addOptionAndPosition(new KeyMapper("escapeToNexus","Options.EscapeToNexus","Options.EscapeToNexusDesc"));
         this.addOptionAndPosition(new KeyMapper("options","Options.ShowOptions","Options.ShowOptionsDesc"));
         this.addOptionAndPosition(new KeyMapper("switchTabs","Options.SwitchTabs","Options.SwitchTabsDesc"));
         this.addOptionAndPosition(new KeyMapper("toggleRealmQuestDisplay","Toggle Realm Quests Display","Toggle Expand/Collapse of the Realm Quests Display"));
         this.addOptionAndPosition(new KeyMapper("walkKey","Walk Key","Allows you to walk (move slowly) while the key is held down"));
         this.addOptionsChoiceOption();
      }
      
      private function addChatOptions() : void {
         this.addOptionAndPosition(new KeyMapper("chat","Options.ActivateChat","Options.ActivateChatDesc"));
         this.addOptionAndPosition(new KeyMapper("chatCommand","Options.StartCommand","Options.StartCommandDesc"));
         this.addOptionAndPosition(new KeyMapper("tell","Options.BeginTell","Options.BeginTellDesc"));
         this.addOptionAndPosition(new KeyMapper("guildChat","Options.BeginGuildChat","Options.BeginGuildChatDesc"));
         this.addOptionAndPosition(new ChoiceOption("filterLanguage",makeOnOffLabels(),[true,false],"Options.FilterOffensiveLanguage","Options.FilterOffensiveLanguageDesc",null));
         this.addOptionAndPosition(new KeyMapper("scrollChatUp","Options.ScrollChatUp","Options.ScrollChatUpDesc"));
         this.addOptionAndPosition(new KeyMapper("scrollChatDown","Options.ScrollChatDown","Options.ScrollChatDownDesc"));
         this.addOptionAndPosition(new ChoiceOption("forceChatQuality",makeOnOffLabels(),[true,false],"Options.forceChatQuality","Options.forceChatQualityDesc",null));
         this.addOptionAndPosition(new ChoiceOption("hidePlayerChat",makeOnOffLabels(),[true,false],"Options.hidePlayerChat","Options.hidePlayerChatDesc",null));
         this.addOptionAndPosition(new ChoiceOption("chatStarRequirement",makeStarSelectLabels(),[0,1,2,3,5,10],"Options.starReq","Options.chatStarReqDesc",null));
         this.addOptionAndPosition(new ChoiceOption("chatAll",makeOnOffLabels(),[true,false],"Options.chatAll","Options.chatAllDesc",this.onAllChatEnabled));
         this.addOptionAndPosition(new ChoiceOption("chatWhisper",makeOnOffLabels(),[true,false],"Options.chatWhisper","Options.chatWhisperDesc",this.onAllChatDisabled));
         this.addOptionAndPosition(new ChoiceOption("chatGuild",makeOnOffLabels(),[true,false],"Options.chatGuild","Options.chatGuildDesc",this.onAllChatDisabled));
         this.addOptionAndPosition(new ChoiceOption("chatTrade",makeOnOffLabels(),[true,false],"Options.chatTrade","Options.chatTradeDesc",null));
      }
      
      private function onAllChatDisabled() : void {
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         Parameters.data.chatAll = false;
         while(_loc3_ < this.options_.length) {
            _loc1_ = this.options_[_loc3_] as ChoiceOption;
            if(_loc1_ != null) {
               _loc2_ = _loc1_.paramName_;
               if("chatAll" === _loc2_) {
                  _loc1_.refreshNoCallback();
               }
            }
            _loc3_++;
         }
      }
      
      private function onAllChatEnabled() : void {
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         Parameters.data.hidePlayerChat = false;
         Parameters.data.chatWhisper = true;
         Parameters.data.chatGuild = true;
         Parameters.data.chatFriend = false;
         for(; _loc3_ < this.options_.length; _loc3_++) {
            _loc1_ = this.options_[_loc3_] as ChoiceOption;
            if(_loc1_ != null) {
               _loc2_ = _loc1_.paramName_;
               var _loc4_:* = _loc2_;
               switch(_loc4_) {
                  case "hidePlayerChat":
                  case "chatWhisper":
                  case "chatGuild":
                     _loc1_.refreshNoCallback();
                     break;
                  case "chatFriend":
               }
               continue;
            }
         }
      }
      
      private function addExperimentalOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles",makeOnOffLabels(),[true,false],"Disable Enemy Particles","Disable enemy hit and death particles.",null));
         this.addOptionAndPosition(new ChoiceOption("disableAllyShoot",makeAllyShootLabels(),[0,1,2],"Disable Ally Shoot","Disable showing shooting animations and projectiles shot by allies or only projectiles.",null));
         this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles",makeOnOffLabels(),[true,false],"Disable Players Hit Particles","Disable player and ally hit particles.",null));
         this.addOptionAndPosition(new ChoiceOption("toggleToMaxText",makeOnOffLabels(),[true,false],"Options.ToggleToMaxText","Options.ToggleToMaxTextDesc",onToMaxTextToggle));
         this.addOptionAndPosition(new ChoiceOption("newMiniMapColors",makeOnOffLabels(),[true,false],"Options.ToggleNewMiniMapColorsText","Options.ToggleNewMiniMapColorsTextDesc",null));
         this.addOptionAndPosition(new ChoiceOption("noParticlesMaster",makeOnOffLabels(),[true,false],"Disable Particles Master","Disable all nonessential particles besides enemy and ally hits. Throw, Area and certain other effects will remain.",null));
         this.addOptionAndPosition(new ChoiceOption("noAllyNotifications",makeOnOffLabels(),[true,false],"Disable Ally Notifications","Disable text notifications above allies.",null));
         this.addOptionAndPosition(new ChoiceOption("noEnemyDamage",makeOnOffLabels(),[true,false],"Disable Enemy Damage Text","Disable damage from other players above enemies.",null));
         this.addOptionAndPosition(new ChoiceOption("noAllyDamage",makeOnOffLabels(),[true,false],"Disable Ally Damage Text","Disable damage above allies.",null));
         this.addOptionAndPosition(new ChoiceOption("forceEXP",makeForceExpLabels(),[0,1,2],"Always Show EXP","Show EXP notifications even when level 20.",null));
         this.addOptionAndPosition(new ChoiceOption("showFameGain",makeOnOffLabels(),[true,false],"Show Fame Gain","Shows notifications for each fame gained.",null));
         this.addOptionAndPosition(new ChoiceOption("curseIndication",makeOnOffLabels(),[true,false],"Curse Indication","Makes enemies inflicted by Curse glow red.",null));
      }
      
      private function addGraphicsOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("defaultCameraAngle",makeDegreeOptions(),[5.49778714378214,0],"Options.DefaultCameraAngle","Options.DefaultCameraAngleDesc",onDefaultCameraAngleChange));
         this.addOptionAndPosition(new ChoiceOption("centerOnPlayer",makeOnOffLabels(),[true,false],"Options.CenterOnPlayer","Options.CenterOnPlayerDesc",null));
         this.addOptionAndPosition(new ChoiceOption("showQuestPortraits",makeOnOffLabels(),[true,false],"Options.ShowQuestPortraits","Options.ShowQuestPortraitsDesc",this.onShowQuestPortraitsChange));
         this.addOptionAndPosition(new ChoiceOption("showProtips",makeOnOffLabels(),[true,false],"Options.ShowTips","Options.ShowTipsDesc",null));
         this.addOptionAndPosition(new ChoiceOption("textBubbles",makeOnOffLabels(),[true,false],"Options.DrawTextBubbles","Options.DrawTextBubblesDesc",null));
         this.addOptionAndPosition(new ChoiceOption("showTradePopup",makeOnOffLabels(),[true,false],"Options.ShowTradeRequestPanel","Options.ShowTradeRequestPanelDesc",null));
         this.addOptionAndPosition(new ChoiceOption("showGuildInvitePopup",makeOnOffLabels(),[true,false],"Options.ShowGuildInvitePanel","Options.ShowGuildInvitePanelDesc",null));
         this.addOptionAndPosition(new ChoiceOption("cursorSelect",makeCursorSelectLabels(),["auto","0","1","2","3","4","5","6","7","8","9","10","11"],"Custom Cursor","Click here to change the mouse cursor. May help with aiming.",refreshCursor));
         this.addOptionAndPosition(new ChoiceOption("toggleBarText",makeBarTextLabels(),[0,1,2,3],"Toggle Fame and HP/MP Text","Always show text value for Fame, remaining HP/MP, or both",onBarTextToggle));
         this.addOptionAndPosition(new ChoiceOption("particleEffect",makeHighLowLabels(),[true,false],"Options.ToggleParticleEffect","Options.ToggleParticleEffectDesc",null));
         this.addOptionAndPosition(new ChoiceOption("HPBar",makeHpBarLabels(),[0,1,2,3,4,5],"Options.HPBar","Options.HPBarDesc",null));
         this.addOptionAndPosition(new ChoiceOption("showTierTag",makeOnOffLabels(),[true,false],"Show Tier level","Show Tier level on gear",this.onToggleTierTag));
         this.addOptionAndPosition(new KeyMapper("toggleProjectiles","Toggle Ally Projectiles","This key will toggle rendering of friendly projectiles"));
         this.addOptionAndPosition(new KeyMapper("toggleMasterParticles","Toggle Particles","This key will toggle rendering of nonessential particles (Particles Master option)"));
         this.addOptionAndPosition(new ChoiceOption("expandRealmQuestsDisplay",makeOnOffLabels(),[true,false],"Expand Realm Quests","Expand the Realm Quests Display when entering the realm",null));
         this.addOptionAndPosition(new ChoiceOption("projFace",makeOnOffLabels(),[true,false],"Projectile Rotation","This toggles whether to force projectiles to face the direction they\'re heading to",null));
         this.addOptionAndPosition(new ChoiceOption("disableSorting",makeOnOffLabels(),[false,true],"Object Sorting","This toggles whether to disable object sorting, increasing performance in the process",null));
         this.addOptionAndPosition(new ChoiceOption("vSync",makeOnOffLabels(),[true,false],"Toggle VSync","This toggles whether to enable Vertical Sync",onVSyncToggle));
         this.addOptionAndPosition(new ChoiceOption("fullscreen",makeOnOffLabels(),[true,false],"Toggle Fullscreen","This toggles whether to set the window mode to Fullscreen",onFullscreenToggle));
      }
      
      private function onToggleTierTag() : void {
         StaticInjectorContext.getInjector().getInstance(ToggleShowTierTagSignal).dispatch(Parameters.data.showTierTag);
      }
      
      private function onCharacterGlow() : void {
         var _loc1_:Player = this.gs_.map.player_;
         if(_loc1_.hasSupporterFeature(1)) {
            _loc1_.clearTextureCache();
         }
      }
      
      private function onShowQuestPortraitsChange() : void {
         if(this.gs_ != null && this.gs_.map != null && this.gs_.map.partyOverlay_ != null && this.gs_.map.partyOverlay_.questArrow_ != null) {
            this.gs_.map.partyOverlay_.questArrow_.refreshToolTip();
         }
      }
      
      private function onFullscreenChange() : void {
         stage.displayState = !!Parameters.data.fullscreenMode?"fullScreenInteractive":"normal";
      }
      
      private function addSoundOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("playMusic",makeOnOffLabels(),[true,false],"Options.PlayMusic","Options.PlayMusicDesc",this.onPlayMusicChange));
         this.addOptionAndPosition(new SliderOption("musicVolume",this.onMusicVolumeChange),-120,15);
         this.addOptionAndPosition(new ChoiceOption("playSFX",makeOnOffLabels(),[true,false],"Options.PlaySoundEffects","Options.PlaySoundEffectsDesc",this.onPlaySoundEffectsChange));
         this.addOptionAndPosition(new SliderOption("SFXVolume",this.onSoundEffectsVolumeChange),-120,34);
         this.addOptionAndPosition(new ChoiceOption("playPewPew",makeOnOffLabels(),[true,false],"Options.PlayWeaponSounds","Options.PlayWeaponSoundsDesc",null));
      }
      
      private function addMiscOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("showProtips",new <StringBuilder>[makeLineBuilder("Options.legalView"),makeLineBuilder("Options.legalView")],[Parameters.data.showProtips,Parameters.data.showProtips],"Options.legal1","Options.legal1Desc",this.onLegalPrivacyClick));
         this.addOptionAndPosition(new NullOption());
         this.addOptionAndPosition(new ChoiceOption("showProtips",new <StringBuilder>[makeLineBuilder("Options.legalView"),makeLineBuilder("Options.legalView")],[Parameters.data.showProtips,Parameters.data.showProtips],"Options.legal2","Options.legal2Desc",this.onLegalTOSClick));
      }
      
      private function addFriendOptions() : void {
         this.addOptionAndPosition(new ChoiceOption("tradeWithFriends",makeOnOffLabels(),[true,false],"Options.TradeWithFriends","Options.TradeWithFriendsDesc",this.onPlaySoundEffectsChange));
         this.addOptionAndPosition(new KeyMapper("friendList","Options.FriendList","Options.FriendListDesc"));
         this.addOptionAndPosition(new ChoiceOption("chatFriend",makeOnOffLabels(),[true,false],"Options.ChatFriend","Options.ChatFriendDesc",null));
         this.addOptionAndPosition(new ChoiceOption("friendStarRequirement",makeStarSelectLabels(),[0,1,2,3,5,10],"Options.starReq","Options.FriendsStarReqDesc",null));
         this.addOptionAndPosition(new NullOption());
         this.addOptionAndPosition(new NullOption());
      }
      
      private function onPlayMusicChange() : void {
         Music.setPlayMusic(Parameters.data.playMusic);
         if(Parameters.data.playMusic) {
            Music.setMusicVolume(1);
         } else {
            Music.setMusicVolume(0);
         }
         this.refresh();
      }
      
      private function onPlaySoundEffectsChange() : void {
         SFX.setPlaySFX(Parameters.data.playSFX);
         if(Parameters.data.playSFX || Parameters.data.playPewPew) {
            SFX.setSFXVolume(1);
         } else {
            SFX.setSFXVolume(0);
         }
         this.refresh();
      }
      
      private function onMusicVolumeChange(param1:Number) : void {
         Music.setMusicVolume(param1);
      }
      
      private function onSoundEffectsVolumeChange(param1:Number) : void {
         SFX.setSFXVolume(param1);
      }
      
      private function onLegalPrivacyClick() : void {
         var _loc1_:URLRequest = new URLRequest();
         _loc1_.url = "http://legal.decagames.com/privacy/";
         _loc1_.method = "GET";
      }
      
      private function onLegalTOSClick() : void {
         var _loc1_:URLRequest = new URLRequest();
         _loc1_.url = "http://legal.decagames.com/tos/";
         _loc1_.method = "GET";
      }
      
      private function addOptionAndPosition(param1:Option, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void {
         var smaller:Boolean = param4;
         var option:Option = param1;
         var offsetX:Number = param2;
         var offsetY:Number = param3;
         var positionOption:Function = function():void {
            option.x = (options_.length % 2 == 0?20:Number(415)) + offsetX;
            option.y = int(options_.length / 2) * (!!smaller?34:44) + (!!smaller?109:122) + offsetY;
         };
         option.textChanged.addOnce(positionOption);
         this.addOption(option);
      }
      
      private function addOption(param1:Option) : void {
         this.scrollContainer.addChild(param1);
         param1.addEventListener("change",this.onChange);
         this.options_.push(param1);
      }
      
      private function refresh() : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:uint = this.options_.length;
         while(_loc2_ < _loc1_) {
            _loc3_ = this.options_[_loc2_] as BaseOption;
            if(_loc3_) {
               _loc3_.refresh();
            }
            _loc2_++;
         }
      }
      
      private function onContinueClick(param1:MouseEvent) : void {
         this.close();
      }
      
      private function onResetToDefaultsClick(param1:MouseEvent) : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.options_.length) {
            _loc3_ = this.options_[_loc2_] as BaseOption;
            if(_loc3_ != null) {
               delete Parameters.data[_loc3_.paramName_];
            }
            _loc2_++;
         }
         Parameters.setDefaults();
         Parameters.save();
         this.refresh();
      }
      
      private function onHomeClick(param1:MouseEvent) : void {
         var _loc2_:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
         _loc2_.isLogOutLogIn = true;
         this.close();
         this.gs_.closed.dispatch();
      }
      
      private function onTabClick(param1:MouseEvent) : void {
         var _loc2_:OptionsTabTitle = param1.currentTarget as OptionsTabTitle;
         Parameters.data.lastTab = _loc2_.text_;
         this.setSelected(_loc2_);
      }
      
      private function onAddedToStage(param1:Event) : void {
         this.continueButton_.x = 400;
         this.continueButton_.y = 550;
         this.resetToDefaultsButton_.x = 20;
         this.resetToDefaultsButton_.y = 550;
         this.homeButton_.x = 780;
         this.homeButton_.y = 550;
         if(Capabilities.playerType == "Desktop") {
            Parameters.data.fullscreenMode = stage.displayState == "fullScreenInteractive";
            Parameters.save();
         }
         this.setSelected(this.defaultTab_);
         stage.addEventListener("keyDown",this.onKeyDown,false,1);
         stage.addEventListener("keyUp",this.onKeyUp,false,1);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown,false);
         stage.removeEventListener("keyUp",this.onKeyUp,false);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == 27) {
            param1.preventDefault();
         }
         if(param1.keyCode == Parameters.data.options) {
            this.close();
         }
         param1.stopImmediatePropagation();
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void {
         param1.stopImmediatePropagation();
      }
      
      private function onChange(param1:Event) : void {
         this.refresh();
      }
   }
}
