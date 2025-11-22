part of 'ai_chat_bloc.dart';

@immutable
sealed class AiChatState {}

final class AiChatInitial extends AiChatState {}

final class AiChatLoading extends AiChatState {}

final class AiChatFail extends AiChatState {
  final String errmsg;

  AiChatFail({required this.errmsg});
}

class AiChatSuccess extends AiChatState {
  final String question;
  final String answer;

  AiChatSuccess({required this.question, required this.answer});
}

final class AiChatLoadedSuccessfully extends AiChatState {
  final String aimsg;

  AiChatLoadedSuccessfully({required this.aimsg});
}
