import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Character extends SpriteAnimationComponent with CollisionCallbacks {
  Character(
      {required Vector2 position,
      required Vector2 size,
      required double speed}) {
    this.position = position;
    this.size = size;
    this.speed = speed;
  }

  late SpriteAnimation downAnimation,
      leftAnimation,
      upAnimation,
      rightAnimation;
  late double speed;
  double elapsedTime = 0.0;
  int currentDirection = down;
  static const int down = 0, left = 1, up = 2, right = 3;

  void changeDirection() {
    Random random = Random();
    int newDirection = random.nextInt(4);
    switch (newDirection) {
      case 0:
        animation = downAnimation;
        break;
      case 1:
        animation = leftAnimation;
        break;
      case 2:
        animation = upAnimation;
        break;
      case 3:
        animation = rightAnimation;
        break;
    }
    currentDirection = newDirection;
  }
}
