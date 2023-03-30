import 'dart:convert';
import 'package:chatgpt_demo/constants/open_ai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/open_ai_model.dart';
import '../screen/ideas_screen.dart';

class OpenAiService {
  String apiKey = Constants().apiKey;
  var response;
  Future<GptData?> fetchData(
    BuildContext context,
    TextEditingController _controller,
    GlobalKey<FormState> _formKey,
  ) async {
    var url = Uri.parse('https://api.openai.com/v1/completions');

    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $apiKey'
    };

    String promptData = " ${_controller.value.text} ";

    final data = jsonEncode({
      "model": "text-davinci-003",
      "prompt": promptData,
      "temperature": 0.4,
      "max_tokens": 64,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    });

    if (_formKey.currentState!.validate()) {
      response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        return gptDataFromJson(response.body);
      }
    }
  }
}
