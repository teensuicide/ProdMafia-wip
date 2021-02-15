package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class Testing2Setup implements ApplicationSetup {


    private const SERVER:String = "test2.realmofthemadgod.com";

    private const UNENCRYPTED:String = "http://test2.realmofthemadgod.com";

    private const ENCRYPTED:String = "https://test2.realmofthemadgod.com";

    private const ANALYTICS:String = "UA-11236645-6";

    private const BUILD_LABEL:String = "<font color=\'#FF0000\'>TESTING 2 </font> #{VERSION}";

    public function Testing2Setup() {
        super();
    }

    public function getAppEngineUrl(_arg_1:Boolean = false):String {
        return "https://test2.realmofthemadgod.com";
    }

    public function getAnalyticsCode():String {
        return "UA-11236645-6";
    }

    public function getBuildLabel():String {
        return "<font color=\'#FF0000\'>TESTING 2 </font> #{VERSION}"
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
        return "test2.realmofthemadgod.com";
    }
}
}
