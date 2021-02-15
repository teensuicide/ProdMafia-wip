package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class LocalhostSetup implements ApplicationSetup {


    private const SERVER:String = "http://localhost:8080";

    private const ANALYTICS:String = "UA-101960510-5";

    private const BUILD_LABEL:String = "<font color=\'#FFEE00\'>LOCALHOST</font> #{VERSION}";

    public function LocalhostSetup() {
        super();
    }

    public function getAppEngineUrl(_arg_1:Boolean = false):String {
        return "http://localhost:8080";
    }

    public function getAnalyticsCode():String {
        return "UA-101960510-5";
    }

    public function getBuildLabel():String {
        return "<font color=\'#FFEE00\'>LOCALHOST</font> #{VERSION}"
                .replace("{VERSION}", Parameters.CLIENT_VERSION);
    }

    public function useLocalTextures():Boolean {
        return true;
    }

    public function isToolingEnabled():Boolean {
        return true;
    }

    public function isServerLocal():Boolean {
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
        return true;
    }

    public function getServerDomain():String {
        return "localhost";
    }
}
}
