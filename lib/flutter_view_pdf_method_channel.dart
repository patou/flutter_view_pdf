import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_view_pdf_platform_interface.dart';

/// An implementation of [FlutterViewPdfPlatform] that uses method channels.
class MethodChannelFlutterViewPdf extends FlutterViewPdfPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_view_pdf');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
