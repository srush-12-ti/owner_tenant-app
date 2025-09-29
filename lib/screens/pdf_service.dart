import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> generatePDF(String name, double rent, double water, double elec) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Home Secure - Bill Receipt', style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 20),
          pw.Text('Name: $name'),
          pw.Text('Rent: ₹$rent'),
          pw.Text('Water: ₹$water'),
          pw.Text('Electricity: ₹$elec'),
          pw.Divider(),
          pw.Text('Total: ₹${rent + water + elec}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    ),
  );

  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/$name-Bill.pdf");
  await file.writeAsBytes(await pdf.save());
  await OpenFile.open(file.path);
}
