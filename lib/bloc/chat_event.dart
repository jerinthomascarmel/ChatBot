part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class OnChatEventSendButtonClicked extends ChatEvent {
  final String inputMessage;

  OnChatEventSendButtonClicked({required this.inputMessage});
}
