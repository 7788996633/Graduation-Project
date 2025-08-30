import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  AiChatBloc() : super(AiChatInitial()) {
    on<AiChatEvent>((event, emit) {
      if (event is AskAi) {
        emit(
          AiChatLoading(),
        );
        try {} on Exception catch (e) {
          emit(
            AiChatFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
