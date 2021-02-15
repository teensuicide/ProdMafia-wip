package kabam.lib.tasks {
public class TaskSequence extends BaseTask {


    public function TaskSequence() {
        super();
        this.tasks = new Vector.<Task>();
    }
    private var tasks:Vector.<Task>;
    private var index:int;
    private var continueOnFail:Boolean;

    override protected function startTask():void {
        this.index = 0;
        this.doNextTaskOrComplete();
    }

    override protected function onReset():void {
        var _local1:* = null;
        var _local3:int = 0;
        var _local2:* = this.tasks;
        for each(_local1 in this.tasks) {
            _local1.reset();
        }
    }

    public function getContinueOnFail():Boolean {
        return this.continueOnFail;
    }

    public function setContinueOnFail(_arg_1:Boolean):void {
        this.continueOnFail = _arg_1;
    }

    public function add(_arg_1:Task):void {
        this.tasks.push(_arg_1);
    }

    private function doNextTaskOrComplete():void {
        if (this.isAnotherTask()) {
            this.doNextTask();
        } else {
            completeTask(true);
        }
    }

    private function isAnotherTask():Boolean {
        return this.index < this.tasks.length;
    }

    private function doNextTask():void {
        var _local2:Number = this.index;
        this.index++;
        var _local1:Task = this.tasks[_local2];
        _local1.lastly.addOnce(this.onTaskFinished);
        _local1.start();
    }

    private function onTaskFinished(_arg_1:Task, _arg_2:Boolean, _arg_3:String):void {
        if (_arg_2 || this.continueOnFail) {
            this.doNextTaskOrComplete();
        } else {
            completeTask(false, _arg_3);
        }
    }
}
}
