// lib/services/pdf_service.dart
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';

class PdfService {
  Future<String> generateInvoicePdf({
    required String tenantName,
    required String apartment,
    required List<Map<String, dynamic>> items,
    required String invoiceNo,
    String? logoAssetPath,
  }) async {
    final pdf = pw.Document();

    pw.ImageProvider? logoImageProvider; // Use the more general ImageProvider type
    if (logoAssetPath != null) {
      final data = await rootBundle.load(logoAssetPath);
      // Directly create an ImageProvider from the loaded byte data
      logoImageProvider = pw.MemoryImage(data.buffer.asUint8List());
    }

    final total = items.fold<num>(0, (prev, e) => prev + (e['amount'] as num));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          if (logoImageProvider != null)
            pw.Center(child: pw.Image(logoImageProvider, width: 100)), // Pass as a named parameter
          pw.SizedBox(height: 10),
          pw.Text('Invoice', style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Tenant: $tenantName'),
                  pw.Text('Apartment: $apartment'),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('Invoice No: $invoiceNo'),
                  pw.Text('Date: ${DateTime.now().toLocal().toString().split(' ').first}'),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Table.fromTextArray(
            headers: ['Description', 'Amount (₹)'],
            data: items.map((e) => [e['desc'], (e['amount']).toString()]).toList(),
          ),
          pw.Divider(),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text('Total: ₹$total',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Notes: Thank you for your payment.'),
        ],
      ),
    );

    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/invoice_$invoiceNo.pdf');
    await file.writeAsBytes(bytes);
    await OpenFilex.open(file.path);

    return file.path;
  }
}