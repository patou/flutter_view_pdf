package com.github.patou.flutter_view_pdf

import android.graphics.Bitmap
import android.graphics.pdf.PdfRenderer
import android.os.Build
import android.os.ParcelFileDescriptor
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.io.File
import java.io.FileOutputStream

class FlutterPdfViewApiImpl(private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) : FlutterPdfViewApi {

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun renderPdf(request: PdfDocumentRequest): PdfDocumentResponse {
    val file = File(request.path!!)
    val fileDescriptor = ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_ONLY)
    val pdfDocument = PdfRenderer(fileDescriptor)
    val pageCount = pdfDocument.pageCount
    val pages = ArrayList<PdfPageResponse>(pageCount);
    for (index in 0 until pageCount) {
      val pageNumber = index + 1
      val page = pdfDocument.openPage(index)
      val width = page.width
      val height = page.height
      val tempOutFolder = File(flutterPluginBinding.applicationContext.cacheDir, "pdf_cache")
      tempOutFolder.mkdirs()
      val tempOutFile = File(tempOutFolder, "${file.name}-${pageNumber}.png")
      val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
      page.render(bitmap, null, null, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY)
      val stream = FileOutputStream(tempOutFile, false)
      bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
      stream.flush()
      stream.close()
      page.close()
      val path = tempOutFile.absolutePath
      pages.add(PdfPageResponse(page=pageNumber.toLong(), path=path))
    }
    return PdfDocumentResponse(pageCount=pageCount.toLong(), pages=pages)
  }

  override fun getVersion(): String {
    return "1.0.0"
  }
}