// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:probot/config.dart';

class ApiServices {
  static var client = http.Client();
  static List<Map<String, String>> conversationHistory = [];

  static Future<String> chatCompeletionResponse(String prompt,
      {addApiKey}) async {
    bool isLocalChatApi = appCtrl.storage.read(session.isChatGPTKey) ?? false;
    if (isLocalChatApi == false || addApiKey == null) {
      final firebaseCtrl = Get.isRegistered<SubscriptionFirebaseController>()
          ? Get.find<SubscriptionFirebaseController>()
          : Get.put(SubscriptionFirebaseController());
      firebaseCtrl.removeBalance();
    }
    var url = Uri.https("api.openai.com", "/v1/chat/completions");
    log("prompt : $prompt");

    conversationHistory.add({"role": "user", "content": prompt});

    String localApi = appCtrl.storage.read(session.chatGPTKey) ?? "";
    log("API: $localApi");
    String apiKey = "";
    if (addApiKey != null) {
      apiKey = addApiKey;
    } else {
      if (localApi == "") {
        apiKey = appCtrl.firebaseConfigModel!.chatGPTKey!;
      } else {
        apiKey = localApi;
      }
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
        "messages": conversationHistory
      }),
    );

    // Do something with the response
    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    log("RES $newresponse");

    if (response.statusCode == 200) {
      conversationHistory.add({
        "role": "assistant",
        "content": newresponse['choices'][0]['message']['content']
      });

      return response.statusCode == 200
          ? newresponse['choices'][0]['message']['content']
          : "";
    } else {
      return "";
    }
  }
}
