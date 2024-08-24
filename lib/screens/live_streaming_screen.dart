import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;

  const LivePage({super.key, required this.liveID, this.isHost = false});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final liveStateNotifier =
      ValueNotifier<ZegoLiveStreamingState>(ZegoLiveStreamingState.idle);


  @override
  Widget build(BuildContext context) {
              List<IconData> customIcons = [
      Icons.cookie,
      Icons.phone,
      Icons.speaker,
      Icons.air,
      Icons.blender,
      Icons.file_copy,
      Icons.place,
      Icons.phone_android,
      Icons.phone_iphone,
    ];

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return ZegoUIKitPrebuiltLiveStreaming(
          appID:
              120358852, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
          appSign:
              "e9d7e431e7f7db26ba49641135caacfa2416d8b7842c96685278fdb8a597df33", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
          userID: 'Mahdi',
          userName: 'Mahdi Abd Elmageed',
          liveID: widget.liveID,
          events: ZegoUIKitPrebuiltLiveStreamingEvents(
            onStateUpdated: (ZegoLiveStreamingState state) {
              liveStateNotifier.value = state;
            },
          ),
          config: widget.isHost
              ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
              ..video = ZegoUIKitVideoConfig.preset1080P()
            // ..inRoomMessage.visible = false
            // ..foreground = foreground(constraints)
            // ..audioVideoView.showUserNameOnView = true
            // ..avatarBuilder
            // ..topMenuBar.showCloseButton = true
            // ..preview.beautyEffectIcon = const Icon(Icons.favorite)
            // ..audioVideoView.showSoundWavesInAudioMode = true
            ..bottomMenuBar = ZegoLiveStreamingBottomMenuBarConfig(
          maxCount: 5,
          hostButtons: [
            ZegoLiveStreamingMenuBarButtonName.switchCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton,
          ],
          hostExtendButtons: customIcons
              .map(
                (customIcon) => ZegoLiveStreamingMenuBarExtendButton(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(40, 40),
                  shape: const CircleBorder(),
                  // primary: const Color(0xff2C2F3E).withOpacity(0.6),
                ),
                onPressed: () {},
                child: Icon(customIcon),
              ),
            ),
          )
              .toList(),
          coHostButtons: [
            ZegoLiveStreamingMenuBarButtonName.switchCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton,
            ZegoLiveStreamingMenuBarButtonName.coHostControlButton,
          ],
        )
        ..turnOnCameraWhenJoining = false
        ..bottomMenuBar.hostButtons = [
          ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton
        ]
            ..confirmDialogInfo = ZegoLiveStreamingDialogInfo(
              title: "Leave confirm",
              message: "Do you want to end?",
              cancelButtonName: "Cancel",
              confirmButtonName: "Confirm"
              ,
            ),
            
        );
      }),
    );
  }

  Widget foreground(BoxConstraints constraints) {
    const shortMessageHeight = 20.0;
    const padding = 10.0;

    return ValueListenableBuilder<ZegoLiveStreamingState>(
      valueListenable: liveStateNotifier,
      builder: (context, liveState, _) {
        return ZegoLiveStreamingState.idle == liveState
            ? Container()
            : Positioned(
                left: padding,
                bottom: shortMessageHeight + 40 + 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    messageView(),
                    const SizedBox(
                      height: padding,
                    ),
                    SizedBox(
                      width: constraints.maxWidth - padding * 3,
                      height: shortMessageHeight,
                      child: shortMessageListView(),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget shortMessageListView() {
    final shortMessages = <String>[
      'Hi! 🖐🏻',
      'Namastey 🙏🏻',
      'Hello ❤️',
      'Hey 🔥',
      'Buy 👋🏻',
      'Morning ☀️',
      'Night 🌛'
    ];

    return ListView.separated(
      itemCount: shortMessages.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white38),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: GestureDetector(
            onTap: () {
              ZegoUIKitPrebuiltLiveStreamingController()
                  .message
                  .send(shortMessages[index]);
            },
            child: Text(
              shortMessages[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 5);
      },
    );
  }

  Widget messageView() {
    return StreamBuilder<List<ZegoInRoomMessage>>(
      stream: ZegoUIKitPrebuiltLiveStreamingController().message.stream(),
      builder: (context, snapshot) {
        final messages = snapshot.data ?? <ZegoInRoomMessage>[];

        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: SizedBox(
            width: 200,
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messageItem(messages[index]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget messageItem(ZegoInRoomMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 2,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: SizedBox(
                width: 12 + 4,
                child: ZegoAvatar(
                  user: message.user,
                  avatarSize: const Size(12 + 4, 12 + 4),
                ),
              ),
            ),
            const WidgetSpan(child: SizedBox(width: 2)),
            TextSpan(
              text: '${message.user.name}: ',
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: message.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
