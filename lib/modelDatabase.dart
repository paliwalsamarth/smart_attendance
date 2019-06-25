// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  int index;
  String role;
  String name;
  String post;
  String attendanceId;
  String clas;
  String id;
  String branch;
  String faculty;
  String programme;
  String sec;

  Client({
    this.index,
    this.role,
    this.name,
    this.post,
    this.attendanceId,
    this.clas,
    this.id,
    this.branch,
    this.faculty,
    this.programme,
    this.sec,
  });

  factory Client.fromJson(Map<String, dynamic> json) => new Client(
    index: json["index"],
    role: json["role"],
    name: json["name"],
    post: json["post"],
    attendanceId: json["attendance_id"],
    clas: json["clas"],
    id: json["id"],
    branch: json["branch"],
    faculty: json["faculty"],
    programme: json["programme"],
    sec: json["sec"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "role": role,
    "name": name,
    "post": post,
    "attendance_id": attendanceId,
    "clas": clas,
    "id": id,
    "branch": branch,
    "faculty": faculty,
    "programme": programme,
    "sec": sec,
  };
}
