import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.sourceVideoUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _betterPlayerController,
              key: _betterPlayerKey,
            ),
          ),
          ElevatedButton(
            child: const Text("Switch to mini player"),
            onPressed: () {
              _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
            },
          ),
          Row(
            children: [
              appLauncher(icon: Assets.whatsapp, url: OurSocials.whatsapp),
              appLauncher(icon: Assets.facebook, url: OurSocials.facebook),
              appLauncher(icon: Assets.instagram, url: OurSocials.instagram),
              appLauncher(icon: Assets.twitter, url: OurSocials.twitter),
              appLauncher(icon: Assets.sharechat, url: OurSocials.sharechat),
            ],
          ),
        ],
      ),
    );
  }

  InkWell appLauncher({String url = '', String icon = ''}) {
    return InkWell(
      onTap: () {
        AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: url,
        );
        intent.launch();
      },
      child: SvgPicture.asset(icon),
    );
  }
}
