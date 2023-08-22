import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final registerController = Get.put(RegisterController());
  final firstNameController = Get.put(TextEditingController());
  final lastNameController = Get.put(TextEditingController());
  final emailController = Get.put(TextEditingController());
  final userNameController = Get.put(TextEditingController());
  final passWordController = Get.put(TextEditingController());

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
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
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
                          controller: passWordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
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
                        child: AppButton(
                          onPressed: () {
                            registerController.user.value.firstName = firstNameController.text;
                            registerController.user.value.lastName = lastNameController.text;
                            registerController.user.value.email = emailController.text;
                            registerController.user.value.username = userNameController.text;
                            registerController.user.value.password = passWordController.text;

                            registerController.registerUser();
                          },
                          height: 63,
                          width: 360,
                          child: const AppText("Sign Up", size: 24, fontWeight: FontWeight.w500, color: Colors.white,),
                        ),
                      ),
                    ),
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