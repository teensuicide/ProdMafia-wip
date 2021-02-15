package kabam.lib.console.controller {
import kabam.lib.console.signals.ClearConsoleSignal;
import kabam.lib.console.signals.CopyConsoleTextSignal;
import kabam.lib.console.signals.ListActionsSignal;
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.signals.RemoveConsoleSignal;
import kabam.lib.console.vo.ConsoleAction;

public class AddDefaultConsoleActionsCommand {


    public function AddDefaultConsoleActionsCommand() {
        super();
    }
    [Inject]
    public var register:RegisterConsoleActionSignal;
    [Inject]
    public var listActions:ListActionsSignal;
    [Inject]
    public var clearConsole:ClearConsoleSignal;
    [Inject]
    public var removeConsole:RemoveConsoleSignal;
    [Inject]
    public var copyConsoleText:CopyConsoleTextSignal;

    public function execute():void {
        var _local4:ConsoleAction = new ConsoleAction();
        _local4.name = "list";
        _local4.description = "lists available console commands";
        var _local2:ConsoleAction = new ConsoleAction();
        _local2.name = "clear";
        _local2.description = "clears the console";
        var _local1:ConsoleAction = new ConsoleAction();
        _local1.name = "exit";
        _local1.description = "closes the console";
        var _local3:ConsoleAction = new ConsoleAction();
        _local3.name = "copy";
        _local3.description = "copies the contents of the console to the clipboard";
        this.register.dispatch(_local4, this.listActions);
        this.register.dispatch(_local2, this.clearConsole);
        this.register.dispatch(_local1, this.removeConsole);
        this.register.dispatch(_local3, this.copyConsoleText);
    }
}
}
