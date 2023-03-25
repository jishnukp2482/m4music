import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:m4music/controllers/playercontroller.dart';

import 'package:m4music/consts/textstyle.dart';
import 'package:m4music/consts/colors.dart';
import 'package:m4music/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    var controller = Get.put(playercontroller());
 
    return SafeArea(
      child: Scaffold(
          key: _scaffoldkey,
          drawer: Drawer(
            
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: bgdarkcolor,
                  ),
                  accountEmail: Text(
                    job,
                    style: ourstyle(),
                  ),
                  currentAccountPicture: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/dev.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  accountName: Text(
                    dev,
                    style: ourstyle(),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                  ),
                  title: const Text('Home'),
                  onTap: () {
                    Get.to(() => homepage());
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                  ),
                  title: const Text('Abou App'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          backgroundColor: bgdarkcolor,
          appBar: AppBar(
            backgroundColor: bgdarkcolor,
            leading: IconButton(
                onPressed: () => _scaffoldkey.currentState?.openDrawer(),
                icon: Icon(Icons.sort_rounded, color: whitecolor)),
            title: Text(
              "M4-MUSIC",
              style: ourstyle(
                family: bold,
                size: 18,
              ),
            ),
            actions: [
              IconButton(
                 onPressed: () {
                   
                 },
                  icon: Icon(

                    Icons.search,
                    color: whitecolor,
                  )),
                 
                  
            ],
          ),
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
                                  Get.to(
                                      () => Player(
                                            data: snapshot.data!,
                                          ),
                                      transition: Transition.downToUp);
                                  controller.playsong(
                                      snapshot.data![index].uri, index);
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
 