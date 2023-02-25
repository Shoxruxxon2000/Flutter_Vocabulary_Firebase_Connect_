import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_uzb/add_vocabulary.dart';
import 'package:eng_uzb/vocabulary.dart';
import 'package:flutter/material.dart';

import 'updateVocobluary.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('vocobularies');

  // List<Vocabulary> vocabulary = [
  //   Vocabulary(id: 1, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 2, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 3, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 4, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 5, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 6, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 7, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 8, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 9, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 10, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 11, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 12, eng: "saf", uzb: "few"),
  //   Vocabulary(id: 13, eng: "sdf", uzb: "fe"),
  //   Vocabulary(id: 14, eng: "f", uzb: "ewf"),
  //   Vocabulary(id: 15, eng: "dsvs", uzb: "we")
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("So'zlar"),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Biroz kuting"),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> dacuments = querySnapshot.docs;
            
            List<Vocabulary> vocabulary = dacuments
                .map(
                  (e) => Vocabulary(
                    id: e['id'],
                    eng: e['eng'],
                    uzb: e['uzb'],
                  ),
                )
                .toList();
            return _getBody(vocabulary);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVocabulary(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _getBody(List<Vocabulary> vocabulary) {
    return vocabulary.isEmpty
        ? Center(
            child: Text(
              "Bazaga ulanishni imkoni bo'lmadi. \nQayta urinib ko'ring",
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: vocabulary.length,
            itemBuilder: (context, index) => Card(
              color: Colors.amber.shade400,
              child: ListTile(
                subtitle: Text(vocabulary[index].uzb),
                title: Text(vocabulary[index].eng),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Colors.black.withOpacity(0.75),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateVocabulary(
                                  vocabulary: vocabulary[index]),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red.withOpacity(0.75),
                        ),
                        onTap: () {
                          _reference.doc(vocabulary[index].id).delete();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
