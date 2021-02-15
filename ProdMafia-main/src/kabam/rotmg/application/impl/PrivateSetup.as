package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class PrivateSetup implements ApplicationSetup {


    private const SERVER:String = "test.realmofthemadgod.com";

    private const UNENCRYPTED:String = "http://test.realmofthemadgod.com";

    private const ENCRYPTED:String = "https://test.realmofthemadgod.com";

    private const ANALYTICS:String = "UA-99999999-1";

    private const BUILD_LABEL:String = "<font color=\'#FFEE00\'>TESTING APP ENGINE, PRIVATE SERVER</font> #{VERSION}";

    public function PrivateSetup() {
        super();
    }

    public function getAppEngineUrl(_arg_1:Boolean = false):String {
        return !!_arg_1 ? "http://test.realmofthemadgod.com" : "https://test.realmofthemadgod.com";
    }

    public function getAnalyticsCode():String {
        return "UA-99999999-1";
    }

    public function getBuildLabel():String {
        return "<font color=\'#FFEE00\'>TESTING APP ENGINE, PRIVATE SERVER</font> #{VERSION}"
                .replace("{VERSION}", Parameters.CLIENT_VERSION);
    }

    public function useLocalTextures():Boolean {
        return true;
    }

    public function isToolingEnabled():Boolean {
        return true;
    }

    public function isServerLocal():Boolean {
        return false;
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
        return true;
    }

    public function getServerDomain():String {
        return "test.realmofthemadgod.com";
    }
}
}
