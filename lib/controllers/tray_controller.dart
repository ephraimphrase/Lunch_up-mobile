import 'package:get/get.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/models/order_detail_model.dart';
import 'package:lunch_up/models/station_model.dart';
import 'package:lunch_up/models/tray_item_model.dart';
import 'package:http/http.dart' as http;

class TrayController extends GetxController {
  
  var trayItems = <TrayItem>[].obs;
  var baseUrl = 'http://10.0.2.2:8000/';
  final userController = Get.put(UserController());
  var message = ''.obs;
  var order = OrderDetail(
      id: 0,
      number: '',
      created: DateTime(2023),
      station: Station(
          id: 0,
          name: '',
          location: '',
          coverArt: '',
          delivery: '',
          opening: '',
          closing: ''),
      owner: Owner(
          id: 0,
          password: '',
          lastLogin: '',
          isSuperuser: false,
          username: '',
          firstName: '',
          lastName: '',
          email: '',
          isStaff: false,
          isActive: false,
          dateJoined: DateTime(2023),
          groups: [],
          userPermissions: []),
      trayItem: []).obs;

  double get subTotal => trayItems.fold(0, (sum, item) => sum + int.parse(item.meal.amount)*item.quantity);
  double get total => trayItems.fold(0, (previousValue, element) => (previousValue + int.parse(element.meal.amount)*element.quantity) + 200);

  void getTrayItems(username) async {

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

    final response = await http.delete(
      Uri.parse('${baseUrl}api/trayItem/$tray/subtract/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode==200) {
      trayItems.clear();
      update();
    }
  }

  void placeOrder(tray) async {

    final response = await http.post(
      Uri.parse('${baseUrl}api/orders/$tray/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}'
      },
    );

    if (response.statusCode == 200) {
      clearTray(userController.user.value.username);
      trayItems.clear();
      order.value = orderDetailFromJson(response.body);
      update();
    }
  }
}