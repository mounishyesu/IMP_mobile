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

import 'package:music_player/Views/MusicPlayer/Screens/Player/audioplayer.dart';
import 'package:flutter/material.dart';

class PlaylistHead extends StatelessWidget {
  final List songsList;
  final bool offline;
  final bool fromDownloads;
  final bool recommend;
  const PlaylistHead({
    Key? key,
    required this.songsList,
    required this.fromDownloads,
    required this.recommend,
    required this.offline,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${songsList.length} "songs"',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              final tempList = songsList.toList();
              tempList.shuffle();
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) => PlayScreen(
                    songsList: tempList,
                    index: 0,
                    offline: offline,
                    fromMiniplayer: false,
                    fromDownloads: fromDownloads,
                    recommend: recommend,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shuffle_rounded),
            label: Text(
              "shuffle",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) => PlayScreen(
                    songsList: songsList,
                    index: 0,
                    offline: offline,
                    fromMiniplayer: false,
                    fromDownloads: fromDownloads,
                    recommend: recommend,
                  ),
                ),
              );
            },
            tooltip: "shuffle",
            icon: const Icon(Icons.play_arrow_rounded),
            iconSize: 30.0,
          ),
        ],
      ),
    );
  }
}
