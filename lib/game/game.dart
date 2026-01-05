import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:testLast-runner-02/components/player.dart';
import 'package:testLast-runner-02/components/obstacle.dart';
import 'package:testLast-runner-02/components/collectible.dart';
import 'package:testLast-runner-02/services/analytics.dart';
import 'package:testLast-runner-02/services/ads.dart';
import 'package:testLast-runner-02/services/storage.dart';
import 'package:testLast-runner-02/ui/overlays.dart';

/// The main game class for the 'testLast-runner-02' game.
class testLast-runner-02Game extends FlameGame with TapDetector {
  /// The current game state.
  GameState _gameState = GameState.playing;

  /// The current level being played.
  int _currentLevel = 1;

  /// The player's score.
  int _score = 0;

  /// The player component.
  late Player _player;

  /// The list of obstacles in the current level.
  late List<Obstacle> _obstacles;

  /// The list of collectibles in the current level.
  late List<Collectible> _collectibles;

  /// The analytics service.
  final AnalyticsService _analyticsService = AnalyticsService();

  /// The ads service.
  final AdsService _adsService = AdsService();

  /// The storage service.
  final StorageService _storageService = StorageService();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadLevel(_currentLevel);
    _analyticsService.logGameStart();
  }

  /// Loads the specified level.
  void _loadLevel(int level) {
    // Load level data
    _player = Player();
    _obstacles = _loadObstacles(level);
    _collectibles = _loadCollectibles(level);

    // Add components to the game
    add(_player);
    _obstacles.forEach(add);
    _collectibles.forEach(add);

    // Reset game state
    _gameState = GameState.playing;
    _score = 0;
  }

  /// Loads the obstacles for the specified level.
  List<Obstacle> _loadObstacles(int level) {
    // Load obstacle data based on level
    return [
      Obstacle(position: Vector2(100, 300)),
      Obstacle(position: Vector2(300, 400)),
    ];
  }

  /// Loads the collectibles for the specified level.
  List<Collectible> _loadCollectibles(int level) {
    // Load collectible data based on level
    return [
      Collectible(position: Vector2(200, 200)),
      Collectible(position: Vector2(400, 300)),
    ];
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update game state based on current state
    switch (_gameState) {
      case GameState.playing:
        _updatePlaying(dt);
        break;
      case GameState.paused:
        // Handle paused state
        break;
      case GameState.gameOver:
        // Handle game over state
        break;
      case GameState.levelComplete:
        // Handle level complete state
        break;
    }
  }

  /// Updates the game state while playing.
  void _updatePlaying(double dt) {
    // Update player, obstacles, and collectibles
    _player.update(dt);
    _obstacles.forEach((obstacle) => obstacle.update(dt));
    _collectibles.forEach((collectible) => collectible.update(dt));

    // Check for collisions
    _checkCollisions();

    // Update score
    _updateScore(dt);
  }

  /// Checks for collisions between the player, obstacles, and collectibles.
  void _checkCollisions() {
    // Check for player-obstacle collisions
    for (final obstacle in _obstacles) {
      if (_player.isColliding(obstacle)) {
        _handleGameOver();
        return;
      }
    }

    // Check for player-collectible collisions
    for (final collectible in _collectibles) {
      if (_player.isColliding(collectible)) {
        _collectible.collect();
        _incrementScore(collectible.value);
      }
    }
  }

  /// Handles the game over state.
  void _handleGameOver() {
    _gameState = GameState.gameOver;
    _analyticsService.logLevelFail();
    // Show game over overlay
    overlays.add(GameOverOverlay.ID);
  }

  /// Increments the player's score by the specified amount.
  void _incrementScore(int amount) {
    _score += amount;
    _analyticsService.logScoreUpdate(_score);
  }

  /// Updates the player's score based on time.
  void _updateScore(double dt) {
    // Update score based on time elapsed
    _incrementScore((dt * 10).toInt());
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (_gameState == GameState.playing) {
      _player.jump();
    }
  }
}

/// The possible game states.
enum GameState {
  playing,
  paused,
  gameOver,
  levelComplete,
}