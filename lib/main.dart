import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean/config/theme/app_themes.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/remote/article/remote_article_bloc.dart';
import 'package:news_app_clean/features/daily_news/presentation/bloc/remote/article/remote_article_event.dart';
import 'package:news_app_clean/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app_clean/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: DailyNews(),
      ),
    );
  }
}
