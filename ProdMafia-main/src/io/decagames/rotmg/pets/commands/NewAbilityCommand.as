package io.decagames.rotmg.pets.commands {
   import com.company.assembleegameclient.editor.Command;
   import io.decagames.rotmg.pets.popup.ability.NewAbilityUnlockedDialog;
   import io.decagames.rotmg.pets.utils.PetAbilityDisplayIDGetter;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   
   public class NewAbilityCommand extends Command {
       
      
      [Inject]
      public var openDialog:ShowPopupSignal;
      
      [Inject]
      public var displayIDGetter:PetAbilityDisplayIDGetter;
      
      [Inject]
      public var abilityID:int;
      
      public function NewAbilityCommand() {
         super();
      }
      
      override public function execute() : void {
         this.openDialog.dispatch(new NewAbilityUnlockedDialog(this.displayIDGetter.getID(this.abilityID)));
      }
   }
}
