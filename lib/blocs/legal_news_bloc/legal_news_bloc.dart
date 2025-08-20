import 'package:bloc/bloc.dart';
import '../../data/models/legal_news_model.dart';
import '../../data/repositories/legal_news_repository.dart';
import '../../data/services/legal_news_services.dart';
import 'legal_news_event.dart';
import 'legal_news_state.dart';

class LegalNewsBloc extends Bloc<LegalNewsEvent, LegalNewsState> {
  LegalNewsBloc() : super(LegalNewsInitial()) {
    on<LegalNewsEvent>((event, emit) async {
      if (event is AddLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {
          String result = await LegalNewsServices().addLegalNews(
            event.title,
            event.description,
          );
          emit(LegalNewsSuccess(successMsg: result));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
else
      if (event is GetAllLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {
          List<LegalNewsModel> data = await LegalNewsRepository().getLegalNews();
          emit(LegalNewsListLoaded(list: data));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      } else if (event is GetLegalNewsByIdEvent) {
        emit(LegalNewsLoading());
        try {
          LegalNewsModel news = await LegalNewsServices().getLegalNewsById(event.newsId);
          emit(LegalNewsLoaded(news: news));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
      else
      if (event is MySavedLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {
          List<LegalNewsModel> data = await LegalNewsRepository().getMySavedLegalNews();
          emit(LegalNewsListLoaded(list: data));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
      else
      if (event is LegalNewsLatestEvent) {
        emit(LegalNewsLoading());
        try {
          List<LegalNewsModel> data = await LegalNewsRepository().getLegalNewsLatest();
          emit(LegalNewsListLoaded(list: data));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }else if (event is UpdateLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {
          String result = await LegalNewsServices().updateLegalNews(
            event.newsId,
            event.title,
            event.description,
          );
          emit(LegalNewsSuccess(successMsg: result));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
      else if (event is DeleteLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {
          String result =
          await LegalNewsServices().deleteLegalNews(event.legalNewsId);
          emit(LegalNewsSuccess(successMsg: result));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
      else if (event is UnSaveLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {
          String result = await LegalNewsServices()
              .unSaveLegalNews(event.legalNewsId);
          emit(LegalNewsSuccess(successMsg: result));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
      else if (event is SaveLegalNewsEvent) {
        emit(LegalNewsLoading());
        try {

          String result = await LegalNewsServices()
              .saveLegalNews(event.legalNewsId);
          emit(LegalNewsSuccess(successMsg: result));
        } catch (e) {
          emit(LegalNewsFail(errMsg: e.toString()));
        }
      }
    });
  }
}
