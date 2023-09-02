import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/controllers/tray_controller.dart';
import 'package:lunch_up/controllers/user_controller.dart';
import 'package:lunch_up/views/stations_view.dart';

class OrderDetailsView extends StatelessWidget {
  OrderDetailsView({super.key});

  final trayController = Get.put(TrayController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Order Details", size: 24, fontWeight: FontWeight.w400,),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText('Order number: ${trayController.order.value.number}'),
                      AppText('Created: ${trayController.order.value.created}'),
                      AppText('Station: ${trayController.order.value.station.name}'),
              
                      const SizedBox(height: 10,),
              
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10,);
                          },
                          itemCount: trayController.order.value.trayItem.length,
                          itemBuilder: ( (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(20),
                                  child: const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image(image: AssetImage("assets/images/food.png"))
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(trayController.trayItems[index].meal.name, size: 16, fontWeight: FontWeight.w400,),
                                    AppText('₦${trayController.trayItems[index].meal.amount}', size: 16, fontWeight: FontWeight.w400,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText('Quantity: ${trayController.trayItems[index].quantity}', size: 16, fontWeight: FontWeight.w400,),
                                  ],
                                ),
                              ],
                            );
                          })
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Material(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 63,
                  width: 336,
                  child: AppButton(
                    child: const AppText("Continue", size: 24, fontWeight: FontWeight.w500, color: Colors.white,),
                    onPressed: () {
                      trayController.clearTray(userController.user.value.username);
                      trayController.trayItems.clear();

                      Get.to(StationsView());
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}