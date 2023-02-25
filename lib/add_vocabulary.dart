import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_uzb/HomePage.dart';
import 'package:eng_uzb/vocabulary.dart';
import 'package:flutter/material.dart';

class AddVocabulary extends StatefulWidget {
  const AddVocabulary({super.key});

  @override
  State<AddVocabulary> createState() => _AddVocabularyState();
}

class _AddVocabularyState extends State<AddVocabulary> {
  final TextEditingController IdController = TextEditingController();
  final TextEditingController EngController = TextEditingController();
  final TextEditingController UzbController = TextEditingController();
  int i = 0;
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("So'z qo'shing"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    getMyField(hintText: "English", controller: EngController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: getMyField(hintText: "Uzbek", controller: UzbController),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Vocabulary vocabulary = Vocabulary(
                          id: IdController.text,
                          eng: EngController.text,
                          uzb: UzbController.text);
                      if (i == 0) {
                        addVocabularyNavigateToHome(vocabulary, context);
                      }
                      i++;
                      IdController.text = "";
                      EngController.text = "";
                      UzbController.text = "";
                      focusNode.requestFocus();
                    },
                    child: Text("Qo'shish"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      IdController.text = "";
                      EngController.text = "";
                      UzbController.text = "";
                      focusNode.requestFocus();
                    },
                    child: Text("Tozalash"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getMyField(
      {required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: "${hintText}",
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    );
  }

  void addVocabularyNavigateToHome(
      Vocabulary vocabulary, BuildContext context) {
    final vocabularyRef =
        FirebaseFirestore.instance.collection("vocobularies").doc();
    vocabulary.id = vocabularyRef.id;
    log("${vocabulary.id} = bu Id");
    final date = vocabulary.toJson();
    vocabularyRef.set(date).whenComplete(() {
      log('User inserted.');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false,
      );
    });
  }
}
