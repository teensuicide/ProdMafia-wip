package io.decagames.rotmg.pets.commands {
   import io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialog;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   
   public class OpenCaretakerQueryDialogCommand {
       
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      public function OpenCaretakerQueryDialogCommand() {
         super();
      }
      
      public function execute() : void {
         var _loc1_:CaretakerQueryDialog = new CaretakerQueryDialog();
         this.openDialog.dispatch(_loc1_);
      }
   }
}
