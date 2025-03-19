import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_clean/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleWidget({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [_buildImage(context), _buildTitleAndDescription(context)],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {


    print('--data ${article?.author??""}');

    return CachedNetworkImage(
      imageUrl: article!.urlToImage??"",
      imageBuilder: (context, imageProvider) => Padding(
        padding: EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            child: CupertinoActivityIndicator(),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Padding(
          padding: EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              child: Icon(Icons.error),
              decoration:
                  BoxDecoration(color: Colors.black.withValues(alpha: 0.08)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleAndDescription(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article!.title ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                article!.description ?? "",
                maxLines: 2,
              ),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.timeline_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                article!.publishedAt??"",
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    ));
  }
}
