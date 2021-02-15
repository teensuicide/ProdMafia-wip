package com.company.assembleegameclient.editor {
public class CommandQueue {


    public function CommandQueue() {
        list_ = new Vector.<CommandList>();
        super();
    }
    private var list_:Vector.<CommandList>;
    private var currPos:int = 0;

    public function addCommandList(_arg_1:CommandList):void {
        this.list_.length = this.currPos;
        _arg_1.execute();
        this.list_.push(_arg_1);
        this.currPos++;
    }

    public function undo():void {
        if (this.currPos == 0) {
            return;
        }
        var _local1:* = this.currPos - 1;
        this.currPos--;
        this.list_[_local1].unexecute();
    }

    public function redo():void {
        if (this.currPos == this.list_.length) {
            return;
        }
        var _local1:Number = this.currPos;
        this.currPos++;
        this.list_[_local1].execute();
    }

    public function clear():void {
        this.currPos = 0;
        this.list_.length = 0;
    }
}
}
