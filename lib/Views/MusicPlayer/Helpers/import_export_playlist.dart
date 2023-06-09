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

import 'dart:convert';
import 'dart:io';

import 'package:music_player/Views/MusicPlayer/CustomWidgets/snackbar.dart';
import 'package:music_player/Views/MusicPlayer/Helpers/picker.dart';
import 'package:music_player/Views/MusicPlayer/Helpers/songs_count.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportPlaylist(
  BuildContext context,
  String playlistName,
  String showName,
) async {
  final String dirPath = await Picker.selectFolder(
    context: context,
    message:"selectExportLocation"
  );
  if (dirPath == '') {
    ShowSnackBar().showSnackBar(
      context,
      '"failedExport" "$showName"'
    );
    return;
  }
  await Hive.openBox(playlistName);
  final Box playlistBox = Hive.box(playlistName);
  final Map _songsMap = playlistBox.toMap();
  final String _songs = json.encode(_songsMap);
  final File file =
      await File('$dirPath/$showName.json').create(recursive: true);
  await file.writeAsString(_songs);
  ShowSnackBar().showSnackBar(
    context,
    '"exported" "$showName"'
  );
}

Future<void> sharePlaylist(
  BuildContext context,
  String playlistName,
  String showName,
) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String temp = appDir.path;

  await Hive.openBox(playlistName);
  final Box playlistBox = Hive.box(playlistName);
  final Map _songsMap = playlistBox.toMap();
  final String _songs = json.encode(_songsMap);
  final File file = await File('$temp/$showName.json').create(recursive: true);
  await file.writeAsString(_songs);

  await Share.shareFiles(
    [file.path],
    text: "playlistShareText",
  );
  await Future.delayed(const Duration(seconds: 10), () {});
  if (await file.exists()) {
    await file.delete();
  }
}

Future<List> importPlaylist(BuildContext context, List playlistNames) async {
  try {
    final String temp = await Picker.selectFile(
      context: context,
      ext: ['json'],
      message: "selectJsonImport",
    );
    if (temp == '') {
      ShowSnackBar().showSnackBar(
        context,
        "failedImport",
      );
      return playlistNames;
    }

    final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
    String playlistName = temp
        .split('/')
        .last
        .replaceAll('.json', '')
        .replaceAll(avoid, '')
        .replaceAll('  ', ' ');

    final File file = File(temp);
    final String finString = await file.readAsString();
    final Map _songsMap = json.decode(finString) as Map;
    final List _songs = _songsMap.values.toList();
    // playlistBox.put(mediaItem.id.toString(), info);
    // Hive.box(play)

    if (playlistName.trim() == '') {
      playlistName = 'Playlist ${playlistNames.length}';
    }
    if (playlistNames.contains(playlistName)) {
      playlistName = '$playlistName (1)';
    }
    playlistNames.add(playlistName);

    await Hive.openBox(playlistName);
    final Box playlistBox = Hive.box(playlistName);
    await playlistBox.putAll(_songsMap);

    addSongsCount(
      playlistName,
      _songs.length,
      _songs.length >= 4
          ? _songs.sublist(0, 4)
          : _songs.sublist(0, _songs.length),
    );
    ShowSnackBar().showSnackBar(
      context,
      '"importSuccess" "$playlistName"',
    );
    return playlistNames;
  } catch (e) {
    ShowSnackBar().showSnackBar(
      context,
      '"failedImport"\nError: $e',
    );
  }
  return playlistNames;
}
