package kabam.lib.tasks {
import org.osflash.signals.Signal;

public class DispatchSignalTask extends BaseTask {


    public function DispatchSignalTask(_arg_1:Signal, ...rest) {
        super();
        this.signal = _arg_1;
        this.params = rest;
    }
    private var signal:Signal;
    private var params:Array;

    override protected function startTask():void {
        this.signal.dispatch.apply(null, this.params);
        completeTask(true);
    }
}
}
