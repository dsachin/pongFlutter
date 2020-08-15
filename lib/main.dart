import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_flutter/PongGame.dart';

void main() async {
  PongGame game = PongGame();
  runApp(game.widget);
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapUp = game.onTapUp;
}
