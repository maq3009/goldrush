import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'dart:ui';


class George extends SpriteAnimationComponent {
  late double screenWidth, screenHeight, centerX, centerY;
  late double georgeSizeWidth = 48.0, georgeSizeHeight = 48.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;
    centerX = (screenWidth / 2) - (georgeSizeWidth / 2);
    centerY = (screenHeight / 2) - (georgeSizeHeight / 2);
    position = Vector2(centerX, centerY);
    size = Vector2(georgeSizeWidth, georgeSizeHeight);
    var spriteImages = await Flame.images.load('george.png');
    final spriteSheet = SpriteSheet(image: spriteImages, srcSize: Vector2(width, height));


    animation = spriteSheet.createAnimationByColumn(
      column: 0, stepTime: 0.2);
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