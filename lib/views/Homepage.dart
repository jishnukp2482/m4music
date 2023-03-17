import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:m4music/controllers/playercontroller.dart';
import 'package:m4music/utilis/appbar.dart';
import 'package:m4music/consts/textstyle.dart';
import 'package:m4music/consts/colors.dart';
import 'package:m4music/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(playercontroller());
    return SafeArea(
      child: Scaffold(
          backgroundColor: bgdarkcolor,
          appBar: appBar(),
          body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No songs found",
                      style: ourstyle(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: bgcolor,
                          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Obx(
                              () => ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor: bgcolor,
                                title: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  snapshot.data![index].displayNameWOExt,
                                  style: ourstyle(
                                    family: bold,
                                    size: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  "${snapshot.data![index].artist}",
                                  style: ourstyle(
                                    family: regular,
                                    size: 12,
                                  ),
                                ),
                                leading: QueryArtworkWidget(
                                  id: snapshot.data![index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    color: whitecolor,
                                    size: 32,
                                  ),
                                ),
                                trailing: controller.playIndex.value == index &&
                                        controller.isplaying.value
                                    ? const Icon(
                                        Icons.play_arrow,
                                        color: whitecolor,
                                        size: 26,
                                      )
                                    : null,
                                onTap: () {
                                  Get.to(() => Player(data: snapshot.data!,),
                                  transition: Transition.downToUp);
                                   controller.playsong(snapshot.data![index].uri,index);
                                },
                              ),
                            ));
                      },
                    ),
                  );
                }
              }
            },
          )),
    );
  }
}
