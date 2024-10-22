import 'dart:async';

///你正在开发一个复杂的单人角色扮演游戏。这个游戏需要一个可靠的系统来管理玩家的进度，包括等级、经验值、已完成的任务、收集的物品等。
// 需求：
//
// 游戏在任何时候都只能有一个活跃的进度管理器实例。
// 进度管理器需要在游戏的不同部分之间共享数据。
// 它应该能保存和加载游戏进度。
// 进度管理器应该提供方法来更新和查询玩家的各种统计数据。
// 系统需要线程安全，因为可能会有多个游戏系统同时访问或修改数据。
//
// 任务：
// 使用单例模式实现这个游戏进度管理器。你需要：
//
// 创建一个 GameProgressManager 类，实现单例模式。
// 在这个类中实现以下功能：
//
// 保存玩家的等级、经验值、生命值等基本属性
// 管理已完成的任务列表
// 管理玩家的物品清单
// 提供保存和加载游戏进度的方法
// 实现更新和查询这些数据的方法
//
//
// 确保这个管理器是线程安全的。
// 在 main() 函数中演示如何使用这个系统来模拟游戏进程。
//
// 提示：
//
// 使用 Dart 的工厂构造函数来实现单例。
// 考虑使用 Dart 的 synchronized 包来实现线程安全。
// 你可以使用 Map 或自定义类来存储玩家的各种属性和物品。
// 模拟文件 I/O 操作来演示保存和加载功能（可以简单地打印到控制台）。
//
// 挑战（可选）：
//
// 实现一个简单的命令行界面，允许"玩家"进行一些基本操作，如升级、完成任务、获得物品等。
// 添加一个简单的自动保存功能，比如每次玩家升级时自动保存进度。
//
// 这个场景将让你深入理解单例模式，并且在实现过程中可能会遇到一些有趣的设计决策。完成后，你将有一个可以在实际游戏开发中扩展使用的基础系统。

///实例化时机
//
// 懒汉式：延迟加载（lazy loading），第一次使用时才创建实例
// 饿汉式：在类加载时就创建实例，不管是否使用
//
//
// 性能特点
//
// 懒汉式：
//
// 优点：不使用则不创建，节省资源
// 缺点：第一次使用时需要初始化，可能有延迟
//
//
// 饿汉式：
//
// 优点：获取实例时速度快，没有延迟
// 缺点：即使不使用也会创建，可能浪费资源
//
//
//
//
// 线程安全性
//
// 懒汉式：基本实现不是线程安全的，需要额外处理（如添加同步锁）
// 饿汉式：天然线程安全，因为实例在类加载时就创建完成
//
//
// 适用场景
//
// 懒汉式适用于：
//
// 实例化成本高的情况
// 不确定是否会使用该实例的情况
// 资源敏感的应用
//
//
// 饿汉式适用于：
//
// 实例化成本较低的情况
// 确定会使用该实例的情况
// 需要确保绝对的线程安全的情况

// class GameProgressManager {
//   static GameProgressManager instance = GameProgressManager._();
//
//   GameProgressManager._();
//
// //使用工厂构造确保返回同一个实例
//   factory GameProgressManager() {
//     return instance;
//   }
//
//   // 保存玩家的等级、经验值、生命值等基本属性
//   // 管理已完成的任务列表
//   // 管理玩家的物品清单
//   // 提供保存和加载游戏进度的方法
//   // 实现更新和查询这些数据的方法
//
//   // 玩家的等级
//   int _playerLevel = 0;
//
//   // 经验值
//   int _experienceValue = 0;
//
//   // 生命值
//   int _healthValue = 0;
//
//   // 玩家的物品清单
//   List<String> listOfItems = [];
//
// // 提供保存和加载游戏进度的方法
//   double _gameProgress = 0;
//
//   int get playerLevel => _playerLevel;
//
//   set playerLevel(value) {
//     _playerLevel = value;
//   }
//
//   int get experienceValue => _experienceValue;
//
//   set experienceValue(value) {
//     _experienceValue = value;
//   }
//
//   int get healthValue => _healthValue;
//
//   set healthValue(value) {
//     _healthValue = value;
//   }
//
//   double get gameProgress => _gameProgress;
//
//   set gameProgress(value) {
//     _gameProgress = value;
//   }
//
//   void upDateItems(List<String> items) {
//     listOfItems = items;
//   }
// }



