import Flutter
import UIKit
import PDFKit

class FlutterPdfViewApiImpl: NSObject, FlutterPdfViewApi {
    func renderPdf(request: PdfDocumentRequest) throws -> PdfDocumentResponse {
        if let document = CGPDFDocument(URL(fileURLWithPath: request.path!) as CFURL) {
            var response = PdfDocumentResponse();
            response.pageCount = Int64(truncating: NSNumber.init(value: document.numberOfPages));
            response.pages = [];
            if let outputDirectoryPath = createOutputDirectoryInCache() {
                for i in 0..<document.numberOfPages {
                    if let pdfPage = document.page(at: i) {
                        let pageNumber = i + 1
                        let outputPNGFilePath = "\(outputDirectoryPath)/page\(pageNumber).png"
                        
                        let box = pdfPage.getBoxRect(.mediaBox)
                        
                        // Convert PDF page to UIImage
                        if let pageImage = pdfPage.thumbnail(of: box.size, for: .mediaBox) {
                            if let pngData = pageImage.pngData() {
                                do {
                                    // Save the PNG image to the output directory
                                    try pngData.write(to: URL(fileURLWithPath: outputPNGFilePath))
                                    response.pages?.append(PdfPageResponse(page: Int64(exactly: pageNumber),
                                                                           path: outputPNGFilePath));
                                } catch {
                                    print("Failed to save PNG image for page \(pageNumber): \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
        return response;
      }
      else {
            print("Failed to create PDF document.")
            return PdfDocumentResponse();
      }
    }
    

    func getVersion() throws -> String {
        return "IOS 1.0.0"
    }
    
    
}

func getCacheDirectory() -> String? {
    if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
        return cacheDirectory.path
    }
    return nil
}

func createOutputDirectoryInCache() -> String? {
    if let cacheDirectory = getCacheDirectory() {
        let outputDirectoryPath = (cacheDirectory as NSString).appendingPathComponent("PDFToPNGOutput")
        
        do {
            try FileManager.default.createDirectory(atPath: outputDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            return outputDirectoryPath
        } catch {
            print("Failed to create the output directory: \(error.localizedDescription)")
            return nil
        }
    }
    return nil
}

