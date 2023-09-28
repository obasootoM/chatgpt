import 'dart:convert';
import 'dart:io';
import 'package:chatgpt/constant/const.dart';
import 'package:chatgpt/models/mod.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  static Future<List<Model>> getModel() async {
    try {
      var response = await http.get(Uri.parse('$GET_BASE_URL/models'),
          headers: {"Authorization": "Bearer $BEARER_TOKEN"});

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonresponse['error'] $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']["message"]);
      }
      //print('jsonresponse $jsonResponse');
      List temp = [];
      for (var i in jsonResponse['data']) {
        temp.add(i);
        print('temp ${i['id']}');
      }
      return Model.modelSnapshot(temp);
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendModel(
      {required String msg, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse('$POST_BASE_URL/completions'),
          headers: {
            "Authorization": "Bearer $BEARER_TOKEN",
            "Content-Type": "application/json"
          },
          body:
              jsonEncode({"model": modelId, "prompt": msg, "max_tokens": 100}));

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonresponse['error'] $jsonResponse['error']['message']");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> listModel = [];
      if (jsonResponse['choices'].length > 0) {
        listModel = List.generate(
            jsonResponse['choices'].length,
            (index) => ChatModel(
                msg: jsonResponse['choices'][index]['text'], index: 1));
      }
      return listModel;
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }
}
