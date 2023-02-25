// To parse this JSON data, do
//
//     final vocabulary = vocabularyFromJson(jsonString);

import 'dart:convert';

Vocabulary vocabularyFromJson(String str) => Vocabulary.fromJson(json.decode(str));

String vocabularyToJson(Vocabulary data) => json.encode(data.toJson());

class Vocabulary {
    Vocabulary({
        this.id,
        required this.eng,
        required this.uzb,
    });

     String? id;
    final String eng;
    final String uzb;

    factory Vocabulary.fromJson(Map<String, dynamic> json) => Vocabulary(
        id: json["id"],
        eng: json["eng"],
        uzb: json["uzb"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "eng": eng,
        "uzb": uzb,
    };
}
