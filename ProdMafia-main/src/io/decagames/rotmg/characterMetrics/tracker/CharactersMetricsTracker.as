package io.decagames.rotmg.characterMetrics.tracker {
import com.hurlant.util.Base64;
import flash.utils.Dictionary;
import flash.utils.IDataInput;
import io.decagames.rotmg.characterMetrics.data.CharacterMetricsData;

import kabam.rotmg.messaging.impl.data.CompressedInt;

public class CharactersMetricsTracker {

    public static const STATS_SIZE:int = 5;


    private var charactersStats:Dictionary;

    private var _lastUpdate:Date;

    public function CharactersMetricsTracker() {
        super();
    }

    public function get lastUpdate() : Date {
        return this._lastUpdate;
    }

    public function setBinaryStringData(param1:int, param2:String) : void {
        var _loc5_:RegExp = /-/g;
        var _loc4_:RegExp = /_/g;
        var _loc3_:int = 4 - param2.length % 4;
        while(true) {
            _loc3_--;
            if(_loc3_) {
                param2 = param2 + "=";
                continue;
            }
            break;
        }
        param2 = param2.replace(_loc5_,"+").replace(_loc4_,"/");
        this.setBinaryData(param1,Base64.decodeToByteArray(param2));
    }

    public function setBinaryData(charId:int, data:IDataInput) : void {
        if (!this.charactersStats)
            this.charactersStats = new Dictionary();

        if (!this.charactersStats[charId])
            this.charactersStats[charId] = new CharacterMetricsData();

        var bytes:int = data.bytesAvailable;
        while (data.bytesAvailable > bytes - 20)
            trace("trail", data.readByte());
        while (data.bytesAvailable > 0)
            trace("stats", CompressedInt.read(data));
        //trace("test", CompressedInt.read(param2))
        /*while(param2.bytesAvailable >= 5) {
           _loc4_ = CompressedInt.read(param2);
           _loc3_ = CompressedInt.read(param2);
           trace("stats", _loc4_, _loc3_)
           this.charactersStats[param1].setStat(_loc4_,_loc3_);
        }*/
        this._lastUpdate = new Date();
    }

    public function getCharacterStat(param1:int, param2:int) : int {
        if(!this.charactersStats) {
            this.charactersStats = new Dictionary();
        }
        if(!this.charactersStats[param1]) {
            return 0;
        }
        return this.charactersStats[param1].getStat(param2);
    }

    public function parseCharListData(param1:XML) : void {
        var _loc2_:* = null;
        for each(_loc2_ in param1.Char) {
            this.setBinaryStringData(int(_loc2_.@id),_loc2_.PCStats);
        }
    }
}
}
