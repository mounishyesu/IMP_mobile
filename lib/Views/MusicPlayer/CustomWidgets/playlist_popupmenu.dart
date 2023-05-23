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
import 'package:music_player/Views/MusicPlayer/CustomWidgets/snackbar.dart';
import 'package:music_player/Views/MusicPlayer/Helpers/mediaitem_converter.dart';
import 'package:music_player/Views/MusicPlayer/Helpers/playlist.dart';
import 'package:music_player/Views/MusicPlayer/Screens/Player/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PlaylistPopupMenu extends StatefulWidget {
  final List data;
  final String title;
  const PlaylistPopupMenu({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  _PlaylistPopupMenuState createState() => _PlaylistPopupMenuState();
}

class _PlaylistPopupMenuState extends State<PlaylistPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(color: Colors.black,
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Color(0xFFffab00),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.playlist_add_rounded,
                color: Color(0xFFffab00),
              ),
              const SizedBox(width: 10.0),
              Text("addToQueue",style: TextStyle(color: Color(0xFFffab00)),),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFffab00),
              ),
              const SizedBox(width: 10.0),
              Text("savePlaylist",style: TextStyle(color: Color(0xFFffab00)),),
            ],
          ),
        ),
      ],
      onSelected: (int? value) {
        if (value == 1) {
          addPlaylist(widget.title, widget.data).then(
            (value) => ShowSnackBar().showSnackBar(
              context,
              '"${widget.title}" "addedToPlaylists"',
            ),
          );
        }
        if (value == 0) {
          final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
          final MediaItem? currentMediaItem = audioHandler.mediaItem.value;
          if (currentMediaItem != null &&
              currentMediaItem.extras!['url'].toString().startsWith('http')) {
            // TODO: make sure to check if song is already in queue
            final queue = audioHandler.queue.value;
            widget.data.map((e) {
              final element = MediaItemConverter.mapToMediaItem(e as Map);
              if (!queue.contains(element)) {
                audioHandler.addQueueItem(element);
              }
            });

            ShowSnackBar().showSnackBar(
              context,
              '"${widget.title}" "addedToQueue"',
            );
          } else {
            ShowSnackBar().showSnackBar(
              context,
              currentMediaItem == null
                  ? "nothingPlaying"
                  : "cantAddToQueue",
            );
          }
        }
      },
    );
  }
}
