// To parse this JSON data, do
//
//     final gorevlerPer = gorevlerPerFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<GorevlerPer> gorevlerPerFromJson(String str) => List<GorevlerPer>.from(
    json.decode(str).map((x) => GorevlerPer.fromJson(x)));

String gorevlerPerToJson(List<GorevlerPer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GorevlerPer {
  GorevlerPer({
    this.jobId,
    this.requestId,
    this.technicianId,
    this.name,
    this.detail,
    this.priority,
    this.addressId,
    this.startDate,
    this.endDate,
    this.totalWorkTime,
    this.statusId,
    this.active,
  });

  String jobId;
  String requestId;
  String technicianId;
  String name;
  String detail;
  String priority;
  String addressId;
  DateTime startDate;
  String endDate;
  String totalWorkTime;
  String statusId;
  String active;

  factory GorevlerPer.fromJson(Map<String, dynamic> json) => GorevlerPer(
        jobId: json["job_id"],
        requestId: json["request_id"],
        technicianId: json["technician_id"],
        name: json["name"],
        detail: json["detail"],
        priority: json["priority"],
        addressId: json["address_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        totalWorkTime: json["total_work_time"],
        statusId: json["status_id"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "request_id": requestId,
        "technician_id": technicianId,
        "name": name,
        "detail": detail,
        "priority": priority,
        "address_id": addressId,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate,
        "total_work_time": totalWorkTime,
        "status_id": statusId,
        "active": active,
      };
}
