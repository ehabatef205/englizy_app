import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class ViewPdfLink extends StatefulWidget {
  final String link;
  final String name;
  const ViewPdfLink({required this.link, required this.name, Key? key}) : super(key: key);

  @override
  State<ViewPdfLink> createState() => _ViewPdfLinkState();
}

enum DocShown { sample, tutorial, hello, password }

class _ViewPdfLinkState extends State<ViewPdfLink> {
  late PdfControllerPinch _pdfControllerPinch;

  @override
  void initState() {
    _pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openData(
        InternetFile.get(
          widget.link,
        ),
      ),
      initialPage: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfControllerPinch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: TextStyle(
          color: Theme
              .of(context)
              .textTheme
              .bodyText1!
              .color,
        ),),
      ),
      body: PdfViewPinch(
        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) =>
          const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) =>
          const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),
        ),
        controller: _pdfControllerPinch,
        padding: 10,
      ),
    );
  }
}