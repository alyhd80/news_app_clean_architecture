
import 'package:news_app_clean/core/resources/data_state.dart';
import 'package:news_app_clean/features/daily_news/domain/usecase/get_article.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/remote/article/remote_article_event.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/remote/article/remote_article_state.dart';
import 'package:bloc/bloc.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent,RemoteArticleState>{

  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase):super(const RemoteArticlesLoading()){
    on <GetArticles> (onGetArticles);
  }

  void onGetArticles(GetArticles event,Emitter<RemoteArticleState> emit)async{
   final dataState=await _getArticleUseCase();

   if(dataState is DataSuccess && dataState.data!.isNotEmpty){
     print("--------is success ${dataState.data}");
     emit(
       RemoteArticlesDone(dataState.data!)
     );
   }
   if(dataState is DataFailed){
     print("--------not success");
     print(dataState.error!.message);
     emit(
       RemoteArticlesError(dataState.error!)
     );
   }

  }

}