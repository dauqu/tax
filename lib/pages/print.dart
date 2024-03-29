import 'dart:typed_data';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

              pw.Table(children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    shape: pw.BoxShape.rectangle,
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  children: [
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text("S.No"),
                    ),
                    pw.SizedBox(width: 10),
                    // pw.Text(widget.items[index].items),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text("Item Name"),
                    ),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text("Price"),
                    ),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text("Quantity"),
                    ),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text("Total Amount"),
                    ),
                  ],
                ),
              ]),

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
                    child: pw.Table(
                      children: [
                        pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            shape: pw.BoxShape.rectangle,
                            border: pw.Border(
                              bottom: pw.BorderSide(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          children: [
                            pw.Container(
                              width: 200,
                              height: 40,
                              alignment: pw.Alignment.centerLeft,
                              // padding: const pw.EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: pw.Text((index + 1).toString(),
                                  style: const pw.TextStyle(fontSize: 15)),
                            ),
                            pw.SizedBox(width: 10),
                            // pw.Text(widget.items[index].items),
                            pw.Container(
                              width: 200,
                              height: 40,
                              alignment: pw.Alignment.centerLeft,
                              // padding: const pw.EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: pw.Text(widget.items[index].items),
                            ),
                            pw.Container(
                              width: 200,
                              height: 40,
                              alignment: pw.Alignment.centerLeft,
                              // padding: const pw.EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: pw.Text(
                                  widget.items[index].price.toString(),
                                  style: const pw.TextStyle(fontSize: 15)),
                            ),
                            pw.Container(
                              width: 200,
                              height: 40,
                              alignment: pw.Alignment.centerLeft,
                              // padding: const pw.EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: pw.Text(
                                  widget.items[index].quantity.toString(),
                                  style: const pw.TextStyle(fontSize: 15)),
                            ),
                            pw.Container(
                              width: 200,
                              height: 40,
                              alignment: pw.Alignment.centerLeft,
                              // padding: const pw.EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: pw.Text(
                                  (widget.items[index].price *
                                          widget.items[index].quantity)
                                      .toString(),
                                  style: const pw.TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              pw.SizedBox(height: 50),

              //Total
              pw.Table(children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    shape: pw.BoxShape.rectangle,
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  children: [
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text(widget.items.length.toString(),
                          style: const pw.TextStyle(fontSize: 15)),
                    ),
                    pw.SizedBox(width: 10),
                    // pw.Text(widget.items[index].items),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text(".............."),
                    ),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text(
                          widget.items
                              .map((e) => e.price)
                              .reduce((value, element) => value + element)
                              .toString(),
                          style: const pw.TextStyle(fontSize: 15)),
                    ),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text(
                          widget.items
                              .map((e) => e.quantity)
                              .reduce((value, element) => value + element)
                              .toString(),
                          style: const pw.TextStyle(fontSize: 15)),
                    ),
                    pw.Container(
                      width: 200,
                      height: 40,
                      alignment: pw.Alignment.centerLeft,
                      // padding: const pw.EdgeInsets.all(5),
                      // color: Colors.grey[200],
                      child: pw.Text(
                          widget.items
                              .map((e) => e.price * e.quantity)
                              .reduce((value, element) => value + element)
                              .toString(),
                          style: const pw.TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
              ]),
              //Total
              // pw.Container(
              //   height: 50,
              //   child: pw.Row(
              //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //     children: [
              //       pw.Text(widget.items.length.toString()),
              //       pw.SizedBox(width: 10),
              //       pw.Text("................."),
              //       pw.SizedBox(width: 10),
              //       pw.Text(widget.items
              //           .map((e) => e.price * e.quantity)
              //           .reduce((value, element) => value + element)
              //           .toString()),
              //       pw.SizedBox(width: 10),
              //       pw.Text(widget.items
              //           .map((e) => e.quantity)
              //           .reduce((value, element) => value + element)
              //           .toString()),
              //       pw.SizedBox(width: 10),
              //       pw.Text(widget.items
              //           .map((e) => e.price * e.quantity)
              //           .reduce((value, element) => value + element)
              //           .toString()),
              //     ],
              //   ),
              // ),
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
        pdfFileName: "Item-TxnData.pdf",
        initialPageFormat: PdfPageFormat.a3,
        pageFormats: const {
          "A3": PdfPageFormat.a3,
          "Letter": PdfPageFormat.letter,
          "A4": PdfPageFormat.a4,
          "A5": PdfPageFormat.a5,
        },
        build: (format) => _generatePdf(format, "title"),
      ),
    );
  }
}
