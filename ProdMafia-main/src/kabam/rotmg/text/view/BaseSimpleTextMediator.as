package kabam.rotmg.text.view {
   import com.company.ui.BaseSimpleText;
   import kabam.rotmg.text.model.FontModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class BaseSimpleTextMediator extends Mediator {
       
      
      [Inject]
      public var view:BaseSimpleText;
      
      [Inject]
      public var model:FontModel;
      
      public function BaseSimpleTextMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc1_:String = this.model.getFont().getName();
         this.view.setFont(_loc1_);
      }
   }
}
