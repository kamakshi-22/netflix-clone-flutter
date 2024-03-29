import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/data/data.dart';
import 'package:flutter_netflix_clone/models/content_model.dart';
import 'package:flutter_netflix_clone/screens/screens.dart';
import 'package:flutter_netflix_clone/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    // dispose the scrollController
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[850],
          onPressed: () {},
          child: const Icon(Icons.cast),
        ),
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50.0),
          child: CustomAppBar(
            scrollOffset: _scrollOffset,
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: ContentHeader(
                featuredContent: sintelContent,
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.only(top: 20.0),
                sliver: SliverToBoxAdapter(
                  child: Previews(
                    title: 'Previews',
                    contentList: previews,
                  ),
                )),
            SliverToBoxAdapter(
              child: ContentList(
                title: 'My List',
                contentList: myList,
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                title: 'Netflix Originals',
                contentList: originals,
                isOriginals: true,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: ContentList(
                  title: 'Trending',
                  contentList: trending,
                ),
              ),
            ),
          ],
        ));
  }
}
