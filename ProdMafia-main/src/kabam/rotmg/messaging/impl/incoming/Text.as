package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   
   public class Text extends IncomingMessage {
       
      
      public var name_:String;
      
      public var objectId_:int;
      
      public var numStars_:int;
      
      public var bubbleTime_:uint;
      
      public var recipient_:String;
      
      public var text_:String;
      
      public var cleanText_:String;
      
      public var isSupporter:Boolean = false;
      
      public var starBg:int;
      
      public function Text(param1:uint, param2:Function) {
         this.name_ = new String();
         this.text_ = new String();
         this.cleanText_ = new String();
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void {
         this.name_ = param1.readUTF();
         this.objectId_ = param1.readInt();
         this.numStars_ = param1.readUnsignedShort();
         this.bubbleTime_ = param1.readUnsignedByte();
         this.recipient_ = param1.readUTF();
         this.text_ = param1.readUTF();
         this.cleanText_ = param1.readUTF();
         this.isSupporter = param1.readBoolean();
         this.starBg = param1.readInt();
      }
      
      override public function toString() : String {
         return formatToString("TEXT","name_","objectId_","numStars_","bubbleTime_","recipient_","text_","cleanText_","isSupporter","starBg");
      }
   }
}
