package kabam.rotmg.news.model {
   public class DefaultNewsCellVO extends NewsCellVO {
       
      
      public function DefaultNewsCellVO(param1:int) {
         super();
         imageURL = "";
         linkDetail = param1 == 0?"https://www.reddit.com/r/RotMG/search?sort=new&restrict_sr=on&q=flair%3AOfficial%2BDeca":"https://goo.gl/DXwAbW";
         headline = param1 == 0?"Official Deca Posts on Reddit":"Join us on Facebook!";
         startDate = new Date().getTime() - 1000000000;
         endDate = new Date().getTime() + 1000000000;
         networks = ["kabam.com","kongregate","steam","rotmg"];
         linkType = NewsCellLinkType.OPENS_LINK;
         priority = 999999;
         slot = param1;
      }
   }
}
