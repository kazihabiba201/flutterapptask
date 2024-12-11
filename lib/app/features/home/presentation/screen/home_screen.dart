import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutterapptask/app/config/router/app_router_constants.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/config/themes/app_style.dart';
import 'package:flutterapptask/app/config/themes/button_style.dart';
import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:flutterapptask/app/features/home/presentation/controller/doctor_list_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DoctorController doctorController = DoctorController();
  final SpeechTextController _controller = Get.put(SpeechTextController());
  @override
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
            Gap(30),
            // Expanded(
            //   child: SizedBox(
            //     height: 200,
            //     child: Container(
            //       padding: const EdgeInsets.all(16.0),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8.0),
            //         color: Colors.grey[100],
            //       ),
            //       child: Column(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               padding: const EdgeInsets.all(16),
            //               child: Obx(() {
            //                 return Text(
            //                   '${_controller.text.value} ${_controller.translatedText.isEmpty ? '' : '(${_controller.translatedText.value})'}',
            //                   style: const TextStyle(fontSize: 24),
            //                 );
            //               }),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Obx(() {
            //                   return AvatarGlow(
            //                     animate: _controller.isListening.value,
            //                     glowColor: Colors.blue,
            //                     child: IconButton(
            //                       onPressed: _controller.listen,
            //                       icon: Icon(
            //                         _controller.isListening.value
            //                             ? Icons.mic
            //                             : Icons.mic_none,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   );
            //                 }),
            //                 IconButton(
            //                   onPressed: () async {
            //                     await _controller.speak();
            //                     if (_controller.text.value.isNotEmpty) {
            //                       await _controller.speakTranslated(); // This speaks the translatedText.value
            //                     }
            //                   },
            //                   icon: const Icon(
            //                     size: 30,
            //                     Icons.volume_up,
            //                     color: Colors.blueAccent,
            //                   ),
            //                   tooltip:
            //                       "Speak Both Original and Translated Text",
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Column(
                children: [
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
                            width: MediaQuery.of(context).size.width * 0.14,
                            child: ElevatedButton(
                                style: appButtonStyle(Pallets.colorBlue,BorderRadius.circular(6)),
                                onPressed: () {
                                  Get.toNamed(RoutesPaths.contacts);
                                },
                                child: const Icon(
                                  Icons.person_add_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          const Gap(5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.14,
                            child: ElevatedButton(
                                style: appButtonStyle(Pallets.colorBlue,BorderRadius.circular(6)),
                                onPressed: () {
                                  Get.toNamed(RoutesPaths.conversation);
                                },
                                child: const Icon(
                                  Icons.chat_rounded,
                                  color: Colors.white,
                                )),
                          ),
                          const Gap(5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.14,
                            child: ElevatedButton(
                                style: appButtonStyle(Pallets.colorBlue, BorderRadius.circular(6)),
                                onPressed: () {
                                  Get.toNamed(RoutesPaths.setting);
                                },
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
                      Text(
                        translation(context).showOnlyAvailableDoctors,
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade800),
                      ),
                      Obx(() {
                        return Switch(
                          splashRadius: 8,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: Pallets.colorBlue,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade200,
                          value: doctorController.onlyAvailable.value,
                          onChanged: (value) {
                            doctorController.onlyAvailable(value);
                          },
                        );
                      }),
                    ],
                  ),
                  Expanded(
                    child: Obx(() {
                      if (doctorController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (doctorController.filteredDoctors.isEmpty) {
                        return const Center(child: Text("No doctors found"));
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: doctorController.filteredDoctors.length,
                          itemBuilder: (context, index) {
                            final doctor =
                                doctorController.filteredDoctors[index];
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      child: ClipOval(
                                        child: checkUrl(doctor.profileImg),
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: doctor.availability != "Yes"
                                          ? Colors.white
                                          : Colors.white,
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: doctor.availability != "Yes"
                                          ? Colors.red.shade400
                                          : Colors.green.shade400,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                title: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      doctor.name!,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                subtitle: Text(
                                    "Specialization: ${doctor.specialization!.isEmpty ? 'N/A' : doctor.specialization}"),
                                trailing: Text(
                                    "Fee: ${doctor.visitFee!.isEmpty ? 'N/A' : doctor.visitFee}"),
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

class SpeechTextController extends GetxController {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  final GoogleTranslator _translator = GoogleTranslator();
  var isListening = false.obs;
  var text = "Press the button and start speaking!".obs;
  var confidence = 1.0.obs;
  var translatedText = "".obs;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
  }

  Future<void> listen() async {
    if (await _checkPermission()) {
      if (!isListening.value) {
        try {
          bool available = await _speech.initialize(
            onStatus: (val) {
              print('onStatus: $val');
              if (val == 'done') {
                isListening.value = false;
              }
            },
            onError: (val) {
              print('onError: $val');
              isListening.value = false;
            },
          );

          if (available) {
            isListening.value = true;
            _speech.listen(
              onResult: (val) async {
                text.value = val.recognizedWords;
                if (val.hasConfidenceRating && val.confidence > 0) {
                  confidence.value = val.confidence;
                }
                try {
                  var translation = await _translator.translate(
                    val.recognizedWords,
                    from: 'bn',
                    to: 'en',
                  );
                  translatedText.value = translation.text;
                } catch (e) {
                  print("Translation error: $e");
                }
              },
              localeId: "bn_BD",
            );
          } else {
            print("Speech recognition not available");
            isListening.value = false;
          }
        } catch (e) {
          print("Error initializing speech recognition: $e");
          isListening.value = false;
        }
      } else {
        isListening.value = false;
        _speech.stop();
      }
    }
  }

  Future<void> speak() async {
    await _flutterTts.setLanguage("bn_BD");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text.value);
  }

  Future<void> speakTranslated() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(translatedText.value);
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }
}
