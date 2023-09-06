// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct PdfPageResponse {
  var page: Int64? = nil
  var path: String? = nil

  static func fromList(_ list: [Any?]) -> PdfPageResponse? {
    let page: Int64? = isNullish(list[0]) ? nil : (list[0] is Int64? ? list[0] as! Int64? : Int64(list[0] as! Int32))
    let path: String? = nilOrValue(list[1])

    return PdfPageResponse(
      page: page,
      path: path
    )
  }
  func toList() -> [Any?] {
    return [
      page,
      path,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PdfDocumentResponse {
  var pageCount: Int64? = nil
  var pages: [PdfPageResponse?]? = nil

  static func fromList(_ list: [Any?]) -> PdfDocumentResponse? {
    let pageCount: Int64? = isNullish(list[0]) ? nil : (list[0] is Int64? ? list[0] as! Int64? : Int64(list[0] as! Int32))
    let pages: [PdfPageResponse?]? = nilOrValue(list[1])

    return PdfDocumentResponse(
      pageCount: pageCount,
      pages: pages
    )
  }
  func toList() -> [Any?] {
    return [
      pageCount,
      pages,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PdfDocumentRequest {
  var path: String? = nil

  static func fromList(_ list: [Any?]) -> PdfDocumentRequest? {
    let path: String? = nilOrValue(list[0])

    return PdfDocumentRequest(
      path: path
    )
  }
  func toList() -> [Any?] {
    return [
      path,
    ]
  }
}
private class FlutterPdfViewApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return PdfDocumentRequest.fromList(self.readValue() as! [Any?])
      case 129:
        return PdfDocumentResponse.fromList(self.readValue() as! [Any?])
      case 130:
        return PdfPageResponse.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class FlutterPdfViewApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? PdfDocumentRequest {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? PdfDocumentResponse {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? PdfPageResponse {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class FlutterPdfViewApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return FlutterPdfViewApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return FlutterPdfViewApiCodecWriter(data: data)
  }
}

class FlutterPdfViewApiCodec: FlutterStandardMessageCodec {
  static let shared = FlutterPdfViewApiCodec(readerWriter: FlutterPdfViewApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol FlutterPdfViewApi {
  func renderPdf(request: PdfDocumentRequest) throws -> PdfDocumentResponse
  func getVersion() throws -> String
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class FlutterPdfViewApiSetup {
  /// The codec used by FlutterPdfViewApi.
  static var codec: FlutterStandardMessageCodec { FlutterPdfViewApiCodec.shared }
  /// Sets up an instance of `FlutterPdfViewApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: FlutterPdfViewApi?) {
    let renderPdfChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_view_pdf.FlutterPdfViewApi.renderPdf", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      renderPdfChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let requestArg = args[0] as! PdfDocumentRequest
        do {
          let result = try api.renderPdf(request: requestArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      renderPdfChannel.setMessageHandler(nil)
    }
    let getVersionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_view_pdf.FlutterPdfViewApi.getVersion", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getVersionChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getVersion()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getVersionChannel.setMessageHandler(nil)
    }
  }
}