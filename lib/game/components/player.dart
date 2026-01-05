import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-runner-02/entities/obstacle.dart';
import 'package:testLast-runner-02/entities/collectable.dart';

/// The player character in the runner game.
class Player extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  /// The player's current horizontal position.
  double playerX = 0;

  /// The player's current vertical position.
  double playerY = 0;

  /// The player's current speed.
  double playerSpeed = 200;

  /// The player's current health.
  int playerHealth = 3;

  /// Whether the player is currently invulnerable.
  bool isInvulnerable = false;

  /// The duration of the player's invulnerability frames.
  final double invulnerabilityDuration = 2.0;

  /// The player's animation states.
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runningAnimation;
  late SpriteAnimation jumpingAnimation;
  late SpriteAnimation hurtAnimation;

  /// Initializes the player component.
  Player() : super(size: Vector2.all(50.0));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the player's animation sprites
    final spriteSheet = await gameRef.loadSpriteSheet(
      'player.png',
      srcSize: Vector2(64, 64),
      cols: 4,
      rows: 4,
    );

    idleAnimation = spriteSheet.createAnimation(row: 0, cols: 4, stepTime: 0.2);
    runningAnimation = spriteSheet.createAnimation(row: 1, cols: 4, stepTime: 0.1);
    jumpingAnimation = spriteSheet.createAnimation(row: 2, cols: 4, stepTime: 0.2);
    hurtAnimation = spriteSheet.createAnimation(row: 3, cols: 4, stepTime: 0.2);

    // Set the initial animation
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the player's position based on the current speed
    playerX += playerSpeed * dt;
    position.x = playerX;

    // Update the player's animation based on the current state
    if (playerSpeed > 0) {
      animation = runningAnimation;
    } else {
      animation = idleAnimation;
    }

    // Reduce the player's invulnerability duration
    if (isInvulnerable) {
      invulnerabilityDuration -= dt;
      if (invulnerabilityDuration <= 0) {
        isInvulnerable = false;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // Handle collisions with obstacles and collectibles
    if (other is Obstacle) {
      if (!isInvulnerable) {
        takeDamage();
      }
    } else if (other is Collectable) {
      other.collect();
    }
  }

  /// Reduces the player's health by 1.
  void takeDamage() {
    playerHealth--;
    isInvulnerable = true;
    invulnerabilityDuration = 2.0;
    animation = hurtAnimation;
  }

  /// Increases the player's health by the specified amount.
  void heal(int amount) {
    playerHealth = (playerHealth + amount).clamp(0, 3);
  }
}