import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/config/themes/app_style.dart';
import 'package:flutterapptask/app/config/themes/button_style.dart';
import 'package:flutterapptask/app/core/constants/app_constants.dart';
import 'package:flutterapptask/app/core/constants/assets_path.dart';
import 'package:flutterapptask/app/core/utils/validation/validation.dart';
import 'package:flutterapptask/app/core/widgets/custom_image_assets.dart';
import 'package:flutterapptask/app/features/auth/presentation/controller/login_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.find<LoginController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    print("Widget is rebuilding");
    return  WillPopScope(
      onWillPop: () async {
      return false;
      },
      child: Scaffold(
        backgroundColor: Pallets.surfaceColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customImageAssets(
                      imagePath: Assets.imagesAppLogo,
                      height: 110,
                    ),
                    const Gap(5),
                    const Text(
                      AppConstants.loginTitle,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Pallets.onSurfaceColor,
                      ),
                    ),
                    const Gap(65),
                    TextFormField(
                      controller: emailController,
                      validator:    EmailFieldValidator.validate,
                      onChanged: (value) => loginController.username.value = value,
                      decoration: appInputDecoration(
                        AppConstants.email,
                        suffixIcon: false,
                      ),
                    ),
                    const Gap(25),
                    Obx(() => TextFormField(
                      controller: passwordController,
                      obscureText: loginController.isObscured,
                      validator: PasswordFieldValidator.validate,
                      onChanged: (value) => loginController.password.value = value,
                      decoration: appInputDecoration(
                        AppConstants.password,
                        isObscured: loginController.isObscured,
                        toggleObscure: loginController.togglePasswordVisibility,
                      ),
                    )),
                    const Gap(35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GetBuilder<LoginController>(
                          builder: (controller) {
                            if (controller.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ElevatedButton(
                              style: appButtonStyle(Colors.transparent),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.login();

                                  emailController.clear();
                                  passwordController.clear();
                                }
                              },
                              child: successButtonChild(AppConstants.loginTextButton),
                            );
                          },
                        ),

                      ],
                    ),
                    Obx(() => Text(
                      loginController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    )),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
