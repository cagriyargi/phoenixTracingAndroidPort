// To parse this JSON data, do
//
//     final gorevlerPerSteps = gorevlerPerStepsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<GorevlerPerSteps> gorevlerPerStepsFromJson(String str) =>
    List<GorevlerPerSteps>.from(
        json.decode(str).map((x) => GorevlerPerSteps.fromJson(x)));

String gorevlerPerStepsToJson(List<GorevlerPerSteps> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GorevlerPerSteps {
  GorevlerPerSteps({
    this.stepId,
    this.stepCode,
    this.requestId,
    this.stepLine,
    this.step,
    this.done,
  });

  String stepId;
  String stepCode;
  String requestId;
  String stepLine;
  String step;
  String done;

  factory GorevlerPerSteps.fromJson(Map<String, dynamic> json) =>
      GorevlerPerSteps(
        stepId: json["step_id"],
        stepCode: json["step_code"],
        requestId: json["request_id"],
        stepLine: json["step_line"],
        step: json["step"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "step_id": stepId,
        "step_code": stepCode,
        "request_id": requestId,
        "step_line": stepLine,
        "step": step,
        "done": done,
      };
}
