import 'dart:convert';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:get/get.dart';
import 'package:lunch_up/models/user_model.dart';
import 'package:http/http.dart' as http;



class UserController extends GetxController {
  var user = User(username: "", password: "", email: "", firstName: "", lastName: "").obs;
  var baseUrl = 'http://10.0.2.2:8000/';
  var accessToken = '';
  var refreshToken = '';
  var error = ''.obs;
  var isAuthenticated = false.obs;
  var signUp = 'Sign Up'.obs;

  void registerUser() async {
    
    var userData = userToJson(user.value);

    final response = await http.post(
      Uri.parse('${baseUrl}api/accounts/register/'),
      headers: {'content-type': 'application/json'},
      body: userData
    );

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);

      accessToken = responseData['token'];
      refreshToken = responseData['refresh'];
      user.value = userFromJson(response.body[2]);

      isAuthenticated.value = true;

      update();

      await FlutterSessionJwt.saveToken(accessToken);

      var token = await FlutterSessionJwt.getPayload();
      print(token);
      print(user.value);

    } else {
      print(response.body);

      // error.value = responseData['error'];
      update();
    }
  }

  void loginUser() async {}
}