import 'dart:math';

import 'package:flutter/material.dart';

import '../PongGame.dart';

class Paddle {
  final kPaddleSpeed = 100.0;

  final PongGame game;
  double left;
  double top;
  double height = 20;
  double width = 150;
  Paint paddleColor;
  Rect paddle;
  double dx = 0;
  double leftPosition = 0;

  Paddle(this.game, this.left, this.top) {
    paddle = Rect.fromLTWH(this.left, this.top, width, height);
    paddleColor = Paint();
    paddleColor.color = Colors.red;
  }

  void render(Canvas c) {
    c.drawRect(paddle, paddleColor);
  }

  void update(double t) {
    left = left + dx * t;
    if (dx < 0) {
      leftPosition = min(0, dx * t);
    } else if (dx > 0) {
      leftPosition = min(game.screenSize.width - 75, dx * t);
    }

    paddle = paddle.translate(leftPosition, 0);
  }

  void onTapDown(String paddleName) {
    // if (paddleName == "leftPlayer1") {
    //   dx = -kPaddleSpeed;
    // } else if (paddleName == "rightPlayer1") {
    //   dx = kPaddleSpeed;
    // }
    // if (paddleName == "leftPlayer2") {
    //   dx = -kPaddleSpeed;
    // } else if (paddleName == "rightPlayer2") {
    //   dx = kPaddleSpeed;
    // }
  }
}
