import 'dart:ui';

import 'package:flame/game/base_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pong_flutter/PongGame.dart';

class Controller extends BaseGame {
  final PongGame game;

  Rect leftPlayer1;
  Rect rightPlayer1;

  Rect leftPlayer2;
  Rect rightPlayer2;
  Paint controllerPaint;
  final double height = 30;
  final double width = 35;

  Controller(this.game) {
    print("Screensize ${this.game.screenSize}");
    leftPlayer1 = Rect.fromLTWH(10, 10, width, height);
    rightPlayer1 = Rect.fromLTWH(370, 10, width, height);

    leftPlayer2 = Rect.fromLTWH(10, 690, width, height);
    rightPlayer2 = Rect.fromLTWH(370, 690, width, height);

    controllerPaint = Paint();
    controllerPaint.color = Colors.blue;
  }
  void render(Canvas c) {
    c.drawRect(leftPlayer1, controllerPaint);
    c.drawRect(leftPlayer2, controllerPaint);

    c.drawRect(rightPlayer1, controllerPaint);
    c.drawRect(rightPlayer2, controllerPaint);
  }

  void update(double t) {}
}
