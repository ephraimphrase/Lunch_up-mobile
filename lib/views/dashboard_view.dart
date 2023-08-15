import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_up/components/assets/app_assets.dart';
import 'package:lunch_up/components/assets/app_colors.dart';
import 'package:lunch_up/components/widgets/app_button.dart';
import 'package:lunch_up/components/widgets/app_text.dart';
import 'package:lunch_up/views/stations_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
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
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
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
                const SizedBox(height: 100,),
                Column(
                  children: [
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: const SizedBox(
                        width: 334,
                        height: 45,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            labelText: "Enter your location",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Material(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                      child: AppButton(
                        width: 334,
                        height: 45,
                        onPressed: (){
                          Get.to(const StationsView());
                        },
                        child: AppText("Order Now", color: AppColors.primaryText, fontWeight: FontWeight.w400, size: 18,)))
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