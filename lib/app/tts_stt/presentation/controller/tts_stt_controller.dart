// import 'package:get/get.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';
//
// import 'package:get/get.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class SpeechTextController extends GetxController {
//   late stt.SpeechToText _speech;
//   late FlutterTts _flutterTts;
//
//   var isListening = false.obs;
//   var text = "Press the button and start speaking!".obs;
//   var confidence = 1.0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _speech = stt.SpeechToText();
//     _flutterTts = FlutterTts();
//   }
//
//   Future<void> listen() async {
//     // Check and request microphone permission
//     if (await _checkPermission()) {
//       if (!isListening.value) {
//         bool available = await _speech.initialize(
//           onStatus: (val) => print('onStatus: $val'),
//           onError: (val) => print('onError: $val'),
//         );
//         if (available) {
//           isListening.value = true;
//           _speech.listen(onResult: (val) {
//             text.value = val.recognizedWords;
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               confidence.value = val.confidence;
//             }
//           });
//         }
//       } else {
//         isListening.value = false;
//         _speech.stop();
//       }
//     }
//   }
//
//   Future<void> speak() async {
//     await _flutterTts.setLanguage("en-US");
//     await _flutterTts.setPitch(1.0);
//     await _flutterTts.speak(text.value);
//   }
//
//   Future<bool> _checkPermission() async {
//     var status = await Permission.microphone.status;
//     if (!status.isGranted) {
//       status = await Permission.microphone.request();
//     }
//     return status.isGranted;
//   }
// }
