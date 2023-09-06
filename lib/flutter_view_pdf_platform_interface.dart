import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_view_pdf_method_channel.dart';

abstract class FlutterViewPdfPlatform extends PlatformInterface {
  /// Constructs a FlutterViewPdfPlatform.
  FlutterViewPdfPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterViewPdfPlatform _instance = MethodChannelFlutterViewPdf();

  /// The default instance of [FlutterViewPdfPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterViewPdf].
  static FlutterViewPdfPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterViewPdfPlatform] when
  /// they register themselves.
  static set instance(FlutterViewPdfPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
