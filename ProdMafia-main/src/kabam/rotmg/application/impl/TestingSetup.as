package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class TestingSetup implements ApplicationSetup {


    private const SERVER:String = "test.realmofthemadgod.com";

    private const UNENCRYPTED:String = "http://test.realmofthemadgod.com";

    private const ENCRYPTED:String = "https://test.realmofthemadgod.com";

    private const ANALYTICS:String = "UA-101960510-4";

    private const BUILD_LABEL:String = "<font color=\'#FF0000\'>TESTING</font> #{VERSION}";

    public function TestingSetup() {
        super();
    }

    public function getAppEngineUrl(_arg_1:Boolean = false):String {
        return "https://test.realmofthemadgod.com";
    }

    public function getAnalyticsCode():String {
        return "UA-101960510-4";
    }

    public function getBuildLabel():String {
        return "<font color=\'#FF0000\'>TESTING</font> #{VERSION}"
                .replace("{VERSION}", Parameters.CLIENT_VERSION);
    }

    public function useLocalTextures():Boolean {
        return true;
    }

    public function isServerLocal():Boolean {
        return false;
    }

    public function isToolingEnabled():Boolean {
        return true;
    }

    public function isGameLoopMonitored():Boolean {
        return true;
    }

    public function areErrorsReported():Boolean {
        return false;
    }

    public function useProductionDialogs():Boolean {
        return true;
    }

    public function areDeveloperHotkeysEnabled():Boolean {
        return false;
    }

    public function isDebug():Boolean {
        return false;
    }

    public function getServerDomain():String {
        return "test.realmofthemadgod.com";
    }
}
}
