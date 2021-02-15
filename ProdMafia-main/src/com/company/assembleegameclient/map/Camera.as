package com.company.assembleegameclient.map {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.RandomUtil;
import com.company.util.PointUtil;
import flash.geom.Matrix3D;
import flash.geom.PerspectiveProjection;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Vector3D;

public class Camera {

   public static var CenterRect:Rectangle = new Rectangle(-300,-325,600,600);

   public static var OffCenterRect:Rectangle = new Rectangle(-300,-450,600,600);


   private const MAX_JITTER:Number = 0.5;

   private const JITTER_BUILDUP_MS:int = 10000;

   public var x_:Number;

   public var y_:Number;

   public var z_:Number;

   public var angleRad_:Number;

   public var clipRect_:Rectangle;

   public var pp_:PerspectiveProjection;

   public var maxDist_:Number;

   public var maxDistSq_:Number;

   public var isHallucinating_:Boolean = false;

   public var wToS_:Matrix3D;

   public var wToV_:Matrix3D;

   public var vToS_:Matrix3D;

   public var nonPPMatrix_:Matrix3D;

   public var p_:Vector3D;

   public var yaw:Number = 0;

   private var f_:Vector3D;

   private var u_:Vector3D;

   private var r_:Vector3D;

   private var isJittering_:Boolean = false;

   private var jitter_:Number = 0;

   private var rd_:Vector.<Number>;

   public function Camera() {
      pp_ = new PerspectiveProjection();
      wToS_ = new Matrix3D();
      wToV_ = new Matrix3D();
      vToS_ = new Matrix3D();
      nonPPMatrix_ = new Matrix3D();
      p_ = new Vector3D();
      f_ = new Vector3D();
      u_ = new Vector3D();
      r_ = new Vector3D();
      rd_ = new Vector.<Number>(16,true);
      super();
      this.pp_.focalLength = 3;
      this.pp_.fieldOfView = 48;
      this.nonPPMatrix_.appendScale(50,50,50);
      this.f_.x = 0;
      this.f_.y = 0;
      this.f_.z = -1;
   }

   public function configureCamera(param1:GameObject, param2:Boolean) : void {
      var _loc3_:Rectangle = this.correctViewingArea(Parameters.data.centerOnPlayer);
      this.configure(param1.x_,param1.y_,param1.z_,Parameters.data.cameraAngle,_loc3_);
      this.isHallucinating_ = param2;
   }

   public function startJitter() : void {
      this.isJittering_ = true;
      this.jitter_ = 0;
   }

   public function update(param1:Number) : void {
      if(this.isJittering_ && this.jitter_ < 0.5) {
         this.jitter_ = this.jitter_ + param1 * 0.5 / 10000;
         if(this.jitter_ > 0.5) {
            this.jitter_ = 0.5;
         }
      }
   }

   public function configure(param1:Number, param2:Number, param3:Number, param4:Number, param5:Rectangle) : void {
      if(this.isJittering_) {
         param1 = param1 + RandomUtil.plusMinus(this.jitter_);
         param2 = param2 + RandomUtil.plusMinus(this.jitter_);
      }
      this.x_ = param1;
      this.y_ = param2;
      this.z_ = param3;
      this.angleRad_ = param4;
      this.clipRect_ = param5;
      this.p_.x = param1;
      this.p_.y = param2;
      this.p_.z = param3;
      this.r_.x = Math.cos(this.angleRad_);
      this.r_.y = Math.sin(this.angleRad_);
      this.r_.z = 0;
      this.u_.x = Math.cos(this.angleRad_ + 1.5707963267949);
      this.u_.y = Math.sin(this.angleRad_ + 1.5707963267949);
      this.u_.z = 0;
      this.rd_[0] = this.r_.x;
      this.rd_[1] = this.u_.x;
      this.rd_[2] = this.f_.x;
      this.rd_[3] = 0;
      this.rd_[4] = this.r_.y;
      this.rd_[5] = this.u_.y;
      this.rd_[6] = this.f_.y;
      this.rd_[7] = 0;
      this.rd_[8] = this.r_.z;
      this.rd_[9] = -1;
      this.rd_[10] = this.f_.z;
      this.rd_[11] = 0;
      this.rd_[12] = -this.p_.dotProduct(this.r_);
      this.rd_[13] = -this.p_.dotProduct(this.u_);
      this.rd_[14] = -this.p_.dotProduct(this.f_);
      this.rd_[15] = 1;
      this.wToV_.rawData = this.rd_;
      this.vToS_ = this.nonPPMatrix_;
      this.wToS_.identity();
      this.wToS_.append(this.wToV_);
      this.wToS_.append(this.vToS_);
      var _loc6_:Number = this.clipRect_.width * 0.01;
      var _loc7_:Number = this.clipRect_.height * 0.01;
      this.maxDist_ = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_) + 1;
      this.maxDistSq_ = this.maxDist_ * this.maxDist_;
   }

   public function correctViewingArea(param1:Boolean) : Rectangle {
      var _loc3_:Number = Main.STAGE.stageWidth / Parameters.data.mscale;
      var _loc4_:Number = Main.STAGE.stageHeight / Parameters.data.mscale;
      var _loc2_:Number = 200 * Main.STAGE.stageWidth / 800;
      CenterRect = new Rectangle(-(_loc3_ - _loc2_) / 2,-_loc4_ * 13 / 24,_loc3_,_loc4_);
      OffCenterRect = new Rectangle(-(_loc3_ - _loc2_) / 2,-_loc4_ * 3 / 4,_loc3_,_loc4_);
      return !!param1?CenterRect:OffCenterRect;
   }
}
}