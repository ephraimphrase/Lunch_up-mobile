import 'package:get/get.dart';
import 'package:lunch_up/views/order_details_view.dart';

class SuccessController extends GetxController {
  
  void countDown(){
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(OrderDetailsView());
    }); 
  }
}