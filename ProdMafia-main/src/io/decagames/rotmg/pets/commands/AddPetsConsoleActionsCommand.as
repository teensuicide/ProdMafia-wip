package io.decagames.rotmg.pets.commands {
   import io.decagames.rotmg.pets.signals.OpenCaretakerQueryDialogSignal;
   import kabam.lib.console.signals.RegisterConsoleActionSignal;
   import kabam.lib.console.vo.ConsoleAction;
   
   public class AddPetsConsoleActionsCommand {
       
      
      [Inject]
      public var register:RegisterConsoleActionSignal;
      
      [Inject]
      public var openCaretakerQuerySignal:OpenCaretakerQueryDialogSignal;
      
      public function AddPetsConsoleActionsCommand() {
         super();
      }
      
      public function execute() : void {
         var _loc1_:* = null;
         _loc1_ = new ConsoleAction();
         _loc1_.name = "caretaker";
         _loc1_.description = "opens the pets caretaker query UI";
         this.register.dispatch(_loc1_,this.openCaretakerQuerySignal);
      }
   }
}
