import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/router/app_router_constants.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/config/themes/button_style.dart';
import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:flutterapptask/app/features/home/presentation/controller/doctor_list_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DoctorController doctorController = DoctorController();
  void initState() {
    super.initState();

    doctorController.fetchDoctorData();
  }
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
                      width:  MediaQuery.of(context).size.width * 0.14,
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
                      width: MediaQuery.of(context).size.width * 0.14,
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
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).showOnlyAvailableDoctors, style: TextStyle(fontSize: 15, color: Colors.grey.shade800),),
        Obx(() {
      return Switch(
        splashRadius: 8,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: Pallets.colorBlue,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.shade200,
        value: doctorController.onlyAvailable.value,
        onChanged: (value) {
          doctorController.onlyAvailable(value);
        },
      );}),
              ],
            ),
            Expanded(
              child:   Obx(() {
                    if (doctorController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (doctorController.filteredDoctors.isEmpty) {
                      return const Center(child: Text("No doctors found"));
                    } else {
                      return ListView.builder(padding: EdgeInsets.zero,
                        itemCount: doctorController.filteredDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctorController.filteredDoctors[index];
                          return Card(color: Colors.white,
                            child: ListTile(
                              leading: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    child: ClipOval(
                                      child:  checkUrl(doctor.profileImg),
                                    ),
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: doctor.availability != "Yes" ? Colors.white: Colors.white,
                                    size: 14,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: doctor.availability != "Yes" ? Colors.red.shade400: Colors.green.shade400,
                                    size: 12,
                                  ),
                                ],
                              ),
                              title: SizedBox(width:MediaQuery.of(context).size.width * 0.4, child: Text(doctor.name!, overflow: TextOverflow.ellipsis,)),
                              subtitle: Text("Specialization: ${doctor.specialization!.isEmpty ? 'N/A' : doctor.specialization }"),
                              trailing: Text("Fee: ${doctor.visitFee!.isEmpty ?  'N/A' :doctor.visitFee }"),

                            ),
                          );
                        },
                      );
                    }
                  }),
            ),


          ],
        ),
      ),
    );
  }
}


final Set<String> _failedImageUrls = {};

Widget checkUrl(String? url) {

  if (url == null || url.isEmpty || _failedImageUrls.contains(url)) {
    return const Icon(Icons.person, color: Colors.grey);
  }

  return Image.network(
    url,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      // Cache this URL as failed to avoid reloading
      if (url != null) {
        _failedImageUrls.add(url);
      }

      return const Icon(Icons.person, color: Colors.grey);
    },
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return const Center(child: CircularProgressIndicator());
    },
  );
}