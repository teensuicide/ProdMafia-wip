package com.company.assembleegameclient.map {
   import com.company.assembleegameclient.objects.TextureData;
   import com.company.assembleegameclient.objects.TextureDataConcrete;
   import com.company.util.BitmapUtil;
   import flash.display.BitmapData;
   
   public class GroundProperties {
       
      
      public var type_:int;
      
      public var id_:String;
      
      public var displayId_:String;
      
      public var noWalk_:Boolean = true;
      
      public var minDamage_:int = 0;
      
      public var maxDamage_:int = 0;
      
      public var animate_:AnimateProperties;
      
      public var blendPriority_:int = -1;
      
      public var compositePriority_:int = 0;
      
      public var speed_:Number = 1;
      
      public var xOffset_:Number = 0;
      
      public var yOffset_:Number = 0;
      
      public var slideAmount_:Number = 0;
      
      public var push_:Boolean = false;
      
      public var sink_:Boolean = false;
      
      public var sinking_:Boolean = false;
      
      public var randomOffset_:Boolean = false;
      
      public var hasEdge_:Boolean = false;
      
      public var sameTypeEdgeMode_:Boolean = false;
      
      public var topTD_:TextureData = null;
      
      public var topAnimate_:AnimateProperties = null;
      
      private var edgeTD_:TextureData = null;
      
      private var cornerTD_:TextureData = null;
      
      private var innerCornerTD_:TextureData = null;
      
      private var edges_:Vector.<BitmapData> = null;
      
      private var innerCorners_:Vector.<BitmapData> = null;
      
      public function GroundProperties(param1:XML) {
         animate_ = new AnimateProperties();
         super();
         this.type_ = int(param1.@type);
         var _loc2_:String = param1.@id;
         this.id_ = _loc2_;
         this.displayId_ = _loc2_;
         if("DisplayId" in param1) {
            this.displayId_ = param1.DisplayId;
         }
         this.id_ = String(param1.@id);
         this.noWalk_ = "NoWalk" in param1;
         if("MinDamage" in param1) {
            this.minDamage_ = param1.MinDamage;
         }
         if("MaxDamage" in param1) {
            this.maxDamage_ = param1.MaxDamage;
         }
         if("Animate" in param1) {
            this.animate_.parseXML(XML(param1.Animate));
         }
         if("BlendPriority" in param1) {
            this.blendPriority_ = param1.BlendPriority;
         }
         if("CompositePriority" in param1) {
            this.compositePriority_ = param1.CompositePriority;
         }
         if("Speed" in param1) {
            this.speed_ = param1.Speed;
         }
         if("SlideAmount" in param1) {
            this.slideAmount_ = param1.SlideAmount;
         }
         this.xOffset_ = "XOffset" in param1?param1.XOffset:0;
         this.yOffset_ = "YOffset" in param1?param1.YOffset:0;
         this.push_ = "Push" in param1;
         this.sink_ = "Sink" in param1;
         this.sinking_ = "Sinking" in param1;
         this.randomOffset_ = "RandomOffset" in param1;
         if("Edge" in param1) {
            this.hasEdge_ = true;
            this.edgeTD_ = new TextureDataConcrete(XML(param1.Edge));
            if("Corner" in param1) {
               this.cornerTD_ = new TextureDataConcrete(XML(param1.Corner));
            }
            if("InnerCorner" in param1) {
               this.innerCornerTD_ = new TextureDataConcrete(XML(param1.InnerCorner));
            }
         }
         this.sameTypeEdgeMode_ = "SameTypeEdgeMode" in param1;
         if("Top" in param1) {
            this.topTD_ = new TextureDataConcrete(XML(param1.Top));
            this.topAnimate_ = new AnimateProperties();
            if("TopAnimate" in param1) {
               this.topAnimate_.parseXML(XML(param1.TopAnimate));
            }
         }
      }
      
      public function getEdges() : Vector.<BitmapData> {
         if(!this.hasEdge_ || this.edges_ != null) {
            return this.edges_;
         }
         this.edges_ = new Vector.<BitmapData>(9);
         this.edges_[3] = this.edgeTD_.getTexture(0);
         this.edges_[1] = BitmapUtil.rotateBitmapData(this.edges_[3],1);
         this.edges_[5] = BitmapUtil.rotateBitmapData(this.edges_[3],2);
         this.edges_[7] = BitmapUtil.rotateBitmapData(this.edges_[3],3);
         if(this.cornerTD_ != null) {
            this.edges_[0] = this.cornerTD_.getTexture(0);
            this.edges_[2] = BitmapUtil.rotateBitmapData(this.edges_[0],1);
            this.edges_[8] = BitmapUtil.rotateBitmapData(this.edges_[0],2);
            this.edges_[6] = BitmapUtil.rotateBitmapData(this.edges_[0],3);
         }
         return this.edges_;
      }
      
      public function getInnerCorners() : Vector.<BitmapData> {
         if(this.innerCornerTD_ == null || this.innerCorners_ != null) {
            return this.innerCorners_;
         }
         this.innerCorners_ = this.edges_.concat();
         this.innerCorners_[0] = this.innerCornerTD_.getTexture(0);
         this.innerCorners_[2] = BitmapUtil.rotateBitmapData(this.innerCorners_[0],1);
         this.innerCorners_[8] = BitmapUtil.rotateBitmapData(this.innerCorners_[0],2);
         this.innerCorners_[6] = BitmapUtil.rotateBitmapData(this.innerCorners_[0],3);
         return this.innerCorners_;
      }
   }
}
