import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:news_app_clean/injection_container.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          behavior: HitTestBehavior.opaque,
          child: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article!.title!,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Icon(
                Icons.alarm_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                article!.publishedAt!,
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: EdgeInsets.only(top: 14),
      child: Image.network(
        article!.urlToImage!,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Text(
        "${article!.description ?? ""}\n\n${article!.content ?? ""}",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
        builder: (context) => FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () => _onFloatingActionButtonPressed(context),
              // رفع مشکل
              child: Icon(
                Icons.book,
                color: Colors.white,
              ),
            ));
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Article save successful.')));
  }
}
