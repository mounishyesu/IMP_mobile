import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class Music_player extends StatefulWidget {
  const Music_player({Key? key}) : super(key: key);

  @override
  _Music_playerState createState() => _Music_playerState();
}

class _Music_playerState extends State<Music_player> {
  late AudioPlayer _player;
  final url =
      'https://raw.githubusercontent.com//22suraj/Music_Player/master/Main_Tumhara.mp3';
  late Stream<DurationState> _durationState;
  var _isShowingWidgetOutline = false;
  var audioplayer = AudioPlayer();
  bool playButton = false;

  // myToast(var message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.purple.shade100,
  //       fontSize: 15);
  // }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      debugPrint('An error occured $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: [
        Stack(
          // overflow: Overflow.visible,
          alignment: Alignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.purple,
                        spreadRadius: 10,
                        blurRadius: 100,
                        offset: Offset(0, 0))
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 70),
                      bottomRight: Radius.elliptical(200, 70)),
                  gradient: LinearGradient(colors: [
                    Colors.purple.shade900,
                    Colors.purple.shade400
                  ])),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Music Player",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                          color: Colors.purple.shade100),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 140,
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple.shade100, width: 3),
                  boxShadow: [BoxShadow(color: Colors.purple, blurRadius: 20)],
                  shape: BoxShape.circle,
                  color: Colors.purple.shade100,
                  image: DecorationImage(
                      image: AssetImage("assets/images/music_effect.gif"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            /*Positioned(
                    top: 30,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.purple.shade100,
                      ),
                      onPressed: () {},
                    ),
                  ),*/
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Stack(
          // alignment: Alignment.center,
          // overflow: Overflow.visible,
          children: [
            Container(
              margin: EdgeInsets.only(left: 34, right: 34, top: 30),
              height: 150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.purple, spreadRadius: 5, blurRadius: 70)
                ],
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade900,
                    Colors.purple.shade300,
                  ],
                  begin: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 145),
                    width: double.infinity,
                    child: Text(
                      "Main Tumhara",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.purple.shade100,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 145),
                    width: double.infinity,
                    child: Text(
                      "Dil Bechara",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.purple.shade100,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 110),
              height: 115,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.purple,
                      spreadRadius: 5,
                      blurRadius: 70,
                      offset: Offset(0, 0))
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple.shade100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: IconButton(
                            onPressed: () {
                              print("rewind");
                            },
                            icon: Icon(
                              Icons.fast_rewind,
                              size: 45,
                              color: Colors.purple.shade500,
                            )),
                      ),
                      // SizedBox(width:25),
                      // Container(
                      //   child: IconButton(
                      //     icon: Icon(
                      //       playButton ? Icons.pause : Icons.play_arrow,
                      //       size: 45,
                      //       color: Colors.purple.shade500,
                      //     ),
                      //     onPressed: () async {
                      //       if (playButton == false) {
                      //         var result = await audioplayer.play(
                      //             'https://raw.githubusercontent.com//22suraj/Music_Player/master/Main_Tumhara.mp3');
                      //         print(result);
                      //         myToast("Music Played");
                      //         setState(() {
                      //           playButton == true;
                      //         });
                      //       } else if (playButton == true) {
                      //         var r = await audioplayer.pause();
                      //         print(r);
                      //         myToast("Music Paused");
                      //         setState(() {
                      //           playButton == false;
                      //         });
                      //       }
                      //       print("play");
                      //     },
                      //   ),
                      // ),
                      _playButton(),
                      // SizedBox(width:20),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.fast_forward,
                              size: 45, color: Colors.purple.shade500),
                          onPressed: () {
                            print("forward");
                          },
                        ),
                      ),
                      // SizedBox(width:20),
                    ],
                  ),
                ],
              ),
            )),
            Positioned(
              top: 85,
              left: 39,
              child: Container(
                padding: EdgeInsets.all(55),
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.purple.shade100,
                  image: DecorationImage(
                    image: AssetImage("assets/images/Dilbechara.jpg"),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.purple.shade100,
                  ),
                ),
              ),
            ),
            Container(
              decoration: _widgetBorder(),
              child: _progressBar(),
            ),
          ],
        ),
      ])),
    );
  }

  BoxDecoration _widgetBorder() {
    return BoxDecoration(
      border: _isShowingWidgetOutline
          ? Border.all(color: Colors.red)
          : Border.all(color: Colors.transparent),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            _player.seek(duration);
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: 5,
          baseBarColor: Colors.purple,
          progressBarColor: Colors.black,
          bufferedBarColor: Colors.purple.shade200,
          thumbColor: Colors.deepPurple,
          thumbGlowColor: Colors.yellow,
          barCapShape: BarCapShape.round,
          thumbRadius: 10,
          thumbCanPaintOutsideBar: true,
          timeLabelLocation: TimeLabelLocation.sides,
          timeLabelType: TimeLabelType.remainingTime,
          timeLabelTextStyle: TextStyle(
              fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 45.0,
                color: Colors.purple.shade500,
                onPressed: _player.play,
              ),
            ],
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 45.0,
            color: Colors.purple.shade500,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 45.0,
            color: Colors.purple.shade500,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
