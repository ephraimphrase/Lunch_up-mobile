import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_assets.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/dashboard_controller.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/views/stations_view.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final textController = TextEditingController();
  final dashboardController = Get.put(DashboardController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(const Duration(minutes: 5), (timer) { 
        userController.refreshAccessToken();
      });
    },);
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppAsset.dashboard), fit: BoxFit.cover)),
        ),
        Scaffold(
          backgroundColor: AppColors.overlay,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        AppText("The best foods", size: 36, fontWeight: FontWeight.w500, color: AppColors.primaryText,),
                        AppText("delivered to your", size: 36, fontWeight: FontWeight.w500, color: AppColors.primaryText,),
                        AppText("doorstep", size: 36, fontWeight: FontWeight.w500, color: AppColors.primaryText,),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 90,),
                Column(
                  children: [
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: 334,
                        height: 45,
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Enter your location",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Material(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                      child: Obx(() => AppButton(
                        width: 334,
                        height: 45,
                        onPressed: (){
                          dashboardController.location.value = textController.text;
                          dashboardController.getStations(textController.text);
                          Get.to(
                            StationsView()
                          );
                        },
                        child: AppText(dashboardController.buttonText.value, color: AppColors.primaryText, fontWeight: FontWeight.w400, size: 18,)))
                      ) 
                  ],
               )
              ],
            ),
          ),
        )
      ],
    );
  }
}