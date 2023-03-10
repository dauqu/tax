import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tax/pages/second.dart';

class PrintData extends StatefulWidget {
  final List items;
  const PrintData({super.key, required this.items});

  @override
  State<PrintData> createState() => _PrintDataState();
}

class _PrintDataState extends State<PrintData> {
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text("Quotation",
                    style: const pw.TextStyle(fontSize: 20)),
              ),
              pw.SizedBox(height: 50),
              pw.Container(
                height: 50,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Item No"),
                    pw.SizedBox(width: 10),
                    pw.Text("Item Name"),
                    pw.SizedBox(width: 10),
                    pw.Text("Price"),
                    pw.SizedBox(width: 10),
                    pw.Text("Quantity"),
                    pw.SizedBox(width: 10),
                    pw.Text("Amount"),
                  ],
                ),
              ),
              pw.ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return pw.Container(
                    //Bottom Border
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.black,
                          width: 0.5,
                        ),
                      ),
                    ),
                    height: 50,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("$index"),
                        pw.SizedBox(width: 10),
                        pw.Text("$index"),
                        pw.SizedBox(width: 10),
                        pw.Text("$index"),
                        pw.SizedBox(width: 10),
                        pw.Text("$index"),
                        pw.SizedBox(width: 10),
                        pw.Text("$index"),
                      ],
                    ),
                  );
                },
              ),

              //Total
              pw.Container(
                height: 50,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(""),
                    pw.SizedBox(width: 10),
                    pw.Text(""),
                    pw.SizedBox(width: 10),
                    pw.Text("677"),
                    pw.SizedBox(width: 10),
                    pw.Text("44"),
                    pw.SizedBox(width: 10),
                    pw.Text("456"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text("Printing")),
      body: PdfPreview(
        build: (format) => _generatePdf(format, "title"),
      ),
    );
  }
}
