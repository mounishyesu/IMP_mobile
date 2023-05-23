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

import 'package:music_player/Views/MusicPlayer/APIs/api.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/bouncy_sliver_scroll_view.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/copy_clipboard.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/download_button.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/empty_screen.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/gradient_containers.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/like_button.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/miniplayer.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/playlist_popupmenu.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/snackbar.dart';
import 'package:music_player/Views/MusicPlayer/CustomWidgets/song_tile_trailing_menu.dart';
import 'package:music_player/Views/MusicPlayer/Screens/Player/audioplayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:share_plus/share_plus.dart';

class SongsListPage extends StatefulWidget {
  final Map listItem;

  const SongsListPage({
    Key? key,
     required this.listItem,
  }) : super(key: key);

  @override
  _SongsListPageState createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  int page = 1;
  bool loading = false;
  List songList = [];
  bool fetched = false;
  HtmlUnescape unescape = HtmlUnescape();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchSongs();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          widget.listItem['type'].toString() == 'songs' &&
          !loading) {
        page += 1;
        _fetchSongs();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _fetchSongs() {
    loading = true;
    switch (widget.listItem['type'].toString()) {
      case 'songs':
        SaavnAPI()
            .fetchSongSearchResults(
          searchQuery: widget.listItem['id'].toString(),
          page: page,
        )
            .then((value) {
          setState(() {
            songList.addAll(value['songs'] as List);
            fetched = true;
            loading = false;
          });
          if (value['error'].toString() != '') {
            ShowSnackBar().showSnackBar(
              context,
              'Error: ${value["error"]}',
              duration: const Duration(seconds: 3),
            );
          }
        });
        break;
      case 'album':
        SaavnAPI()
            .fetchAlbumSongs(widget.listItem['id'].toString())
            .then((value) {
          setState(() {
            songList = value['songs'] as List;
            fetched = true;
            loading = false;
          });
          if (value['error'].toString() != '') {
            ShowSnackBar().showSnackBar(
              context,
              'Error: ${value["error"]}',
              duration: const Duration(seconds: 3),
            );
          }
        });
        break;
      case 'playlist':
        SaavnAPI()
            .fetchPlaylistSongs(widget.listItem['id'].toString())
            .then((value) {
          setState(() {
            songList = value['songs'] as List;
            fetched = true;
            loading = false;
          });
          if (value['error'].toString() != '') {
            ShowSnackBar().showSnackBar(
              context,
              'Error: ${value["error"]}',
              duration: const Duration(seconds: 3),
            );
          }
        });
        break;
      default:
        break;
    }


  }

  @override
  Widget build(BuildContext context) {
    print(songList);
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(0.8),
              body: !fetched
                  ? SizedBox(
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          width: MediaQuery.of(context).size.width / 8,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : songList.isEmpty
                      ? Column(
                          children: [
                            AppBar(
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.transparent
                                  : Theme.of(context).colorScheme.secondary,
                              elevation: 0,
                            ),
                            Expanded(
                              child: emptyScreen(
                                context,
                                0,
                                ':( ',
                                100,
                                "sorry",
                                60,
                                "resultsNotFound",
                                20,
                              ),
                            ),
                          ],
                        )
                      : BouncyImageSliverScrollView(
                          scrollController: _scrollController,
                          actions: [
                            MultiDownloadButton(
                              data: songList,
                              playlistName:
                                  widget.listItem['title']?.toString() ??
                                      'Songs',
                            ),
                            IconButton(color: Color(0xFFffab00),
                              icon: const Icon(Icons.share_rounded),
                              tooltip: "share",
                              onPressed: () {
                                Share.share(
                                  widget.listItem['perma_url'].toString(),
                                );
                              },
                            ),
                            PlaylistPopupMenu(
                              data: songList,
                              title: widget.listItem['title']?.toString() ??
                                  'Songs',
                            ),
                          ],
                          title: unescape.convert(
                            widget.listItem['title']?.toString() ?? 'Songs',
                          ),
                          placeholderImage: 'assets/images/album.png',
                          imageUrl: widget.listItem['image']
                              ?.toString()
                              .replaceAll('http:', 'https:')
                              .replaceAll(
                                '50x50',
                                '500x500',
                              )
                              .replaceAll(
                                '150x150',
                                '500x500',
                              ),
                          sliverList: SliverList(
                            delegate: SliverChildListDelegate([
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, __, ___) =>
                                              PlayScreen(
                                            songsList: songList,
                                            index: 0,
                                            offline: false,
                                            fromDownloads: false,
                                            fromMiniplayer: false,
                                            recommend: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 5,
                                      ),
                                      height: 45.0,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: Colors.black,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5.0,
                                            offset: Offset(0.0, 3.0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.play_arrow_rounded,
                                            color: Color(0xFFffab00),
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            "play all",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Color(0xFFffab00),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final List tempList = List.from(songList);
                                      tempList.shuffle();
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, __, ___) =>
                                              PlayScreen(
                                            songsList: tempList,
                                            index: 0,
                                            offline: false,
                                            fromDownloads: false,
                                            fromMiniplayer: false,
                                            recommend: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 5,
                                      ),
                                      height: 45.0,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: Colors.black,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5.0,
                                            offset: Offset(0.0, 3.0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.shuffle_rounded,
                                            color: Color(0xFFffab00),
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            "shuffle all",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Color(0xFFffab00),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...songList.map((entry) {
                                return ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 15.0),
                                  title: Text(
                                    '${entry["title"]}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFFffab00),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onLongPress: () {
                                    copyToClipboard(
                                      context: context,
                                      text: '${entry["title"]}',
                                    );
                                  },
                                  subtitle: Text(
                                    '${entry["subtitle"]}',style: TextStyle(color: Color(0xFFffab00)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      errorWidget: (context, _, __) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/cover.jpg',
                                        ),
                                      ),
                                      imageUrl:
                                          '${entry["image"].replaceAll('http:', 'https:')}',
                                      placeholder: (context, url) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/cover.jpg',
                                        ),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DownloadButton(
                                        data: entry as Map,
                                        icon: 'download',
                                      ),
                                      LikeButton(
                                        mediaItem: null,
                                        data: entry,
                                      ),
                                      SongTileTrailingMenu(data: entry),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder: (_, __, ___) => PlayScreen(
                                          songsList: songList,
                                          index: songList.indexWhere(
                                            (element) => element == entry,
                                          ),
                                          offline: false,
                                          fromDownloads: false,
                                          fromMiniplayer: false,
                                          recommend: true,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList()
                            ]),
                          ),
                        ),
            ),
          ),
          const MiniPlayer(),
        ],
      ),
    );
  }
}
