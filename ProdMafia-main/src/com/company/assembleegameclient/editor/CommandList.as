package com.company.assembleegameclient.editor {
public class CommandList {


    public function CommandList() {
        list_ = new Vector.<Command>();
        super();
    }
    private var list_:Vector.<Command>;

    public function empty():Boolean {
        return this.list_.length == 0;
    }

    public function addCommand(_arg_1:Command):void {
        this.list_.push(_arg_1);
    }

    public function execute():void {
        var _local1:* = null;
        var _local3:int = 0;
        var _local2:* = this.list_;
        for each(_local1 in this.list_) {
            _local1.execute();
        }
    }

    public function unexecute():void {
        var _local1:* = null;
        var _local3:int = 0;
        var _local2:* = this.list_;
        for each(_local1 in this.list_) {
            _local1.unexecute();
        }
    }
}
}
