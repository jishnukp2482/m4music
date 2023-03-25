import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4music/views/Homepage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

class playercontroller extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playIndex = 0.obs;
  var isplaying = false.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var newvalue = 0.0..obs;
 
  @override
  void onInit() {
    super.onInit();
    checkpermission();
  }

  playsong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isplaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  updatePosition() {
    audioPlayer.durationStream.listen((dur) {
      duration.value = dur.toString().split(".")[0];
      max.value = dur!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((pos) {
      position.value = pos.toString().split(".")[0];
      newvalue = pos.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  checkpermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
  
    } else {
      checkpermission();
    }
  }
}
