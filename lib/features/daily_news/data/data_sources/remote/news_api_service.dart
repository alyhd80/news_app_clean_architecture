import 'package:dio/dio.dart';
import 'package:news_app_clean/core/constants/constants.dart';
import 'package:news_app_clean/features/daily_news/data/models/article.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET("/top-headlines")
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({  // تغییر در این خط
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
