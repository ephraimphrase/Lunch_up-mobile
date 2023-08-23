import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/views/dashboard_view.dart';
import 'package:lunch_up/views/login_view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final userController = Get.put(UserController());
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Sign Up", size: 24, fontWeight: FontWeight.w700,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 51,
                        width: 360,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: "First Name"
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 51,
                        width: 360,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: "Last Name"
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 51,
                        width: 360,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Email"
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 51,
                        width: 360,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: userNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: "Username"
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 51,
                        width: 360,
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passWordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Password"
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                        child: Obx(() =>AppButton(
                          onPressed: () {
                            userController.user.value.firstName = firstNameController.text;
                            userController.user.value.lastName = lastNameController.text;
                            userController.user.value.email = emailController.text;
                            userController.user.value.username = userNameController.text;
                            userController.user.value.password = passWordController.text;

                            userController.registerUser();

                            if (userController.error.value == '') {
                              Get.snackbar("Success", "User Succesfully created", margin: const EdgeInsets.all(15));
                              Get.to(DashboardView());
                            } else {
                              Get.snackbar("Error", userController.error.value, margin: const EdgeInsets.all(15));
                            }
                          },
                          height: 63,
                          width: 360,
                          child: AppText(userController.signUp.value, size: 24, fontWeight: FontWeight.w500, color: Colors.white,),
                        ),) 
                      ),
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () => Get.to(const LoginView()),
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: "Log in",
                                style: TextStyle(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.w400)
                              )
                            ]
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}