import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class APIHandler {
  static Future<List<dynamic>> getData(
      {required String target, String? limit}) async {
    try {
      var url;
      var uri = Uri.https(
          url,
          "api/v1/$target",
          target == "products"
              ? {
                  "offset": "0",
                  "limit": limit,
                }
              : {});
      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
        // print("V $v \n\n");
      }
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }
}
