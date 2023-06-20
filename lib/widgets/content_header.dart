import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/models/content_model.dart';
import 'package:flutter_netflix_clone/widgets/responsive.dart';
import 'package:flutter_netflix_clone/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const _ContentHeaderMobile({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(featuredContent.imageUrl),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250,
            child: Image.asset(featuredContent.titleImageUrl!),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: 'List',
                  onTap: () => print('My List'),
                ),
                _PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'Info',
                  onTap: () => print('Info'),
                ),
              ],
            ))
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const _ContentHeaderDesktop({super.key, required this.featuredContent});

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController? _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    // initialize the videoController and set the volume to 0 and play the video and set the looping to true and setState to update the UI
    _videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl!)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play()
          ..setLooping(true);
  }

  @override
  void dispose() {
    // dispose the videoController
    _videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController!.value.isPlaying
          ? _videoController!.pause()
          : _videoController!.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // if the videoController is initialized then show the videoPlayer else show the image
          AspectRatio(
            aspectRatio: _videoController!.value.isInitialized
                ? _videoController!.value.aspectRatio
                : 2.344,
            child: _videoController!.value.isInitialized
                ? VideoPlayer(_videoController!)
                : Image.asset(
                    widget.featuredContent.imageUrl!,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController!.value.isInitialized
                  ? _videoController!.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
              ),
            ),
          ),

          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(widget.featuredContent.titleImageUrl!),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                      child: TextButton.icon(
                        onPressed: () => print('More Info'),
                        icon: const Icon(
                          Icons.info_outline,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'More Info',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    if (_videoController!.value.isInitialized)
                      IconButton(
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoController!.setVolume(100)
                              : _videoController!.setVolume(0);
                          _isMuted = _videoController!.value.volume == 0;
                        }),
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => print('Play'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: !Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
              : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
          child: const Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 30.0,
              ),
              Text(
                'Play',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ));
  }
}
