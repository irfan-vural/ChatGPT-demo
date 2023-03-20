import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/open_ai_model.dart';
import 'ideas_screen.dart';

const List<String> listOfRelations = <String>[
  'Friend',
  'Partner',
  'Spouse',
  'Sibling'
];
const List<String> listOfOccasions = <String>[
  "Valentine's Day",
  'Birthday',
  'Anniversary',
  'Retirement'
];

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var response;
  String apiKey = "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";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = new TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT Demo'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some hobbies';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    await fetchData(context);
                  },
                ),
              ),
              Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 206, 66, 66),
                        )
                      : Text("")),
            ],
          ),
        ));
  }

  Future<void> fetchData(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('https://api.openai.com/v1/completions');

    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $apiKey'
    };

    //String promptData =
    //    "Suggest gift ideas for someone who is realted to me as $firstDropdownValue of $gender gender for the occasion of $secondDropdownValue in budget less than 10,000 rupees with ${_controller.value.text} as hobbies.";
    String promptData = " ${_controller.value.text} ";
    print(promptData);
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
        setState(() {
          isLoading = false;
        });

        final gptData = gptDataFromJson(response.body);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IdeasScreen(gptReponseData: gptData)));
      }
    }
  }
}
