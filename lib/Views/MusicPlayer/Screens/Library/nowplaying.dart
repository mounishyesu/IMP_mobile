/*
 *  This file is part of music_player/Views/MusicPlayer (https://github.com/Sangwan5688/music_player/Views/MusicPlayer).
 * 
 * music_player/Views/MusicPlayer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * music_player/Views/MusicPlayer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with music_player/Views/MusicPlayer.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2022, Ankit Sangwan
 */

import 'package:audio_service/audio_service.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/bouncy_sliver_scroll_view.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/empty_screen.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/gradient_containers.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/miniplayer.dart';
import 'package:music_player/Views/MusicPlayer/Screens/Player/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<PlaybackState>(
              stream: audioHandler.playbackState,
              builder: (context, snapshot) {
                final playbackState = snapshot.data;
                final processingState = playbackState?.processingState;
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: processingState != AudioProcessingState.idle
                      ? null
                      : AppBar(
                          title: Text("nowPlaying"),
                          centerTitle: true,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.transparent
                                  : Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                        ),
                  body: processingState == AudioProcessingState.idle
                      ? emptyScreen(
                          context,
                          3,
                          "nothingIs",
                          18.0,
                          "playingCap",
                          60,
                          "playSomething",
                          23.0,
                        )
                      : StreamBuilder<MediaItem?>(
                          stream: audioHandler.mediaItem,
                          builder: (context, snapshot) {
                            final mediaItem = snapshot.data;
                            return mediaItem == null
                                ? const SizedBox()
                                : BouncyImageSliverScrollView(
                                    title: "nowPlaying",
                                    localImage: mediaItem.artUri!
                                        .toString()
                                        .startsWith('file:'),
                                    imageUrl: mediaItem.artUri!
                                            .toString()
                                            .startsWith('file:')
                                        ? mediaItem.artUri!.toFilePath()
                                        : mediaItem.artUri!.toString(),
                                    sliverList: SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          NowPlayingStream(
                                            audioHandler: audioHandler,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                );
              },
            ),
          ),
          const MiniPlayer(),
        ],
      ),
    );
  }
}
