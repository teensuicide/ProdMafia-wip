package kabam.rotmg.assets.task {
   import com.company.assembleegameclient.objects.particles.OrbEffect;
   import com.company.assembleegameclient.objects.particles.ThunderEffect;
   import kabam.lib.tasks.BaseTask;
   
   public class InitializeEffects extends BaseTask {
       
      
      public function InitializeEffects() {
         super();
      }
      
      override protected function startTask() : void {
         ThunderEffect.initialize();
         OrbEffect.initialize();
         completeTask(true);
      }
   }
}
