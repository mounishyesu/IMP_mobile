import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Views/MusicPlayer/Helpers/config.dart';
import 'package:music_player/Views/MusicPlayer/Screens/Player/audioplayer.dart';
import 'package:music_player/Views/Tabs/Tabs.dart';
import 'package:path_provider/path_provider.dart';

import 'Views/Login/SplashScreen.dart';
import 'Views/MusicPlayer/Services/audio_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('IMP');
  } else {
    await Hive.initFlutter();
  }
  await openHiveBox('settings');
  await openHiveBox('downloads');
  await openHiveBox('Favorite Songs');
  await openHiveBox('cache', limit: true);
  if (Platform.isAndroid) {
    setOptimalDisplayMode();
  }
  await startService();
  runApp(MyApp());
}

Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where(
        (DisplayMode m) => m.width == active.width && m.height == active.height,
  )
      .toList()
    ..sort(
          (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    );

  final DisplayMode mostOptimalMode =
  sameResolution.isNotEmpty ? sameResolution.first : active;

  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}

Future<void> startService() async {
  final AudioPlayerHandler audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.shadow.blackhole.channel.audio',
      androidNotificationChannelName: 'BlackHole',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'drawable/ic_stat_music_note',
      androidShowNotificationBadge: true,
      // androidStopForegroundOnPause: Hive.box('settings')
      // .get('stopServiceOnPause', defaultValue: true) as bool,
      notificationColor: Colors.grey[900],
    ),
  );
  GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
  GetIt.I.registerSingleton<MyTheme>(MyTheme());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/BlackHole/$boxName.hive');
      lockFile = File('$dirPath/BlackHole/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IMP",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/screen1': (BuildContext context) => const Tabs(),
        });
  }
}
