package kabam.rotmg.chat.view {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.assembleegameclient.util.StageProxy;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.chat.model.ChatModel;
   import kabam.rotmg.text.model.FontModel;
   import kabam.rotmg.text.view.BitmapTextFactory;
   
   public class ChatListItemFactory {
      
      private static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      private static const SERVER:String = "";
      
      private static const CLIENT:String = "*Client*";
      
      private static const HELP:String = "*Help*";
      
      private static const ERROR:String = "*Error*";
      
      private static const GUILD:String = "*Guild*";
      
      private static const SYNC:String = "*Sync*";
      
      private static const ALERT:String = "*Alert*";
      
      private static const testField:TextField = makeTestTextField();
       
      
      [Inject]
      public var model:ChatModel;
      
      [Inject]
      public var fontModel:FontModel;
      
      [Inject]
      public var stageProxy:StageProxy;
      
      private var message:ChatMessage;
      
      private var buffer:Vector.<DisplayObject>;
      
      private var delete_:Vector.<DisplayObject>;
      
      public function ChatListItemFactory() {
         delete_ = new Vector.<DisplayObject>();
         super();
      }
      
      public static function isTradeMessage(param1:int, param2:int, param3:String) : Boolean {
         return (param1 == -1 || param2 == -1) && param3.search("/trade") != -1;
      }
      
      public static function isGuildMessage(param1:String) : Boolean {
         return param1 == "*Guild*";
      }
      
      private static function makeTestTextField() : TextField {
         var _loc2_:TextField = new TextField();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.size = 15;
         _loc1_.bold = true;
         _loc2_.defaultTextFormat = _loc1_;
         return _loc2_;
      }
      
      public function make(param1:ChatMessage, param2:Boolean = false) : ChatListItem {
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc7_:* = 0;
         var _loc5_:Boolean = false;
         this.message = param1;
         if(this.buffer != null) {
            var _loc11_:int = 0;
            var _loc10_:* = buffer;
            for each(var _loc3_ in buffer) {
               delete_.push(_loc3_);
            }
         }
         this.buffer = new Vector.<DisplayObject>();
         this.setTFonTestField();
         this.makeStarsIcon();
         this.makeWhisperText();
         this.makeNameText();
         this.makeMessageText();
         var _loc6_:Boolean = param1.numStars == -1 || param1.objectId == -1;
         var _loc9_:* = param1.name;
         if(_loc6_ && param1.text.search("/trade ") != -1) {
            _loc4_ = _loc4_ + 7;
            _loc8_ = "";
            _loc7_ = _loc4_;
            _loc4_ = _loc4_ + 10;
            while(_loc7_ < _loc4_) {
               if(param1.text.charAt(_loc7_) != "\"") {
                  _loc8_ = _loc8_ + param1.text.charAt(_loc7_);
                  _loc7_++;
                  continue;
               }
               break;
            }
            _loc9_ = _loc8_;
            _loc5_ = true;
         }
         return new ChatListItem(this.buffer,this.model.bounds.width,this.model.lineHeight,param2,param1.objectId,_loc9_,param1.recipient == "*Guild*",_loc5_);
      }
      
      public function dispose() : void {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:uint = this.delete_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_) {
            _loc1_ = delete_[_loc2_] as Bitmap;
            if(_loc1_) {
               _loc1_.bitmapData.dispose();
               _loc1_.bitmapData = null;
               _loc1_ = null;
               delete_[_loc2_] = null;
            }
            _loc2_++;
         }
         this.delete_.length = 0;
      }
      
      private function makeStarsIcon() : void {
         var _loc2_:int = this.message.numStars;
         if(_loc2_ >= 0) {
            this.buffer.push(FameUtil.numStarsToIcon(_loc2_));
         }
      }
      
      private function makeWhisperText() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(this.message.isWhisper && !this.message.isToMe) {
            _loc2_ = "To: ";
            _loc1_ = this.getBitmapData(_loc2_,61695);
            this.buffer.push(new Bitmap(_loc1_));
         }
      }
      
      private function makeNameText() : void {
         if(!this.isSpecialMessageType()) {
            this.bufferNameText();
         }
      }
      
      private function isSpecialMessageType() : Boolean {
         var _loc1_:String = this.message.name;
         return _loc1_ == "" || _loc1_ == "*Client*" || _loc1_ == "*Help*" || _loc1_ == "*Error*" || _loc1_ == "*Guild*";
      }
      
      private function bufferNameText() : void {
         var _loc1_:BitmapData = this.getBitmapData(this.processName(),this.getNameColor());
         this.buffer.push(new Bitmap(_loc1_));
      }
      
      private function processName() : String {
         var _loc1_:String = this.message.isWhisper && !this.message.isToMe?this.message.recipient:this.message.name;
         if(_loc1_.charAt(0) == "#" || _loc1_.charAt(0) == "@") {
            _loc1_ = _loc1_.substr(1);
         }
         return "<" + _loc1_ + ">";
      }
      
      private function makeMessageText() : void {
         var _loc2_:int = 0;
         var _loc1_:Array = this.message.text.split("\n");
         var _loc3_:uint = _loc1_.length;
         if(_loc3_ > 0) {
            this.makeNewLineFreeMessageText(_loc1_[0],true);
            _loc2_ = 1;
            while(_loc2_ < _loc3_) {
               this.makeNewLineFreeMessageText(_loc1_[_loc2_],false);
               _loc2_++;
            }
         }
      }
      
      private function makeNewLineFreeMessageText(param1:String, param2:Boolean) : void {
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:* = param1;
         if(param2) {
            _loc11_ = 0;
            _loc12_ = this.buffer;
            var _loc15_:int = 0;
            var _loc14_:* = this.buffer;
            for each(_loc6_ in this.buffer) {
               _loc13_ = _loc13_ + _loc6_.width;
            }
            _loc10_ = _loc4_.length;
            testField.text = _loc4_;
            while(testField.textWidth >= this.model.bounds.width - _loc13_) {
               _loc10_ = _loc10_ - 10;
               testField.text = _loc4_.substr(0,_loc10_);
            }
            if(_loc10_ < _loc4_.length) {
               _loc5_ = _loc4_.substr(0,_loc10_).lastIndexOf(" ");
               _loc10_ = _loc5_ == 0 || _loc5_ == -1?_loc10_:_loc5_ + 1;
            }
            this.makeMessageLine(_loc4_.substr(0,_loc10_));
         }
         var _loc7_:int = _loc4_.length;
         if(_loc7_ > _loc10_) {
            _loc3_ = uint(_loc4_.length);
            _loc8_ = _loc10_;
            while(_loc8_ < _loc7_) {
               testField.text = _loc4_.substr(_loc8_,_loc3_);
               while(testField.textWidth >= this.model.bounds.width) {
                  _loc3_ = uint(_loc3_ - 2);
                  testField.text = _loc4_.substr(_loc8_,_loc3_);
               }
               _loc9_ = _loc3_;
               if(_loc4_.length > _loc8_ + _loc3_) {
                  _loc9_ = _loc4_.substr(_loc8_,_loc3_).lastIndexOf(" ");
                  _loc9_ = _loc9_ == 0 || _loc9_ == -1?_loc3_:_loc9_ + 1;
               }
               this.makeMessageLine(_loc4_.substr(_loc8_,_loc9_));
               _loc8_ = int(_loc8_ + _loc9_);
            }
         }
      }
      
      private function makeMessageLine(param1:String) : void {
         var _loc2_:BitmapData = this.getBitmapData(param1,this.getTextColor());
         this.buffer.push(new Bitmap(_loc2_));
      }
      
      private function getNameColor() : uint {
         if(this.message.name.charAt(0) == "#") {
            return 16754688;
         }
         if(this.message.name.charAt(0) == "@") {
            return 16776960;
         }
         if(this.message.recipient == "*Guild*") {
            return 10944349;
         }
         if(this.message.recipient != "") {
            return 61695;
         }
         if(this.message.isFromSupporter) {
            return 13395711;
         }
         return 65280;
      }
      
      private function getTextColor() : uint {
         var _loc1_:String = this.message.name;
         if(_loc1_ == "") {
            return 16776960;
         }
         if(_loc1_ == "*Client*") {
            return 255;
         }
         if(_loc1_ == "*Help*") {
            return 16734981;
         }
         if(_loc1_ == "*Error*") {
            return 16711680;
         }
         if(_loc1_ == "*Sync*") {
            return 1168896;
         }
         if(_loc1_.charAt(0) == "@") {
            return 16776960;
         }
         if(this.message.recipient == "*Guild*") {
            return 10944349;
         }
         if(this.message.recipient != "") {
            return 61695;
         }
         return 16777215;
      }
      
      private function getBitmapData(param1:String, param2:uint) : BitmapData {
         var _loc5_:String = this.stageProxy.getQuality();
         var _loc4_:Boolean = Parameters.data.forceChatQuality;
         _loc4_ && this.stageProxy.setQuality("high");
         var _loc3_:BitmapData = BitmapTextFactory.make(param1,14,param2,true,IDENTITY_MATRIX,true);
         _loc4_ && this.stageProxy.setQuality(_loc5_);
         return _loc3_;
      }
      
      private function setTFonTestField() : void {
         var _loc1_:TextFormat = testField.getTextFormat();
         _loc1_.font = this.fontModel.getFont().getName();
         testField.defaultTextFormat = _loc1_;
      }
   }
}
