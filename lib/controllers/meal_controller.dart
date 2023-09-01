import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/models/meal_model.dart';
import 'package:lunch_up/models/station_model.dart';

class MealController extends GetxController {

  final userController = Get.put(UserController());

  var meals = <Meal>[].obs;
  Station choice = Station(id: 0, name: '', location: '', coverArt: '', delivery: '', opening: '', closing: '');

  void getMeals(station) async{
    var baseUrl = 'http://10.0.2.2:8000/';

    try {
      userController.refreshAccessToken();
    } finally {
      final response = await http.get(
        Uri.parse('${baseUrl}api/$station/meals/'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${userController.accessToken.value}'
        },
      );

      if (response.statusCode == 200) {
        var meal = mealFromJson(response.body);
        meals.value = meal;

        update();
      } 
    }

  }
}