class GameProgressManager {
  // 1. 使用私有静态字段
  static final GameProgressManager _instance = GameProgressManager._();

  // 2. 提供公共的获取实例方法确保返回的是同一个实例
  static GameProgressManager get instance => _instance;

  // 3. 私有构造函数
  GameProgressManager._();

  // 4. 使用私有static final常量来定义默认值
  static const int _DEFAULT_LEVEL = 1;
  static const int _DEFAULT_HEALTH = 100;
  static const int _DEFAULT_EXPERIENCE = 0;

  // 5. 使用late final来声明Stream控制器，用于状态管理
  late final _progressController = StreamController<double>.broadcast();
  late final _levelController = StreamController<int>.broadcast();

  // 6. 玩家属性
  int _playerLevel = _DEFAULT_LEVEL;
  int _experienceValue = _DEFAULT_EXPERIENCE;
  int _healthValue = _DEFAULT_HEALTH;
  double _gameProgress = 0.0;
  final List<String> _items = [];  // 使用final list

  // 7. 添加Stream getter用于监听变化
  Stream<double> get onProgressChanged => _progressController.stream;
  Stream<int> get onLevelChanged => _levelController.stream;

  // 8. 优化getter和setter
  int get playerLevel => _playerLevel;
  set playerLevel(int value) {
    if (value != _playerLevel) {
      _playerLevel = value;
      _levelController.add(value);
    }
  }

  int get experienceValue => _experienceValue;
  set experienceValue(int value) {
    if (value < 0) throw ArgumentError('经验值不能为负数');
    _experienceValue = value;
    _checkLevelUp();  // 检查是否需要升级
  }

  int get healthValue => _healthValue;
  set healthValue(int value) {
    if (value < 0) {
      _healthValue = 0;
    } else if (value > 100) {
      _healthValue = 100;
    } else {
      _healthValue = value;
    }
  }

  double get gameProgress => _gameProgress;
  set gameProgress(double value) {
    if (value < 0 || value > 100) {
      throw ArgumentError('进度必须在0-100之间');
    }
    _gameProgress = value;
    _progressController.add(value);
  }

  // 9. 优化物品管理方法
  List<String> get items => List.unmodifiable(_items);

  void addItem(String item) {
    if (item.isNotEmpty && !_items.contains(item)) {
      _items.add(item);
    }
  }

  void removeItem(String item) {
    _items.remove(item);
  }

  // 10. 添加游戏存档管理
  Future<void> saveProgress() async {
    // 这里添加保存到本地存储的逻辑
    final gameData = {
      'level': _playerLevel,
      'exp': _experienceValue,
      'health': _healthValue,
      'progress': _gameProgress,
      'items': _items,
    };

    // 模拟保存操作
    await Future.delayed(const Duration(milliseconds: 100));
    print('保存游戏进度: $gameData');
  }

  Future<void> loadProgress() async {
    // 这里添加从本地存储加载的逻辑
    await Future.delayed(const Duration(milliseconds: 100));
    // 模拟加载数据
    resetToDefault();
  }

  // 11. 添加辅助方法
  void resetToDefault() {
    _playerLevel = _DEFAULT_LEVEL;
    _experienceValue = _DEFAULT_EXPERIENCE;
    _healthValue = _DEFAULT_HEALTH;
    _gameProgress = 0.0;
    _items.clear();
  }

  void _checkLevelUp() {
    // 简单的升级逻辑示例
    final newLevel = (_experienceValue / 1000).floor() + 1;
    if (newLevel != _playerLevel) {
      playerLevel = newLevel;
    }
  }

  // 12. 添加资源清理方法
  void dispose() {
    _progressController.close();
    _levelController.close();
  }
}


//饿汉模式
//饿汉就是类一旦加载，就把单例初始化完成，保证getInstance的时候，单例是已经存在的了。
class SingletonEH {
  static SingletonEH instance = SingletonEH._();

  SingletonEH._();

  static SingletonEH getInstance() {
    return instance;
  }
}

//而懒汉比较懒，只有当调用getInstance的时候，才回去初始化这个单例。
class SingletonLH {
  static SingletonLH? instance;

  SingletonLH._();

  static SingletonLH getInstance() {
    instance ??= SingletonLH._();
    return instance!;
  }
}
