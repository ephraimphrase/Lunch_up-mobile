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

      user.value = User.fromJson(responseData['user']);

      update();

      await FlutterSessionJwt.saveToken(accessToken);

    } else {
      print(response.body);

      // error.value = responseData['error'];
      update();
    }
  }

  void loginUser() async {
    var userData = userToJson(user.value);

    final response = await http.post(
      Uri.parse("${baseUrl}api/accounts/login/"),
      headers: {'content-type': 'application/json'},
      body: userData
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      accessToken = responseData['access'];
      refreshToken = responseData['refresh'];

      await FlutterSessionJwt.saveToken(accessToken);
    }
  }

  void getUserDetails(username) async {

    var exp = await FlutterSessionJwt.isTokenExpired();

    if (exp == true) {
      
    }

    final response  = await http.get(
      Uri.parse("${baseUrl}api/accounts/users/$username/"),
      headers: {
        'content-type': 'application/json',
        'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      user.value = userFromJson(response.body);
      update();
    }
  }
}