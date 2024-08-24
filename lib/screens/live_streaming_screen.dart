import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({Key? key, required this.liveID, this.isHost = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 120358852,// Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: "e9d7e431e7f7db26ba49641135caacfa2416d8b7842c96685278fdb8a597df33",// Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: 'Saeed',
        userName: 'Saeed Gamal',
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
