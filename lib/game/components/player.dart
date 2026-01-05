import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/input.dart';

/// The player character in the runner game.
class Player extends SpriteAnimationComponent
    with CollisionCallbacks, KeyboardHandler {
  /// The player's current health or lives.
  int _health = 3;

  /// The player's current score.
  int _score = 0;

  /// Initializes the player component.
  Player({
    required Vector2 position,
    required SpriteAnimation idleAnimation,
    required SpriteAnimation runningAnimation,
    required SpriteAnimation jumpingAnimation,
  }) : super(
          position: position,
          size: Vector2.all(64),
          animation: idleAnimation,
        ) {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update player's position and animation based on input
    handleInput(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // Handle collisions with obstacles
    if (other is Obstacle) {
      _health--;
      if (_health <= 0) {
        // Player has died, handle game over
        resetPlayer();
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Handle player input (e.g., jump)
    if (event is RawKeyDownEvent && keysPressed.contains(LogicalKeyboardKey.space)) {
      jump();
    }
    return true;
  }

  /// Jumps the player.
  void jump() {
    // Implement jump logic
  }

  /// Resets the player's state.
  void resetPlayer() {
    _health = 3;
    _score = 0;
    // Reset player's position and animation
  }

  /// Increases the player's score.
  void increaseScore(int points) {
    _score += points;
  }
}