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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BouncyImageSliverScrollView extends StatelessWidget {
  final ScrollController? scrollController;
  final SliverList sliverList;
  final bool shrinkWrap;
  final List<Widget>? actions;
  final String title;
  final String? imageUrl;
  final bool localImage;
  final String placeholderImage;
  const BouncyImageSliverScrollView({
    Key? key,
    this.scrollController,
    this.shrinkWrap = false,
    required this.sliverList,
    required this.title,
    this.placeholderImage = 'assets/images/images/cover.jpg',
    this.localImage = false,
    this.imageUrl,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = imageUrl == null
        ? Image(
            fit: BoxFit.cover,
            image: AssetImage(placeholderImage),
          )
        : localImage
            ? Image(
                image: FileImage(
                  File(
                    imageUrl!,
                  ),
                ),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (context, _, __) => Image(
                  fit: BoxFit.cover,
                  image: AssetImage(placeholderImage),
                ),
                imageUrl: imageUrl!,
                placeholder: (context, url) => Image(
                  fit: BoxFit.cover,
                  image: AssetImage(placeholderImage),
                ),
              );
    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          elevation: 0,
          stretch: true,
          pinned: true,
          // floating: true,
          // backgroundColor: Colors.transparent,
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
          actions: actions,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsetsDirectional.only(
              start: 72,
              bottom: 16,
              end: 120,
            ),
            background: Stack(
              children: [
                SizedBox.expand(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ).createShader(
                        Rect.fromLTRB(
                          0,
                          0,
                          rect.width,
                          rect.height,
                        ),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: image,
                  ),
                ),
                if (rotated)
                  Align(
                    alignment: const Alignment(-0.85, 0.5),
                    child: Card(
                      elevation: 5,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: image,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        sliverList,
      ],
    );
  }
}
