// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:lunch_up/models/station_model.dart';
import 'package:lunch_up/models/tray_item_model.dart';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
    int id;
    String number;
    DateTime created;
    Station station;
    Owner owner;
    List<dynamic> trayItem;

    Order({
        required this.id,
        required this.number,
        required this.created,
        required this.station,
        required this.owner,
        required this.trayItem,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
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
