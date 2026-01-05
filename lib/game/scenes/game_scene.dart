import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:testLast-runner-02/player.dart';
import 'package:testLast-runner-02/obstacle.dart';
import 'package:testLast-runner-02/collectible.dart';

/// The main game scene that handles the game logic.
class GameScene extends FlameGame with TapDetector {
  late Player _player;
  final List<Obstacle> _obstacles = [];
  final List<Collectible> _collectibles = [];
  int _score = 0;
  bool _isPaused = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadLevel();
    _spawnPlayer();
    _spawnObstacles();
    _spawnCollectibles();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_isPaused) {
      _updatePlayer(dt);
      _updateObstacles(dt);
      _updateCollectibles(dt);
      _checkCollisions();
      _checkWinCondition();
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (!_isPaused) {
      _player.jump();
    }
  }

  void _loadLevel() {
    // Load level data and set up the game world
  }

  void _spawnPlayer() {
    _player = Player();
    add(_player);
  }

  void _spawnObstacles() {
    // Spawn obstacles based on level data
    for (int i = 0; i < 5; i++) {
      final obstacle = Obstacle();
      _obstacles.add(obstacle);
      add(obstacle);
    }
  }

  void _spawnCollectibles() {
    // Spawn collectibles based on level data
    for (int i = 0; i < 10; i++) {
      final collectible = Collectible();
      _collectibles.add(collectible);
      add(collectible);
    }
  }

  void _updatePlayer(double dt) {
    _player.update(dt);
  }

  void _updateObstacles(double dt) {
    for (final obstacle in _obstacles) {
      obstacle.update(dt);
    }
  }

  void _updateCollectibles(double dt) {
    for (final collectible in _collectibles) {
      collectible.update(dt);
    }
  }

  void _checkCollisions() {
    // Check for collisions between player, obstacles, and collectibles
    // Handle collision events (e.g., player hit obstacle, player collected coin)
  }

  void _checkWinCondition() {
    // Check if the player has completed the level
    // Update score and handle level completion
  }

  void pause() {
    _isPaused = true;
  }

  void resume() {
    _isPaused = false;
  }
}