
package kabam.rotmg.messaging.impl.incoming {
import com.company.assembleegameclient.util.FreeList;

import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.CompressedInt;
import kabam.rotmg.messaging.impl.data.GroundTileData;
import kabam.rotmg.messaging.impl.data.ObjectData;

public class Update extends IncomingMessage {


   public var tiles_:Vector.<GroundTileData>;

   public var newObjs_:Vector.<ObjectData>;

   public var drops_:Vector.<int>;

   public function Update(param1:uint, param2:Function) {
      this.tiles_ = new Vector.<GroundTileData>();
      this.newObjs_ = new Vector.<ObjectData>();
      this.drops_ = new Vector.<int>();
      super(param1,param2);
   }

   override public function parseFromInput(data:IDataInput) : void {
      var newLen:int = CompressedInt.read(data);
      var curLen:uint = this.tiles_.length;
      var i:int = newLen;
      for (; i < curLen; i++)
         FreeList.deleteObject(this.tiles_[i]);

      this.tiles_.length = Math.min(newLen, curLen);
      while (this.tiles_.length < newLen)
         this.tiles_.push(FreeList.newObject(GroundTileData) as GroundTileData);

      for (i = 0; i < newLen; i++)
         this.tiles_[i].parseFromInput(data);

      this.newObjs_.length = 0;
      newLen = CompressedInt.read(data);
      curLen = this.newObjs_.length;
      for (i = newLen; i < curLen; i++)
         FreeList.deleteObject(this.newObjs_[i]);

      this.newObjs_.length = Math.min(newLen,curLen);
      while (this.newObjs_.length < newLen)
         this.newObjs_.push(FreeList.newObject(ObjectData) as ObjectData);

      for (i = 0; i < newLen; i++)
         this.newObjs_[i].parseFromInput(data);

      this.drops_.length = 0;
      newLen = CompressedInt.read(data);
      for (i = 0; i < newLen; i++)
         this.drops_.push(CompressedInt.read(data));
   }

   override public function toString() : String {
      return formatToString("UPDATE","tiles_","newObjs_","drops_");
   }
}
}
