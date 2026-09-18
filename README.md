<div align="center">

# 🎵 ClassiPod

![Classipod App Screenshots](screenshots/combined.jpg)

Introducing "ClassiPod" – Your Timeless Audio Experience

Step back in time with ClassiPod, a local music player app designed to capture the nostalgic essence
of the iconic iPod Classic. Immerse yourself in the familiar click wheel interface and relive the
joy of navigating your music library with a touch of retro charm.

</div>

> ### 🍴 This is a fork
>
> This repository is a personal fork of
> **[ClassiPod by Aditya R (@adeeteya)](https://github.com/adeeteya/Classipod)**. All of the
> design, the click wheel, and effectively the entire app are their work — I am only adding a
> few things on top for my own use. If you want ClassiPod itself, go to
> [the original repository](https://github.com/adeeteya/Classipod); please star and support that
> one rather than this fork.
>
> See [About this fork](#-about-this-fork) for what is different here.

🧭 Intuitive Navigation: Navigate through your music library effortlessly using the virtual click
wheel. Scroll, click, and feel the tactile response as you rediscover the joy of selecting your
favorite tracks with the same ease as the original iPod.

🗃️ Local Music Library: ClassiPod is focused on your locally stored music files, ensuring that your
personal music collection takes center stage. Organize your tracks, albums, and playlists just like
you did on your trusty iPod Classic.

🖌️ Customizable Themes: Personalize your ClassiPod experience with the option of silver or grey
device frame. Choose from the two different color schemes to tailor the app's appearance to your
unique style.

🖼️ Cover Art Display: Immerse yourself in your music by appreciating album artwork on the vibrant
display. ClassiPod pays homage to the visual appeal of classic iPods by showcasing your favorite
album covers in a retro-inspired format.

🎼 No Frills, Just Music: ClassiPod stays true to the essence of a music player – no distractions, no
unnecessary features. Focus solely on the joy of listening to your favorite tunes without the
complexities of a modern streaming service.

🎧 Offline Listening: Enjoy your music without relying on an internet connection. ClassiPod is
perfect for those moments when you want to disconnect and savor the tunes stored locally on your
device.

Relive the magic of the iPod Classic with ClassiPod – where timeless design meets the convenience of
today. Download now and embark on a journey down memory lane with your music in the palm of your
hand.

If you like what you see, please ⭐ the repo.

## ✨ Features

- 🗃️ Plays MP3, WAV, FLAC, M4A, MP4, Ogg, Opus, AAC, AIFF, APE, and MOV audio
- 🔎 Choose a Custom Folder To Scan Music From (By Default it is the Device Music Folder in the root folder
  of the device)
- 🎨 Multiple Ipod Classic Device Colors (Silver and Black)
- 🖼️ Displays the Music Metadata (Album Art, Artist Names)
- ⏩ Ability to seek forward and backwards on a audio file (By Long Pressing the seek
  forward/backwards buttons)
- ⏮️ Ability to go to previous and next track in the playlist
- 📱 Ipod Classic User Interface
- 🎞️ Cover Flow View
- 🎡 Click Wheel with Scrollable Rotation Enabled
- 💿 Now Playing Screen with current music progress displayed
- 🎶 Songs Screen with all the possible songs from the selected directory
- 🧑‍🎤 Ability to Filter and Select From a Particular Artist, Album or Genre
- 📲 Responsive Design For all Different Types of Screen Sizes
- 🔋 Displays the current device battery level and charging status on the status bar
- 🎧 Background Playback with Notification Control
- 🔀 Shuffle Songs Feature
- ➰ Loop Songs Feature (Loop one song or an entire playlist)
- 🔉 Click Wheel Sounds
- 📳 Vibration when clicking buttons and scrolling through the scroll wheel
- 🔇 In App Volume Control
- 🪞 Reflective Cover Art
- ℹ️ About Screen
- 🌍 Multi Language Support (Over 197 Languages Supported)
- 👆 Touch Screen Support
- 📺 Split Screen View (6th and 7th Gen iPod Classic)
- 🔍 Ability to search songs, artists, playlists and albums
- ⬇️ Caching Metadata of the songs for faster boot up times
- 📃 Ability to Create and Store Custom User Created Playlists
- 📖 App Usage Tutorial
- ⭐ Song Rating Feature
- 📝 Displays embedded lyrics in Now Playing

### 🎵 Supported audio formats

ClassiPod imports a format when its metadata can be read and at least one
configured playback backend can play it. Playback availability therefore varies
by platform:

| Format         | Extensions               | Expected playback                               |
|----------------|--------------------------|-------------------------------------------------|
| MP3            | `.mp3`                   | Android, iOS, Windows, Linux, web               |
| PCM WAV        | `.wav`                   | Android, iOS, Windows, Linux, web               |
| FLAC           | `.flac`                  | Android, iOS, Windows, Linux, major browsers    |
| AAC in MP4     | `.m4a`, `.mp4`           | Android, iOS, Windows, Linux, major browsers    |
| Ogg Vorbis     | `.ogg`                   | Android, Windows, Linux, supporting browsers    |
| Ogg Opus       | `.opus`                  | Android, Windows, Linux, supporting browsers    |
| Raw ADTS AAC   | `.aac`                   | Android, iOS, Windows, Linux; browser-dependent |
| AIFF / AIFF-C  | `.aif`, `.aiff`, `.aifc` | iOS, Windows, Linux                             |
| Monkey's Audio | `.ape`                   | Windows, Linux                                  |
| QuickTime      | `.mov`                   | iOS, Windows, Linux; browser-dependent          |

### 🔜 Upcoming Features

- 🎮 Ipod Built-in Games
- 📸 Ability to View Photos and Videos from the device

## 🍴 About this fork

The goal is to use ClassiPod as an **Android home screen**, not just a music player — keeping the
click wheel as the way to drive the phone, and gradually adding the things that make a device
usable day to day.

### Changed so far

- **`OLED Black` device colour is now genuinely black.** Upstream already had a pure black frame,
  but the click wheel housing was `#212122` and the select button used a light grey gradient. The
  wheel and button are now black too, with a faint `#2A2A2C` ring so the dial is still findable.
- **The select button now honours `noiseOpacity`.** It previously painted the noise texture at
  full opacity regardless of the device colour, so it could never render as true black.
- **System bar icons follow the device colour.** They were pinned to dark globally, which made
  them invisible against a black frame. `DeviceFrame` now sets the overlay style from
  `DeviceColorStyle.isDark`, which also fixes the navigation bar on the black, blue, green and
  brown frames.
- **An Apps menu.** A new top-level entry lists every launchable app on the device, scrolled with
  the click wheel and opened with the select button. Android only; other platforms show the empty
  state.
- **Pin apps to the main menu.** Long press select on any app in the Apps list to promote it onto
  the main menu, so launching it is one scroll and one press instead of descending into Apps
  first. Pinned apps are marked with a dot and persist across restarts.
- **A `HOME` intent filter**, so the app can be selected as the device home screen. This does
  nothing until you pick it under *Settings → Apps → Default apps → Home app*, and you can switch
  back to your usual launcher there at any time.
- **A `Build Debug APK` workflow** that produces an installable artifact on every push, so the app
  can be built without a local Flutter toolchain.
- **The Flutter version constraint is `>=3.44.7`** instead of pinned exactly, so the SDK bundled
  with Android Studio works. CI still checks against 3.44.7.

### Planned

- Clock and timer screens
- Contacts and dialling
- Making the home screen render before the music library scan finishes

### Building this fork

```bash
flutter pub get
flutter gen-l10n
flutter run --flavor dev
```

Or grab the APK from the **Actions** tab — every push builds a debug `dev`-flavour APK that
installs alongside the real ClassiPod rather than replacing it.

## 💻 Installation links

> The links below are for the **original** ClassiPod, not this fork.


<table>
  <tr>
    <th>Platform</th>
    <th>Installation Links</th>
  </tr>
  <tr>
    <td>Android</td>
    <td>
      <a href="https://play.google.com/store/apps/details?id=com.adeeteya.classipod">
        <img height="80" alt="Get it on Google Play" src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png">
      </a>
      <br>
      <a href="https://f-droid.org/packages/com.adeeteya.classipod">
        <img height="80" alt="Get it on F-Droid" src="https://f-droid.org/badge/get-it-on.png">
      </a>
      <br>
      <a href="https://github.com/adeeteya/Classipod/releases/latest/download/Classipod-Android.apk">
        <img alt="APK download" src="https://img.shields.io/static/v1?label=Download&message=Android+.apk&color=2ea44f&style=for-the-badge&logo=Android&logoColor=white&logoSize=auto">
      </a>
    </td>
  </tr>

  <tr>
      <td>Linux</td>
      <td>
        <a href="https://github.com/adeeteya/Classipod/releases/latest/download/Classipod-Linux-AppImage.AppImage">
          <img alt="Download .AppImage" src="https://img.shields.io/static/v1?label=Download&message=.AppImage&color=FCC624&style=for-the-badge&logo=linux&logoColor=white&logoSize=auto">
        </a>
        <br>
        <br>
        <a href="https://github.com/adeeteya/Classipod/releases/latest/download/Classipod-Linux-deb.deb">
          <img alt="Download .deb" src="https://img.shields.io/static/v1?label=Download&message=%20%20%20%20%20.deb&color=A81D33&style=for-the-badge&logo=debian&logoColor=white&logoSize=auto">
        </a>
        <br>
        <br>
        <a href="https://github.com/adeeteya/Classipod/releases/latest/download/Classipod-Linux-rpm.rpm">
          <img alt="Download .rpm" src="https://img.shields.io/static/v1?label=Download&message=.rpm&color=EE0000&style=for-the-badge&logo=redhat&logoColor=white&logoSize=auto">
        </a>
      </td>
  </tr>

  <tr>
      <td>Windows</td>
      <td>
        <a href="https://github.com/adeeteya/Classipod/releases/latest/download/Classipod-Windows.exe">
          <img alt="Download Windows Installer" src="https://img.shields.io/static/v1?label=Download&message=Windows+.exe&color=blue&style=for-the-badge&logo=webtrees&logoColor=white&logoSize=auto">
        </a>
      </td>
  </tr>

  <tr>
      <td>Web App</td>
      <td>
        <a href="https://adeeteya.github.io/Classipod/#/">
          <img alt="Web App" src="https://img.shields.io/static/v1?label=Webapp&message=Visit+Website&color=blueviolet&style=for-the-badge&logo=googlechrome&logoColor=white&logoSize=auto">
        </a>
      </td>
  </tr>

</table>

## 🔌 Plugins

| Name                                                                                          | Usage                                                                               |
|-----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| [**audio_metadata_reader**](https://pub.dev/packages/audio_metadata_reader)                   | To read the metadata of the local mp3 files                                         |
| [**audio_service**](https://pub.dev/packages/audio_service)                                   | To support background audio playback                                                |
| [**battery_plus**](https://pub.dev/packages/battery_plus)                                     | Shows phone battery level and status                                                |
| [**cupertino_icons**](https://pub.dev/packages/cupertino_icons)                               | For ios style icons                                                                 |
| [**device_preview_plus**](https://pub.dev/packages/device_preview_plus)                       | For visualizing how the app looks on different devices and screens                  |
| [**disable_battery_optimization**](https://github.com/adeeteya/Disable-Battery-Optimizations) | To Disable vendor or android specific battery optimizations for background playback |
| [**file_picker**](https://pub.dev/packages/file_picker)                                       | To select the directory from which the music files are scanned                      |
| [**flutter_localizations**](https://pub.dev/packages/flutter_localizations)                   | For in-app localization map data                                                    |
| [**flutter_riverpod**](https://pub.dev/packages/flutter_riverpod)                             | For State Management                                                                |
| [**go_router**](https://pub.dev/packages/go_router)                                           | To handle routing within the app                                                    |
| [**hive_ce**](https://pub.dev/packages/hive_ce)                                               | To Cache Auio Metadata and store playlists                                          |
| [**hive_ce_flutter**](https://pub.dev/packages/hive_ce_flutter)                               | For flutter specific libs of hive                                                   |
| [**intl**](https://pub.dev/packages/intl)                                                     | For internalization and localization of the app                                     |
| [**just_audio**](https://pub.dev/packages/just_audio)                                         | To play audio files                                                                 |
| [**just_audio_background**](https://pub.dev/packages/just_audio_background)                   | To control audio through media notification                                         |
| [**just_audio_media_kit**](https://pub.dev/packages/just_audio_media_kit)                     | To play audio files on Windows and Linux                                            |
| [**media_kit_libs_linux**](https://pub.dev/packages/media_kit_libs_linux)                     | Media kit Libraries for Linux                                                       |
| [**media_kit_libs_windows_audio**](https://pub.dev/packages/media_kit_libs_windows_audio)     | Media kit Libraries for Windows                                                     |
| [**on_audio_query**](https://github.com/adeeteya/on_audio_query)                              | To fetch all the music files from Android and iOS                                   |
| [**path_provider**](https://pub.dev/packages/path_provider)                                   | To fetch app data directories                                                       |
| [**permission_handler**](https://pub.dev/packages/permission_handler)                         | To check and request for file and audio access permissions                          |
| [**shared_preferences**](https://pub.dev/packages/shared_preferences)                         | To store system settings                                                            |
| [**tutorial_coach_mark**](https://pub.dev/packages/tutorial_coach_mark)                       | To provide app tutorial to the users                                                |
| [**universal_html**](https://pub.dev/packages/universal_html)                                 | For Launching the app in full-screen mode on web versions                           |
| [**url_launcher**](https://pub.dev/packages/url_launcher)                                     | For Launching the Donation Page Link                                                |
| [**vibration**](https://pub.dev/packages/vibration)                                           | Used for vibration while using device controls                                      |
| [**vibration_web**](https://pub.dev/packages/vibration_web)                                   | Used for vibration on the webapp version                                            |
| [**build_runner**](https://pub.dev/packages/build_runner)                                     | For code generation                                                                 |
| [**custom_lint**](https://pub.dev/packages/custom_lint)                                       | For using custom lint rules                                                         |
| [**flutter_lints**](https://pub.dev/packages/flutter_lints)                                   | For using recommended flutter lints                                                 |
| [**flutter_test**](https://pub.dev/packages/flutter_test)                                     | For unit and widget testing the app                                                 |
| [**hive_ce_generator**](https://pub.dev/packages/hive_ce_generator)                           | For automatically generating Hive TypeAdapters                                      |
| [**riverpod_lint**](https://pub.dev/packages/riverpod_lint)                                   | For using riverpod specific linting rules                                           |

## 🤓 Author

ClassiPod is created and maintained by **[Aditya R](https://github.com/adeeteya)**. Huge thanks to
them for building it and for releasing it as open source — this fork exists only because that work
was shared freely.

This fork is maintained by **[Pratham Dupare](https://github.com/prathamdupare)**.

## 🔖 LICENCE

Copyright (c) 2025 Aditya R
[BSD-4-Clause LICENCE](https://github.com/adeeteya/Classipod/blob/master/LICENSE)

## 🙏 Attributions

<a href="https://www.flaticon.com/free-icons/ipod" title="ipod icons">Ipod icons created by
Freepik - Flaticon</a>
