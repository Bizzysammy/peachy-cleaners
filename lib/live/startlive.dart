import 'package:flutter/material.dart';
import 'package:peachy/secrets.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveScreen1 extends StatelessWidget {
  const LiveScreen1({
    Key? key,
    required this.liveID,
    required this.userName,
    this.isHost = true,
  }) : super(key: key);

  final String liveID;
  final String userName;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: Secrets.myID,
        appSign: Secrets.mySign,
        userID: userName, // Use cleaner name as userID
        userName: userName, // Use cleaner name as userName
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
