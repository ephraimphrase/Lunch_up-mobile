import 'dart:convert';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:get/get.dart';
import 'package:lunch_up/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var user = User(username: "", password: "", email: "", firstName: "", lastName: "").obs;
  var baseUrl = 'http://10.0.2.2:8000/';
  var accessToken = ''.obs;
  var refreshToken = '';
  var error = ''.obs;
  var signUp = 'Sign Up'.obs;
  var signIn = 'Sign In'.obs;

  void registerUser() async {
    
    var userData = userToJson(user.value);

    final response = await http.post(
      Uri.parse('${baseUrl}api/accounts/register/'),
      headers: {'content-type': 'application/json'},
      body: userData
    );

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);

      accessToken.value = responseData['token'];
      refreshToken = responseData['refresh'];

      user.value = User.fromJson(responseData['user']);

      update();

      await FlutterSessionJwt.saveToken(accessToken.value);

    } else {

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

      accessToken.value = responseData['access'];
      refreshToken = responseData['refresh'];

      update();

      await FlutterSessionJwt.saveToken(accessToken.value);
    } else if (response.statusCode == 401) {
      var responseData = jsonDecode(response.body);

      error.value = responseData['detail'];
    }
  }

  void refreshAccessToken() async {

    var exp = await FlutterSessionJwt.isTokenExpired();

    if (exp == true) {
      var token = await http.post(
        Uri.parse("${baseUrl}api/accounts/refresh/"),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "refresh":refreshToken
          }
        )
      );

      if (token.statusCode==200) {
        var newaccessToken = jsonDecode(token.body);
        accessToken.value = newaccessToken['access'];

        await FlutterSessionJwt.saveToken(accessToken.value);
      }
    }
  }

  void getUserDetails(username) async {

    refreshAccessToken();

    final response  = await http.get(
      Uri.parse("${baseUrl}api/accounts/users/$username/"),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${accessToken.value}',
      },
    );

    if (response.statusCode == 200) {
      user.value = userFromJson(response.body);
      update();
    }
  }

  void logoutUser() async {
    
    refreshAccessToken();

    final response = await http.get(
      Uri.parse("${baseUrl}api/accounts/logout/"),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${accessToken.value}',
      }
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
    }

  }
}