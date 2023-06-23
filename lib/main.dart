import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_rpg/features/video_rpg/provider/video_player_provider.dart';
import 'package:video_rpg/features/video_rpg/ui/video_player_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (ctx) => VideoPlayerProvider(),
        child: const VideoPlayerScreen(),
      ),
    ),
  );
}
