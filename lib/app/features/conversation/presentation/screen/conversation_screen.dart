import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/config/themes/button_style.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final SpeechController _controller = Get.put(SpeechController());
  final PatientSpeechController _patientController =
      Get.put(PatientSpeechController());
  @override
  void initState() {
    super.initState();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Doctor Speak Now',
              style: TextStyle(color: Pallets.buttonColor, fontSize: 20),
            ),
          )),
          content: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: AvatarGlow(
                animate: _controller.isListening.value,
                glowCount: 3,
                glowColor: Colors.blue,
                glowRadiusFactor: 0.4,
                child: GestureDetector(
                  onTap: _controller.listen,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      _controller.isListening.value
                          ? Icons.mic
                          : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: ElevatedButton(
                      style: appButtonStyle(
                          Pallets.buttonColor, BorderRadius.circular(10)),
                      onPressed: () {  if (_controller.isReadyToSave.value) {
                        if (_controller.text.value.isNotEmpty) {
                          _controller.saveText(); // Save text
                          Navigator.pop(context); // Close dialog
                        } else {
                          print(
                              "Cannot save. Recognized text is empty."); // Debug log
                        }
                      } else {
                        print(
                            "Recognition/translation is not yet complete."); // Debug log
                      }},
                      child: const Text(
                        'Translate and read aloud',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAlertPatientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Patient Speak Now',
              style: TextStyle(color: Pallets.buttonColor, fontSize: 20),
            ),
          )),
          content: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: AvatarGlow(
                animate: _patientController.isListening.value,
                glowCount: 3,
                glowColor: Colors.blue,
                glowRadiusFactor: 0.4,
                child: GestureDetector(
                  onTap: _patientController.listen,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      _patientController.isListening.value
                          ? Icons.mic
                          : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: ElevatedButton(
                      style: appButtonStyle(
                          Pallets.buttonColor, BorderRadius.circular(10)),
                      onPressed: () {
                        if (_patientController.isReadyToSave.value) {
                          if (_patientController.text.value.isNotEmpty) {
                            _patientController.saveText(); // Save text
                            Navigator.pop(context); // Close dialog
                          } else {
                            print(
                                "Cannot save. Recognized text is empty."); // Debug log
                          }
                        } else {
                          print(
                              "Recognition/translation is not yet complete."); // Debug log
                        }
                      },
                      child: const Text(
                        'Translate and read aloud',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.surfaceColor,
      appBar: AppBar(
        backgroundColor: Pallets.surfaceColor,
        surfaceTintColor: Pallets.surfaceColor,
        leading: InkWell(onTap: (){Get.back();}, child: const Icon(Icons.arrow_back_ios)),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Doctor',
                  style: TextStyle(fontSize: 28, color: Pallets.containerColor),
                ),
              ),
            ),
            const Gap(5),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return Text(
                      _controller.isReadyToSave.value
                          ? _controller.savedText.value
                          :    'Press the button and start speaking!',
                      style: const TextStyle(fontSize: 24),
                    );
                  }),
                ),
                IconButton(
                  onPressed: () async {
                    await _controller.speak();

                  },
                  icon: const Icon(
                    size: 30,
                    Icons.volume_up,
                    color: Colors.blueAccent,
                  ),
                  tooltip: "Speak Both Original and Translated Text",
                ),
              ],
            ),
            const Gap(25),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Patient',
                  style: TextStyle(fontSize: 28, color: Pallets.containerColor),
                ),
              ),
            ),
            const Gap(5),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return Text(
                      _patientController.isReadyToSave.value
                          ? _patientController.savedText.value
                          :    'Press the button and start speaking!',
                      style: const TextStyle(fontSize: 24),
                    );
                  }),
                ),
                IconButton(
                  onPressed: () async {
                    await _patientController.speak();

                  },
                  icon: const Icon(
                    size: 30,
                    Icons.volume_up,
                    color: Colors.blueAccent,
                  ),
                  tooltip: "Speak Both Original and Translated Text",
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.42,
              child: ElevatedButton(
                  style: appButtonStyle(
                      Pallets.surfaceColor, BorderRadius.circular(0),
                      borderColor: Pallets.buttonColor),
                  onPressed: () {
                    _showAlertPatientDialog(context);
                  },
                  child: const Text(
                    'Patient',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )),
            ),
            const Gap(10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.42,
              child: ElevatedButton(
                  style: appButtonStyle(
                      Pallets.buttonColor, BorderRadius.circular(0)),
                  onPressed: () {
                    _showAlertDialog(context);
                  },
                  child: const Text(
                    'Doctor',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class SpeechController extends GetxController {
  var savedText = "".obs;
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  final GoogleTranslator _translator = GoogleTranslator();
  var isListening = false.obs;
  var text = "Press the button and start speaking!".obs;
  var confidence = 1.0.obs;
  var translatedText = "".obs;
  var isReadyToSave = false.obs;
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
                if (translatedText.value.isNotEmpty) {
                  isReadyToSave.value = true;
                }
              }
            },
            onError: (val) {
              print('onError: $val');
              isListening.value = false;
            },
          );

          if (available) {
            isListening.value = true;
            isReadyToSave.value = false; // Reset flag before listening
            _speech.listen(
              onResult: (val) async {
                text.value = val.recognizedWords;
                print("Recognized Words: ${text.value}");

                if (val.hasConfidenceRating && val.confidence > 0) {
                  confidence.value = val.confidence;
                }

                // Translate the text here
                await translateText();
              },
              localeId: "en-US",
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

  Future<void> translateText() async {
    try {
      if (text.value.isEmpty) {
        print("Text is empty, nothing to translate.");
        return;
      }

      print("Translating: ${text.value}");
      var translation = await _translator.translate(text.value, from: 'en', to: 'bn');
      translatedText.value = translation.text.trim();
      print("Translated Text: ${translatedText.value}");

      if (translatedText.value.isNotEmpty) {
        isReadyToSave.value = true;
      }
    } catch (e, stackTrace) {
      print("Translation error: $e");
      print("Stack Trace: $stackTrace");
    }
  }

  void saveText() {
    // Ensure valid text and translation before saving
    if (text.value.isNotEmpty && translatedText.value.isNotEmpty) {
      savedText.value = '${text.value} (${translatedText.value})';
      print("Saved Text: ${savedText.value}");

      // Stop listening explicitly after saving
      if (isListening.value) {
        _speech.stop();
        isListening.value = false;
      }
    } else {
      print("Text or TranslatedText is empty. Cannot save.");
    }
  }


  Future<void> speak() async {
    try {
      if (text.value.isNotEmpty) {
        // Set up FlutterTts to wait for speech completion
        await _flutterTts.setLanguage("en-US");
        await _flutterTts.setPitch(1.0);
        await _flutterTts.awaitSpeakCompletion(true);

        // Speak the original text
        print("Speaking text: ${text.value}");
        await _flutterTts.speak(text.value);

        // Wait for the speech to finish
        print("Finished speaking text.");

        if (translatedText.value.isNotEmpty) {
          // Change language and speak the translated text
          await _flutterTts.setLanguage("bn-BD");
          print("Speaking translated text: ${translatedText.value}");
          await _flutterTts.speak(translatedText.value);

          // Wait for the translated speech to finish
          print("Finished speaking translated text.");
        } else {
          print("Translated text is empty. Skipping.");
        }
      } else {
        print("Text is empty. Nothing to speak.");
      }
    } catch (e) {
      print("Error while speaking: $e");
    }
  }


  Future<bool> _checkPermission() async {
    if (await Permission.microphone.isGranted) {
      return true;
    }
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    Get.snackbar('Permission Denied', 'Please enable microphone access from settings.');
    return false;
  }

}

class PatientSpeechController extends GetxController {
  var savedText = "".obs;
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  final GoogleTranslator _translator = GoogleTranslator();
  var isListening = false.obs;
  var text = "Press the button and start speaking!".obs;
  var confidence = 1.0.obs;
  var translatedText = "".obs;
  var isReadyToSave = false.obs;
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
                if (translatedText.value.isNotEmpty) {
                  isReadyToSave.value = true;
                }
              }
            },
            onError: (val) {
              print('onError: $val');
              isListening.value = false;
            },
          );

          if (available) {
            isListening.value = true;
            isReadyToSave.value = false; // Reset flag before listening
            _speech.listen(
              onResult: (val) async {
                text.value = val.recognizedWords;
                print("Recognized Words: ${text.value}");

                if (val.hasConfidenceRating && val.confidence > 0) {
                  confidence.value = val.confidence;
                }

                // Translate the text here
                await translateText();
              },
              localeId: "bn-BD",
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

  Future<void> translateText() async {
    try {
      if (text.value.isEmpty) {
        print("Text is empty, nothing to translate.");
        return;
      }

      print("Translating: ${text.value}");
      var translation = await _translator.translate(text.value, from: 'bn', to: 'en');
      translatedText.value = translation.text.trim();
      print("Translated Text: ${translatedText.value}");

      if (translatedText.value.isNotEmpty) {
        isReadyToSave.value = true;
      }
    } catch (e, stackTrace) {
      print("Translation error: $e");
      print("Stack Trace: $stackTrace");
    }
  }

  void saveText() {
    // Ensure valid text and translation before saving
    if (text.value.isNotEmpty && translatedText.value.isNotEmpty) {
      savedText.value = '${text.value} (${translatedText.value})';
      print("Saved Text: ${savedText.value}");

      // Stop listening explicitly after saving
      if (isListening.value) {
        _speech.stop();
        isListening.value = false;
      }
    } else {
      print("Text or TranslatedText is empty. Cannot save.");
    }
  }

  Future<void> speak() async {
    try {
      if (text.value.isNotEmpty) {
        // Set up FlutterTts to wait for speech completion
        await _flutterTts.setLanguage("bn_BD");
        await _flutterTts.setPitch(1.0);
        await _flutterTts.awaitSpeakCompletion(true);

        // Speak the original text
        print("Speaking text: ${text.value}");
        await _flutterTts.speak(text.value);

        // Wait for the speech to finish
        print("Finished speaking text.");

        if (translatedText.value.isNotEmpty) {
          // Change language and speak the translated text
          await _flutterTts.setLanguage("en-US");
          print("Speaking translated text: ${translatedText.value}");
          await _flutterTts.speak(translatedText.value);

          // Wait for the translated speech to finish
          print("Finished speaking translated text.");
        } else {
          print("Translated text is empty. Skipping.");
        }
      } else {
        print("Text is empty. Nothing to speak.");
      }
    } catch (e) {
      print("Error while speaking: $e");
    }
  }


  Future<bool> _checkPermission() async {
    if (await Permission.microphone.isGranted) {
      return true;
    }
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    Get.snackbar('Permission Denied', 'Please enable microphone access from settings.');
    return false;
  }

}
