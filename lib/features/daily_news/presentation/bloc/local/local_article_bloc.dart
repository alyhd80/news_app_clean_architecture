

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean/features/daily_news/domain/usecase/get_saved_article.dart';
import 'package:news_app_clean/features/daily_news/domain/usecase/remove_article.dart';
import 'package:news_app_clean/features/daily_news/domain/usecase/save_article.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent,LocalArticlesState>{
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SavedArticleUseCase _savedArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCasel;

  LocalArticleBloc(this._getSavedArticleUseCase, this._savedArticleUseCase,
      this._removeArticleUseCasel):super(const LocalArticlesLoading()){
   on<GetSavedArticles>(onGetSavedArticles);
   on<RemoveArticle>(onRemoveArticle);
   on<SaveArticle>(onSaveArticle);

  }


  void onGetSavedArticles(GetSavedArticles event,Emitter<LocalArticlesState> emit)async{
    final articles=await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(RemoveArticle removeArticle,Emitter<LocalArticlesState> emit)async{
    await _removeArticleUseCasel(params: removeArticle.article);
    final articles=await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(SaveArticle saveArticle,Emitter<LocalArticlesState> emit)async{
    await _savedArticleUseCase(params: saveArticle.article);
    final articles=await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

}