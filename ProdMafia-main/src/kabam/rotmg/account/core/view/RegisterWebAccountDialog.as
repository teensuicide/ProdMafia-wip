package kabam.rotmg.account.core.view {
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.util.EmailValidator;

import flash.events.MouseEvent;

import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class RegisterWebAccountDialog extends Frame {


    public function RegisterWebAccountDialog() {
        register = new Signal(AccountData);
        cancel = new Signal();
        super("RegisterWebAccountDialog.title", "RegisterWebAccountDialog.leftButton", "RegisterWebAccountDialog.rightButton", "/kongregateRegisterAccount");
        this.createAssets();
        this.enableForTabBehavior();
        this.addEventListeners();
    }
    public var register:Signal;
    public var cancel:Signal;
    private var emailInput:TextInputField;
    private var passwordInput:TextInputField;
    private var retypePasswordInput:TextInputField;
    private var checkbox:CheckBoxField;

    public function showError(_arg_1:String):void {
        this.emailInput.setError(_arg_1);
    }

    private function addEventListeners():void {
        leftButton_.addEventListener("click", this.onCancel);
        rightButton_.addEventListener("click", this.onRegister);
    }

    private function createAssets():void {
        this.emailInput = new TextInputField("RegisterWebAccountDialog.email", false);
        addTextInputField(this.emailInput);
        this.passwordInput = new TextInputField("RegisterWebAccountDialog.password", true);
        addTextInputField(this.passwordInput);
        this.retypePasswordInput = new TextInputField("RegisterWebAccountDialog.retypePassword", true);
        addTextInputField(this.retypePasswordInput);
        this.checkbox = new CheckBoxField("", false);
        this.checkbox.setTextStringBuilder(new LineBuilder().setParams("RegisterWebAccountDialog.checkbox", {
            "link": "<font color=\"#7777EE\"><a href=\"http://legal.decagames.com/tos/\" target=\"_blank\">",
            "_link": "</a></font>."
        }));
        addCheckBox(this.checkbox);
    }

    private function enableForTabBehavior():void {
        this.emailInput.inputText_.tabIndex = 1;
        this.passwordInput.inputText_.tabIndex = 2;
        this.retypePasswordInput.inputText_.tabIndex = 3;
        this.checkbox.checkBox_.tabIndex = 4;
        leftButton_.tabIndex = 6;
        rightButton_.tabIndex = 5;
        this.emailInput.inputText_.tabEnabled = true;
        this.passwordInput.inputText_.tabEnabled = true;
        this.retypePasswordInput.inputText_.tabEnabled = true;
        this.checkbox.checkBox_.tabEnabled = true;
        leftButton_.tabEnabled = true;
        rightButton_.tabEnabled = true;
    }

    private function isCheckboxChecked():Boolean {
        var _local1:Boolean = this.checkbox.isChecked();
        if (!_local1) {
            this.checkbox.setError("RegisterWebAccountDialog.checkboxError");
        }
        return _local1;
    }

    private function isEmailValid():Boolean {
        var _local1:Boolean = EmailValidator.isValidEmail(this.emailInput.text());
        if (!_local1) {
            this.emailInput.setError("WebRegister.invalid_email_address");
        }
        return _local1;
    }

    private function isPasswordValid():Boolean {
        var _local1:* = this.passwordInput.text().length >= 5;
        if (!_local1) {
            this.passwordInput.setError("RegisterWebAccountDialog.shortError");
        }
        return _local1;
    }

    private function isPasswordVerified():Boolean {
        var _local1:* = this.passwordInput.text() == this.retypePasswordInput.text();
        if (!_local1) {
            this.retypePasswordInput.setError("RegisterWebAccountDialog.matchError");
        }
        return _local1;
    }

    private function onCancel(_arg_1:MouseEvent):void {
        this.cancel.dispatch();
    }

    private function onRegister(_arg_1:MouseEvent):void {
        var _local2:* = null;
        if (this.isEmailValid() && this.isPasswordValid() && this.isPasswordVerified() && this.isCheckboxChecked()) {
            _local2 = new AccountData();
            _local2.username = this.emailInput.text();
            _local2.password = this.passwordInput.text();
            this.register.dispatch(_local2);
        }
    }
}
}
