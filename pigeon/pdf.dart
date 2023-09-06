import 'package:pigeon/pigeon.dart';

class PdfPageResponse {
  int? page;
  String? path;
}

class PdfDocumentResponse {
  int? pageCount;
  List<PdfPageResponse?>? pages;
}

class PdfDocumentRequest {
  String? path;
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pdf/pdf.dart',
  kotlinOut:
      'android/src/main/kotlin/com/github/patou/flutter_view_pdf/FlutterPdfViewApi.kt',
  kotlinOptions: KotlinOptions(package: 'com.github.patou.flutter_view_pdf'),
  swiftOut: 'ios/Classes/FlutterPdfViewApi.swift',
))
@HostApi()
abstract class FlutterPdfViewApi {
  PdfDocumentResponse renderPdf(PdfDocumentRequest request);
  String getVersion();
}
