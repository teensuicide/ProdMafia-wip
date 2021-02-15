package kabam.rotmg.appengine.impl {
   import kabam.lib.console.signals.ConsoleWatchSignal;
   
   public class AppEngineRequestStats {
       
      
      private const nameMap:Object = {};
      
      [Inject]
      public var watch:ConsoleWatchSignal;
      
      public function AppEngineRequestStats() {
         super();
      }
      
      public function recordStats(param1:String, param2:Boolean, param3:int) : void {
         var _loc4_:* = this.nameMap[param1] || new StatsWatch(param1);
         this.nameMap[param1] = _loc4_;
         var _loc5_:StatsWatch = _loc4_;
         _loc5_.addResponse(param2,param3);
         this.watch.dispatch(_loc5_);
      }
   }
}

import kabam.lib.console.model.Watch;

class StatsWatch extends Watch {
   
   private static const STATS_PATTERN:String = "[APPENGINE STATS] [0xFFEE00:{/x={MEAN}ms, ok={OK}/{COUNT}} {NAME}]";
   
   private static const MEAN:String = "{MEAN}";
   
   private static const COUNT:String = "{COUNT}";
   
   private static const OK:String = "{OK}";
   
   private static const NAME:String = "{NAME}";
    
   
   private var count:int;
   
   private var time:int;
   
   private var mean:int;
   
   private var ok:int;
   
   function StatsWatch(param1:String) {
      super(param1,"");
      this.count = 0;
      this.ok = 0;
      this.time = 0;
   }
   
   public function addResponse(param1:Boolean, param2:int) : void {
      var _loc3_:* = undefined;
      param1 && _loc3_;
      this.time = this.time + param2;
      _loc3_ = this.count + 1;
      this.count++;
      this.mean = this.time / _loc3_;
      data = this.report();
   }
   
   private function report() : String {
      return "[APPENGINE STATS] [0xFFEE00:{/x={MEAN}ms, ok={OK}/{COUNT}} {NAME}]".replace("{MEAN}",this.mean).replace("{COUNT}",this.count).replace("{OK}",this.ok).replace("{NAME}",name);
   }
}
