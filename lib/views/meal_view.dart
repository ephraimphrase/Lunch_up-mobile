import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_assets.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/meal_controller.dart';
import 'package:lunch_up/controllers/tray_controller.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/views/tray_view.dart';

class MealView extends StatelessWidget {
  MealView({super.key});

  final mealController = Get.put(MealController());
  final trayController = Get.put(TrayController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(mealController.choice.name, size: 24, fontWeight: FontWeight.w500, color: Colors.black,),
        elevation: 0,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              trayController.getTrayItems(userController.user.value.username);
              Get.to(TrayView());
            },
            child: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(mealController.meals.length, (index) {
                  return GestureDetector(
                    onTap: () => trayController.addToTray(mealController.meals[index].id),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 145,
                          height: 300,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(image: AssetImage("assets/images/food.png")),
                              ),
                              Expanded(
                                child: AppText(mealController.meals[index].name, size: 16, fontWeight: FontWeight.w400,)
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(AppAsset.calories),
                                      const AppText("201 cal", size: 13, fontWeight: FontWeight.w400,)
                                    ],
                                  ),
                                  AppText('₦${mealController.meals[index].amount}')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            )
          ],
        ),
      ),
    );
  }
}