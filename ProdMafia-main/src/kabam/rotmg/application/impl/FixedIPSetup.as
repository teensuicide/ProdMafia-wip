package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class FixedIPSetup implements ApplicationSetup {


    private const SERVER:String = "test.realmofthemadgod.com";

    private const UNENCRYPTED:String = "http://test.realmofthemadgod.com";

    private const ENCRYPTED:String = "https://test.realmofthemadgod.com";

    private const ANALYTICS:String = "UA-99999999-1";

    private const BUILD_LABEL:String = "<font color=\'#9900FF\'>{IP}</font> #{VERSION}";

    public function FixedIPSetup() {
        super();
    }
    private var ipAddress:String;

    public function setAddress(_arg_1:String):FixedIPSetup {
        this.ipAddress = _arg_1;
        return this;
    }

    public function getAppEngineUrl(_arg_1:Boolean = false):String {
        return !!_arg_1 ? "http://test.realmofthemadgod.com" : "https://test.realmofthemadgod.com";
    }

    public function getAnalyticsCode():String {
        return "UA-99999999-1";
    }

    public function isServerLocal():Boolean {
        return false;
    }

    public function getBuildLabel():String {
        return "<font color=\'#9900FF\'>{IP}</font> #{VERSION}".replace("{IP}", this.ipAddress)
                .replace("{VERSION}", Parameters.CLIENT_VERSION);
    }

    public function useLocalTextures():Boolean {
        return true;
    }

    public function isToolingEnabled():Boolean {
        return true;
    }

    public function isGameLoopMonitored():Boolean {
        return true;
    }

    public function useProductionDialogs():Boolean {
        return false;
    }

    public function areErrorsReported():Boolean {
        return false;
    }

    public function areDeveloperHotkeysEnabled():Boolean {
        return true;
    }

    public function isDebug():Boolean {
        return false;
    }

    public function getServerDomain():String {
        return "test.realmofthemadgod.com";
    }
}
}
