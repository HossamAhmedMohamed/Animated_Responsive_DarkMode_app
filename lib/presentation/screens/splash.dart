// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'package:animation_splash_login/presentation/screens/login.dart';
import 'package:animation_splash_login/presentation/widgets/animation_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Artboard? riveArtboard;

  late RiveAnimationController controllerFloating;
  late RiveAnimationController controllerState;
  late RiveAnimationController controllerAppearing;

  void loadRiveFilesWithItsStates() {
    rootBundle.load("assets/new_file.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerAppearing);
      setState(() {
        riveArtboard = artboard;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    controllerFloating = SimpleAnimation(AnimationSplash.Floating.name);
    controllerState = SimpleAnimation(AnimationSplash.State.name);
    controllerAppearing = SimpleAnimation(AnimationSplash.Appearing.name);

    loadRiveFilesWithItsStates();

    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 213, 222, 225),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,
            child: riveArtboard == null
                ? const SizedBox.shrink()
                : Rive(
                    artboard: riveArtboard!,
                  ),
          ),
        ),
      ),
    );
  }
}
