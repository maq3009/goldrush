import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:goldrush/components/george.dart';
import 'package:goldrush/components/background.dart';




//GAME SYNOPSIS - 
//In GoldRush, you play as an explorer who must travel across the land in search of wealth by collecting
//any gold coins you can find.  Beware, though: the path ahead won't be easy.  You must avoid the zombies
//and skeletons that roam the land in search of your blood.


void main() async {
  final goldRush = GoldRush();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  runApp(
    GameWidget(game: goldRush)
  );
}


class GoldRush extends FlameGame with HasCollisionDetection{
  static const int squareSpeed = 250;
  static final squarePaint = BasicPalette.green.paint();
  static const squareWidth = 100.0, squareHeight = 100.0;
  late Rect squarePos;
  int squareDirection = 1;
  late double screenWidth, screenHeight, centerX, centerY;




  @override
  Future<void> onLoad() async {
    super.onLoad();
      add(Background());
      add(George());
  }





}