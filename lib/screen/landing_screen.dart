import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../core/open_ai_cubit.dart';
import '../core/open_ai_state.dart';
import '../models/open_ai_model.dart';
import '../services/open_ai_service.dart';
import 'ideas_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT Demo'),
        ),
        body: BlocProvider(
          create: (context) => OpenAiCubit(),
          child: BlocBuilder<OpenAiCubit, OpenAiState>(
            builder: (context, state) {
              if (state is OpenAiInitial) {
                return Form(
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
                          controller: controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () async {
                            await OpenAiService()
                                .fetchData(context, controller, _formKey);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is OpenAiLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OpenAiLoaded) {
                return IdeasScreen(gptReponseData: state.gptReponseData);
              }
            },
          ),
        ));
  }
}
