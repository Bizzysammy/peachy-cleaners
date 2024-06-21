import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class ReportDetailsScreen extends StatefulWidget {
  final String cleanerId; // Cleaner's ID
  final String dayOfCleaning; // Day of cleaning
  final String dateOfCleaning; // Date of cleaning

  const ReportDetailsScreen({
    Key? key,
    required this.cleanerId,
    required this.dayOfCleaning,
    required this.dateOfCleaning,
  }) : super(key: key);

  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  late String cleanerName;
  late String customerName;
  late String day;
  late String date;
  late String address;
  late String numRooms;
  late String totalCash;
  late String totalVisa;
  late String totalMobileMoney;
  late String totalCollection;
  late Uint8List profileImageBytes;

  @override
  void initState() {
    super.initState();
    fetchReportData();
  }

  Future<void> fetchReportData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reports')
          .doc(widget.cleanerId)
          .collection('user_reports')
          .where('dayofcleaning', isEqualTo: widget.dayOfCleaning)
          .where('dateofcleaning', isEqualTo: widget.dateOfCleaning)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final reportData = querySnapshot.docs[0].data() as Map<String, dynamic>;
        String profilePhotoUrl = reportData['profile_photo'] ?? '';

        setState(() {
          cleanerName = reportData['cleanername'] ?? 'N/A';
          customerName = reportData['customername'] ?? 'N/A';
          day = widget.dayOfCleaning;
          date = widget.dateOfCleaning;
          address = reportData['customeraddress'] ?? 'N/A';
          numRooms = reportData['numberofrooms']?.toString() ?? 'N/A';
          totalCash = reportData['totalcashcollection']?.toString() ?? 'N/A';
          totalVisa = reportData['totalvisacollection']?.toString() ?? 'N/A';
          totalMobileMoney = reportData['totalmobilemoneycollection']?.toString() ?? 'N/A';
          totalCollection = reportData['totalcollection']?.toString() ?? 'N/A';
        });

        fetchImage(profilePhotoUrl);
      } else {
        print('No report found for this date.');
      }
    } catch (e) {
      print("Error fetching report data: $e");
    }
  }

  Future<void> fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      setState(() {
        profileImageBytes = Uint8List.fromList(response.bodyBytes);
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format,
          orientation: pw.PageOrientation.portrait,
        ),
        build: (context) {
          return pw.Center(
            child: pw.Column(
              children: [
                if (profileImageBytes.isNotEmpty)
                  pw.Image(pw.MemoryImage(profileImageBytes), width: 100, height: 100),
                pw.SizedBox(height: 20),
                pw.Text('Cleaning Report', style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Divider(),
                _buildDataRow('Cleaner Name', cleanerName),
                _buildDataRow('Customer Name', customerName),
                _buildDataRow('Day of Cleaning', day),
                _buildDataRow('Date of Cleaning', date),
                _buildDataRow('Customer Address', address),
                _buildDataRow('Number of Rooms', numRooms),
                _buildDataRow('Total Cash Collection', totalCash),
                _buildDataRow('Total Visa Collection', totalVisa),
                _buildDataRow('Total MobileMoney Collection', totalMobileMoney),
                _buildDataRow('Total Collection', totalCollection),
                pw.Divider(),
              ],
            ),
          );
        },
      ),
    );

    return Uint8List.fromList(await doc.save());
  }

  pw.Container _buildDataRow(String label, String value) {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text('$label: ', style: const pw.TextStyle(fontSize: 20)),
          pw.Text(value, style: const pw.TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => generateDocument(format),
    );
  }
}
