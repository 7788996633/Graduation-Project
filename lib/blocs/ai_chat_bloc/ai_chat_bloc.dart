import 'package:bloc/bloc.dart';
import 'package:graduation/data/services/ai_chat_services.dart';
import 'package:meta/meta.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  AiChatBloc() : super(AiChatInitial()) {
    on<AskAi>((event, emit) async {
      emit(AiChatLoading());
      try {
        final answer = await AiChatServices().askAi(event.question);

        emit(AiChatSuccess(
          question: event.question,
          answer: answer,
        ));
      } catch (e) {
        emit(AiChatFail(errmsg: e.toString()));
      }
    });
  }
}
