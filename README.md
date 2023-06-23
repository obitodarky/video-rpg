# video_rpg

An interactive video player.
- [video\_rpg](#video_rpg)
  - [Development Environment](#development-environment)
  - [Supported Platforms](#supported-platforms)
  - [Installation](#installation)
  - [System Architecture](#system-architecture)
    - [main.dart](#maindart)
    - [lib/features](#libfeatures)
    - [data](#data)
    - [provider](#provider)
    - [ui](#ui)
  - [Using the App](#using-the-app)
  - [Modifications](#modifications)


## Development Environment
- OS and version: macOS Big Sur, Version: 11.6.6 (20G624)
- IDE: Android Studio
- IDE Version: Android Studio Chipmunk | 2021.2.1
- Flutter SDK: 3.3.8

## Supported Platforms
- Android
- iOS

## Installation 

The following steps for installation are with FVM. You can also avoid using FVM as long as you have Flutter SDK version `3.3.8` installed

1. Install FVM (Flutter Version Management) by following the official installation guide: https://fvm.app/docs/getting_started/installation

2. Clone the repository by running the following command:

    ```bash
    git clone https://github.com/obitodarky/video-rpg.git
    cd video_rpg    
    ```

3. Run the following commands to install the Flutter SDK version specified for this project:

    ```bash
    fvm install 3.3.8
    fvm use 3.3.8
    fvm flutter doctor -v
    ```
   
4. Run `fvm flutter pub get && fvm flutter run` to run the project

## System Architecture

The file structure is as follows:

  -lib<br>
    &ensp; -features<br>
        &emsp;-video_rpg<br>
            &emsp; &ensp;-data<br>
            &emsp; &ensp;-provider<br>
            &emsp; &ensp;-ui<br>
    main.dart<br>

 ### main.dart
This is the main entry point of the app

### lib/features
All the features should separately go inside the `/features` directory. Every feature should be broken down into `data, provider and ui` layers if applicable. 

### data
This contains the `Choice` data model and `getMockData` public method.
Ideally, the data layer should contain data models, currently, we have also added a sample `getMockData` method since we do not have any network calls. If there are any network calls, ideally they should go to the `network` layer which should call generic network calls from an abstract class, agnostic of the feature.

### provider
The Provider will contain the business logic that updates the UI layer. Any updates/changes should happen here. The `VideoPlayerProvider` class notifies listeners on the UI layer and tells them when to update the view 

### ui
UI layer has just one screen `VideoPlayerScreen`. Since the project scope is not that big, function `_formatDuration` has been defined in the class itself. Ideally, the formatting functions should be in a separate `util` file. `VideoPlayerScreen` should ideally also be broken down into smaller Widgets for readability and reusability, again keeping the scope of the project in mind, this was not considered. 



## Using the App

Once the app is launched, a video will open up. (Ideally, the videos should have defined aspect ratios (eg: 16:9, 4:3), but since the videos were sample/test videos randomly taken from the internet, they have different aspect ratios). 

The play button will start the video. 
The video has a seek bar that helps in going forwards/backward. 
Once the first video is played, the user is prompted with two options to select a choice. Based on the choice they choose, a different video will be played. Once the user taps on the video again, they can use the playback options provided to them and also go back to different options and revisit the video.


## Modifications

- Data Moditifaciton
  - If you want to test on different videos, you can add your links to the `getMockData` method. The data follows a binary tree-like structure. So make sure your last `Choice` should not have any `nextOptions` and your `rootOption` will be the first option given to the user
  - If you want to add other attributes to the `Choice` class, (like emojis, ids, widgets, etc) you can add them as separate fields (make sure you keep null safety in mind)
- UI Modification
  - `VideoPlayer` library uses a very basic video player. All the UI controls are built on top. These controls can be changed to your liking. You can also change the UI for showing options, currently only a button UI is shown for each option. Similarly, you can also change the re-selecting of the options widget as per your liking
