import 'dart:convert';

List<DestekSorgu> destekSorguFromJson(String str) => List<DestekSorgu>.from(
    json.decode(str).map((x) => DestekSorgu.fromJson(x)));

String destekSorguToJson(List<DestekSorgu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestekSorgu {
  DestekSorgu({
    this.requestId,
    this.userId,
    this.destinationUsers,
    this.name,
    this.detail,
    this.statusId,
    this.active,
  });

  String requestId;
  String userId;
  String destinationUsers;
  String name;
  String detail;
  String statusId;
  String active;

  factory DestekSorgu.fromJson(Map<String, dynamic> json) => DestekSorgu(
        requestId: json["request_id"],
        userId: json["user_id"],
        destinationUsers: json["destination_users"],
        name: json["name"],
        detail: json["detail"],
        statusId: json["status_id"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "request_id": requestId,
        "user_id": userId,
        "destination_users": destinationUsers,
        "name": name,
        "detail": detail,
        "status_id": statusId,
        "active": active,
      };
}
