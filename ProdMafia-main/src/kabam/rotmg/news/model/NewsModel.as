package kabam.rotmg.news.model {
   import com.company.assembleegameclient.parameters.Parameters;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
   import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
   import kabam.rotmg.news.view.NewsModalPage;
   
   public class NewsModel {
       
      
      private const COUNT:int = 3;
      
      [Inject]
      public var update:NewsDataUpdatedSignal;
      
      [Inject]
      public var updateNoParams:NewsButtonRefreshSignal;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      public var news:Vector.<NewsCellVO>;
      
      public var modalPageData:Vector.<NewsCellVO>;
      
      private var inGameNews:Vector.<InGameNews>;
      
      public function NewsModel() {
         inGameNews = new Vector.<InGameNews>();
         super();
      }
      
      public function get numberOfNews() : int {
         return this.inGameNews.length;
      }
      
      public function addInGameNews(param1:InGameNews) : void {
         this.inGameNews.push(param1)
         this.sortNews();
      }
      
      public function clearNews() : void {
         if(this.inGameNews) {
            this.inGameNews.length = 0;
         }
      }

      
      public function markAsRead() : void {
         var _loc1_:InGameNews = this.getFirstNews();
         if(_loc1_ != null) {
            Parameters.data["lastNewsKey"] = _loc1_.newsKey;
            Parameters.save();
         }
      }
      
      public function hasUpdates() : Boolean {
         var _loc1_:InGameNews = this.getFirstNews();
         return !(_loc1_ == null || Parameters.data["lastNewsKey"] == _loc1_.newsKey);
      }
      
      public function getFirstNews() : InGameNews {
         if(this.inGameNews && this.inGameNews.length > 0) {
            return this.inGameNews[0];
         }
         return null;
      }
      
      public function initNews() : void {
         var _loc1_:int = 0;
         this.news = new Vector.<NewsCellVO>(3,true);
         while(_loc1_ < 3) {
            this.news[_loc1_] = new DefaultNewsCellVO(_loc1_);
            _loc1_++;
         }
      }
      
      public function updateNews(param1:Vector.<NewsCellVO>) : void {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         this.initNews();
         var _loc2_:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
         this.modalPageData = new Vector.<NewsCellVO>(4,true);
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc5_ in param1) {
            if(_loc5_.slot <= 3) {
               _loc2_.push(_loc5_);
            } else {
               _loc4_ = _loc5_.slot - 4;
               _loc3_ = _loc4_ + 1;
               this.modalPageData[_loc4_] = _loc5_;
               if(Parameters.data["newsTimestamp" + _loc3_] != _loc5_.endDate) {
                  Parameters.data["newsTimestamp" + _loc3_] = _loc5_.endDate;
                  Parameters.data["hasNewsUpdate" + _loc3_] = true;
               }
            }
         }
         this.sortByPriority(_loc2_);
         this.update.dispatch(this.news);
         this.updateNoParams.dispatch();
      }
      
      public function hasValidNews() : Boolean {
         return this.news[0] != null && this.news[1] != null && this.news[2] != null;
      }
      
      public function hasValidModalNews() : Boolean {
         return this.inGameNews.length > 0;
      }
      
      public function getModalPage(param1:int) : NewsModalPage {
         var _loc2_:* = null;
         if(this.hasValidModalNews()) {
            _loc2_ = this.inGameNews[param1 - 1];
            return new NewsModalPage(_loc2_.title,_loc2_.text);
         }
         return new NewsModalPage("No new information","Please check back later.");
      }
      
      private function sortNews() : void {
         this.inGameNews.sort(function(param1:InGameNews, param2:InGameNews):int {
            if(param1.weight > param2.weight) {
               return -1;
            }
            if(param1.weight == param2.weight) {
               return 0;
            }
            return 1;
         });
      }
      
      private function sortByPriority(param1:Vector.<NewsCellVO>) : void {
         var _loc2_:* = null;
         var _loc3_:* = param1;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(_loc2_ in param1) {
            if(this.isNewsTimely(_loc2_) && this.isValidForPlatformGlobal(_loc2_)) {
               this.prioritize(_loc2_);
            }
         }
      }
      
      private function prioritize(param1:NewsCellVO) : void {
         var _loc2_:uint = param1.slot - 1;
         if(this.news[_loc2_]) {
            param1 = this.comparePriority(this.news[_loc2_],param1);
         }
         this.news[_loc2_] = param1;
      }
      
      private function comparePriority(param1:NewsCellVO, param2:NewsCellVO) : NewsCellVO {
         return param1.priority < param2.priority?param1:param2;
      }
      
      private function isNewsTimely(param1:NewsCellVO) : Boolean {
         var _loc2_:Number = new Date().getTime();
         return param1.startDate < _loc2_ && _loc2_ < param1.endDate;
      }
      
      private function isValidForPlatformGlobal(param1:NewsCellVO) : Boolean {
         return param1.networks.indexOf("rotmg") != -1;
      }
      
      private function isValidForPlatform(param1:InGameNews) : Boolean {
         return param1.platform.indexOf("rotmg") != -1;
      }
   }
}
