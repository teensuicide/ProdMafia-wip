package kabam.lib.tasks {
public class TaskGroup extends BaseTask {


    public function TaskGroup() {
        super();
        this.tasks = new Vector.<BaseTask>();
    }
    private var tasks:Vector.<BaseTask>;
    private var pending:int;

    override protected function startTask():void {
        this.pending = this.tasks.length;
        if (this.pending > 0) {
            this.startAllTasks();
        } else {
            completeTask(true);
        }
    }

    override protected function onReset():void {
        var _local1:* = null;
        var _local3:int = 0;
        var _local2:* = this.tasks;
        for each(_local1 in this.tasks) {
            _local1.reset();
        }
    }

    public function add(_arg_1:BaseTask):void {
        this.tasks.push(_arg_1);
    }

    public function toString():String {
        return "[TaskGroup(" + this.tasks.join(",") + ")]";
    }

    private function startAllTasks():void {
        var _local1:int = this.pending;
        while (true) {
            _local1--;
            if (!_local1) {
                break;
            }
            this.tasks[_local1].lastly.addOnce(this.onTaskFinished);
            this.tasks[_local1].start();
        }
    }

    private function onTaskFinished(_arg_1:BaseTask, _arg_2:Boolean, _arg_3:String):void {
        if (_arg_2) {
            var _local4:* = this.pending - 1;
            this.pending--;
            if (_local4 == 0) {
                completeTask(true);
            }
        } else {
            completeTask(false, _arg_3);
        }
    }
}
}
