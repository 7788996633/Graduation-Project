part of 'ai_chat_bloc.dart';

@immutable
sealed class AiChatEvent {}

class AskAi extends AiChatEvent {
  final String question;

  AskAi({required this.question});
}
