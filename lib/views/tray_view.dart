import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_assets.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/meal_controller.dart';
import 'package:lunch_up/controllers/tray_controller.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/views/order_success_view.dart';

class TrayView extends StatelessWidget {
  TrayView({super.key});

  final trayController = Get.put(TrayController());
  final mealController = Get.put(MealController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(const Duration(minutes: 5), (timer) { 
        userController.refreshAccessToken();
      });
    },);
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Tray", size: 24, fontWeight: FontWeight.w500,),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(mealController.choice.name, size: 24, fontWeight: FontWeight.w400,),
                    (trayController.trayItems.isNotEmpty) ? GestureDetector(
                      onTap: () {
                        trayController.clearTray(userController.user.value.username);
                      },
                      child: AppText("Clear", size: 20, fontWeight: FontWeight.w400, color: AppColors.primaryColor,),
                    ) : Container()
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primaryColor,),
                    const SizedBox(width: 10,),
                    AppText(mealController.choice.delivery, size: 16, fontWeight: FontWeight.w400,)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColors.primaryColor,),
                    const SizedBox(width: 10,),
                    AppText(mealController.choice.location, size: 16, fontWeight: FontWeight.w400,)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              children: [
                AppText("Your Order", size: 24, fontWeight: FontWeight.w400,),
              ],
            ),
            const SizedBox(height: 10,),
            (trayController.trayItems.isNotEmpty) ? Expanded(
              child: Obx(() => ListView.separated(
                itemBuilder: ((context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        child: const SizedBox(
                          height: 128,
                          width: 128,
                          child: Image(image: AssetImage("assets/images/food.png"))
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(trayController.trayItems[index].meal.name, size: 16, fontWeight: FontWeight.w400,),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (trayController.trayItems[index].quantity > 1) {
                                    trayController.subtractTrayItem(trayController.trayItems[index].id);
                                  } else {
                                    trayController.deleteTrayItem(trayController.trayItems[index].id);
                                  }
                                },
                                child: Material(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  child: const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Icon(Icons.remove, color: Colors.white,),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                height: 25,
                                width: 44,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(trayController.trayItems[index].quantity.toString()),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  trayController.addToTray(trayController.trayItems[index].meal.id);
                                },
                                child: Material(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  child: const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Icon(Icons.add, color: Colors.white,),
                                  ),
                                ),
                              ),
                            ],
                          ), 
                        ],
                      ),
                      Column(
                        children: [
                          AppText("₦${trayController.trayItems[index].meal.amount}", size: 12, fontWeight: FontWeight.w400,),
                          const SizedBox(height: 20,),
                          GestureDetector(onTap: (){
                            trayController.deleteTrayItem(trayController.trayItems[index].id);
                          },child: Icon(Icons.delete_outlined, color: AppColors.primaryColor,))
                        ],
                      ),
                      const SizedBox(height: 20,),
                    ],
                  );
                }), 
                separatorBuilder: ((context, index) => const SizedBox(height: 30,)), 
                itemCount: trayController.trayItems.length
              ))  
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(image: AssetImage(AppAsset.emptyTray)),
                AppText("Sorry, It seems you don’t have", size: 18, fontWeight: FontWeight.w400, color: AppColors.secondaryText,),
                AppText("any food on your tray", size: 18, fontWeight: FontWeight.w400, color: AppColors.secondaryText,),
                const SizedBox(height: 38,)
              ],
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText("Subtotal:", size: 18, color: AppColors.secondaryText, fontWeight: FontWeight.w400,),
                AppText('₦${trayController.subTotal}', size: 14, fontWeight: FontWeight.w400,)
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText("Delivery fee:", size: 18, color: AppColors.secondaryText, fontWeight: FontWeight.w400,),
                const AppText('₦200', size: 14, fontWeight: FontWeight.w400,)
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText("Total:", size: 18, color: AppColors.secondaryText, fontWeight: FontWeight.w400,),
                AppText('₦${trayController.total}', size: 14, fontWeight: FontWeight.w400,)
              ],
            ),
            const SizedBox(height: 10,),
            (trayController.trayItems.isNotEmpty) ? Align(
              alignment: Alignment.center,
              child: Material(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 63,
                  width: 336,
                  child: AppButton(
                    child: const AppText("Place Order", size: 24, fontWeight: FontWeight.w500, color: Colors.white,),
                    onPressed: (){
                      trayController.placeOrder(mealController.choice.id);
                      Get.to(OrderSuccessView());
                    }
                  ),
                ),
              ),
            ) : Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(
                  height: 63,
                  width: 336,
                  child: AppButton(child: AppText("Place Order", size: 24, fontWeight: FontWeight.w500, color: Colors.white,),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}