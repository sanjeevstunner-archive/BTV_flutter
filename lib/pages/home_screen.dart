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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(height: 8),
          Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(
                'http://139.99.96.85:1935/pollachi/myStream/playlist.m3u8',
                betterPlayerConfiguration: const BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                  allowedScreenSleep: false,
                  autoPlay: true,
                ),
              ),
            ),
          ),
          socialsBar(),
        ],
      ),
    );
  }

  Row socialsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        appLauncher(
            icon: Image(image: AssetImage(IconAssets.whatsapp)),
            url: OurSocials.whatsapp),
        appLauncher(
            icon: SvgPicture.asset(IconAssets.facebook),
            url: OurSocials.facebook),
        appLauncher(
            icon: SvgPicture.asset(IconAssets.instagram),
            url: OurSocials.instagram),
        appLauncher(
            icon: SvgPicture.asset(IconAssets.twitter),
            url: OurSocials.twitter),
        appLauncher(
            icon: Image(image: AssetImage(IconAssets.sharechat)),
            url: OurSocials.sharechat),
      ],
    );
  }

  InkWell appLauncher({String? url, Widget icon = const Text("Test")}) {
    return InkWell(
      onTap: () {
        AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: url,
        );
        intent.launch();
      },
      child: Container(
        height: 70,
        width: 70,
        child: Expanded(child: icon),
      ),
    );
  }
}
