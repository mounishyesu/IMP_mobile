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

import 'dart:io';

import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
class NativeMethod {
  static const MethodChannel sharedTextChannel =
      MethodChannel('com.shadow.music_player/Views/MusicPlayer/sharedTextChannel');
  static const MethodChannel registermediaChannel =
      MethodChannel('com.shadow.music_player/Views/MusicPlayer/registerMedia');
  static const MethodChannel intentChannel =
      MethodChannel('com.shadow.music_player/Views/MusicPlayer/intentChannel');

  static Future<void> handleIntent() async {
    // final _intent = await sharedTextChannel.invokeMethod('getSharedText');
    // if (_intent != null) {
    //   print('IntentHandler: Result: $_intent');
    // } else {
    //   print('intent is null');
    // }
  }

  static Future<void> handleAudioIntent(String audioPath) async {
    if (await File(audioPath).exists()) {
      intentChannel.invokeMethod('openAudio', {'audioPath': audioPath});
    }
  }
}
