package io.decagames.rotmg.fame {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.utils.Dictionary;

import io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker;
import io.decagames.rotmg.fame.data.FameTracker;
import io.decagames.rotmg.fame.data.TotalFame;
import io.decagames.rotmg.fame.data.bonus.FameBonus;
import io.decagames.rotmg.fame.data.bonus.FameBonusConfig;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;
import io.decagames.rotmg.utils.date.TimeSpan;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FameContentPopupMediator extends Mediator {


    public function FameContentPopupMediator() {
        super();
    }
    [Inject]
    public var view:FameContentPopup;
    [Inject]
    public var closePopupSignal:ClosePopupSignal;
    [Inject]
    public var showTooltipSignal:ShowTooltipSignal;
    [Inject]
    public var hideTooltipSignal:HideTooltipsSignal;
    [Inject]
    public var fameTracker:FameTracker;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var metrics:CharactersMetricsTracker;
    [Inject]
    public var hudModel:HUDModel;
    private var closeButton:SliceScalingButton;
    private var toolTip:TextToolTip = null;
    private var hoverTooltipDelegate:HoverTooltipDelegate;
    private var totalFame:TotalFame;
    private var bonuses:Dictionary;
    private var bonusesList:Vector.<FameBonus>;
    private var characterID:int;

    override public function initialize():void {
        var _loc3_:* = null;
        var _loc2_:* = null;
        this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
        this.closeButton.clickSignal.addOnce(this.onClose);
        this.view.header.addButton(this.closeButton, "right_button");
        this.characterID = this.view.characterId == -1 ? this.hudModel.gameSprite.gsc_.charId_ : int(this.view.characterId);
        this.totalFame = this.fameTracker.getCurrentTotalFame(this.characterID);
        this.bonuses = this.totalFame.bonuses;
        this.bonusesList = new Vector.<FameBonus>();
        var _loc4_:String = "";
        if (!this.player.getCharacterById(this.characterID)) {
            _loc4_ = "";
        } else {
            _loc4_ = this.player.getCharacterById(this.characterID).bornOn();
        }
        this.showInfo();
        this.view.fameOnDeath = this.totalFame.currentFame;
        if (this.view.characterId == -1) {
            _loc3_ = this.hudModel.gameSprite.map.player_;
            this.view.setCharacterData(this.totalFame.baseFame, _loc3_.name_, _loc3_.level_, ObjectLibrary.typeToDisplayId_[_loc3_.objectType_], _loc4_, _loc3_.getFamePortrait(200));
        } else {
            _loc2_ = this.player.getCharacterById(this.characterID);
            this.view.setCharacterData(this.totalFame.baseFame, _loc2_.name(), _loc2_.level(), ObjectLibrary.typeToDisplayId_[_loc2_.objectType()], _loc4_, _loc2_.getIcon(100));
        }
        this.toolTip = new TextToolTip(3552822, 10197915, "Fame calculation", "Refreshes when returning to the Nexus or main menu.", 230);
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
        this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
        this.hoverTooltipDelegate.setDisplayObject(this.view.infoButton);
        this.hoverTooltipDelegate.tooltip = this.toolTip;
        this.showTooltipSignal.add(this.onShowTooltip);
        Parameters.data["clicked_on_fame_ui"] = true;
    }

    override public function destroy():void {
        this.closeButton.dispose();
        this.hoverTooltipDelegate = null;
        this.toolTip = null;
        this.showTooltipSignal.remove(this.onShowTooltip);
    }

    public function getTotalDungeonCompleted():int {
        var _loc2_:int = 0;
        var _loc1_:int = 21;
        while (_loc1_ <= 52) {
            _loc2_ = _loc2_ + this.metrics.getCharacterStat(this.characterID, _loc1_);
            _loc1_++;
        }
        return this.metrics.getCharacterStat(this.characterID, 13) + this.metrics.getCharacterStat(this.characterID, 14) + this.metrics.getCharacterStat(this.characterID, 15) + this.metrics.getCharacterStat(this.characterID, 16) + this.metrics.getCharacterStat(this.characterID, 17) + this.metrics.getCharacterStat(this.characterID, 18) + _loc2_;
    }

    private function onShowTooltip(param1:TextToolTip):void {
        var _loc2_:StringBuilder = param1.titleText_.getStringBuilder();
        if (this.fameTracker.metrics.lastUpdate && _loc2_ is LineBuilder && LineBuilder(_loc2_).key == "Fame calculation") {
            param1.setTitle(new StaticStringBuilder("Updated " + TimeSpan.distanceOfTimeInWords(this.fameTracker.metrics.lastUpdate, new Date(), true) + "."));
        }
    }

    private function onClose(param1:BaseButton):void {
        this.closePopupSignal.dispatch(this.view);
    }

    private function getBonusValue(param1:int):int {
        if (!this.totalFame.bonuses[param1]) {
            return 0;
        }
        return this.totalFame.bonuses[param1].fameAdded;
    }

    private function showCompletedDungeons():void {
        var _loc1_:* = null;
        var _loc3_:Vector.<StatsLine> = new Vector.<StatsLine>();
        this.view.addDungeonLine(new StatsLine("Dungeons", "", "", 2));
        _loc3_.push(new DungeonLine("Pirate Cave", "Pirate Cave", this.metrics.getCharacterStat(this.characterID, 13) + ""));
        _loc3_.push(new DungeonLine("Undead Lair", "Undead Lair", this.metrics.getCharacterStat(this.characterID, 14) + ""));
        _loc3_.push(new DungeonLine("Abyss of Demons", "Abyss of Demons", this.metrics.getCharacterStat(this.characterID, 15) + ""));
        _loc3_.push(new DungeonLine("Snake Pit", "Snake Pit", this.metrics.getCharacterStat(this.characterID, 16) + ""));
        _loc3_.push(new DungeonLine("Spider Den", "Spider Den", this.metrics.getCharacterStat(this.characterID, 17) + ""));
        _loc3_.push(new DungeonLine("Sprite World", "Sprite World", this.metrics.getCharacterStat(this.characterID, 18) + ""));
        _loc3_.push(new DungeonLine("Tomb of the Ancients", "Tomb of the Ancients", this.metrics.getCharacterStat(this.characterID, 21) + ""));
        _loc3_.push(new DungeonLine("Ocean Trench", "Ocean Trench", this.metrics.getCharacterStat(this.characterID, 22) + ""));
        _loc3_.push(new DungeonLine("Forbidden Jungle", "Forbidden Jungle", this.metrics.getCharacterStat(this.characterID, 23) + ""));
        _loc3_.push(new DungeonLine("Manor of the Immortals", "Manor of the Immortals", this.metrics.getCharacterStat(this.characterID, 24) + ""));
        _loc3_.push(new DungeonLine("Forest Maze", "Forest Maze", this.metrics.getCharacterStat(this.characterID, 25) + ""));
        _loc3_.push(new DungeonLine("Lair of Draconis", "Lair of Draconis", this.metrics.getCharacterStat(this.characterID, 26) + this.metrics.getCharacterStat(this.characterID, 46) + ""));
        _loc3_.push(new DungeonLine("Haunted Cemetery", "Haunted Cemetery", this.metrics.getCharacterStat(this.characterID, 28) + ""));
        _loc3_.push(new DungeonLine("Cave of a Thousand Treasures", "Cave of A Thousand Treasures", this.metrics.getCharacterStat(this.characterID, 29) + ""));
        _loc3_.push(new DungeonLine("Mad Lab", "Mad Lab", this.metrics.getCharacterStat(this.characterID, 30) + ""));
        _loc3_.push(new DungeonLine("Davy Jones\' Locker", "Davy Jones\' Locker", this.metrics.getCharacterStat(this.characterID, 31) + ""));
        _loc3_.push(new DungeonLine("Ice Cave", "Ice Cave", this.metrics.getCharacterStat(this.characterID, 34) + ""));
        _loc3_.push(new DungeonLine("Deadwater Docks", "Deadwater Docks", this.metrics.getCharacterStat(this.characterID, 35) + ""));
        _loc3_.push(new DungeonLine("The Crawling Depths", "The Crawling Depths", this.metrics.getCharacterStat(this.characterID, 36) + ""));
        _loc3_.push(new DungeonLine("Woodland Labyrinth", "Woodland Labyrinth", this.metrics.getCharacterStat(this.characterID, 37) + ""));
        _loc3_.push(new DungeonLine("Battle for the Nexus", "Battle for the Nexus", this.metrics.getCharacterStat(this.characterID, 38) + ""));
        _loc3_.push(new DungeonLine("The Shatters", "The Shatters", this.metrics.getCharacterStat(this.characterID, 39) + ""));
        _loc3_.push(new DungeonLine("Belladonna\'s Garden", "Belladonna\'s Garden", this.metrics.getCharacterStat(this.characterID, 40) + ""));
        _loc3_.push(new DungeonLine("Puppet Master\'s Theatre", "Puppet Master\'s Theatre", this.metrics.getCharacterStat(this.characterID, 41) + ""));
        _loc3_.push(new DungeonLine("Toxic Sewers", "Toxic Sewers", this.metrics.getCharacterStat(this.characterID, 42) + ""));
        _loc3_.push(new DungeonLine("The Hive", "The Hive", this.metrics.getCharacterStat(this.characterID, 43) + ""));
        _loc3_.push(new DungeonLine("Mountain Temple", "Mountain Temple", this.metrics.getCharacterStat(this.characterID, 44) + ""));
        _loc3_.push(new DungeonLine("The Nest", "The Nest", this.metrics.getCharacterStat(this.characterID, 45) + ""));
        _loc3_.push(new DungeonLine("Lost Halls", "Lost Halls", this.metrics.getCharacterStat(this.characterID, 47) + ""));
        _loc3_.push(new DungeonLine("Cultist Hideout", "Cultist Hideout", this.metrics.getCharacterStat(this.characterID, 48) + ""));
        _loc3_.push(new DungeonLine("The Void", "The Void", this.metrics.getCharacterStat(this.characterID, 49) + ""));
        _loc3_.push(new DungeonLine("Puppet Master\'s Encore", "Puppet Master\'s Encore", this.metrics.getCharacterStat(this.characterID, 50) + ""));
        _loc3_.push(new DungeonLine("Lair of Shaitan", "Lair of Shaitan", this.metrics.getCharacterStat(this.characterID, 51) + ""));
        _loc3_.push(new DungeonLine("Parasite Chambers", "Parasite Chambers", this.metrics.getCharacterStat(this.characterID, 52) + ""));
        _loc3_.push(new DungeonLine("Magic Woods", "Magic Woods", this.metrics.getCharacterStat(this.characterID, 53) + ""));
        _loc3_.push(new DungeonLine("Cnidarian Reef", "Cnidarian Reef", this.metrics.getCharacterStat(this.characterID, 54) + ""));
        _loc3_.push(new DungeonLine("Secluded Thicket", "Secluded Thicket", this.metrics.getCharacterStat(this.characterID, 55) + ""));
        _loc3_.push(new DungeonLine("Cursed Library", "Cursed Library", this.metrics.getCharacterStat(this.characterID, 56) + ""));
        _loc3_.push(new DungeonLine("Fungal Cavern", "Fungal Cavern", this.metrics.getCharacterStat(this.characterID, 57) + ""));
        _loc3_.push(new DungeonLine("Crystal Cavern", "Crystal Cavern", this.metrics.getCharacterStat(this.characterID, 58) + ""));
        _loc3_.push(new DungeonLine("Ancient Ruins", "Ancient Ruins", this.metrics.getCharacterStat(this.characterID, 59) + ""));
        _loc3_ = _loc3_.sort(this.dungeonNameSort);
        var _loc2_:* = _loc3_;
        var _loc6_:int = 0;
        var _loc5_:* = _loc3_;
        for each(_loc1_ in _loc3_) {
            this.view.addDungeonLine(_loc1_);
        }
    }

    private function dungeonNameSort(param1:StatsLine, param2:StatsLine):int {
        if (param1.labelText > param2.labelText) {
            return 1;
        }
        return -1;
    }

    private function showStats():void {
        var _loc1_:* = 0;
        if (this.metrics.getCharacterStat(this.characterID, 1) > 0 && this.metrics.getCharacterStat(this.characterID, 0) > 0) {
            _loc1_ = this.metrics.getCharacterStat(this.characterID, 1) / this.metrics.getCharacterStat(this.characterID, 0) * 100;
        }
        this.view.addStatLine(new StatsLine("Statistics", "", "", 2));
        this.view.addStatLine(new StatsLine("Shots Fired", this.metrics.getCharacterStat(this.characterID, 0).toString(), "The total number of shots fired by this character.", 1));
        this.view.addStatLine(new StatsLine("Shots Hit", this.metrics.getCharacterStat(this.characterID, 1).toString(), "The total number of enemy hitting shots fired by this character.", 1));
        this.view.addStatLine(new StatsLine("Potions Drunk", this.metrics.getCharacterStat(this.characterID, 5).toString(), "The number of potions this character has consumed.", 1));
        this.view.addStatLine(new StatsLine("Abilities Used", this.metrics.getCharacterStat(this.characterID, 2).toString(), "The number of times this character used their abilities.", 1));
        this.view.addStatLine(new StatsLine("Teleported", this.metrics.getCharacterStat(this.characterID, 4).toString(), "The number of times this character has teleported.", 1));
        this.view.addStatLine(new StatsLine("Dungeons Completed", this.getTotalDungeonCompleted().toString(), "The number of dungeons completed by this character.", 1));
        this.view.addStatLine(new StatsLine("Monster Kills", this.metrics.getCharacterStat(this.characterID, 6).toString(), "Total number of monsters killed by this character.", 1));
        this.view.addStatLine(new StatsLine("God Kills", this.metrics.getCharacterStat(this.characterID, 8).toString(), "Total number of Gods killed by this character.", 1));
        this.view.addStatLine(new StatsLine("Oryx Kills", this.metrics.getCharacterStat(this.characterID, 11).toString(), "Total number of Oryx kills for this character.", 1));
        this.view.addStatLine(new StatsLine("Monster Assists", this.metrics.getCharacterStat(this.characterID, 7).toString(), "Total number of monster kills assisted by this character.", 1));
        this.view.addStatLine(new StatsLine("God Assists", this.metrics.getCharacterStat(this.characterID, 9).toString(), "Total number of God kills assisted by this character.", 1));
        this.view.addStatLine(new StatsLine("Party Level Ups", this.metrics.getCharacterStat(this.characterID, 19).toString(), "Total number of level ups assisted by this character.", 1));
        this.view.addStatLine(new StatsLine("Quests Completed", this.metrics.getCharacterStat(this.characterID, 12).toString(), "Total number of quests completed by this character.", 1));
        this.view.addStatLine(new StatsLine("Cube Kills", this.metrics.getCharacterStat(this.characterID, 10).toString(), "Total number of Cube Enemies killed by this character.", 1));
        this.view.addStatLine(new StatsLine("Accuracy", _loc1_.toFixed(2) + "%", "", 1));
        this.view.addStatLine(new StatsLine("Tiles Seen", this.metrics.getCharacterStat(this.characterID, 3).toString(), "", 1));
        this.view.addStatLine(new StatsLine("Minutes Active", this.metrics.getCharacterStat(this.characterID, 20).toString(), "Time spent actively defeating Oryx\'s minions.", 1));
    }

    private function sortBonusesByLevel(param1:FameBonus, param2:FameBonus):int {
        if (param1.level > param2.level) {
            return 1;
        }
        return -1;
    }

    private function sortBonusesByFame(param1:FameBonus, param2:FameBonus):int {
        if (param1.fameAdded > param2.fameAdded) {
            return -1;
        }
        return 1;
    }

    private function showBonuses():void {
        var i:int = 1;
        while (i <= 14) {
            var bonusConfig:FameBonus = this.totalFame.bonuses[i];
            if (bonusConfig == null) {
                this.bonusesList.push(FameBonusConfig.getBonus(i));
            } else {
                this.bonusesList.push(bonusConfig);
            }
            i = Number(i) + 1;
        }
        bonusConfig = this.totalFame.bonuses[16];
        if (bonusConfig == null) {
            this.bonusesList.push(FameBonusConfig.getBonus(16));
        } else {
            this.bonusesList.push(bonusConfig);
        }
        i = 18;
        while (i <= 22) {
            bonusConfig = this.totalFame.bonuses[i];
            if (bonusConfig == null) {
                this.bonusesList.push(FameBonusConfig.getBonus(i));
            } else {
                this.bonusesList.push(bonusConfig);
            }
            i = Number(i) + 1;
        }
        if (this.view.characterId == -1) {
            var level:int = this.hudModel.gameSprite.map.player_.level_;
        } else {
            level = this.player.getCharacterById(this.characterID).level();
        }
        this.bonusesList = this.bonusesList.sort(this.sortBonusesByLevel);
        var unlocked:Vector.<FameBonus> = this.bonusesList.filter(function (param1:FameBonus, param2:int, param3:Vector.<FameBonus>):Boolean {
            return level >= param1.level;
        });
        unlocked = unlocked.sort(this.sortBonusesByFame);
        var locked:Vector.<FameBonus> = this.bonusesList.filter(function (param1:FameBonus, param2:int, param3:Vector.<FameBonus>):Boolean {
            return level < param1.level;
        });
        this.bonusesList = unlocked.concat(locked);
        this.view.addStatLine(new StatsLine("Bonuses", "", "", 2));
        for each(var bonus:FameBonus in this.bonusesList) {
            this.view.addStatLine(new StatsLine(LineBuilder.getLocalizedStringFromKey("FameBonus." + bonus.name), bonus.fameAdded.toString(), LineBuilder.getLocalizedStringFromKey("FameBonus." + bonus.name + "Description") + "\n" + LineBuilder.getLocalizedStringFromKey("FameBonus.LevelRequirement", {"level": bonus.level}), 0, level < bonus.level));
        }
    }

    private function showInfo():void {
        this.showStats();
        this.showBonuses();
        this.showCompletedDungeons();
    }
}
}
