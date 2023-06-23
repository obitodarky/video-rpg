import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_rpg/features/video_rpg/provider/video_player_provider.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});


  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<VideoPlayerProvider>(
        builder: (context, provider, child) {
          final showOptions = provider.showOptions;
          final currentChoice = provider.currentChoice;
          final choiceHistory = provider.choiceHistory;
          final showVideoControls = provider.showVideoControls;
          final controller = provider.controller;

          return Stack(
            children: [
              GestureDetector(
                child: VideoPlayer(controller),
                onTap: () => provider.setShowVideoControls(
                    value: !provider.showVideoControls),
              ),
              const SizedBox(height: 16),
              if (showOptions && currentChoice.nextChoices.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: currentChoice.nextChoices.map((choice) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              provider.playVideo(choice.videoUrl);
                              provider.onChoiceSelect(choice);
                            },
                            child: Text(choice.title),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              if (showVideoControls)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: choiceHistory.asMap().entries.map((entry) {
                        final choice = entry.value;
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              provider.playVideo(choice.videoUrl);
                              provider.onChoiceHistorySelect(choice);
                              provider.setCurrentChoice(choice);
                            },
                            child: Text(choice.title),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            _formatDuration(controller.value.position),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onTap: () {
                              controller.value.isPlaying
                                  ? controller.pause()
                                  : controller.play();
                            },
                          ),
                          Expanded(
                            child: Slider(
                              min: 0.0,
                              max: controller.value.duration.inMilliseconds
                                  .toDouble(),
                              value: controller.value.position.inMilliseconds
                                  .toDouble(),
                              onChanged: (value) {
                                controller.seekTo(
                                    Duration(milliseconds: value.toInt()));
                                controller.play();
                              },
                            ),
                          ),
                          Text(
                            _formatDuration(controller.value.duration),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
