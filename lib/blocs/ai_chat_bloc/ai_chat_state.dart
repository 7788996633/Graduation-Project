part of 'ai_chat_bloc.dart';

@immutable
sealed class AiChatState {}

final class AiChatInitial extends AiChatState {}

final class AiChatLoading extends AiChatState {}

final class AiChatFail extends AiChatState {
  final String errmsg;

  AiChatFail({required this.errmsg});
}

final class AiChatSuccess extends AiChatState {

  final String successmsg;

  AiChatSuccess({required this.successmsg});

}

final class AiChatLoadedSuccessfully extends AiChatState {
  final String aimsg;

  AiChatLoadedSuccessfully({required this.aimsg});
  
}
