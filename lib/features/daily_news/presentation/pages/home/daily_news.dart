import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/remote/article/remote_article_bloc.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/remote/article/remote_article_state.dart';
import 'package:news_app_clean/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_app_clean/features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:news_app_clean/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SavedArticle()));
      }),
      body: BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
          builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is RemoteArticlesError) {
          return Center(
            child: Icon(Icons.refresh),
          );
        }

        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index) {
              print("------data: ${index}   ${state.articles![index]}");
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleDetailsView(
                                article: state.articles![index],
                              )));
                },
                title: ArticleWidget(
                  article: state.articles![index],
                ),
              );
            },
          );
        }

        return SizedBox();
      }),
    );
  }

  _buildAppBar({VoidCallback? onTap}) {
    return AppBar(
      leading: GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.save,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Daily News",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
