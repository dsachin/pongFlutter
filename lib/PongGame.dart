import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pong_flutter/Components/Ball.dart';
import 'package:pong_flutter/Components/Controller.dart';
import 'package:pong_flutter/Components/Paddle.dart';

class PongGame extends Game with TapDetector {
  Size screenSize;

  Ball ball;
  Ball ball2;
  Ball ball3;
  Random rnd;
  Paddle topPaddle;
  Paddle bottomPaddle;
  Controller controller;
  final kPaddleSpeed = 100.0;
  PongGame() {
    initialize();
  }

  void initialize() async {
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    ball = Ball(this, 20, 50);
    ball2 = Ball(this, 50, 20);
    ball3 = Ball(this, 100, 100);
    topPaddle =
        Paddle(this, screenSize.width / 2 - 75, screenSize.height - 700);
    bottomPaddle =
        Paddle(this, screenSize.width / 2 - 75, screenSize.height - 50);
    controller = Controller(this);
  }

  void render(Canvas c) {
    ball.render(c);
    //ball2.render(c);
    //ball3.render(c);
    bottomPaddle.render(c);
    topPaddle.render(c);
    controller.render(c);
  }

  void update(double t) {
    //Collision Detection
    if (ball.collide(topPaddle) || ball.collide(bottomPaddle)) {
      ball.dy = -ball.dy;
    }

    if (ball.left >= screenSize.width - 12.5) {
      ball.dx = -ball.dx;
      ball.left = screenSize.width - 12.5;
    } else if (ball.left <= 0 - 12.5) {
      ball.dx = -ball.dx;
      ball.left = 0 - 12.5;
    }

    //Score Setter
    if (ball.top < 0) {
      ball.reset();
    } else if (ball.top > screenSize.height - 12.5) {
      ball.reset();
    }

    ball.update(t);

    // --Game Controls
    //      if love.keyboard.isDown('w') then
    //       paddle1.dy=-PADDLE_SPEED
    //   elseif
    //       love.keyboard.isDown('s') then
    //       paddle1.dy=PADDLE_SPEED
    //   else
    //       paddle1.dy=0
    //   end

    //   if love.keyboard.isDown('up') then
    //       paddle2.dy=-PADDLE_SPEED
    //   elseif love.keyboard.isDown('down') then
    //       paddle2.dy=PADDLE_SPEED
    //   else
    //       paddle2.dy=0
    //   end

    topPaddle.update(t);
    bottomPaddle.update(t);
    //ball3.update(t);

    //ball2.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  @override
  void onTapUp(TapUpDetails d) {
    print("Player tap down on ${d.globalPosition.dx} - ${d.globalPosition.dy}");

    if (controller.leftPlayer1.contains(d.globalPosition)) {
      topPaddle.onTapDown("leftPlayer1");
      topPaddle.dx = -kPaddleSpeed;
    } else if (controller.rightPlayer1.contains(d.globalPosition)) {
      topPaddle.onTapDown("rightPlayer1");
      topPaddle.dx = kPaddleSpeed;
    } else {
      topPaddle.dx = 0;
    }
    if (controller.leftPlayer2.contains(d.globalPosition)) {
      bottomPaddle.onTapDown("leftPlayer2");

      bottomPaddle.dx = -kPaddleSpeed;
    } else if (controller.rightPlayer2.contains(d.globalPosition)) {
      bottomPaddle.onTapDown("rightPlayer2");

      bottomPaddle.dx = kPaddleSpeed;
    } else {
      bottomPaddle.dx = 0;
    }
  }
}
