import 'package:get/get.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import '../models/station_model.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController{
  var buttonText = "Order Now".obs;
  var location = "".obs;
  var stations = <Station>[].obs;

  final userController = Get.put(UserController());

  void getStations(location) async {
    var baseUrl = "http://10.0.2.2:8000/";

    final response = await http.get(
      Uri.parse('${baseUrl}api/stations/$location/'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${userController.accessToken.value}',
      },
    );

    if (response.statusCode == 200) {

      var station = stationFromJson(response.body);

      stations.value = station;
      update();
    }
  }
}