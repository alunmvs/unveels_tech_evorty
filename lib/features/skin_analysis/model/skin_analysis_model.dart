// To parse this JSON data, do
//
//     final skinAnalysisModel = skinAnalysisModelFromJson(jsonString);

import 'dart:convert';

List<SkinAnalysisModel> skinAnalysisModelFromJson(String str) => List<SkinAnalysisModel>.from(json.decode(str).map((x) => SkinAnalysisModel.fromJson(x)));

String skinAnalysisModelToJson(List<SkinAnalysisModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkinAnalysisModel {
    int skinAnalysisModelClass;
    String label;
    double score;

    SkinAnalysisModel({
        required this.skinAnalysisModelClass,
        required this.label,
        required this.score,
    });

    factory SkinAnalysisModel.fromJson(Map<String, dynamic> json) => SkinAnalysisModel(
        skinAnalysisModelClass: json["class"],
        label: json["label"],
        score: json["score"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "class": skinAnalysisModelClass,
        "label": label,
        "score": score,
    };
}
