import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/views/dashboard_view.dart';
import 'package:lunch_up/views/register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final userController = Get.put(UserController());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Sign In", size: 24, fontWeight: FontWeight.w400,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 360,
                      height: 51,
                      child: TextField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: "Enter username",
                          prefixIcon: const Icon(Icons.phone)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 360,
                      height: 51,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: "Enter password",
                          prefixIcon: const Icon(Icons.lock)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100,),
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      child: Obx(() => AppButton(
                        width: 360,
                        height: 63,
                        onPressed: () {
                          userController.user.value.username = usernameController.text;
                          userController.user.value.password = passwordController.text;
      
                          userController.loginUser();
      
                          if (userController.error.value == '') {
                            Get.to(DashboardView());
                          }
                        },
                        child: AppText(userController.signIn.value, size: 24, fontWeight: FontWeight.w500, color: Colors.white,),
                      )),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () => Get.to(RegisterView()),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.w400)
                              )
                            ]
                          )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
                        child: AppText("Forgot Password?", size: 18, fontWeight: FontWeight.w400, color: AppColors.primaryColor,)
                      ),
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}