import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pong_flutter/Components/Ball.dart';
import 'package:pong_flutter/Components/Controller.dart';
import 'package:pong_flutter/Components/Paddle.dart';

class PongGame extends BaseGame with TapDetector {
  Size screenSize;

  int player1Score = 0;
  int player2Score = 0;
  Ball ball;
  Ball ball2;
  Ball ball3;
  Random rnd;
  Paddle topPaddle;
  Paddle bottomPaddle;
  Controller controller;
  final kPaddleSpeed = 450.0;
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
      player2Score++;
      resetGame();
    } else if (ball.top > screenSize.height - 12.5) {
      player1Score++;
      resetGame();
    }

    ball.update(t);

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
      topPaddle.dx = -kPaddleSpeed;
    } else if (controller.rightPlayer1.contains(d.globalPosition)) {
      topPaddle.dx = kPaddleSpeed;
    } else {
      topPaddle.dx = 0;
    }
    if (controller.leftPlayer2.contains(d.globalPosition)) {
      bottomPaddle.dx = -kPaddleSpeed;
    } else if (controller.rightPlayer2.contains(d.globalPosition)) {
      bottomPaddle.dx = kPaddleSpeed;
    } else {
      bottomPaddle.dx = 0;
    }
  }

  void resetGame() {
    print("P1 $player1Score, P2 $player2Score");
    ball.reset();
    topPaddle.reset(screenSize.width / 2 - 75, screenSize.height - 700);
    bottomPaddle.reset(screenSize.width / 2 - 75, screenSize.height - 50);
  }
}
