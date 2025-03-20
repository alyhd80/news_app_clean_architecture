import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_state.dart';
import 'package:news_app_clean/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_app_clean/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:news_app_clean/injection_container.dart';

class SavedArticle extends HookWidget {
  const SavedArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.chevron_left_outlined,
            color: Colors.black,
          ),
        ),
      ),
      title: Text(
        "Saved Articles",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticlesState>(
      builder: (context, state) {
        print("------state");
        print(state);
        if (state is LocalArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is LocalArticlesDone) {
          return _buildArticleList(state.articles!);
        }
        return Container();
      },
    );
  }

  Widget _buildArticleList(List<ArticleEntity> article) {
    print("-------article lenght ${article.length}");
    if (article.isEmpty) {
      return Center(
        child: Text(
          "List is Empty",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: article.length,
          itemBuilder: (context, index) {
            return ArticleWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArticleDetailsView(
                          article: article[index],
                        )));
              },
              onTapRemove: () => _onRemoveArticle(context, article[index]),
              isRemoveEnable: true,
              article: article[index],
            );
          });
    }
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
  }
}
