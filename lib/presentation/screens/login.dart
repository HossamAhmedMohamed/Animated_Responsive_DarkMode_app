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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String testEmail = "hossam@gmail.com";
  String testPassword = "123456";

  bool isLookingLeft = false;
  bool isLookingRight = false;

  final passwordFocusNode = FocusNode();

  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);

    isLookingLeft = false;
    isLookingRight = false;
  }

  void addAnimatedController(RiveAnimationController neededController) {
    removeAllControllers();
    riveArtboard?.artboard.addController(neededController);
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerLookLeft);
    debugPrint("Lefttttttt");
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtboard?.artboard.addController(controllerLookRight);
    debugPrint("Righttttttt");
  }

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

  void checkForPasswordFocusNodeToChangeAnimation() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addAnimatedController(controllerHandsUp);
      } else if (!passwordFocusNode.hasFocus) {
        addAnimatedController(controllerHandsDown);
      }
    });
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addAnimatedController(controllerSuccess);
      } else {
        addAnimatedController(controllerFail);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    loadRiveFileWithItsState();
    checkForPasswordFocusNodeToChangeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20),
          child: Column(
            
            children: [
                SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: riveArtboard == null
                    ? SizedBox.shrink()
                    : Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Rive(artboard: riveArtboard!)),
              ),

                SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) =>
                            value != testEmail ? "Wrong Email" : null,
                        onChanged: (value) {
                          if (value.isNotEmpty &&
                              value.length < 16 &&
                              !isLookingLeft) {
                            addLookLeftController();
                          } else if (value.isNotEmpty &&
                              value.length > 16 &&
                              !isLookingRight) {
                            addLookRightController();
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      TextFormField(
                        obscureText: true,
                        focusNode: passwordFocusNode,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) =>
                            value != testPassword ? "Wrong Password" : null,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18)),
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/70),
                          child: InkWell(
                            onTap: () {
                              passwordFocusNode.unfocus();
                              validateEmailAndPassword();
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
