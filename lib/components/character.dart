import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';


class Character extends SpriteAnimationComponent with CollisionCallbacks {
  Character({required Vector2 position, required Vector2 size, required double speed}) { 
    this.position = position;
    this.size = size;
    this.speed = speed;
  }


  late SpriteAnimation downAnimation, leftAnimation, upAnimation, rightAnimation;
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

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;
    if(elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }

    switch (currentDirection) {
      case down:
        position.y += speed * dt;
        break;
      case left:
        position.x -= speed * dt;
        break;
      case up:
        position.y -= speed * dt;
        break;
      case right:
        position.x += speed * dt;
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);

      switch (currentDirection) {
        case down:
          currentDirection = up;
          animation = downAnimation;
          break;
        case up:
          currentDirection = down;
          animation = upAnimation;
          break;
        case right:
          currentDirection = left;
          animation = rightAnimation;
          break;
        case left:
          currentDirection = right;
          animation = leftAnimation;
          break;
      }
      elapsedTime = 0.0;
    }
  }


extension CreateAnimationByColumn on SpriteSheet {
  SpriteAnimation createAnimationByColumn({
    required int column,
    required double stepTime,
    bool loop = true, 
    int from = 0,
    int? to,
  }) {
    to ??= columns;
    final spriteList = List<int>.generate(to - from,
      (i) => from + i)
        .map((e) => getSprite(e, column)).toList();
        return SpriteAnimation.spriteList(
          spriteList,
          stepTime: stepTime,
          loop: loop,
      );
  }


}