import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_view_pdf/flutter_view_pdf.dart';
import 'package:flutter_view_pdf/flutter_view_pdf_platform_interface.dart';
import 'package:flutter_view_pdf/flutter_view_pdf_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterViewPdfPlatform
    with MockPlatformInterfaceMixin
    implements FlutterViewPdfPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterViewPdfPlatform initialPlatform = FlutterViewPdfPlatform.instance;

  test('$MethodChannelFlutterViewPdf is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterViewPdf>());
  });

  test('getPlatformVersion', () async {
    FlutterViewPdf flutterViewPdfPlugin = FlutterViewPdf();
    MockFlutterViewPdfPlatform fakePlatform = MockFlutterViewPdfPlatform();
    FlutterViewPdfPlatform.instance = fakePlatform;

    expect(await flutterViewPdfPlugin.getPlatformVersion(), '42');
  });
}
