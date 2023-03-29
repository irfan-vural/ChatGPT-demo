class OpenAiState {
  OpenAiState();
}

class OpenAiInitial extends OpenAiState {
  OpenAiInitial();
}

class OpenAiLoading extends OpenAiState {
  OpenAiLoading();
}

class OpenAiLoaded extends OpenAiState {
  OpenAiLoaded(this.response);
  final String response;
}

class OpenAiError extends OpenAiState {
  OpenAiError(this.error);
  final String error;
}
