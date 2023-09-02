import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_assets.dart';
import 'package:lunch_up/controllers/success_controller.dart';
import 'package:lunch_up/controllers/tray_controller.dart';

class OrderSuccessView extends StatelessWidget {
  OrderSuccessView({super.key});

  final trayController = Get.put(TrayController());
  final successController = Get.put(SuccessController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      successController.countDown();
     });
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAsset.successIcon)
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}