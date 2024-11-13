// To parse this JSON data, do
//
//     final skinResultModel = skinResultModelFromJson(jsonString);

import 'dart:convert';

List<SkinResultModel> skinResultModelFromJson(String str) => List<SkinResultModel>.from(json.decode(str).map((x) => SkinResultModel.fromJson(x)));

String skinResultModelToJson(List<SkinResultModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkinResultModel {
    String label;
    int value;

    SkinResultModel({
        required this.label,
        required this.value,
    });

    factory SkinResultModel.fromJson(Map<String, dynamic> json) => SkinResultModel(
        label: json["label"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
    };
}
