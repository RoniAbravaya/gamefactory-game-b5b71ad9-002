import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// The main menu scene for the runner game.
class MenuScene extends Component with HasGameRef {
  /// The title of the game.
  late final TextComponent _titleComponent;

  /// The button to start the game.
  late final ButtonComponent _playButton;

  /// The button to access the level select screen.
  late final ButtonComponent _levelSelectButton;

  /// The button to access the settings screen.
  late final ButtonComponent _settingsButton;

  /// The background animation.
  late final AnimationComponent _backgroundAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Create the title component
    _titleComponent = TextComponent(
      text: 'testLast-runner-02',
      position: gameRef.size / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(_titleComponent);

    // Create the play button
    _playButton = ButtonComponent(
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.6),
      size: Vector2(200, 60),
      anchor: Anchor.center,
      child: TextComponent(
        text: 'Play',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        // Navigate to the game scene
      },
    );
    add(_playButton);

    // Create the level select button
    _levelSelectButton = ButtonComponent(
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.7),
      size: Vector2(200, 60),
      anchor: Anchor.center,
      child: TextComponent(
        text: 'Level Select',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        // Navigate to the level select scene
      },
    );
    add(_levelSelectButton);

    // Create the settings button
    _settingsButton = ButtonComponent(
      position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.8),
      size: Vector2(200, 60),
      anchor: Anchor.center,
      child: TextComponent(
        text: 'Settings',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        // Navigate to the settings scene
      },
    );
    add(_settingsButton);

    // Create the background animation
    _backgroundAnimation = AnimationComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      animation: await gameRef.loadAnimation('background.png'),
    );
    add(_backgroundAnimation);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _backgroundAnimation.update(dt);
  }
}