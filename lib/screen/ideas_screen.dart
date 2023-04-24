import 'package:flutter/material.dart';

import '../models/open_ai_model.dart';

class IdeasScreen extends StatelessWidget {
  GptData gptReponseData;
  IdeasScreen({super.key, required this.gptReponseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "The AI has generated the following answer:",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            gptReponseData.choices[0].text,
            style: const TextStyle(fontSize: 20),
          ),
        )
      ]),
    );
  }
}
