import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/router/app_router_constants.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/config/themes/button_style.dart';
import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.surfaceColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text(
                 translation(context).doctorList,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Pallets.onSurfaceColor,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                          style: appButtonStyle(Pallets.colorBlue),
                          onPressed: () {
                            Get.toNamed(RoutesPaths.contacts);
                          },
                          // },
                          child: const Icon(
                            Icons.person_add_outlined,
                            color: Colors.white,
                          )),
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                          style: appButtonStyle(Pallets.colorBlue),
                          onPressed: () {
                            Get.toNamed(RoutesPaths.setting);
                          },
                          // },
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget checkUrl(String? url) {
  // If the URL is null or empty, return a default icon or placeholder
  if (url == null || url.isEmpty) {
    return const Icon(Icons.person,
        color: Colors.grey); // Default icon for no image
  }

  return Image.network(
    url,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      // Display a default icon or placeholder image if the loading fails
      return const Icon(Icons.error, color: Colors.red); // Customize this icon
    },
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child; // Image loaded
      return const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      );
    },
  );
}
