import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'dart:async';

class DocumentViewer extends StatefulWidget {
  final Reference documentRef;

  const DocumentViewer({super.key, required this.documentRef});

  @override
  _DocumentViewerState createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  PDFDocument? document;

  Future<void> loadDocument() async {
    final url = await widget.documentRef.getDownloadURL();
    print(url);
    document = await PDFDocument.fromURL(url);
    print('done');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    if (document == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF68B1D0),
            title: Text(widget.documentRef.name),
            centerTitle: true,
          ),
          body: PDFViewer(
            document: document!,
          ));
    }
  }
}
