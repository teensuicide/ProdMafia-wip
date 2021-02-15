package io.decagames.rotmg.pets.panels {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import kabam.rotmg.editor.view.StaticTextButton;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;
   
   public class PetPanel extends Panel {
      
      private static const FONT_SIZE:int = 16;
      
      private static const INVENTORY_PADDING:int = 6;
      
      private static const HUD_PADDING:int = 5;
       
      
      public const addToolTip:Signal = new Signal(ToolTip);
      
      private const nameTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777215,16,true);
      
      private const rarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(11974326,12,false);
      
      public var petBitmapRollover:NativeSignal;
      
      public var petBitmapContainer:Sprite;
      
      public var followButton:StaticTextButton;
      
      public var releaseButton:StaticTextButton;
      
      public var unFollowButton:StaticTextButton;
      
      public var petVO:PetVO;
      
      private var petBitmap:Bitmap;
      
      public function PetPanel(param1:AGameSprite, param2:PetVO) {
         petBitmapContainer = new Sprite();
         super(param1);
         this.petVO = param2;
         this.petBitmapRollover = new NativeSignal(this.petBitmapContainer,"mouseOver");
         this.petBitmapRollover.add(this.onRollOver);
         if(param2) {
            this.petBitmap = param2.getSkinBitmap();
         }
         this.addChildren();
         this.positionChildren();
         this.updateTextFields();
         this.createButtons();
      }
      
      private static function sendToBottom(param1:StaticTextButton) : void {
         param1.y = 84 - param1.height - 4;
      }
      
      public function setState(param1:uint) : void {
         this.toggleButtons(param1 == 1);
      }
      
      public function toggleButtons(param1:Boolean) : void {
         this.followButton.visible = param1;
         this.releaseButton.visible = param1;
         this.unFollowButton.visible = !param1;
      }
      
      private function createButtons() : void {
         this.followButton = this.makeButton("Pets.follow");
         this.releaseButton = this.makeButton("PetPanel.release");
         this.unFollowButton = this.makeButton("Pets.unfollow");
         this.alignButtons();
      }
      
      private function makeButton(param1:String) : StaticTextButton {
         var _loc2_:StaticTextButton = new StaticTextButton(16,param1);
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function addChildren() : void {
         this.petBitmap && this.petBitmapContainer.addChild(this.petBitmap);
         addChild(this.petBitmapContainer);
         addChild(this.nameTextField);
         addChild(this.rarityTextField);
      }
      
      private function updateTextFields() : void {
         if (!this.petVO || !this.petVO.rarity)
            return;

         this.nameTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.name)).setColor(this.petVO.rarity.color).setSize(this.petVO.name.length > 17?11:15);
         this.rarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.rarity.rarityKey));
      }
      
      private function positionChildren() : void {
         this.petBitmap.x = 4;
         this.petBitmap.y = -3;
         this.nameTextField.x = 58;
         this.nameTextField.y = 21;
         this.rarityTextField.x = 58;
         this.rarityTextField.y = 35;
      }
      
      private function alignButtons() : void {
         this.positionFollow();
         this.positionRelease();
         this.positionUnfollow();
      }
      
      private function positionFollow() : void {
         this.followButton.x = 6;
         sendToBottom(this.followButton);
      }
      
      private function positionRelease() : void {
         this.releaseButton.x = 188 - this.releaseButton.width - 6 - 5;
         sendToBottom(this.releaseButton);
      }
      
      private function positionUnfollow() : void {
         this.unFollowButton.x = (188 - this.unFollowButton.width) / 2;
         sendToBottom(this.unFollowButton);
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         var _loc2_:PetTooltip = new PetTooltip(this.petVO);
         _loc2_.attachToTarget(this);
         this.addToolTip.dispatch(_loc2_);
      }
   }
}
