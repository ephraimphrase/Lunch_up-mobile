// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

import 'package:lunch_up/models/station_model.dart';
import 'package:lunch_up/models/tray_item_model.dart';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
    int id;
    String number;
    DateTime created;
    Station station;
    Owner owner;
    List<dynamic> trayItem;

    OrderDetail({
        required this.id,
        required this.number,
        required this.created,
        required this.station,
        required this.owner,
        required this.trayItem,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        number: json["number"],
        created: DateTime.parse(json["created"]),
        station: Station.fromJson(json["station"]),
        owner: Owner.fromJson(json["owner"]),
        trayItem: List<dynamic>.from(json["tray_item"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "created": created.toIso8601String(),
        "station": station.toJson(),
        "owner": owner.toJson(),
        "tray_item": List<dynamic>.from(trayItem.map((x) => x)),
    };
}