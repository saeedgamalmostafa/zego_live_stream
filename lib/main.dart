import 'package:flutter/material.dart';
import 'package:live_stream_zego_test/screens/live_streaming_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LivePage(
        liveID: '1',
        isHost: false,
      ),
    );
  }
}
