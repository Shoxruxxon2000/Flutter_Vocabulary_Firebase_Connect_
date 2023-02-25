import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_uzb/HomePage.dart';
import 'package:eng_uzb/vocabulary.dart';
import 'package:flutter/material.dart';

class UpdateVocabulary extends StatelessWidget {
  final Vocabulary vocabulary;

  final TextEditingController IdController = TextEditingController();

  final TextEditingController EngController = TextEditingController();

  final TextEditingController UzbController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  UpdateVocabulary({super.key, required this.vocabulary});
  int k = 0;

  @override
  Widget build(BuildContext context) {
    IdController.text = "${vocabulary.id}";
    EngController.text = vocabulary.eng;
    UzbController.text = vocabulary.uzb;

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
              child: getMyField(hintText: "English", controller: EngController),
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
                    Vocabulary updateVocabulary = Vocabulary(
                        id: vocabulary.id,
                        eng: EngController.text,
                        uzb: UzbController.text);
                    if (k == 0) {
                      final collectionReference =
                          FirebaseFirestore.instance.collection('vocobularies');
                      collectionReference
                          .doc(updateVocabulary.id)
                          .update(updateVocabulary.toJson())
                          .whenComplete(() {
                        log("So'z tahrirlandi");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      });
                      k++;
                    }
                  },
                  child: Text("Tahrirlash"),
                ),
              ],
            )
          ],
        ),
      )),
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
        hintText: "${hintText}ni kiriting",
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
