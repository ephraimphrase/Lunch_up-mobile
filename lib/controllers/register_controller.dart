import 'package:get/state_manager.dart';
import 'package:lunch_up/models/user_model.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var user = User(username: "", password: "", email: "", firstName: "", lastName: "").obs;

  void registerUser() async {
    var baseUrl = 'http://10.0.2.2:8000/';
    
    var userData = userToJson(user);

    final response = await http.post(
      Uri.parse('${baseUrl}api/accounts/register/'),
      
    )
  }
}