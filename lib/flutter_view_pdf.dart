
import 'flutter_view_pdf_platform_interface.dart';

class FlutterViewPdf {
  Future<String?> getPlatformVersion() {
    return FlutterViewPdfPlatform.instance.getPlatformVersion();
  }
}
