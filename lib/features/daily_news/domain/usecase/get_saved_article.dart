import 'package:news_app_clean/core/resources/data_state.dart';
import 'package:news_app_clean/core/usecases/usecase.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase
    implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticle();
  }
}
