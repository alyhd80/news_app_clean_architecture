
import 'package:news_app_clean/core/resources/data_state.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository{

  Future<DataState<List<ArticleEntity>>> getNewsArticles();

}