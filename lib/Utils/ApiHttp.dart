import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiHttp
{
  ApiHttp._();
  static ApiHttp apiHttp = ApiHttp._();

  Future<void> PostEmailPass({required String title, required String body})
  async {
    Map requostBody = Map();
    var response = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=AAAAVWJtRTY:APA91bGN9kaW7dG2KutlAY11sk1K0RX3qsu8f3oCpM0KD3CM8n2Kx5taa_YTjY_ldeBFZtYFMu-KSHFxbHNnhzL9ZMPFoGysI4jXsYk5s4uDleyFnxaONkX36gm4DFjEHkis_FxCshzX"
      },
      body: jsonEncode(
          {
            "to": "fam9KHgISvibaFJAZ2hZKK:APA91bFbdGBG-DFBA_L1WaB9oySG_cZTkzL9QiJRw7ebgnoB7MJae_VQKuqCa7JQMsL3qtq9newlBeVos9YPYACvcT2R9j2Af0qMDsHxfl9yigpRC-2O-nlBJfXTRWntoUCB1w2FsXuR",
            "notification": {
              "title": title,
              "body": body,
              "mutable_content": true,
              "sound": "Tri-tone"
            },

            "data": {
              "url": "<url of media image>",
              "dl": "<deeplink action on tap of notification>"
            }
          }
      )
    );
  }
}