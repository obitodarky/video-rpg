import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_rpg/features/video_rpg/data/options_data.dart';

class VideoPlayerProvider with ChangeNotifier {

  VideoPlayerProvider(){
    currentChoice = getMockData();
    controller = VideoPlayerController.network(currentChoice.videoUrl);
    controller.initialize().then((_) {
      notifyListeners();
    });

    controller.addListener( () => _getControllerListener(controller));
  }

  bool showOptions = false;
  bool showVideoControls = true;
  List<Choice> choiceHistory = [];
  late Choice currentChoice;
  late VideoPlayerController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void playVideo(String videoUrl) {
    final VideoPlayerController newController =
        VideoPlayerController.network(videoUrl);

    newController.initialize().then((_) {
      showOptions = false;
      controller.pause();
      controller.dispose();
      controller = newController;
      controller.addListener(() => _getControllerListener(controller));
      controller.play();
      notifyListeners();
    });
  }

  void setCurrentChoice(Choice choice){
    currentChoice = choice;
    notifyListeners();
  }

  void _getControllerListener(VideoPlayerController controller){
    if (controller.value.position >= controller.value.duration) {
      showOptions = true;
      showVideoControls = currentChoice.nextChoices.isEmpty;
    }
    notifyListeners();
  }

  void onChoiceSelect(Choice choice) {
    showOptions = false;
    choiceHistory.add(currentChoice);
    currentChoice = choice;
    notifyListeners();
  }

  void onChoiceHistorySelect(Choice choice) {
    choiceHistory = choiceHistory.sublist(0, choiceHistory.indexOf(choice));
    currentChoice = choice;
    notifyListeners();
  }

  void setShowVideoControls({required bool value}) {
    showVideoControls = value;
    notifyListeners();
  }

  void setShowOptions({required bool value}) {
    showOptions = value;
    notifyListeners();
  }
}
