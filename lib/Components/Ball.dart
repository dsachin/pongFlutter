import 'dart:math';

import 'package:flame/game/base_game.dart';
import 'package:flutter/material.dart';
import 'package:pong_flutter/Components/Paddle.dart';
import 'package:pong_flutter/PongGame.dart';

class Ball extends BaseGame {
  final PongGame game;
  Rect ball;
  Paint ballPaint;
  Random rnd;

  double left;
  double top;
  final double width = 25;
  final double height = 25;

  int dx;
  int dy;
  int direction;

  Ball(this.game, this.left, this.top) {
    rnd = Random();
    reset();
  }
  void reset() {
    left = game.screenSize.width / 2 - 12.5;
    top = game.screenSize.height / 2 - 12.5;

    direction = rnd.nextInt(2) == 1 ? -1 : 1;
    dx = direction * 200;
    //dy = rnd.nextInt(500) * direction;
    dy = 50 * direction;
    ball = Rect.fromLTWH(left, top, width, height);
  }

  void render(Canvas c) {
    ballPaint = Paint();
    ballPaint.color = Colors.white;

    c.drawRect(ball, ballPaint);
  }

  void update(double t) {
    left = left + dx * t;
    top = top + dy * t;
    ball = ball.translate(dx * t, dy * t);
  }

  bool collide(Paddle box) {
    if (ball.left > box.left + box.width || ball.left + ball.width < box.left)
      return false;

    if (ball.top > box.height + box.top || ball.top + ball.height < box.top)
      return false;
    ballPaint.color = Colors.red;

    return true;
  }
}
