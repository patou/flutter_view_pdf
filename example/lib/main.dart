import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_view_pdf/pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int? _pageCount;
  List<PdfPageResponse>? _pages;
  final _flutterViewPdfPlugin = FlutterPdfViewApi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    try {
      platformVersion = await _flutterViewPdfPlugin.getVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    try {
      print('downloading pdf');
      var result = await downloadPdf(downloadUrl);
      setState(() {
        _pageCount = result.pageCount;
        _pages = result.pages?.whereType<PdfPageResponse>().toList();
      });
    } on PlatformException catch (e) {
      print(e);
      platformVersion = 'Failed to get pdf count.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  String downloadUrl =
      'https://freetestdata.com/wp-content/uploads/2023/07/800KB.pdf';

  Future<PdfDocumentResponse> downloadPdf(String url) async {
    // Download the pdf to a temporary file
    final file = await _downloadUrl(url);
    print('file: $file');

    final request = PdfDocumentRequest();
    request.path = file;
    print('request: $request');
    final response = await _flutterViewPdfPlugin.renderPdf(request);
    print('response: ${response.pageCount}');
    response.pages?.forEach((element) {
      print('element: ${element?.path}');
    });
    return response;
  }

  Future<String> _downloadUrl(String url) async {
    final httpClient = HttpClient();
    var uri = Uri.parse(url);
    final request = await httpClient.getUrl(uri);
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${uri.pathSegments.last}.pdf');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Page count: $_pageCount'),
        ),
        body: (_pageCount != null)
            ? ListView.builder(
                itemCount: _pages?.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 8)),
                      child: Image.file(File(_pages?[index].path ?? '')));
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
