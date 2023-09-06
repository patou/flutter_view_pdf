package com.github.patou.flutter_view_pdf

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** FlutterViewPdfPlugin */
class FlutterViewPdfPlugin: FlutterPlugin {
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    FlutterPdfViewApi.setUp(flutterPluginBinding.binaryMessenger, FlutterPdfViewApiImpl(flutterPluginBinding))
  }

  override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    FlutterPdfViewApi.setUp(flutterPluginBinding.binaryMessenger, null)
  }
}
