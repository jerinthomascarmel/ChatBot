import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/models/chat_message_model.dart';
import 'package:gemini_app/repo/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<OnChatEventSendButtonClicked>(onChatEventSendButtonClicked);
  }

  List<ChatMessageModel> messages = [];
  FutureOr<void> onChatEventSendButtonClicked(
      OnChatEventSendButtonClicked event, Emitter<ChatState> emit) async {
    final String input = event.inputMessage;
    messages.add(
        ChatMessageModel(role: "user", parts: [ChatPartModel(text: input)]));
    emit(ChatSuccess(isGenerating: true, messages: messages.reversed.toList()));
    final answerbyBot = await ChatRepo.chatTextGenerationRepo(messages);
    answerbyBot.fold((l) {
      emit(ChatFailure(
          messages: messages.reversed.toList(), errorText: l.message));
    }, (r) {
      messages.add(
          ChatMessageModel(role: "model", parts: [ChatPartModel(text: r)]));
      emit(ChatSuccess(
          isGenerating: false, messages: messages.reversed.toList()));
    });
  }
}
