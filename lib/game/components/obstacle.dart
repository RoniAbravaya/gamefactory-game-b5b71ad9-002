import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-runner-02/game_objects/player.dart';

/// Represents an obstacle in the runner game.
class Obstacle extends PositionComponent with CollisionCallbacks {
  final Sprite _sprite;
  final double _speed;
  final double _damage;

  Obstacle({
    required Vector2 position,
    required this._sprite,
    required this._speed,
    required this._damage,
  }) : super(position: position, size: _sprite.originalSize) {
    addShape(HitboxShape.rectangle(size: size));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      other.takeDamage(_damage);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= _speed * dt;

    // Despawn the obstacle if it goes off-screen
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.render(canvas, position: position, size: size);
  }
}