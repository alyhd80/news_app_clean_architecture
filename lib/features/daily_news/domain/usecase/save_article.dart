import 'package:news_app_clean/core/resources/data_state.dart';
import 'package:news_app_clean/core/usecases/usecase.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean/features/daily_news/domain/repository/article_repository.dart';

class SavedArticleUseCase
    implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  SavedArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.saveArticle(params!);
  }
}
