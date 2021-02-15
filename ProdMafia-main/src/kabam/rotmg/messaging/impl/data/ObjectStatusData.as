
package kabam.rotmg.messaging.impl.data {
import com.company.assembleegameclient.util.FreeList;

import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class ObjectStatusData {


   public var objectId_:int;

   public var pos_:WorldPosData;

   public var stats_:Vector.<StatData>;

   public function ObjectStatusData() {
      this.pos_ = new WorldPosData();
      this.stats_ = new Vector.<StatData>();
      super();
   }

   public function parseFromInput(param1:IDataInput) : void {
      var _local4:* = 0;
      this.objectId_ = CompressedInt.read(param1);
      this.pos_.parseFromInput(param1);
      var _local3:uint = this.stats_.length;
      var _local2:int = CompressedInt.read(param1);
      _local4 = uint(_local2);
      while(_local4 < _local3) {
         FreeList.deleteObject(this.stats_[_local4]);
         _local4++;
      }
      this.stats_.length = Math.min(_local2,this.stats_.length);
      while(this.stats_.length < _local2) {
         this.stats_.push(FreeList.newObject(StatData) as StatData);
      }
      _local4 = uint(0);
      while(_local4 < _local2) {
         this.stats_[_local4].parseFromInput(param1);
         _local4++;
      }
   }

   public function writeToOutput(param1:IDataOutput) : void {
      var _local3:* = 0;
      param1.writeInt(this.objectId_);
      this.pos_.writeToOutput(param1);
      param1.writeShort(this.stats_.length);
      var _local2:uint = this.stats_.length;
      _local3 = uint(0);
      while(_local3 < _local2) {
         this.stats_[_local3].writeToOutput(param1);
         _local3++;
      }
   }

   public function toString() : String {
      return "objectId_: " + this.objectId_ + " pos_: " + this.pos_ + " stats_: " + this.stats_;
   }
}
}
