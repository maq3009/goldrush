import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class Background extends PositionComponent {
  static final backgroundPaint = BasicPalette.white.paint();
  late double screenWidth, screenHeight;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = MediaQueryData.fromView(window).size.width;
    screenHeight = MediaQueryData.fromView(window).size.height;
    position = Vector2(0, 0);
    size = Vector2(screenWidth, screenHeight);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
        Rect.fromPoints(position.toOffset(), size.toOffset()), backgroundPaint);
  }
}
