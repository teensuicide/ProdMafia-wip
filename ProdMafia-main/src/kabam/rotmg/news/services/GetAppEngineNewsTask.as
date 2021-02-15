package kabam.rotmg.news.services {
   import com.company.assembleegameclient.util.TimeUtil;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.language.model.LanguageModel;
   import kabam.rotmg.news.model.NewsCellLinkType;
   import kabam.rotmg.news.model.NewsCellVO;
   import kabam.rotmg.news.model.NewsModel;
   
   public class GetAppEngineNewsTask extends BaseTask implements GetNewsTask {
      
      private static const TEN_MINUTES:int = 600;
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var model:NewsModel;
      
      [Inject]
      public var languageModel:LanguageModel;
      
      private var lastRan:int = -1;
      
      private var numUpdateAttempts:int = 0;
      
      private var updateCooldown:int = 600;
      
      public function GetAppEngineNewsTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.numUpdateAttempts++;
         var _loc1_:Number = TimeUtil.getTrueTime() * 0.001;
         if(this.lastRan == -1 || this.lastRan + this.updateCooldown < _loc1_) {
            this.lastRan = _loc1_;
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/app/globalNews",{"language":this.languageModel.getLanguage()});
         } else {
            completeTask(true);
            reset();
         }
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onNewsRequestDone(param2);
         }
         completeTask(param1,param2);
         reset();
      }
      
      private function onNewsRequestDone(param1:String) : void {
         var _loc2_:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
         var _loc3_:Object = JSON.parse(param1);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_) {
            _loc2_.push(this.returnNewsCellVO(_loc4_));
         }
         this.model.updateNews(_loc2_);
      }
      
      private function returnNewsCellVO(param1:Object) : NewsCellVO {
         var _loc2_:NewsCellVO = new NewsCellVO();
         _loc2_.headline = param1.title;
         _loc2_.imageURL = param1.image;
         _loc2_.linkDetail = param1.linkDetail;
         _loc2_.startDate = param1.startTime;
         _loc2_.endDate = param1.endTime;
         _loc2_.linkType = NewsCellLinkType.parse(param1.linkType);
         _loc2_.networks = param1.platform.split(",");
         _loc2_.priority = param1.priority;
         _loc2_.slot = param1.slot;
         return _loc2_;
      }
   }
}
