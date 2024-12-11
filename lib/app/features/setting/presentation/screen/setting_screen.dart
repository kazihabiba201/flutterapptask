import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/core/localization/language.dart';
import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:flutterapptask/app/features/auth/presentation/controller/login_controller.dart';
import 'package:flutterapptask/main.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Pallets.surfaceColor,
      appBar: AppBar(
        backgroundColor: Pallets.colorBlue,
        titleSpacing: 0,
        title: Text(translation(context).settings, style: const TextStyle(color: Colors.white),),
        leading: InkWell(onTap: (){Get.back();}, child: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(onTap: (){loginController.logout();}, child: const Icon(Icons.logout,color: Colors.white,)),
        )],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: DropdownButton<Language>(
                menuWidth: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                dropdownColor: Colors.white,
                menuMaxHeight: 110,
                iconSize: 30,
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.language_outlined),
                      const Gap(10),
                      Text(
                        translation(context).language,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    MyApp.setLocale(context, _locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        alignment: Alignment.centerRight,
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
