package kabam.rotmg.arena.view {
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
   import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import kabam.rotmg.arena.component.AbridgedPlayerTooltip;
   import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   
   public class ArenaLeaderboardListItem extends Sprite {
      
      private static const HEIGHT:int = 60;
       
      
      public const showTooltip:Signal = new Signal(Sprite);
      
      public const hideTooltip:Signal = new Signal();
      
      private var playerIconContainer:Sprite;
      
      private var petIconContainer:Sprite;
      
      private var playerIcon:Bitmap;
      
      private var playerTooltip:AbridgedPlayerTooltip;
      
      private var petTooltip:PetTooltip;
      
      private var rank:int = 0;
      
      private var petBitmap:Bitmap;
      
      private var petIconBackground:Sprite;
      
      private var petIconFactory:PetIconFactory;
      
      private var rankNumber:StaticTextDisplay;
      
      private var playerName:StaticTextDisplay;
      
      private var waveNumber:StaticTextDisplay;
      
      private var runTime:StaticTextDisplay;
      
      private var background:Sprite;
      
      private var isActive:Boolean = false;
      
      private var isPersonalRecord:Boolean = false;
      
      private var rankNumberStringBuilder:StaticStringBuilder;
      
      private var playerNameStringBuilder:StaticStringBuilder;
      
      private var waveNumberStringBuilder:LineBuilder;
      
      private var runTimeStringBuilder:StaticStringBuilder;
      
      public function ArenaLeaderboardListItem() {
         playerIconContainer = new Sprite();
         petIconContainer = new Sprite();
         playerIcon = new Bitmap();
         this.petIconBackground = this.makePetIconBackground();
         this.rankNumber = this.makeTextDisplay();
         this.playerName = this.makeTextDisplay();
         this.waveNumber = this.makeTextDisplay();
         this.runTime = this.makeTextDisplay();
         this.background = this.makeBackground();
         this.rankNumberStringBuilder = new StaticStringBuilder();
         this.playerNameStringBuilder = new StaticStringBuilder();
         this.waveNumberStringBuilder = new LineBuilder();
         this.runTimeStringBuilder = new StaticStringBuilder();
         super();
         this.petIconFactory = StaticInjectorContext.getInjector().getInstance(PetIconFactory);
         this.rankNumber.setAutoSize("right");
         this.addChildren();
         this.addEventListeners();
      }
      
      public function apply(param1:ArenaLeaderboardEntry, param2:Boolean) : void {
         this.isActive = param1 != null;
         if(param1) {
            this.initPlayerData(param1);
            this.initArenaData(param1);
            if(param1.rank && param2) {
               this.rankNumber.visible = true;
               this.rankNumber.setStringBuilder(this.rankNumberStringBuilder.setString(param1.rank + "."));
            } else {
               this.rankNumber.visible = false;
            }
            if(this.petBitmap) {
               this.destroyPetIcon();
            }
            if(param1.pet) {
               this.initPetIcon(param1);
            }
            this.rank = param1.rank;
            this.isPersonalRecord = param1.isPersonalRecord;
            this.setColor();
         } else {
            this.clear();
         }
         this.align();
      }
      
      public function setColor() : void {
         var _loc1_:int = 16777215;
         if(this.isPersonalRecord) {
            _loc1_ = 16567065;
         } else if(this.rank == 1) {
            _loc1_ = 16777103;
         }
         this.playerName.setColor(_loc1_);
         this.waveNumber.setColor(_loc1_);
         this.runTime.setColor(_loc1_);
         this.rankNumber.setColor(_loc1_);
      }
      
      public function clear() : void {
         this.playerIcon.bitmapData = null;
         this.playerName.setStringBuilder(this.playerNameStringBuilder.setString(""));
         this.waveNumber.setStringBuilder(this.waveNumberStringBuilder.setParams(""));
         this.runTime.setStringBuilder(this.runTimeStringBuilder.setString(""));
         this.rankNumber.setStringBuilder(this.rankNumberStringBuilder.setString(""));
         if(this.petBitmap) {
            this.destroyPetIcon();
         }
         this.petBitmap = null;
         this.petIconBackground.visible = false;
         this.rank = 0;
      }
      
      private function addEventListeners() : void {
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("mouseOut",this.onMouseOut);
         this.playerIconContainer.addEventListener("mouseOver",this.onPlayerIconOver);
         this.playerIconContainer.addEventListener("mouseOut",this.onPlayerIconOut);
         this.petIconContainer.addEventListener("mouseOver",this.onPetIconOver);
         this.petIconContainer.addEventListener("mouseOut",this.onPetIconOut);
      }
      
      private function addChildren() : void {
         addChild(this.background);
         addChild(this.playerIconContainer);
         addChild(this.petIconBackground);
         addChild(this.petIconContainer);
         addChild(this.rankNumber);
         addChild(this.playerName);
         addChild(this.waveNumber);
         addChild(this.runTime);
         this.playerIconContainer.addChild(this.playerIcon);
      }
      
      private function initArenaData(param1:ArenaLeaderboardEntry) : void {
         this.waveNumber.setStringBuilder(this.waveNumberStringBuilder.setParams("ArenaLeaderboardListItem.waveNumber",{"waveNumber":(param1.currentWave - 1).toString()}));
         this.runTime.setStringBuilder(this.runTimeStringBuilder.setString(this.formatTime(Math.floor(param1.runtime))));
      }
      
      private function initPlayerData(param1:ArenaLeaderboardEntry) : void {
         this.playerIcon.bitmapData = param1.playerBitmap;
         this.playerTooltip = new AbridgedPlayerTooltip(param1);
         this.playerName.setStringBuilder(this.playerNameStringBuilder.setString(param1.name));
      }
      
      private function initPetIcon(param1:ArenaLeaderboardEntry) : void {
         this.petTooltip = new PetTooltip(param1.pet);
         this.petBitmap = this.getPetBitmap(param1.pet,48);
         this.petIconContainer.addChild(this.petBitmap);
         this.petIconBackground.visible = true;
      }
      
      private function destroyPetIcon() : void {
         this.petIconContainer.removeChild(this.petBitmap);
         this.petTooltip = null;
         this.petBitmap = null;
         this.petIconBackground.visible = false;
      }
      
      private function getPetBitmap(param1:PetVO, param2:int) : Bitmap {
         return new Bitmap(this.petIconFactory.getPetSkinTexture(param1,param2));
      }
      
      private function makeTextDisplay() : StaticTextDisplay {
         var _loc1_:* = null;
         _loc1_ = new StaticTextDisplay();
         _loc1_.setBold(true).setSize(24);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         return _loc1_;
      }
      
      private function makeBackground() : Sprite {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0.5);
         _loc1_.graphics.drawRect(0,0,750,60);
         _loc1_.graphics.endFill();
         _loc1_.alpha = 0;
         return _loc1_;
      }
      
      private function makePetIconBackground() : Sprite {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(5526612);
         _loc1_.graphics.drawRoundRect(0,0,40,40,10,10);
         _loc1_.graphics.endFill();
         _loc1_.visible = false;
         return _loc1_;
      }
      
      private function formatTime(param1:int) : String {
         var _loc2_:int = Math.floor(param1 / 60);
         var _loc5_:String = (_loc2_ < 10?"0":"") + _loc2_.toString();
         var _loc4_:int = param1 % 60;
         var _loc3_:String = (_loc4_ < 10?"0":"") + _loc4_.toString();
         return _loc5_ + ":" + _loc3_;
      }
      
      private function align() : void {
         this.rankNumber.x = 75;
         this.rankNumber.y = 30 - this.rankNumber.height / 2;
         this.playerIcon.x = 110;
         this.playerIcon.y = 30 - this.playerIcon.height / 2 - 3;
         if(this.petBitmap) {
            this.petBitmap.x = 170;
            this.petBitmap.y = 30 - this.petBitmap.height / 2;
            this.petIconBackground.x = 175;
            this.petIconBackground.y = 30 - this.petIconBackground.height / 2;
         }
         this.playerName.x = 230;
         this.playerName.y = 30 - this.playerName.height / 2;
         this.waveNumber.x = 485;
         this.waveNumber.y = 30 - this.waveNumber.height / 2;
         this.runTime.x = 635;
         this.runTime.y = 30 - this.runTime.height / 2;
      }
      
      private function onPlayerIconOut(param1:MouseEvent) : void {
         this.hideTooltip.dispatch();
      }
      
      private function onPlayerIconOver(param1:MouseEvent) : void {
         if(this.playerTooltip) {
            this.showTooltip.dispatch(this.playerTooltip);
         }
      }
      
      private function onPetIconOut(param1:MouseEvent) : void {
         this.hideTooltip.dispatch();
      }
      
      private function onPetIconOver(param1:MouseEvent) : void {
         if(this.playerTooltip) {
            this.showTooltip.dispatch(this.petTooltip);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         if(this.isActive) {
            this.background.alpha = 0;
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         if(this.isActive) {
            this.background.alpha = 1;
         }
      }
   }
}
