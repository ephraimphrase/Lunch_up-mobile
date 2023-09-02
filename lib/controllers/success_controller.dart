import 'package:get/get.dart';
import 'package:lunch_up/views/stations_view.dart';

class SuccessController extends GetxController {
  
  void countDown(){
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(StationsView());
    }); 
  }
}