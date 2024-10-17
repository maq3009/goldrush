import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class George extends SpriteAnimationComponent with CollisionCallbacks {
  George(
      {required Vector2 position, required Vector2 size, required double speed})
      : super(
          position: position,
          size: size,
        );

  late double screenWidth, screenHeight, centerX, centerY;
  late double georgeSizeWidth = 48.0, georgeSizeHeight = 48.0;
  late SpriteAnimation georgeDownAnimation,
      georgeLeftAnimation,
      georgeUpAnimation,
      georgeRightAnimation;
  double elapsedTime = 0.0;
  double georgeSpeed = 40.0;
  int currentDirection = down;
  static const int down = 0, left = 1, up = 2, right = 3;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = MediaQueryData.fromView(window).size.width;
    screenHeight = MediaQueryData.fromView(window).size.height;
    centerX = (screenWidth / 2) - (georgeSizeWidth / 2);
    centerY = (screenHeight / 2) - (georgeSizeHeight / 2);
    // size = Vector2(georgeSizeWidth, georgeSizeHeight);
    var spriteImages = await Flame.images.load('george.png');
    final spriteSheet =
        SpriteSheet(image: spriteImages, srcSize: Vector2(width, height));

    georgeDownAnimation =
        spriteSheet.createAnimationByColumn(column: 0, stepTime: 0.2);
    georgeLeftAnimation =
        spriteSheet.createAnimationByColumn(column: 1, stepTime: 0.2);
    georgeUpAnimation =
        spriteSheet.createAnimationByColumn(column: 2, stepTime: 0.2);
    georgeRightAnimation =
        spriteSheet.createAnimationByColumn(column: 3, stepTime: 0.2);

    animation = spriteSheet.createAnimationByColumn(column: 0, stepTime: 0.2);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (currentDirection) {
      case down:
        position.y += georgeSpeed * dt;
        break;
      case left:
        position.x -= georgeSpeed * dt;
        break;
      case up:
        position.y -= georgeSpeed * dt;
        break;
      case right:
        position.x += georgeSpeed * dt;
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);

    // if (position.x < 0) {
    //   position.x = 0;  // Clamp to the left edge
    // } else if (position.x + size.x > screenWidth) {
    //   position.x = screenWidth - size.x;  // Clamp to the right edge
    // }

    // if (position.y < 0) {
    //   position.y = 0;  // Clamp to the top edge
    // } else if (position.y + size.y > screenHeight) {
    //   position.y = screenHeight - size.y;  // Clamp to the bottom edge
    // }

    switch (currentDirection) {
      case down:
        currentDirection = down;
        animation = georgeDownAnimation;
        break;
      case up:
        currentDirection = up;
        animation = georgeUpAnimation;
        break;
      case right:
        currentDirection = right;
        animation = georgeRightAnimation;
        break;
      case left:
        currentDirection = left;
        animation = georgeLeftAnimation;
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
    final spriteList = List<int>.generate(to - from, (i) => from + i)
        .map((e) => getSprite(e, column))
        .toList();
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}
