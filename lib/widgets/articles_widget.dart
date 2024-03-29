// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:newsrestapi/inner_screens/blog_details.dart';
import 'package:newsrestapi/providers/news_provider.dart';
import 'package:newsrestapi/services/models/news_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:newsrestapi/consts/utils.dart';
import 'package:newsrestapi/inner_screens/news_details_webview.dart';
import 'package:newsrestapi/providers/theme_provider.dart';
import 'vertical_spacing.dart';

class ArticlesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var utils = Utils(context: context);
    var newsProvider = context.read<NewsModel>();
    Size size = utils.getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(NewsDetailsScreen.routeName,
                arguments: newsProvider.publishedAt);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: newsProvider.publishedAt,
                          child: FancyShimmerImage(
                            height: size.height * 0.12,
                            width: size.height * 0.12,
                            boxFit: BoxFit.fill,
                            errorWidget:
                                Image.asset('assets/images/empty_image.png'),
                            imageUrl: newsProvider.urlToImage,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            newsProvider.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: utils.smallTextStyle.copyWith(
                              color: themeProvider.getDarkTheme
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 ${newsProvider.readingTimeText}',
                              style: utils.smallTextStyle.copyWith(
                                color: themeProvider.getDarkTheme
                                    ? Colors.black
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: NewsDetailsWebView(
                                            url: newsProvider.url,
                                          ),
                                          inheritTheme: true,
                                          ctx: context),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.link,
                                    color: themeProvider.getDarkTheme
                                        ? Colors.black
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                  ),
                                ),
                                Text(
                                  newsProvider.dateToShow,
                                  maxLines: 1,
                                  style: utils.smallTextStyle.copyWith(
                                    color: themeProvider.getDarkTheme
                                        ? Colors.black
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
