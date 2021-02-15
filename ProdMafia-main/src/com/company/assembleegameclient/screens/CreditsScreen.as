package com.company.assembleegameclient.screens {
import com.company.rotmg.graphics.KabamLogo;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.rotmg.graphics.StackedLogoR;

import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;

public class CreditsScreen extends Sprite {

    private static const WILD_SHADOW_URL:String = "http://www.wildshadow.com/";

    private static const KABAM_URL:String = "http://www.kabam.com/";

    public function CreditsScreen() {
        this.creditsText = this.makeCreditsText();
        this.wildshadowLogo = this.makeWildshadowLogo();
        this.kabamLogo = this.makeKabamLogo();
        this.closeButton = this.makeCloseButton();
        super();
        this.close = new Signal();
        addChild(new ScreenBase());
        addChild(new ScreenGraphic());
        addChild(this.creditsText);
        addChild(this.wildshadowLogo);
        addChild(this.kabamLogo);
        addChild(this.closeButton);
    }
    public var close:Signal;
    private var creditsText:TextFieldDisplayConcrete;
    private var wildshadowLogo:StackedLogoR;
    private var kabamLogo:KabamLogo;
    private var closeButton:TitleMenuOption;

    public function initialize():void {
        this.creditsText.x = stage.stageWidth / 2;
        this.creditsText.y = 10;
        this.wildshadowLogo.x = stage.stageWidth / 2 - this.wildshadowLogo.width / 2;
        this.wildshadowLogo.y = 50;
        this.kabamLogo.x = stage.stageWidth / 2 - this.kabamLogo.width / 2;
        this.kabamLogo.y = 325;
        this.closeButton.x = stage.stageWidth / 2 - this.closeButton.width / 2;
        this.closeButton.y = 530;
    }

    private function makeCloseButton():TitleMenuOption {
        this.closeButton = new TitleMenuOption("Close.text", 36, false);
        this.closeButton.setAutoSize("center");
        this.closeButton.addEventListener("click", this.onDoneClick);
        return this.closeButton;
    }

    private function makeKabamLogo():KabamLogo {
        this.kabamLogo = new KabamLogo();
        this.kabamLogo.scaleY = 1;
        this.kabamLogo.scaleX = 1;
        this.kabamLogo.addEventListener("click", this.onKabamLogoClick);
        this.kabamLogo.buttonMode = true;
        this.kabamLogo.useHandCursor = true;
        return this.kabamLogo;
    }

    private function makeWildshadowLogo():StackedLogoR {
        this.wildshadowLogo = new StackedLogoR();
        this.wildshadowLogo.scaleY = 1.2;
        this.wildshadowLogo.scaleX = 1.2;
        this.wildshadowLogo.addEventListener("click", this.onWSLogoClick);
        this.wildshadowLogo.buttonMode = true;
        this.wildshadowLogo.useHandCursor = true;
        return this.wildshadowLogo;
    }

    private function makeCreditsText():TextFieldDisplayConcrete {
        this.creditsText = new TextFieldDisplayConcrete();
        this.creditsText.setColor(0xb3b3b3).setSize(16).setBold(true);
        this.creditsText.setStringBuilder(new LineBuilder().setParams("Credits.developed"));
        this.creditsText.filters = [new DropShadowFilter(0, 0, 0)];
        this.creditsText.setAutoSize("center");
        return this.creditsText;
    }

    protected function onWSLogoClick(_arg_1:Event):void {
    }

    protected function onKabamLogoClick(_arg_1:Event):void {
    }

    private function onDoneClick(_arg_1:Event):void {
        this.close.dispatch();
    }
}
}
