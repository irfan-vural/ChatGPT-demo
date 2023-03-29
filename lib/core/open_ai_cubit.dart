import 'package:chatgpt_demo/core/open_ai_state.dart';
import 'package:chatgpt_demo/services/open_ai_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenAiCubit extends Cubit<OpenAiState> {
  OpenAiCubit() : super(OpenAiInitial());

  Future<void> getAnswer() async {
    try {
      emit(OpenAiLoading());

      emit(OpenAiLoaded("Hello"));
    } catch (e) {
      emit(OpenAiError(e.toString()));
    }
  }
}
