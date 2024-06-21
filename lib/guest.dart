import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

final userID = Random().nextInt(10000).toString();

class LiveScreen2 extends StatelessWidget {
  const LiveScreen2({Key? key,
    required this.liveID,
    this.isHost = false,})
      : super(key: key);

  final  String liveID;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  ZegoUIKitPrebuiltLiveStreaming(
        appID:1475318324,
        appSign: "02f7c6fd705bec41e0fa0d73b9b324c638217c5cc1f65699488573151e680adc",
        userID: userID,
        userName: 'user_$userID',
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            :ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );

  }

}