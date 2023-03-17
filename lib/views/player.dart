import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4music/consts/colors.dart';
import 'package:m4music/consts/textstyle.dart';
import 'package:m4music/controllers/playercontroller.dart';
import 'package:m4music/utilis/appbar.dart';
import 'package:m4music/consts/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<playercontroller>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () =>  Expanded(
                    child:  Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 300,
                                  width: 300,
                                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 48,
                        color: whitecolor,
                      ),
                                  ),
                                ),
                    ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: whitecolor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                child: Obx(
                  () =>  Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                        child: Text(
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          data[controller.playIndex.value].displayNameWOExt,
                          style: ourstyle(
                            family: bold,
                            Color: bgdarkcolor,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                         textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                       
                        data[controller.playIndex.value].artist.toString(),
                        style: ourstyle(
                          family: regular,
                          Color: bgdarkcolor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: ourstyle(
                                Color: bgdarkcolor,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: slidercolor,
                                activeColor: slidercolor,
                                inactiveColor: bgcolor,
                                min: const Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value: controller.newvalue,
                                onChanged: (value) {
                                  controller.changeDurationToSeconds(value.toInt());
                                  value = value;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: ourstyle(
                                Color: bgdarkcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.playsong(
                                    data[controller.playIndex.value-1].uri,
                                    controller.playIndex.value-1);
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 40,
                                color: bgdarkcolor,
                              )),
                          Obx(
                            () => CircleAvatar(
                                backgroundColor: bgdarkcolor,
                                radius: 35,
                                child: Transform.scale(
                                    scale: 2.5,
                                    child: IconButton(
                                      onPressed: () {
                                        if (controller.isplaying.value) {
                                          controller.audioPlayer.pause();
                                          controller.isplaying(false);
                                        } else {
                                          controller.audioPlayer.play();
                                          controller.isplaying(true);
                                        }
                                      },
                                      icon: controller.isplaying.value
                                          ? const Icon(
                                              Icons.pause,
                                              color: whitecolor,
                                            )
                                          : const Icon(
                                              Icons.play_arrow_rounded,
                                              color: whitecolor,
                                            ),
                                    ))),
                          ),
                          IconButton(
                              onPressed: () {
                                   controller.playsong(
                                    data[controller.playIndex.value+1].uri,
                                    controller.playIndex.value+1);
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 40,
                                color: bgdarkcolor,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
