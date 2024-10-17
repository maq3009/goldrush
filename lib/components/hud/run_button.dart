import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class RunButton extends HudButtonComponent {
  RunButton({
    required button,
    buttonDown, //consider changing to SpriteComponent button
    EdgeInsets? margin,
    Vector2? position,
    Vector2? size,
    Anchor anchor = Anchor.center,
    onPressed,
  }) : super(
            button: button,
            buttonDown: buttonDown,
            margin: margin,
            position: position,
            size: size ?? button.size,
            anchor: anchor,
            onPressed: onPressed);

  bool buttonPressed = false;

  // @override
  // bool onTapDown(TapDownInfo info) {
  //   super.onTapDown(info);
  //   buttonPressed = true;
  //   return true;
  // }

  // void onTapUp(TapUpInfo info) {
  //   super.onTapUp(info);
  //   buttonPressed = false;
  // }

  // @override
  // bool onTapCancel() {
  //   super.onTapCancel();
  //   buttonPressed = false;
  //   return true;
  // }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    buttonPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    buttonPressed = false;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    buttonPressed = false;
  }
}
