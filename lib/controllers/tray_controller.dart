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
      Uri.parse("${baseUrl}api/trayItem/${meal.id}/"),
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
      Uri.parse('${baseUrl}api/trayItem/${trayItem.id}/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      message.value = responseData['message'];
      update();
    }
  }
}