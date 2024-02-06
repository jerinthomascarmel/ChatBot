part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
  final bool isGenerating;
  final List<ChatMessageModel> messages;

  ChatSuccess({required this.isGenerating, required this.messages});
}

final class ChatFailure extends ChatState {
  final List<ChatMessageModel> messages;
  final String errorText;

  ChatFailure({required this.messages, required this.errorText});
}
