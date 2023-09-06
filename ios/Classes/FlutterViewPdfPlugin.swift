import Flutter
import UIKit

public class FlutterViewPdfPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let api = PianoAnalyticsApiImpl()
        FlutterPdfViewApiSetup.setUp(binaryMessenger: registrar.messenger(), api: api)
    }
}
