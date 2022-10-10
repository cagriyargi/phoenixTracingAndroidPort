// To parse this JSON data, do
//
//     final gorevlerOpSteps = gorevlerOpStepsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<GorevlerOpSteps> gorevlerOpStepsFromJson(String str) =>
    List<GorevlerOpSteps>.from(
        json.decode(str).map((x) => GorevlerOpSteps.fromJson(x)));

String gorevlerOpStepsToJson(List<GorevlerOpSteps> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GorevlerOpSteps {
  GorevlerOpSteps({
    this.stepId,
    this.requestId,
    this.stepLine,
    this.step,
    this.done,
  });

  String stepId;
  String requestId;
  String stepLine;
  String step;
  String done;

  factory GorevlerOpSteps.fromJson(Map<String, dynamic> json) =>
      GorevlerOpSteps(
        stepId: json["step_id"],
        requestId: json["request_id"],
        stepLine: json["step_line"],
        step: json["step"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "step_id": stepId,
        "request_id": requestId,
        "step_line": stepLine,
        "step": step,
        "done": done,
      };
}
