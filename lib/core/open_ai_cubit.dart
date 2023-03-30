import 'package:chatgpt_demo/core/open_ai_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../services/open_ai_service.dart';

class OpenAiCubit extends Cubit<OpenAiState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  OpenAiCubit(this.formKey, this.controller) : super(OpenAiInitial());

  Future<void> getAnswer(BuildContext context) async {
    try {
      emit(OpenAiLoading());
      final response = await OpenAiService().fetchData(
        context,
        controller,
        formKey,
      );
      emit(OpenAiLoaded(response!));
    } catch (e) {
      emit(OpenAiError(e.toString()));
    }
  }
}
