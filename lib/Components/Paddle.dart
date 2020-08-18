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
    width = game.screenSize.width / 3;

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
    if (left > game.screenSize.width - (width - 3)) {
      left = game.screenSize.width - (width - 3);
      dx = 0;
    }
    if (left < 2) {
      dx = 0;
      left = 2;
    }
    if (dx != 0) {
      paddle = paddle.translate(leftPosition, 0);
      dx = 0;
      print(paddle);
    }
  }

  void reset(double leftPos, double topPos) {
    dx = 0;
    Offset pos = Offset(leftPos, topPos);

    paddle.shift(pos);
    // paddle = Rect.fromLTWH(leftPos, topPos, width, height);
  }
}
