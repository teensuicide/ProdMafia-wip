package io.decagames.rotmg.seasonalEvent.tasks {
import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;

import robotlegs.bender.framework.api.ILogger;

public class GetLegacySeasonsTask extends BaseTask {


    public function GetLegacySeasonsTask() {
        super();
    }
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var seasonalEventModel:SeasonalEventModel;

    override protected function startTask():void {
        this.logger.info("GetLegacySeasons start");
        var _local1:Object = this.account.getCredentials();
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/fame/challengerSeasonList", _local1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onSeasonalEvent(_arg_2);
        } else {
            this.onTextError(_arg_2);
        }
    }

    private function onTextError(_arg_1:String):void {
        this.logger.info("GetLegacySeasons error");
        completeTask(true);
    }

    private function onSeasonalEvent(_arg_1:String):void {
        var _local3:* = null;
        var _local2:* = _arg_1;
        try {
            _local3 = new XML(_local2);
        } catch (e:Error) {
            logger.error("Error parsing seasonal data: " + _local2);
            completeTask(true);
            return;
        }
        this.logger.info("GetLegacySeasons update");
        this.logger.info(_local3);
        this.seasonalEventModel.parseLegacySeasonsData(_local3);
        completeTask(true);
    }
}
}
