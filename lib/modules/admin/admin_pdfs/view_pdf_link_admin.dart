import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class ViewPdfLinkAdmin extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;

  const ViewPdfLinkAdmin({required this.data, Key? key}) : super(key: key);

  @override
  State<ViewPdfLinkAdmin> createState() => _ViewPdfLinkAdminState();
}

enum DocShown { sample, tutorial, hello, password }

class _ViewPdfLinkAdminState extends State<ViewPdfLinkAdmin> {
  late PdfControllerPinch _pdfControllerPinch;

  @override
  void initState() {
    _pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openData(
        InternetFile.get(
          widget.data["pdf"],
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
        title: Text(
          widget.data["name"],
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text('Do you want to delete this?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("pdfs")
                                .doc(widget.data.id)
                                .delete()
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  ),
              icon: const Icon(Icons.delete_outline)),
        ],
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

/*
await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "posts")
                                                                        .doc(data[
                                                                                index]
                                                                            .id)
                                                                        .collection(
                                                                            "comments")
                                                                        .doc(value
                                                                            .docs[
                                                                                i]
                                                                            .id)
                                                                        .delete();
                                                                  }
                                                                }).whenComplete(
                                                                        () async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "posts")
                                                                      .doc(data[
                                                                              index]
                                                                          .id)
                                                                      .delete();
                                                                });
 */
