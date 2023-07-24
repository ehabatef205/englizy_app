import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englizy_app/shared/components.dart';
import 'package:englizy_app/shared/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class AdminViewPdfLinkHomework extends StatefulWidget {
  final String link;
  final String name;
  final String unitId;
  final String userId;
  final String grade;

  const AdminViewPdfLinkHomework(
      {required this.link,
      required this.name,
      required this.unitId,
      required this.userId,
      required this.grade,
      Key? key})
      : super(key: key);

  @override
  State<AdminViewPdfLinkHomework> createState() =>
      _AdminViewPdfLinkHomeworkState();
}

enum DocShown { sample, tutorial, hello, password }

class _AdminViewPdfLinkHomeworkState extends State<AdminViewPdfLinkHomework> {
  late PdfControllerPinch _pdfControllerPinch;
  TextEditingController gradeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void updateGrade() {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      FirebaseFirestore.instance
          .collection("units")
          .doc(widget.unitId)
          .collection("homework")
          .doc(widget.userId)
          .update({"grade": gradeController.text}).whenComplete(() async{
            Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfViewPinch(
              builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                options: const DefaultBuilderOptions(),
                documentLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                pageLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                errorBuilder: (_, error) =>
                    Center(child: Text(error.toString())),
              ),
              controller: _pdfControllerPinch,
              padding: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              key: formKey,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormFieldWidget(
                        controller: gradeController,
                        type: TextInputType.text,
                        context: context,
                        hint: widget.grade.toString(),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Grade is required";
                          }
                          return null;
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color2,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          updateGrade();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
