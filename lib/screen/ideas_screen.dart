import 'package:flutter/material.dart';

import '../models/open_ai_model.dart';

class IdeasScreen extends StatelessWidget {
  GptData gptReponseData;
  IdeasScreen({super.key, required this.gptReponseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Here are your answer",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            gptReponseData.choices[0].text,
          ),
        )
      ]),
    );
  }
}
