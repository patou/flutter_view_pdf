import Flutter

class PianoAnalyticsApiImpl: NSObject, FlutterPdfViewApi {

    func getVersion() throws -> String {
        return "IOS 1.0.0"
    }
}
