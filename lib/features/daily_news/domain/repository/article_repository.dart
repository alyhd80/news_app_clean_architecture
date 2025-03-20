
import 'package:news_app_clean/core/resources/data_state.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository{

  /// api methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  /// database methods
  Future<List<ArticleEntity>> getSavedArticle();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);

}