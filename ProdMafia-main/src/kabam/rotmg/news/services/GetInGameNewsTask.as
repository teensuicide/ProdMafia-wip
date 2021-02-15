package kabam.rotmg.news.services {
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.news.model.InGameNews;
   import kabam.rotmg.news.model.NewsModel;
   import kabam.rotmg.news.view.NewsModal;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GetInGameNewsTask extends BaseTask {
       
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var model:NewsModel;
      
      [Inject]
      public var addToQueueSignal:AddPopupToStartupQueueSignal;
      
      [Inject]
      public var openDialogSignal:OpenDialogSignal;
      
      private var requestData:Object;
      
      public function GetInGameNewsTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.requestData = this.makeRequestData();
         this.sendRequest();
      }
      
      public function makeRequestData() : Object {
         return {};
      }
      
      private function sendRequest() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/inGameNews/getNews",this.requestData);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.parseNews(param2);
         } else {
            completeTask(true);
         }
      }
      
      private function parseNews(param1:String) : void {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         try {
            _loc7_ = JSON.parse(param1);
            _loc4_ = 0;
            _loc5_ = _loc7_;
            var _loc10_:int = 0;
            var _loc9_:* = _loc7_;
            for each(_loc6_ in _loc7_) {
               _loc3_ = new InGameNews();
               _loc3_.newsKey = _loc6_.newsKey;
               _loc3_.showAtStartup = _loc6_.showAtStartup;
               _loc3_.showInModes = _loc6_.showInModes;
               _loc3_.startTime = _loc6_.startTime;
               _loc3_.text = _loc6_.text;
               _loc3_.title = _loc6_.title;
               _loc3_.platform = _loc6_.platform;
               _loc3_.weight = _loc6_.weight;
               this.model.addInGameNews(_loc3_);
            }
         }
         catch(e:Error) {
         }
         var _loc2_:InGameNews = this.model.getFirstNews();
         if(_loc2_ && _loc2_.showAtStartup && this.model.hasUpdates()) {
            this.addToQueueSignal.dispatch("news_popup",this.openDialogSignal,-1,new NewsModal(true));
         }
         completeTask(true);
      }
   }
}
