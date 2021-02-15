package kabam.rotmg.account.core.view {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class RegisterPromptDialog extends Dialog {
       
      
      public var cancel:Signal;
      
      public var register:Signal;
      
      public function RegisterPromptDialog(param1:String, param2:Object = null) {
         super("RegisterPrompt.notRegistered",param1,"RegisterPrompt.left","RegisterPrompt.right","/needRegister",param2);
         this.cancel = new NativeMappedSignal(this,"dialogLeftButton");
         this.register = new NativeMappedSignal(this,"dialogRightButton");
      }
   }
}
