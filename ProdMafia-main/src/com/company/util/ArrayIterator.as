package com.company.util {
   public class ArrayIterator implements IIterator {
       
      
      private var objects_:Array;
      
      private var index_:int;
      
      public function ArrayIterator(param1:Array) {
         super();
         this.objects_ = param1;
         this.index_ = 0;
      }
      
      public function reset() : void {
         this.index_ = 0;
      }
      
      public function next() : Object {
         var _loc1_:Number = this.index_;
         this.index_++;
         return this.objects_[_loc1_];
      }
      
      public function hasNext() : Boolean {
         return this.index_ < this.objects_.length;
      }
   }
}
