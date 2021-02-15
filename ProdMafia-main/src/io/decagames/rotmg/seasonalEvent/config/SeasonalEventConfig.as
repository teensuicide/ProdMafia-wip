package io.decagames.rotmg.seasonalEvent.config {
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.tasks.GetSeasonalEventTask;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
   import robotlegs.bender.framework.api.IConfig;
   
   public class SeasonalEventConfig implements IConfig {
       
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var injector:Injector;
      
      public function SeasonalEventConfig() {
         super();
      }
      
      public function configure() : void {
         this.injector.map(SeasonalEventModel).asSingleton();
         this.injector.map(GetSeasonalEventTask);
      }
   }
}
