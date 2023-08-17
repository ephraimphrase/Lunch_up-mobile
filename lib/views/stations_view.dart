import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/dashboard_controller.dart';
import 'package:lunch_up/controllers/meal_controller.dart';
import 'package:lunch_up/views/meal_view.dart';


class StationsView extends StatelessWidget {
  StationsView({super.key});

  final dashboardController = Get.put(DashboardController());
  final mealController = Get.put(MealController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Obx(() => AppText("Stations in ${dashboardController.location.value}", size: 24, fontWeight: FontWeight.w500, color: Colors.black,),)
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [ 
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount: dashboardController.stations.length,
                separatorBuilder: ((context, index) => const SizedBox(height: 30,)),
                itemBuilder: ( (context, index) {
                  return GestureDetector(
                    onTap: () {
                      mealController.getMeals(dashboardController.stations[index]);
                      mealController.choice = dashboardController.stations[index];
                      Get.to(MealView());
                    },
                    child: SizedBox(
                      width: 349,
                      height: 100,
                      child: Stack(
                        children: [
                          Container(
                            // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(dashboardController.stations[index].coverArt), fit: BoxFit.fill)),
                          ),
                          Container(
                            color: AppColors.overlay1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(dashboardController.stations[index].name, size: 24, fontWeight: FontWeight.w500, color: Colors.white,),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })
              )) 
            )
          ],
        ),
      ),
    );
  }
}