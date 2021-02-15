package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.ui.GameObjectListItem;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class QuestToolTip extends ToolTip {
       
      
      public var enemyGOLI_:GameObjectListItem;
      
      private var gameObject:GameObject;
      
      public function QuestToolTip(param1:GameObject) {
         super(6036765,1,16549442,1,false);
         this.gameObject = param1;
         this.init();
      }
      
      private function init() : void {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(22).setColor(16549442).setBold(true);
         _loc1_.setStringBuilder(new LineBuilder().setParams("Bounty!"));
         _loc1_.filters = [new DropShadowFilter(0,0,0)];
         _loc1_.x = 0;
         _loc1_.y = 0;
         waiter.push(_loc1_.textChanged);
         addChild(_loc1_);
         this.enemyGOLI_ = new GameObjectListItem(16777215,true,this.gameObject);
         this.enemyGOLI_.x = 0;
         this.enemyGOLI_.y = 32;
         waiter.push(this.enemyGOLI_.textReady);
         addChild(this.enemyGOLI_);
         filters = [];
      }
   }
}
