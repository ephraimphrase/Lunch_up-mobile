import 'dart:convert';

import 'package:get/get.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/models/tray_item_model.dart';
import 'package:http/http.dart' as http;

class TrayController extends GetxController {
  
  var trayItems = <TrayItem>[].obs;
  var baseUrl = 'http://10.0.2.2:8000/';
  final userController = Get.put(UserController());
  var message = ''.obs;

  double get subTotal => trayItems.fold(0, (sum, item) => sum + int.parse(item.meal.amount)*item.quantity);
  double get total => trayItems.fold(0, (previousValue, element) => previousValue + int.parse(element.meal.amount)*element.quantity + 100);

  void getTrayItems(username) async {
    
    userController.refreshAccessToken();

    final response = await http.get(
      Uri.parse('${baseUrl}api/trayItem/$username/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode == 200) {
      
      trayItems.value = trayItemFromJson(response.body);
      update();
    }
  }

  void addToTray(meal) async {

    userController.refreshAccessToken();

    final response = await http.post(
      Uri.parse("${baseUrl}api/trayItem/$meal/"),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode == 201) {
      
      trayItems.value = trayItemFromJson(response.body);
      update();
    }
  }

  void deleteTrayItem(trayItem) async {
    userController.refreshAccessToken();

    final response = await http.delete(
      Uri.parse('${baseUrl}api/trayItem/$trayItem/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode == 200) {
      trayItems.value = trayItemFromJson(response.body);
      update();
    }
  }

  void subtractTrayItem(trayItem) async {
    userController.refreshAccessToken();

    final response = await http.post(
      Uri.parse('${baseUrl}api/trayItem/$trayItem/subtract/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode == 200) {
      trayItems.value = trayItemFromJson(response.body);
      update();
    }
  }

  void clearTray(tray) async {
    userController.refreshAccessToken();

    final response = await http.delete(
      Uri.parse('${baseUrl}api/trayItem/$tray/subtract/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode==200) {
      trayItems.value = trayItemFromJson(response.body);
    }
  }
}