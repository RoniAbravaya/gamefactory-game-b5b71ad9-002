import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/audio.dart';
import 'package:flutter/material.dart';

/// A collectible item component for a runner game.
class Collectible extends SpriteComponent with CollisionCallbacks {
  final int scoreValue;
  final Audio _collectSound;

  /// Constructs a new [Collectible] instance.
  ///
  /// [sprite] is the sprite to be used for the collectible.
  /// [position] is the initial position of the collectible.
  /// [size] is the size of the collectible.
  /// [scoreValue] is the score value awarded for collecting this item.
  /// [collectSound] is the audio to be played when the collectible is collected.
  Collectible({
    required Sprite sprite,
    required Vector2 position,
    required Vector2 size,
    required this.scoreValue,
    required Audio collectSound,
  })  : _collectSound = collectSound,
        super(
          position: position,
          size: size,
          sprite: sprite,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addCollision();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    _handleCollision();
  }

  void _handleCollision() {
    // Trigger score update and play collect sound
    _collectSound.play();
    removeFromParent();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Add optional animation logic here (e.g., spinning, floating)
  }
}