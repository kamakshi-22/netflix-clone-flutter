import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/assets.dart';
import 'package:flutter_netflix_clone/widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset; // scrollOffset is the distance scrolled
  const CustomAppBar({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 24.0,
        ),
        // set the color of the appbar to black when the scrollOffset is 350
        color: Colors.black.withOpacity(
          (scrollOffset / 350).clamp(0, 1).toDouble(),
        ),
        child: Responsive(
          mobile: CustomAppBarMobile(),
          desktop: CustomAppBarDesktop(),
        ));
  }
}

class CustomAppBarMobile extends StatelessWidget {
  const CustomAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  title: 'TV Shows',
                  onTap: () => print('TV Shows'),
                ),
                _AppBarButton(
                  title: 'Movies',
                  onTap: () => print('Movies'),
                ),
                _AppBarButton(
                  title: 'My List',
                  onTap: () => print('Latest'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBarDesktop extends StatelessWidget {
  const CustomAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  title: 'Home',
                  onTap: () => print('Home'),
                ),
                _AppBarButton(
                  title: 'Latest',
                  onTap: () => print('Latest'),
                ),
                _AppBarButton(
                  title: 'TV Shows',
                  onTap: () => print('TV Shows'),
                ),
                _AppBarButton(
                  title: 'Movies',
                  onTap: () => print('Movies'),
                ),
                _AppBarButton(
                  title: 'My List',
                  onTap: () => print('My List'),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => print('Search'),
                  icon: const Icon(Icons.search),
                  iconSize: 28.0,
                  color: Colors.white,
                  padding: const EdgeInsets.all(0),
                ),
                _AppBarButton(
                  title: 'KIDS',
                  onTap: () => print('KIDS'),
                ),
                _AppBarButton(
                  title: 'DVD',
                  onTap: () => print('DVD'),
                ),
                IconButton(
                  onPressed: () => print('Gift'),
                  icon: const Icon(Icons.card_giftcard),
                  iconSize: 28.0,
                  color: Colors.white,
                  padding: const EdgeInsets.all(0),
                ),
                IconButton(
                  onPressed: () => print('Notification'),
                  icon: const Icon(Icons.notifications),
                  iconSize: 28.0,
                  color: Colors.white,
                  padding: const EdgeInsets.all(0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const _AppBarButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
