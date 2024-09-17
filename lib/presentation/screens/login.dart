// ignore_for_file: prefer_const_constructors

import 'package:animation_splash_login/presentation/widgets/animation_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtboard;

  GlobalKey formKey = GlobalKey();

  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  void loadRiveFileWithItsState() {
    rootBundle.load("assets/login_screen_character.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      artboard.addController(controllerIdle);

      setState(() {
        riveArtboard = artboard;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.look_down_left.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.look_down_right.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    loadRiveFileWithItsState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20),
                
                ),
      ),
    );
  }
}
