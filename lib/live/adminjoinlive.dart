import 'package:flutter/material.dart';
import 'package:peachy/secrets.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class adminlive extends StatelessWidget {
  const adminlive({
    Key? key,
    required this.liveID,
    this.isHost = false,
  }) : super(key: key);

  final String liveID;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: Secrets.myID,
        appSign: Secrets.mySign,
        userID: 'admin', // Use "admin" as the userID
        userName: 'admin', // Use "admin" as the userName
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
